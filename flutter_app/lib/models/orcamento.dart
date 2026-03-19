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
}