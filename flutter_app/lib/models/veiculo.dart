class Veiculo {
  final String id;
  final String placa;
  final String marca;
  final String modelo;
  final String ano;
  final String cor;
  final int kmAtual;
  final int ultimaRevisao;
  final int proximaRevisao;
  final String proprietario;
  final String telefone;
  final String? email;
  final String ultimaManutencao;
  final List<HistoricoKm> historicoKm;

  Veiculo({
    required this.id,
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.cor,
    required this.kmAtual,
    required this.ultimaRevisao,
    required this.proximaRevisao,
    required this.proprietario,
    required this.telefone,
    this.email,
    required this.ultimaManutencao,
    required this.historicoKm,
  });

  Veiculo copyWith({
    String? id,
    String? placa,
    String? marca,
    String? modelo,
    String? ano,
    String? cor,
    int? kmAtual,
    int? ultimaRevisao,
    int? proximaRevisao,
    String? proprietario,
    String? telefone,
    String? email,
    String? ultimaManutencao,
    List<HistoricoKm>? historicoKm,
  }) {
    return Veiculo(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      ano: ano ?? this.ano,
      cor: cor ?? this.cor,
      kmAtual: kmAtual ?? this.kmAtual,
      ultimaRevisao: ultimaRevisao ?? this.ultimaRevisao,
      proximaRevisao: proximaRevisao ?? this.proximaRevisao,
      proprietario: proprietario ?? this.proprietario,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      ultimaManutencao: ultimaManutencao ?? this.ultimaManutencao,
      historicoKm: historicoKm ?? this.historicoKm,
    );
  }

  StatusManutencao get statusManutencao {
    final kmParaRevisao = proximaRevisao - kmAtual;
    
    if (kmParaRevisao <= 0) {
      return StatusManutencao.urgente;
    } else if (kmParaRevisao <= 500) {
      return StatusManutencao.atencao;
    } else if (kmParaRevisao <= 2000) {
      return StatusManutencao.proximo;
    } else {
      return StatusManutencao.ok;
    }
  }

  int get kmParaRevisao => proximaRevisao - kmAtual;
}

class HistoricoKm {
  final String data;
  final int km;

  HistoricoKm({
    required this.data,
    required this.km,
  });
}

enum StatusManutencao {
  urgente,
  atencao,
  proximo,
  ok,
}
