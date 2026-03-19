import 'package:flutter/material.dart';

class ProcurarVeiculoScreen extends StatefulWidget {
  const ProcurarVeiculoScreen({Key? key}) : super(key: key);

  @override
  State<ProcurarVeiculoScreen> createState() => _ProcurarVeiculoScreenState();
}

class _ProcurarVeiculoScreenState extends State<ProcurarVeiculoScreen> {
  final _searchController = TextEditingController();
  bool _isLoading = false;
  String _selectedFilter = 'placa';
  
  // Dados mockados
  List<Map<String, dynamic>> _veiculos = [
    {
      'id': '1',
      'placa': 'ABC-1234',
      'marca': 'Toyota',
      'modelo': 'Corolla',
      'ano': '2020',
      'cor': 'Prata',
      'km': '45000',
      'cliente': 'João Silva',
      'telefone': '(11) 99999-1111',
      'ultimaRevisao': '15/02/2024',
    },
    {
      'id': '2',
      'placa': 'XYZ-5678',
      'marca': 'Honda',
      'modelo': 'Civic',
      'ano': '2021',
      'cor': 'Preto',
      'km': '32000',
      'cliente': 'Maria Santos',
      'telefone': '(11) 99999-2222',
      'ultimaRevisao': '20/01/2024',
    },
    {
      'id': '3',
      'placa': 'DEF-9876',
      'marca': 'Fiat',
      'modelo': 'Uno',
      'ano': '2019',
      'cor': 'Branco',
      'km': '68000',
      'cliente': 'Carlos Oliveira',
      'telefone': '(11) 99999-3333',
      'ultimaRevisao': '10/03/2024',
    },
  ];

  List<Map<String, dynamic>> _filteredVeiculos = [];

  @override
  void initState() {
    super.initState();
    _filteredVeiculos = _veiculos;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVeiculos(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredVeiculos = _veiculos;
      } else {
        _filteredVeiculos = _veiculos.where((veiculo) {
          switch (_selectedFilter) {
            case 'placa':
              return veiculo['placa']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
            case 'cliente':
              return veiculo['cliente']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
            case 'modelo':
              return veiculo['modelo']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
            default:
              return false;
          }
        }).toList();
      }
    });
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
              _buildSearchSection(),
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
                      _buildFilterChips(),
                      Expanded(
                        child: _filteredVeiculos.isEmpty
                            ? _buildEmptyState()
                            : _buildVeiculosList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                'Procurar Veículo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Busque por placa, cliente ou modelo',
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

  Widget _buildSearchSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: _filterVeiculos,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Digite para buscar...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    _filterVeiculos('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(
            'Buscar por:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 12),
          _buildFilterChip('Placa', 'placa'),
          SizedBox(width: 8),
          _buildFilterChip('Cliente', 'cliente'),
          SizedBox(width: 8),
          _buildFilterChip('Modelo', 'modelo'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
          _filterVeiculos(_searchController.text);
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF3B82F6),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? Color(0xFF3B82F6) : Colors.grey[300]!,
      ),
    );
  }

  Widget _buildVeiculosList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      itemCount: _filteredVeiculos.length,
      itemBuilder: (context, index) {
        return _buildVeiculoCard(_filteredVeiculos[index]);
      },
    );
  }

  Widget _buildVeiculoCard(Map<String, dynamic> veiculo) {
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
        onTap: () => _showVeiculoDetails(veiculo),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF3B82F6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.directions_car,
                      color: Color(0xFF3B82F6),
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${veiculo['marca']} ${veiculo['modelo']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          veiculo['placa'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(height: 1),
              SizedBox(height: 16),
              _buildInfoRow(Icons.person, 'Cliente', veiculo['cliente']),
              SizedBox(height: 8),
              _buildInfoRow(Icons.phone, 'Telefone', veiculo['telefone']),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                        Icons.calendar_today, 'Ano', veiculo['ano']),
                  ),
                  Expanded(
                    child: _buildInfoRow(Icons.speed, 'KM',
                        '${veiculo['km']} km'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Nenhum veículo encontrado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tente buscar por outro termo',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showVeiculoDetails(Map<String, dynamic> veiculo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
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
                          Icons.directions_car,
                          color: Color(0xFF3B82F6),
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '${veiculo['marca']} ${veiculo['modelo']}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF3B82F6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              veiculo['placa'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildDetailSection('Informações do Veículo', [
                      _buildDetailItem('Ano', veiculo['ano']),
                      _buildDetailItem('Cor', veiculo['cor']),
                      _buildDetailItem('Quilometragem', '${veiculo['km']} km'),
                      _buildDetailItem(
                          'Última Revisão', veiculo['ultimaRevisao']),
                    ]),
                    SizedBox(height: 24),
                    _buildDetailSection('Dados do Proprietário', [
                      _buildDetailItem('Nome', veiculo['cliente']),
                      _buildDetailItem('Telefone', veiculo['telefone']),
                    ]),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navegar para criar orçamento
                            },
                            icon: Icon(Icons.description),
                            label: Text('Novo Orçamento'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3B82F6),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navegar para histórico
                            },
                            icon: Icon(Icons.history),
                            label: Text('Histórico'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF3B82F6),
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(color: Color(0xFF3B82F6)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
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

  Widget _buildDetailSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
