import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../providers/veiculo_provider.dart';
import '../../models/veiculo.dart';
import '../../routes/loading_route_builder.dart';

class MeusVeiculosScreen extends StatefulWidget {
  const MeusVeiculosScreen({super.key});

  @override
  State<MeusVeiculosScreen> createState() => _MeusVeiculosScreenState();
}

class _MeusVeiculosScreenState extends State<MeusVeiculosScreen> {
  String? _veiculoEditando;
  final _kmController = TextEditingController();

  @override
  void dispose() {
    _kmController.dispose();
    super.dispose();
  }

  void _iniciarEdicao(Veiculo veiculo) {
    setState(() {
      _veiculoEditando = veiculo.id;
      _kmController.text = veiculo.kmAtual.toString();
    });
  }

  void _cancelarEdicao() {
    setState(() {
      _veiculoEditando = null;
      _kmController.clear();
    });
  }

  void _salvarKm(BuildContext context, String veiculoId, int kmAtual) {
    final novaKm = int.tryParse(_kmController.text);

    if (novaKm == null || novaKm <= 0) {
      Fluttertoast.showToast(
        msg: "Quilometragem inválida",
        backgroundColor: Colors.red,
      );
      return;
    }

    if (novaKm < kmAtual) {
      Fluttertoast.showToast(
        msg: "A nova quilometragem não pode ser menor que a atual",
        backgroundColor: Colors.red,
      );
      return;
    }

    context.read<VeiculoProvider>().atualizarKm(veiculoId, novaKm);
    
    final veiculo = context.read<VeiculoProvider>().getVeiculoById(veiculoId);
    if (veiculo != null) {
      final status = veiculo.statusManutencao;
      if (status == StatusManutencao.urgente) {
        Fluttertoast.showToast(
          msg: "⚠️ Seu veículo está com revisão atrasada!",
          backgroundColor: Colors.red,
        );
      } else if (status == StatusManutencao.atencao) {
        Fluttertoast.showToast(
          msg: "⚠️ Seu veículo está próximo da revisão!",
          backgroundColor: Colors.orange,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Quilometragem atualizada com sucesso!",
          backgroundColor: Colors.green,
        );
      }
    }

    _cancelarEdicao();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VeiculoProvider>(
      builder: (context, veiculoProvider, child) {
        final veiculos = veiculoProvider.veiculos;
        final alertas = veiculos.where((v) =>
            v.statusManutencao == StatusManutencao.urgente ||
            v.statusManutencao == StatusManutencao.atencao).length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meus Veículos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Atualize a quilometragem e veja alertas',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 16),
              
              // Resumo
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: const Color(0xFFEFF6FF),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.directions_car,
                              color: Color(0xFF2563EB),
                              size: 20,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${veiculos.length}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                            const Text(
                              'Veículos',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      color: const Color(0xFFFFF7ED),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.warning,
                              color: Color(0xFFF59E0B),
                              size: 20,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$alertas',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF59E0B),
                              ),
                            ),
                            const Text(
                              'Alertas',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Lista de veículos
              ...veiculos.map((veiculo) {
                final estaEditando = _veiculoEditando == veiculo.id;
                return _buildVeiculoCard(context, veiculo, estaEditando);
              }),
              
              // Dica
              const SizedBox(height: 16),
              Card(
                color: const Color(0xFFEFF6FF),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.lightbulb,
                            color: Color(0xFF2563EB),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Dica ProMec',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Mantenha sua quilometragem sempre atualizada para receber alertas precisos sobre manutenções preventivas. Isso ajuda a evitar problemas e economizar!',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVeiculoCard(
    BuildContext context,
    Veiculo veiculo,
    bool estaEditando,
  ) {
    final status = veiculo.statusManutencao;
    final (statusCor, statusTexto, statusIcon) = _getStatusInfo(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Header do card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[50]!, Colors.grey[100]!],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${veiculo.marca} ${veiculo.modelo}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildBadge(veiculo.placa),
                          const SizedBox(width: 4),
                          _buildBadge(veiculo.ano),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(statusIcon, color: statusCor, size: 20),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status da manutenção
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusCor.withOpacity(0.1),
                    border: Border.all(color: statusCor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Status da Manutenção',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Chip(
                            label: Text(
                              statusTexto,
                              style: TextStyle(
                                color: statusCor,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: statusCor.withOpacity(0.2),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Próxima revisão: ${veiculo.proximaRevisao.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} km',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // KM Atual
                if (estaEditando)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nova Quilometragem',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _kmController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Digite a KM atual',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              autofocus: true,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton.filled(
                            onPressed: () => _salvarKm(
                              context,
                              veiculo.id,
                              veiculo.kmAtual,
                            ),
                            icon: const Icon(Icons.check, size: 20),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                          IconButton.outlined(
                            onPressed: _cancelarEdicao,
                            icon: const Icon(Icons.close, size: 20),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quilometragem Atual',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${veiculo.kmAtual.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} km',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Atualizado em ${veiculo.historicoKm.first.data}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _iniciarEdicao(veiculo),
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text('Atualizar'),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                
                // Estatísticas
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: Color(0xFF2563EB),
                              size: 16,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Desde última revisão',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(veiculo.kmAtual - veiculo.ultimaRevisao).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} km',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Recomendação
                if (status == StatusManutencao.urgente ||
                    status == StatusManutencao.atencao) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      border: Border.all(
                        color: const Color(0xFFFED7AA),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.build,
                              size: 16,
                              color: Color(0xFFF59E0B),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Ação Recomendada',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          status == StatusManutencao.urgente
                              ? 'Sua revisão está atrasada. Agende o quanto antes para evitar problemas.'
                              : 'Está chegando a hora da revisão. Agende com antecedência.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF59E0B),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Solicitar Orçamento'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  (Color, String, IconData) _getStatusInfo(StatusManutencao status) {
    switch (status) {
      case StatusManutencao.urgente:
        return (Colors.red, 'Revisão atrasada!', Icons.error);
      case StatusManutencao.atencao:
        return (Colors.orange, 'Atenção necessária', Icons.warning);
      case StatusManutencao.proximo:
        return (Colors.blue, 'Próximo da revisão', Icons.schedule);
      case StatusManutencao.ok:
        return (Colors.green, 'Em dia', Icons.check_circle);
    }
  }
}
