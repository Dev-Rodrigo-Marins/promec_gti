import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/login/login_screen.dart';
import '../screens/cliente/home_cliente_screen.dart';
import '../screens/cliente/meus_veiculos_screen.dart';
import '../screens/cliente/orcamentos_cliente_screen.dart';
import '../screens/cliente/historico_cliente_screen.dart';
import '../screens/cliente/solicitar_guincho_screen.dart';
import '../screens/cliente/oficinas_credenciadas_screen.dart';
import '../screens/oficina/home_oficina_screen.dart';
import '../screens/oficina/cadastrar_veiculo_screen.dart';
import '../screens/oficina/procurar_veiculo_screen.dart';
import '../screens/oficina/agenda_screen.dart';
import '../screens/oficina/orcamentos_oficina_screen.dart';
import '../screens/oficina/cadastrar_servicos_screen.dart';
import '../screens/oficina/montar_orcamento_screen.dart';
import '../screens/oficina/historico_veiculo_screen.dart';
import '../widgets/layouts/cliente_layout.dart';
import '../widgets/layouts/oficina_layout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // Rotas do Cliente
    ShellRoute(
      builder: (context, state, child) => ClienteLayout(child: child),
      routes: [
        GoRoute(
          path: '/cliente',
          builder: (context, state) => const HomeClienteScreen(),
        ),
        GoRoute(
          path: '/cliente/veiculos',
          builder: (context, state) => const MeusVeiculosScreen(),
        ),
        GoRoute(
          path: '/cliente/orcamentos',
          builder: (context, state) => const OrcamentosClienteScreen(),
        ),
        GoRoute(
          path: '/cliente/historico',
          builder: (context, state) => const HistoricoClienteScreen(),
        ),
        GoRoute(
          path: '/cliente/guincho',
          builder: (context, state) => const SolicitarGuinchoScreen(),
        ),
        GoRoute(
          path: '/cliente/oficinas',
          builder: (context, state) => const OficinasCredenciadasScreen(),
        ),
      ],
    ),
    
    // Rotas da Oficina
    ShellRoute(
      builder: (context, state, child) => OficinaLayout(child: child),
      routes: [
        GoRoute(
          path: '/oficina',
          builder: (context, state) => const HomeOficinaScreen(),
        ),
        GoRoute(
          path: '/oficina/cadastrar-veiculo',
          builder: (context, state) => const CadastrarVeiculoScreen(),
        ),
        GoRoute(
          path: '/oficina/procurar-veiculo',
          builder: (context, state) => const ProcurarVeiculoScreen(),
        ),
        GoRoute(
          path: '/oficina/agenda',
          builder: (context, state) => const AgendaScreen(),
        ),
        GoRoute(
          path: '/oficina/orcamentos',
          builder: (context, state) => const OrcamentosOficinaScreen(),
        ),
        GoRoute(
          path: '/oficina/cadastrar-servicos',
          builder: (context, state) => const CadastrarServicosScreen(),
        ),
        GoRoute(
          path: '/oficina/montar-orcamento',
          builder: (context, state) => const MontarOrcamentoScreen(),
        ),
        GoRoute(
          path: '/oficina/historico-veiculo/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return HistoricoVeiculoScreen(veiculoId: id);
          },
        ),
      ],
    ),
  ],
);
