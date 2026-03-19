import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedFilter = 'todos';

  // Dados mockados
  final List<Map<String, dynamic>> _agendamentos = [
    {
      'id': '1',
      'data': DateTime.now(),
      'horario': '09:00',
      'cliente': 'João Silva',
      'veiculo': 'Toyota Corolla',
      'placa': 'ABC-1234',
      'servico': 'Revisão completa',
      'status': 'confirmado',
      'telefone': '(11) 99999-1111',
    },
    {
      'id': '2',
      'data': DateTime.now(),
      'horario': '11:00',
      'cliente': 'Maria Santos',
      'veiculo': 'Honda Civic',
      'placa': 'XYZ-5678',
      'servico': 'Troca de óleo',
      'status': 'em_atendimento',
      'telefone': '(11) 99999-2222',
    },
    {
      'id': '3',
      'data': DateTime.now(),
      'horario': '14:00',
      'cliente': 'Carlos Oliveira',
      'veiculo': 'Fiat Uno',
      'placa': 'DEF-9876',
      'servico': 'Alinhamento e balanceamento',
      'status': 'pendente',
      'telefone': '(11) 99999-3333',
    },
    {
      'id': '4',
      'data': DateTime.now().add(Duration(days: 1)),
      'horario': '10:00',
      'cliente': 'Ana Costa',
      'veiculo': 'VW Gol',
      'placa': 'GHI-1111',
      'servico': 'Revisão de freios',
      'status': 'confirmado',
      'telefone': '(11) 99999-4444',
    },
  ];

  List<Map<String, dynamic>> get _filteredAgendamentos {
    return _agendamentos.where((agendamento) {
      final isSameDay = agendamento['data'].year == _selectedDate.year &&
          agendamento['data'].month == _selectedDate.month &&
          agendamento['data'].day == _selectedDate.day;

      if (!isSameDay) return false;

      if (_selectedFilter == 'todos') return true;
      return agendamento['status'] == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E40AF),
              Color(0xFF3B82F6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildCalendarSection(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildFilterSection(),
                      _buildAgendamentosCount(),
                      Expanded(
                        child: _filteredAgendamentos.isEmpty
                            ? _buildEmptyState()
                            : _buildAgendamentosList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNovoAgendamentoDialog,
        backgroundColor: Color(0xFF3B82F6),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Agenda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gerencie seus agendamentos',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _selectedDate =
                        _selectedDate.subtract(Duration(days: 1));
                  });
                },
              ),
              Text(
                DateFormat('EEEE, d MMMM yyyy', 'pt_BR')
                    .format(_selectedDate),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _selectedDate = _selectedDate.add(Duration(days: 1));
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          TextButton.icon(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                locale: Locale('pt', 'BR'),
              );
              if (date != null) {
                setState(() {
                  _selectedDate = date;
                });
              }
            },
            icon: Icon(Icons.calendar_today, color: Colors.white, size: 18),
            label: Text(
              'Selecionar data',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('Todos', 'todos', Icons.list),
            SizedBox(width: 8),
            _buildFilterChip('Confirmados', 'confirmado', Icons.check_circle),
            SizedBox(width: 8),
            _buildFilterChip(
                'Em Atendimento', 'em_atendimento', Icons.build_circle),
            SizedBox(width: 8),
            _buildFilterChip('Pendentes', 'pendente', Icons.pending),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, IconData icon) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
          SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF3B82F6),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
      showCheckmark: false,
      side: BorderSide(
        color: isSelected ? Color(0xFF3B82F6) : Colors.grey[300]!,
      ),
    );
  }

  Widget _buildAgendamentosCount() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            '${_filteredAgendamentos.length} ${_filteredAgendamentos.length == 1 ? 'agendamento' : 'agendamentos'}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgendamentosList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: _filteredAgendamentos.length,
      itemBuilder: (context, index) {
        return _buildAgendamentoCard(_filteredAgendamentos[index]);
      },
    );
  }

  Widget _buildAgendamentoCard(Map<String, dynamic> agendamento) {
    Color statusColor;
    String statusText;

    switch (agendamento['status']) {
      case 'confirmado':
        statusColor = Color(0xFF10B981);
        statusText = 'Confirmado';
        break;
      case 'em_atendimento':
        statusColor = Color(0xFFF59E0B);
        statusText = 'Em Atendimento';
        break;
      case 'pendente':
        statusColor = Color(0xFF6B7280);
        statusText = 'Pendente';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Desconhecido';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showAgendamentoDetails(agendamento),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF3B82F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      agendamento['horario'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                agendamento['cliente'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.directions_car, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    '${agendamento['veiculo']} - ${agendamento['placa']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.build, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      agendamento['servico'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            Icons.event_busy,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Nenhum agendamento',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Não há agendamentos para esta data',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showAgendamentoDetails(Map<String, dynamic> agendamento) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF3B82F6).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.event,
                          color: Color(0xFF3B82F6),
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Text(
                        agendamento['horario'],
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildDetailRow('Cliente', agendamento['cliente']),
                    _buildDetailRow('Veículo', agendamento['veiculo']),
                    _buildDetailRow('Placa', agendamento['placa']),
                    _buildDetailRow('Serviço', agendamento['servico']),
                    _buildDetailRow('Telefone', agendamento['telefone']),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Iniciar atendimento
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF10B981),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Iniciar Atendimento',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Cancelar agendamento
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancelar Agendamento',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  void _showNovoAgendamentoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Novo Agendamento'),
        content: Text(
            'Funcionalidade de criação de agendamento será implementada aqui.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
