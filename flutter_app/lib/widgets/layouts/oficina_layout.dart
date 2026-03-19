import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OficinaLayout extends StatelessWidget {
  final Widget child;

  const OficinaLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        elevation: 4,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.build,
                color: Color(0xFF2563EB),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ProMec-GTI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Gestão de Oficina',
                  style: TextStyle(
                    color: Color(0xFFBFDBFE),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (location != '/oficina')
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => context.go('/oficina'),
            ),
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(location),
        onTap: (index) => _onItemTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: const Color(0xFF64748B),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Orçamentos',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(String location) {
    if (location == '/oficina') return 0;
    if (location == '/oficina/cadastrar-veiculo') return 1;
    if (location == '/oficina/procurar-veiculo') return 2;
    if (location == '/oficina/agenda') return 3;
    if (location == '/oficina/orcamentos') return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/oficina');
        break;
      case 1:
        context.go('/oficina/cadastrar-veiculo');
        break;
      case 2:
        context.go('/oficina/procurar-veiculo');
        break;
      case 3:
        context.go('/oficina/agenda');
        break;
      case 4:
        context.go('/oficina/orcamentos');
        break;
    }
  }
}
