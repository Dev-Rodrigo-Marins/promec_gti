import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../models/orcamento.dart';


class OrcamentosClienteScreen extends StatefulWidget {
  const OrcamentosClienteScreen({super.key});

  @override
  State<OrcamentosClienteScreen> createState() =>
      _OrcamentosClienteScreenState();
}

class _OrcamentosClienteScreenState
    extends State<OrcamentosClienteScreen> {
  String _filtroSelecionado = 'todos';

  List<Orcamento> _orcamentos = [];
  bool _loading = true;

  final String clienteId =
      '7b2958ec-852a-47e7-8975-e1cfd33bd9c9'; // ajuste dinâmico depois

  @override
  void initState() {
    super.initState();
    _carregarOrcamentos();
  }

  Future<void> _carregarOrcamentos() async {
    final url = Uri.parse(
        'http://204.216.132.130/promec/api/consulta_orcamentos.php?cliente_id=$clienteId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        setState(() {
          _orcamentos =
              data.map((json) => Orcamento.fromJson(json)).toList();
          _loading = false;
        });
      } else {
        throw Exception('Erro ao carregar orçamentos');
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      debugPrint(e.toString());
    }
  }

  List<Orcamento> get _orcamentosFiltrados {
    if (_filtroSelecionado == 'todos') return _orcamentos;
    return _orcamentos
        .where((o) => o.status == _filtroSelecionado)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        _buildFiltros(),
        Expanded(
          child: _orcamentosFiltrados.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _orcamentosFiltrados.length,
                  itemBuilder: (context, index) {
                    return _buildOrcamentoCard(
                        _orcamentosFiltrados[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFiltros() {
    return Container(
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
    );
  }

  Widget _buildFiltroChip(String label, String valor) {
    final isSelected = _filtroSelecionado == valor;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _filtroSelecionado = valor;
        });
      },
    );
  }

  Widget _buildOrcamentoCard(Orcamento orcamento) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(orcamento.numero),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('dd/MM/yyyy').format(orcamento.data)),
            const SizedBox(height: 4),
            Text('R\$ ${orcamento.valor.toStringAsFixed(2)}'),
          ],
        ),
        trailing: _buildStatusBadge(orcamento.status),
        onTap: () => _mostrarDetalhesOrcamento(orcamento),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
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
        color: cor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(color: cor),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('Nenhum orçamento encontrado'),
    );
  }

  void _mostrarDetalhesOrcamento(Orcamento orcamento) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              orcamento.numero,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...orcamento.servicos.map((s) => ListTile(
                  title: Text(s.nome),
                  trailing:
                      Text('R\$ ${s.total.toStringAsFixed(2)}'),
                )),
          ],
        ),
      ),
    );
  }
}