import 'package:flutter/material.dart';
import '../models/veiculo.dart';

class VeiculoProvider extends ChangeNotifier {
  List<Veiculo> _veiculos = [
    Veiculo(
      id: '1',
      placa: 'ABC-1234',
      marca: 'Volkswagen',
      modelo: 'Gol',
      ano: '2020',
      cor: 'Prata',
      kmAtual: 48500,
      ultimaRevisao: 45000,
      proximaRevisao: 50000,
      proprietario: 'João Silva',
      telefone: '(11) 98765-4321',
      email: 'joao@email.com',
      ultimaManutencao: '05/03/2026',
      historicoKm: [
        HistoricoKm(data: '05/03/2026', km: 48200),
        HistoricoKm(data: '15/01/2026', km: 45000),
        HistoricoKm(data: '20/09/2025', km: 40000),
      ],
    ),
    Veiculo(
      id: '2',
      placa: 'DEF-5678',
      marca: 'Honda',
      modelo: 'Civic',
      ano: '2021',
      cor: 'Preto',
      kmAtual: 22300,
      ultimaRevisao: 20000,
      proximaRevisao: 25000,
      proprietario: 'Maria Santos',
      telefone: '(11) 91234-5678',
      email: 'maria@email.com',
      ultimaManutencao: '10/03/2026',
      historicoKm: [
        HistoricoKm(data: '10/03/2026', km: 22100),
        HistoricoKm(data: '10/12/2025', km: 20000),
        HistoricoKm(data: '15/08/2025', km: 15000),
      ],
    ),
  ];

  List<Veiculo> get veiculos => _veiculos;

  Veiculo? getVeiculoById(String id) {
    try {
      return _veiculos.firstWhere((v) => v.id == id);
    } catch (e) {
      return null;
    }
  }

  void atualizarKm(String veiculoId, int novaKm) {
    final index = _veiculos.indexWhere((v) => v.id == veiculoId);
    if (index != -1) {
      final veiculo = _veiculos[index];
      final novoHistorico = [
        HistoricoKm(
          data: DateTime.now().toString().split(' ')[0],
          km: novaKm,
        ),
        ...veiculo.historicoKm.take(4),
      ];
      
      _veiculos[index] = veiculo.copyWith(
        kmAtual: novaKm,
        historicoKm: novoHistorico,
      );
      notifyListeners();
    }
  }

  void adicionarVeiculo(Veiculo veiculo) {
    _veiculos.add(veiculo);
    notifyListeners();
  }
}
