import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrcamentosOficinaScreen extends StatefulWidget {
  const OrcamentosOficinaScreen({super.key});

  @override
  State<OrcamentosOficinaScreen> createState() =>
      _OrcamentosOficinaScreenState();
}

class _OrcamentosOficinaScreenState
    extends State<OrcamentosOficinaScreen> {
  String _selectedFilter = 'todos';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _orcamentos = [
    {
      'id': 'ORC-001',
      'data': DateTime.now(),
      'cliente': 'João Silva',
      'veiculo': 'Corolla',
      'placa': 'ABC-1234',
      'valor': 1250.0,
      'status': 'pendente',
      'servicos': ['Revisão', 'Óleo'],
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    List<Map<String, dynamic>> list = _orcamentos;

    if (_selectedFilter != 'todos') {
      list = list.where((e) => e['status'] == _selectedFilter).toList();
    }

    if (_searchController.text.isNotEmpty) {
      final q = _searchController.text.toLowerCase();
      list = list.where((e) {
        return e['cliente'].toLowerCase().contains(q) ||
            e['id'].toLowerCase().contains(q) ||
            e['placa'].toLowerCase().contains(q);
      }).toList();
    }

    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/oficina/orcamentos/novo'),
        backgroundColor: const Color(0xFF3B82F6),
        icon: const Icon(Icons.add),
        label: const Text('Novo Orçamento'),
      ),
      body: Column(
        children: [
          _header(),
          _search(),
          Expanded(
            child: Column(
              children: [
                _filters(),
                _stats(),
                Expanded(
                  child: _filtered.isEmpty
                      ? _empty()
                      : _list(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF3B82F6),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Text(
            'Orçamentos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  // ================= SEARCH =================

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Buscar...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ================= FILTER =================

  Widget _filters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip('Todos', 'todos'),
          _chip('Pendentes', 'pendente'),
          _chip('Aprovados', 'aprovado'),
        ],
      ),
    );
  }

  Widget _chip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedFilter == value,
        onSelected: (_) {
          setState(() {
            _selectedFilter = value;
          });
        },
      ),
    );
  }

  // ================= STATS =================

  Widget _stats() {
    final total = _filtered.fold<double>(
        0, (sum, e) => sum + e['valor']);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: _stat('Qtd', '${_filtered.length}')),
          Expanded(
              child: _stat('Total',
                  NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                      .format(total))),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label),
      ],
    );
  }

  // ================= LIST =================

  Widget _list() {
    return ListView.builder(
      itemCount: _filtered.length,
      itemBuilder: (context, i) {
        final o = _filtered[i];

        return ListTile(
          title: Text(o['id']),
          subtitle: Text('${o['cliente']} - ${o['placa']}'),
          trailing: Text(
            NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                .format(o['valor']),
          ),
          onTap: () => _details(o),
        );
      },
    );
  }

  // ================= EMPTY =================

  Widget _empty() {
    return const Center(
      child: Text('Nenhum orçamento'),
    );
  }

  // ================= DETAILS =================

  void _details(Map<String, dynamic> o) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(o['id'],
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            Text(o['cliente']),
            Text(NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                .format(o['valor'])),
          ],
        ),
      ),
    );
  }
}