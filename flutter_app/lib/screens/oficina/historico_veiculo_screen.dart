import 'package:flutter/material.dart';

class HistoricoVeiculoScreen extends StatelessWidget {
  final String veiculoId;

  const HistoricoVeiculoScreen({
    super.key,
    required this.veiculoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico do Veículo')),
      body: Center(
        child: Text('Histórico do veículo: $veiculoId'),
      ),
    );
  }
}