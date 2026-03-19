import 'package:flutter/material.dart';

class SolicitarGuinchoScreen extends StatefulWidget {
  const SolicitarGuinchoScreen({super.key});

  @override
  State<SolicitarGuinchoScreen> createState() =>
      _SolicitarGuinchoScreenState();
}

class _SolicitarGuinchoScreenState extends State<SolicitarGuinchoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _veiculoSelecionado;
  String? _tipoProblema;

  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  // 🔧 CORRIGIDO: tipagem forte
  final List<Map<String, String>> _veiculos = [
    {'id': '1', 'nome': 'Gol 2020 - ABC-1234'},
    {'id': '2', 'nome': 'Civic 2021 - DEF-5678'},
  ];

  final List<String> _tiposProblema = [
    'Pane mecânica',
    'Pneu furado',
    'Bateria descarregada',
    'Sem combustível',
    'Acidente',
    'Outro',
  ];

  @override
  void dispose() {
    _localizacaoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔴 Header 24h
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_shipping,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Serviço 24 Horas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Atendimento rápido e seguro',
                          style: TextStyle(
                            color: Color(0xFFFEE2E2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Informações do Veículo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // 🚗 VEÍCULO (CORRIGIDO)
            DropdownButtonFormField<String>(
              value: _veiculoSelecionado,
              decoration: InputDecoration(
                labelText: 'Selecione o veículo *',
                prefixIcon: const Icon(Icons.directions_car),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _veiculos.map<DropdownMenuItem<String>>((veiculo) {
                return DropdownMenuItem<String>(
                  value: veiculo['id'],
                  child: Text(veiculo['nome']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _veiculoSelecionado = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Selecione um veículo' : null,
            ),

            const SizedBox(height: 24),

            const Text(
              'Detalhes da Ocorrência',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // ⚠️ TIPO PROBLEMA (CORRIGIDO)
            DropdownButtonFormField<String>(
              value: _tipoProblema,
              decoration: InputDecoration(
                labelText: 'Tipo de problema *',
                prefixIcon: const Icon(Icons.warning),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _tiposProblema.map<DropdownMenuItem<String>>((tipo) {
                return DropdownMenuItem<String>(
                  value: tipo,
                  child: Text(tipo),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _tipoProblema = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Selecione o tipo de problema' : null,
            ),

            const SizedBox(height: 16),

            // 📍 Localização
            TextFormField(
              controller: _localizacaoController,
              decoration: InputDecoration(
                labelText: 'Localização *',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Informe a localização' : null,
            ),

            const SizedBox(height: 16),

            // 📝 Descrição
            TextFormField(
              controller: _descricaoController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Descrição',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🚀 BOTÃO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _solicitarGuincho,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Solicitar Guincho',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔧 FUNÇÃO
  void _solicitarGuincho() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Guincho solicitado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}