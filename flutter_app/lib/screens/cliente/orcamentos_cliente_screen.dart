import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../models/orcamento.dart';

class OrcamentosClienteScreen extends StatefulWidget {
  const OrcamentosClienteScreen({super.key});

  @override
  State<OrcamentosClienteScreen> createState() =>
      _OrcamentosClienteScreenState();
}

class _OrcamentosClienteScreenState
    extends State<OrcamentosClienteScreen> {
  List<Orcamento> _orcamentos = [];
  bool _loading = true;

  final String clienteId = '7b2958ec-852a-47e7-8975-e1cfd33bd9c9';

  @override
  void initState() {
    super.initState();
    carregarOrcamentos();
  }

  Future<void> carregarOrcamentos() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://204.216.132.130/promec/api/consulta_orcamentos.php?cliente_id=$clienteId'),
      );

      final data = jsonDecode(response.body);

      setState(() {
        _orcamentos =
            data.map<Orcamento>((e) => Orcamento.fromJson(e)).toList();
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_orcamentos.isEmpty) {
      return const Center(child: Text('Nenhum orçamento encontrado'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orcamentos.length,
      itemBuilder: (context, index) {
        final orc = _orcamentos[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orc.numero,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    _statusBadge(orc.status),
                  ],
                ),

                const SizedBox(height: 10),

                /// VEÍCULO + PLACA
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_car, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            orc.veiculo,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Placa: ${orc.placa ?? "Não informada"}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// DATA
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('dd/MM/yyyy').format(orc.data),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// SERVIÇOS COM VALOR
                if (orc.servicos.isNotEmpty)
                  Column(
                    children: orc.servicos.map((s) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('• ${s.nome}'),
                            ),
                            Text(
                              NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                              ).format(s.valor),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 12),

                /// TOTAL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total'),
                    Text(
                      NumberFormat.currency(
                        locale: 'pt_BR',
                        symbol: 'R\$',
                      ).format(orc.valor),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statusBadge(String status) {
    Color cor;

    switch (status) {
      case 'pendente':
        cor = Colors.orange;
        break;
      case 'aprovado':
        cor = Colors.blue;
        break;
      case 'concluido':
        cor = Colors.green;
        break;
      default:
        cor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(color: cor, fontSize: 12),
      ),
    );
  }
}