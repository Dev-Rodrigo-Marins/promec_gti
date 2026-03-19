import 'package:flutter/material.dart';

class OficinasCredenciadasScreen extends StatelessWidget {
  const OficinasCredenciadasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oficinas = ['Oficina Silva', 'Auto Center RS'];

    return Scaffold(
      appBar: AppBar(title: const Text('Oficinas')),
      body: ListView(
        children: oficinas
            .map((o) => Card(child: ListTile(title: Text(o))))
            .toList(),
      ),
    );
  }
}