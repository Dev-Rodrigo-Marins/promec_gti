import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/veiculo.dart';

class HistoricoClienteScreen extends StatefulWidget {
  const HistoricoClienteScreen({super.key});

  @override
  State<HistoricoClienteScreen> createState() => _HistoricoClienteScreenState();
}

class _HistoricoClienteScreenState extends State<HistoricoClienteScreen> {
  String? _veiculoSelecionado;

  // Mock data - substituir por dados reais
  final List<Map<String, dynamic>> _veiculos = [
    {'id': '1', 'nome': 'Gol 2020 - ABC-1234'},
    {'id': '2', 'nome': 'Civic 2021 - DEF-5678'},
  ];

  final Map<String, List<Map<String, dynamic>>> _historico = {
    '1': [
      {
        'data': DateTime(2024, 1, 15),
        'servico': 'Troca de óleo e filtro',
        'oficina': 'ProMec Centro',
        'km': 45000,
        'valor': 200.00,
        'observacoes': 'Óleo sintético 5W30',
      },
      {
        'data': DateTime(2023, 10, 20),
        'servico': 'Revisão completa',
        'oficina': 'ProMec Centro',
        'km': 40000,
        'valor': 450.00,
        'observacoes': 'Revisão dos 40 mil km',
      },
      {
        'data': DateTime(2023, 7, 10),
        'servico': 'Alinhamento e balanceamento',
        'oficina': 'ProMec Norte',
        'km': 38000,
        'valor': 120.00,
        'observacoes': '',
      },
    ],
    '2': [
      {
        'data': DateTime(2024, 2, 1),
        'servico': 'Troca de pneus',
        'oficina': 'ProMec Sul',
        'km': 32000,
        'valor': 1200.00,
        'observacoes': 'Pneus Michelin 205/55R16',
      },
      {
        'data': DateTime(2023, 11, 15),
        'servico': 'Troca de óleo',
        'oficina': 'ProMec Centro',
        'km': 30000,
        'valor': 250.00,
        'observacoes': 'Óleo sintético',
      },
    ],
  };

  List<Map<String, dynamic>> get _historicoFiltrado {
    if (_veiculoSelecionado == null) {
      // Retorna todos os históricos combinados
      final List<Map<String, dynamic>> todos = [];
      _historico.forEach((key, value) {
        todos.addAll(value.map((h) => {
              ...h,
              'veiculo': _veiculos.firstWhere((v) => v['id'] == key)['nome'],
            }));
      });
      todos.sort((a, b) => (b['data'] as DateTime).compareTo(a['data'] as DateTime));
      return todos;
    }
    return _historico[_veiculoSelecionado] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Seletor de veículo
        Container(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Selecione o veículo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            value: _veiculoSelecionado,
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Todos os veículos'),
              ),
              ..._veiculos.map((veiculo) {
                return DropdownMenuItem(
                  value: veiculo['id'],
                  child: Text(veiculo['nome']),
                );
              }),
            ],
            onChanged: (valor) {
              setState(() {
                _veiculoSelecionado = valor;
              });
            },
          ),
        ),

        // Resumo
        if (_veiculoSelecionado != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildResumoItem(
                  'Serviços',
                  _historicoFiltrado.length.toString(),
                  Icons.build,
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                _buildResumoItem(
                  'Gasto Total',
                  NumberFormat.currency(
                    locale: 'pt_BR',
                    symbol: 'R\$',
                  ).format(
                    _historicoFiltrado.fold(
                      0.0,
                      (sum, item) => sum + (item['valor'] as double),
                    ),
                  ),
                  Icons.attach_money,
                ),
              ],
            ),
          ),

        const SizedBox(height: 16),

        // Lista de histórico
        Expanded(
          child: _historicoFiltrado.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _historicoFiltrado.length,
                  itemBuilder: (context, index) {
                    final item = _historicoFiltrado[index];
                    return _buildHistoricoCard(item);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildResumoItem(String label, String valor, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFBFDBFE),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoricoCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item['servico'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'pt_BR',
                    symbol: 'R\$',
                  ).format(item['valor']),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd/MM/yyyy').format(item['data']),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.speed, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${NumberFormat('#,###', 'pt_BR').format(item['km'])} km',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  item['oficina'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            if (_veiculoSelecionado == null && item['veiculo'] != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.directions_car, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    item['veiculo'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
            if (item['observacoes'].toString().isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['observacoes'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum histórico encontrado',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Os serviços realizados aparecerão aqui',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
