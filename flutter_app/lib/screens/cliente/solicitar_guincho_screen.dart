import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SolicitarGuinchoScreen extends StatefulWidget {
  const SolicitarGuinchoScreen({Key? key}) : super(key: key);

  @override
  State<SolicitarGuinchoScreen> createState() =>
      _SolicitarGuinchoScreenState();
}

class _SolicitarGuinchoScreenState
    extends State<SolicitarGuinchoScreen> {
  Position? _position;
  bool _loading = false;

  // Lista de marcadores para o flutter_map
  List<Marker> _markers = [];

  /// ===============================
  /// BUSCAR OFICINAS (API)
  /// ===============================
  Future<List<Map<String, dynamic>>> buscarOficinas(
      double lat, double lon) async {
    final url = Uri.parse(
        'http://204.216.132.130/promec/api/oficinas_proximas.php?lat=$lat&lon=$lon');

    final response =
        await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        return List<Map<String, dynamic>>.from(data['dados']);
      } else {
        throw Exception(data['mensagem']);
      }
    } else {
      throw Exception('Erro HTTP');
    }
  }

  /// ===============================
  /// CARREGAR OFICINAS NO MAPA
  /// ===============================
  Future<void> _carregarOficinas() async {
    if (_position == null) return;

    try {
      final oficinas = await buscarOficinas(
        _position!.latitude,
        _position!.longitude,
      );

      List<Marker> novosMarkers = [];

      // 📍 marcador do usuário
      novosMarkers.add(
        Marker(
          point: LatLng(
            _position!.latitude,
            _position!.longitude,
          ),
          width: 40,
          height: 40,
          builder: (_) => const Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      );

      // 🔧 oficinas
      for (var oficina in oficinas) {
        novosMarkers.add(
          Marker(
            point: LatLng(
              oficina['lat'],
              oficina['lon'],
            ),
            width: 40,
            height: 40,
            builder: (_) => const Icon(
              Icons.store,
              color: Colors.red,
              size: 30,
            ),
          ),
        );
      }

      setState(() {
        _markers = novosMarkers;
      });
    } catch (e) {
      _showSnack('Erro ao carregar oficinas');
    }
  }

  /// ===============================
  /// LOCALIZAÇÃO
  /// ===============================
  Future<void> _getCurrentLocation() async {
    setState(() => _loading = true);

    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      _showSnack('Ative o GPS');
      setState(() => _loading = false);
      return;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        _showSnack('Permissão negada');
        setState(() => _loading = false);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnack('Permissão permanente negada');
      setState(() => _loading = false);
      return;
    }

    final pos = await Geolocator.getCurrentPosition();

    setState(() {
      _position = pos;
      _loading = false;
    });

    await _carregarOficinas(); // 🔥 ESSENCIAL
  }

  /// ===============================
  /// WHATSAPP GUINCHO
  /// ===============================
  Future<void> _requestTow() async {
    if (_position == null) return;

    final lat = _position!.latitude;
    final lon = _position!.longitude;

    final message = Uri.encodeComponent(
        'Preciso de guincho: https://www.google.com/maps/search/?api=1&query=$lat,$lon');

    final url = 'https://wa.me/5551986102344?text=$message';

    await launchUrl(Uri.parse(url));
  }

  /// ===============================
  /// MAPA EXTERNO
  /// ===============================
  Future<void> _openWorkshopsMap() async {
    if (_position == null) return;

    final lat = _position!.latitude;
    final lon = _position!.longitude;

    final url =
        'https://www.google.com/maps/search/oficinas+mechanicas/@$lat,$lon,15z';

    await launchUrl(Uri.parse(url));
  }

  /// ===============================
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  /// ===============================
  Widget _buildMap() {
    if (_position == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 200,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(_position!.latitude, _position!.longitude),
            zoom: 15,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _markers,
            ),
          ],
        ),
      ),
    );
  }

  /// ===============================
  Widget _card({required Widget child}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  /// ===============================
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2563EB);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Solicitar Guincho'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sua localização',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildMap(),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed:
                        _loading ? null : _getCurrentLocation,
                    icon: const Icon(Icons.my_location),
                    label: Text(_loading
                        ? 'Carregando...'
                        : 'Atualizar localização'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _card(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _position != null
                        ? _requestTow
                        : null,
                    icon: const Icon(Icons.local_shipping),
                    label:
                        const Text('Solicitar Guincho'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 10),

                  OutlinedButton.icon(
                    onPressed: _position != null
                        ? _openWorkshopsMap
                        : null,
                    icon: const Icon(Icons.map),
                    label: const Text(
                        'Ver no Google Maps'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}