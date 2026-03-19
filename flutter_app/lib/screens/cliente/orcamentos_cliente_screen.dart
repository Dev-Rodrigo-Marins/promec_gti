import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/orcamento.dart';

class OrcamentosClienteScreen extends StatefulWidget {
  const OrcamentosClienteScreen({super.key});

  @override
  State<OrcamentosClienteScreen> createState() =>
      _OrcamentosClienteScreenState();
}

class _OrcamentosClienteScreenState extends State<OrcamentosClienteScreen> {
  String _filtroSelecionado = 'todos';

  // Mock data - substituir por dados reais do Provider
  final List<Orcamento> _orcamentos = [
    Orcamento(
      id: '1',
      numero: 'ORC-001',
      data: DateTime.now().subtract(const Duration(days: 2)),
      veiculoId: '1',
      veiculo: 'Gol 2020 - ABC-1234',
      proprietario: 'João Silva',
      servicos: [
        ItemOrcamento(
          servicoId: '1',
          nome: 'Troca de óleo',
          quantidade: 1,
          valorUnitario: 150.00,
        ),
        ItemOrcamento(
          servicoId: '2',
          nome: 'Filtro de óleo',
          quantidade: 1,
          valorUnitario: 50.00,
        ),
      ],
      valor: 200.00,
      status: 'pendente',
      validade: DateTime.now().add(const Duration(days: 5)),
      observacoes: 'Serviço agendado para próxima semana',
    ),
    Orcamento(
      id: '2',
      numero: 'ORC-002',
      data: DateTime.now().subtract(const Duration(days: 15)),
      veiculoId: '2',
      veiculo: 'Civic 2021 - DEF-5678',
      proprietario: 'João Silva',
      servicos: [
        ItemOrcamento(
          servicoId: '3',
          nome: 'Revisão completa',
          quantidade: 1,
          valorUnitario: 450.00,
        ),
      ],
      valor: 450.00,
      status: 'aprovado',
      validade: DateTime.now().add(const Duration(days: 15)),
    ),
    Orcamento(
      id: '3',
      numero: 'ORC-003',
      data: DateTime.now().subtract(const Duration(days: 30)),
      veiculoId: '1',
      veiculo: 'Gol 2020 - ABC-1234',
      proprietario: 'João Silva',
      servicos: [
        ItemOrcamento(
          servicoId: '4',
          nome: 'Alinhamento e balanceamento',
          quantidade: 1,
          valorUnitario: 120.00,
        ),
      ],
      valor: 120.00,
      status: 'concluido',
      validade: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  List<Orcamento> get _orcamentosFiltrados {
    if (_filtroSelecionado == 'todos') {
      return _orcamentos;
    }
    return _orcamentos.where((o) => o.status == _filtroSelecionado).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filtros
        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFiltroChip('Todos', 'todos'),
                const SizedBox(width: 8),
                _buildFiltroChip('Pendentes', 'pendente'),
                const SizedBox(width: 8),
                _buildFiltroChip('Aprovados', 'aprovado'),
                const SizedBox(width: 8),
                _buildFiltroChip('Concluídos', 'concluido'),
              ],
            ),
          ),
        ),

        // Lista de orçamentos
        Expanded(
          child: _orcamentosFiltrados.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _orcamentosFiltrados.length,
                  itemBuilder: (context, index) {
                    final orcamento = _orcamentosFiltrados[index];
                    return _buildOrcamentoCard(orcamento);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFiltroChip(String label, String valor) {
    final isSelected = _filtroSelecionado == valor;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filtroSelecionado = valor;
        });
      },
      selectedColor: const Color(0xFF2563EB),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildOrcamentoCard(Orcamento orcamento) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () => _mostrarDetalhesOrcamento(orcamento),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orcamento.numero,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusBadge(orcamento.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.directions_car, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    orcamento.veiculo,
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
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('dd/MM/yyyy').format(orcamento.data),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Serviços:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...orcamento.servicos.map((servico) => Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '• ${servico.nome}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Valor Total',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                        ).format(orcamento.valor),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ],
                  ),
                  if (orcamento.isPendente)
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _aprovarOrcamento(orcamento),
                          icon: const Icon(Icons.check, size: 18),
                          label: const Text('Aprovar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextButton(
                          onPressed: () => _recusarOrcamento(orcamento),
                          child: const Text(
                            'Recusar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              if (orcamento.isPendente && !orcamento.isVencido)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Válido até ${DateFormat('dd/MM/yyyy').format(orcamento.validade)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              if (orcamento.isVencido)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        size: 14,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Orçamento vencido',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color cor;
    String texto;

    switch (status) {
      case 'pendente':
        cor = Colors.orange;
        texto = 'Pendente';
        break;
      case 'aprovado':
        cor = Colors.blue;
        texto = 'Aprovado';
        break;
      case 'recusado':
        cor = Colors.red;
        texto = 'Recusado';
        break;
      case 'concluido':
        cor = Colors.green;
        texto = 'Concluído';
        break;
      default:
        cor = Colors.grey;
        texto = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        border: Border.all(color: cor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: cor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
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
            Icons.description_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhum orçamento encontrado',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalhesOrcamento(Orcamento orcamento) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orcamento.numero,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusBadge(orcamento.status),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow(
                Icons.directions_car,
                'Veículo',
                orcamento.veiculo,
              ),
              _buildInfoRow(
                Icons.calendar_today,
                'Data',
                DateFormat('dd/MM/yyyy').format(orcamento.data),
              ),
              _buildInfoRow(
                Icons.event_available,
                'Validade',
                DateFormat('dd/MM/yyyy').format(orcamento.validade),
              ),
              const SizedBox(height: 24),
              const Text(
                'Serviços',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...orcamento.servicos.map((servico) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                servico.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Quantidade: ${servico.quantidade}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: 'pt_BR',
                            symbol: 'R\$',
                          ).format(servico.total),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Valor Total',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: 'pt_BR',
                      symbol: 'R\$',
                    ).format(orcamento.valor),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
              if (orcamento.observacoes != null) ...[
                const SizedBox(height: 24),
                const Text(
                  'Observações',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  orcamento.observacoes!,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _aprovarOrcamento(Orcamento orcamento) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aprovar Orçamento'),
        content: Text(
          'Deseja aprovar o orçamento ${orcamento.numero} no valor de ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(orcamento.valor)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implementar aprovação
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Orçamento aprovado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
            ),
            child: const Text('Aprovar'),
          ),
        ],
      ),
    );
  }

  void _recusarOrcamento(Orcamento orcamento) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recusar Orçamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deseja recusar o orçamento ${orcamento.numero}?'),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Motivo (opcional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implementar recusa
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Orçamento recusado'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Recusar'),
          ),
        ],
      ),
    );
  }
}
