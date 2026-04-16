class Orcamento {
  final String id;
  final String numero;
  final DateTime data;
  final String veiculo;
  final String? placa;
  final List<ItemOrcamento> servicos;
  final double valor;
  final String status;
  final DateTime validade;

  Orcamento({
    required this.id,
    required this.numero,
    required this.data,
    required this.veiculo,
    this.placa,
    required this.servicos,
    required this.valor,
    required this.status,
    required this.validade,
  });

  factory Orcamento.fromJson(Map<String, dynamic> json) {
    return Orcamento(
      id: json['id'],
      numero: json['numero_orcamento'],
      data: DateTime.parse(json['data_criacao']),
      veiculo: json['veiculo'] ?? '',
      placa: json['placa']?.toString(),
      valor: double.parse(json['valor_total'].toString()),
      status: json['status'],
      validade: DateTime.now().add(const Duration(days: 15)),

      servicos: (json['itens'] as List)
          .map((item) => ItemOrcamento.fromJson(item))
          .toList(),
    );
  }

  bool get isPendente => status == 'pendente';
  bool get isVencido => validade.isBefore(DateTime.now());
}

class ItemOrcamento {
  final String nome;
  final int quantidade;
  final double valor;

  ItemOrcamento({
    required this.nome,
    required this.quantidade,
    required this.valor,
  });

  factory ItemOrcamento.fromJson(Map<String, dynamic> json) {
    return ItemOrcamento(
      nome: json['servico'],
      quantidade: json['quantidade'],
      valor: double.parse(json['valor'].toString()),
    );
  }

  double get total => quantidade * valor;
}