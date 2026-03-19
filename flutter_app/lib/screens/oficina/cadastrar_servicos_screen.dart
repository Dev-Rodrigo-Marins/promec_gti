import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastrarServicosScreen extends StatefulWidget {
  const CadastrarServicosScreen({Key? key}) : super(key: key);

  @override
  State<CadastrarServicosScreen> createState() =>
      _CadastrarServicosScreenState();
}

class _CadastrarServicosScreenState extends State<CadastrarServicosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _tempoEstimadoController = TextEditingController();
  
  String _categoriaSelecionada = 'manutencao';
  bool _isLoading = false;

  // Lista de serviços cadastrados (mockado)
  List<Map<String, dynamic>> _servicos = [
    {
      'id': '1',
      'nome': 'Troca de óleo',
      'descricao': 'Troca de óleo do motor e filtro',
      'valor': 150.00,
      'categoria': 'manutencao',
      'tempoEstimado': '30 min',
    },
    {
      'id': '2',
      'nome': 'Alinhamento e balanceamento',
      'descricao': 'Alinhamento de direção e balanceamento de rodas',
      'valor': 120.00,
      'categoria': 'suspensao',
      'tempoEstimado': '45 min',
    },
    {
      'id': '3',
      'nome': 'Revisão de freios',
      'descricao': 'Inspeção e revisão completa do sistema de freios',
      'valor': 280.00,
      'categoria': 'freios',
      'tempoEstimado': '1h 30min',
    },
  ];

  final Map<String, String> _categorias = {
    'manutencao': 'Manutenção',
    'freios': 'Freios',
    'suspensao': 'Suspensão',
    'motor': 'Motor',
    'eletrica': 'Elétrica',
    'ar_condicionado': 'Ar Condicionado',
    'outro': 'Outro',
  };

  final Map<String, IconData> _categoriasIcons = {
    'manutencao': Icons.build,
    'freios': Icons.disc_full,
    'suspensao': Icons.support,
    'motor': Icons.settings,
    'eletrica': Icons.electrical_services,
    'ar_condicionado': Icons.ac_unit,
    'outro': Icons.more_horiz,
  };

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _valorController.dispose();
    _tempoEstimadoController.dispose();
    super.dispose();
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
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        _buildTabBar(),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildNovoServicoTab(),
                              _buildServicosListTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                'Cadastrar Serviços',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gerencie o catálogo de serviços',
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

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[700],
        indicator: BoxDecoration(
          color: Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorPadding: EdgeInsets.all(4),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle, size: 20),
                SizedBox(width: 8),
                Text('Novo Serviço'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list, size: 20),
                SizedBox(width: 8),
                Text('Serviços (${_servicos.length})'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNovoServicoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Informações do Serviço'),
            SizedBox(height: 16),
            _buildTextField(
              controller: _nomeController,
              label: 'Nome do Serviço',
              icon: Icons.build,
              hint: 'Ex: Troca de óleo',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome do serviço';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildTextField(
              controller: _descricaoController,
              label: 'Descrição',
              icon: Icons.description,
              hint: 'Descreva o serviço...',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a descrição';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _buildCategoriaDropdown(),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _valorController,
                    label: 'Valor',
                    icon: Icons.attach_money,
                    hint: '0,00',
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    prefixText: 'R\$ ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o valor';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _tempoEstimadoController,
                    label: 'Tempo Estimado',
                    icon: Icons.access_time,
                    hint: '30 min',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o tempo';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildServicosListTab() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: _servicos.length,
      itemBuilder: (context, index) {
        return _buildServicoCard(_servicos[index]);
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    String? prefixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixText: prefixText,
        prefixIcon: Icon(icon, color: Color(0xFF3B82F6)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildCategoriaDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _categoriaSelecionada,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Color(0xFF3B82F6)),
          items: _categorias.entries.map((entry) {
            return DropdownMenuItem(
              value: entry.key,
              child: Row(
                children: [
                  Icon(
                    _categoriasIcons[entry.key],
                    color: Color(0xFF3B82F6),
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(entry.value),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _categoriaSelecionada = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3B82F6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Cadastrar Serviço',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildServicoCard(Map<String, dynamic> servico) {
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
                    _categoriasIcons[servico['categoria']] ?? Icons.build,
                    color: Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        servico['nome'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _categorias[servico['categoria']] ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20, color: Color(0xFF3B82F6)),
                          SizedBox(width: 12),
                          Text('Editar'),
                        ],
                      ),
                      value: 'editar',
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 12),
                          Text('Excluir'),
                        ],
                      ),
                      value: 'excluir',
                    ),
                  ],
                  onSelected: (value) {
                    // Implementar edição e exclusão
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              servico['descricao'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Divider(height: 1),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text(
                      servico['tempoEstimado'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Text(
                  'R\$ ${servico['valor'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simula chamada de API
      await Future.delayed(Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _servicos.add({
            'id': '${_servicos.length + 1}',
            'nome': _nomeController.text,
            'descricao': _descricaoController.text,
            'valor': double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0.0,
            'categoria': _categoriaSelecionada,
            'tempoEstimado': _tempoEstimadoController.text,
          });
          _isLoading = false;
        });

        _nomeController.clear();
        _descricaoController.clear();
        _valorController.clear();
        _tempoEstimadoController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Serviço cadastrado com sucesso!'),
            backgroundColor: Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Muda para a aba de lista
        DefaultTabController.of(context).animateTo(1);
      }
    }
  }
}
