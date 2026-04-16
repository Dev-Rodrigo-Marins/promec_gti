class Orcamento {
  final String id;
  final String numero;
  final DateTime data;
  final String veiculoId;
  final String veiculo;
  final String proprietario;
  final List<ItemOrcamento> servicos;
  final double valor;
  final String status;
  final DateTime validade;
  final String? observacoes;

  Orcamento({
    required this.id,
    required this.numero,
    required this.data,
    required this.veiculoId,
    required this.veiculo,
    required this.proprietario,
    required this.servicos,
    required this.valor,
    required this.status,
    required this.validade,
    this.observacoes,
  });

  bool get isPendente => status == 'pendente';
  bool get isAprovado => status == 'aprovado';
  bool get isRecusado => status == 'recusado';
  bool get isConcluido => status == 'concluido';

  bool get isVencido => validade.isBefore(DateTime.now());

  factory Orcamento.fromJson(Map<String, dynamic> json) {
  return Orcamento(
    id: json['id'],
    numero: json['numero_orcamento'],
    data: DateTime.parse(json['data_criacao']),
    veiculoId: '',
    veiculo: 'Não informado', // API ainda não envia
    proprietario: '',
    servicos: (json['itens'] as List)
        .map((item) => ItemOrcamento.fromJson(item))
        .toList(),
    valor: double.parse(json['valor_total'].toString()),
    status: json['status'],
    validade: DateTime.now(), // ajustar quando API tiver esse campo
    observacoes: null,
  );
}
}

class ItemOrcamento {
  final String servicoId;
  final String nome;
  final int quantidade;
  final double valorUnitario;

  ItemOrcamento({
    required this.servicoId,
    required this.nome,
    required this.quantidade,
    required this.valorUnitario,
  });

  double get total => quantidade * valorUnitario;

  factory ItemOrcamento.fromJson(Map<String, dynamic> json) {
  return ItemOrcamento(
    servicoId: '',
    nome: json['servico'],
    quantidade: json['quantidade'],
    valorUnitario: double.parse(json['valor'].toString()),
  );
}
}