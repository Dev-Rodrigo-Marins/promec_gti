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
import 'loading_route_builder.dart';

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
            builder: (context, state) => withLoading((ctx) => const HomeClienteScreen()),
        ),
        GoRoute(
          path: '/cliente/veiculos',
          builder: (context, state) => withLoading((ctx) => const MeusVeiculosScreen()),
        ),
        GoRoute(
          path: '/cliente/orcamentos',
          builder: (context, state) => withLoading((ctx) => const OrcamentosClienteScreen()),
        ),
        GoRoute(
          path: '/cliente/historico',
          builder: (context, state) => withLoading((ctx) => const HistoricoClienteScreen()),
        ),
        GoRoute(
          path: '/cliente/guincho',
          builder: (context, state) => withLoading((ctx) => const SolicitarGuinchoScreen()),
        ),
        GoRoute(
          path: '/cliente/oficinas',
          builder: (context, state) => withLoading((ctx) => const OficinasCredenciadasScreen()),
        ),
      ],
    ),
    // Rotas da Oficina
    ShellRoute(
      builder: (context, state, child) => OficinaLayout(child: child),
      routes: [
        GoRoute(
          path: '/oficina',
          builder: (context, state) => withLoading((ctx) => const HomeOficinaScreen()),
        ),
        GoRoute(
          path: '/oficina/cadastrar-veiculo',
          builder: (context, state) => withLoading((ctx) => const CadastrarVeiculoScreen()),
        ),
        GoRoute(
          path: '/oficina/procurar-veiculo',
          builder: (context, state) => withLoading((ctx) => const ProcurarVeiculoScreen()),
        ),
        GoRoute(
          path: '/oficina/agenda',
          builder: (context, state) => withLoading((ctx) => const AgendaScreen()),
        ),
        GoRoute(
          path: '/oficina/orcamentos',
          builder: (context, state) => withLoading((ctx) => const OrcamentosOficinaScreen()),
        ),
        GoRoute(
          path: '/oficina/cadastrar-servicos',
          builder: (context, state) => withLoading((ctx) => const CadastrarServicosScreen()),
        ),
        GoRoute(
          path: '/oficina/montar-orcamento',
          builder: (context, state) => withLoading((ctx) => const MontarOrcamentoScreen()),
        ),
        GoRoute(
          path: '/oficina/historico-veiculo/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return withLoading((ctx) => HistoricoVeiculoScreen(veiculoId: id));
          },
        ),
      ],
    ),
  ],
);
