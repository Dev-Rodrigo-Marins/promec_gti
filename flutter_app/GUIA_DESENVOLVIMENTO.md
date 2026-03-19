# 📱 Guia Completo de Desenvolvimento - ProMec-GTI Flutter

Este guia fornece toda a estrutura e exemplos de código para desenvolver o aplicativo completo.

## 🗂️ Estrutura Completa do Projeto

```
flutter_app/
├── lib/
│   ├── main.dart
│   ├── routes/
│   │   └── app_router.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── veiculo_provider.dart
│   │   ├── servico_provider.dart
│   │   └── orcamento_provider.dart
│   ├── models/
│   │   ├── veiculo.dart
│   │   ├── servico.dart
│   │   ├── orcamento.dart
│   │   ├── agendamento.dart
│   │   └── oficina.dart
│   ├── screens/
│   │   ├── login/
│   │   │   └── login_screen.dart ✅
│   │   ├── cliente/
│   │   │   ├── home_cliente_screen.dart
│   │   │   ├── meus_veiculos_screen.dart ✅
│   │   │   ├── orcamentos_cliente_screen.dart
│   │   │   ├── historico_cliente_screen.dart
│   │   │   ├── solicitar_guincho_screen.dart
│   │   │   └── oficinas_credenciadas_screen.dart
│   │   └── oficina/
│   │       ├── home_oficina_screen.dart
│   │       ├── cadastrar_veiculo_screen.dart
│   │       ├── procurar_veiculo_screen.dart
│   │       ├── agenda_screen.dart
│   │       ├── orcamentos_screen.dart
│   │       ├── cadastrar_servicos_screen.dart
│   │       ├── montar_orcamento_screen.dart
│   │       └── historico_veiculo_screen.dart
│   └── widgets/
│       ├── layouts/
│       │   ├── cliente_layout.dart ✅
│       │   └── oficina_layout.dart ✅
│       └── common/
│           ├── custom_button.dart
│           ├── custom_card.dart
│           ├── status_badge.dart
│           └── loading_indicator.dart
├── pubspec.yaml ✅
└── README.md ✅
```

## 📝 Arquivos Já Criados

✅ Estrutura base
✅ Sistema de navegação (GoRouter)
✅ Providers (Auth e Veículo)
✅ Tela de Login completa
✅ Layouts (Cliente e Oficina)
✅ Tela "Meus Veículos" completa com alertas

## 🔨 Modelos de Dados Necessários

### Modelo de Serviço
```dart
// lib/models/servico.dart
class Servico {
  final String id;
  final String nome;
  final String categoria; // 'Preventiva', 'Corretiva', 'Diagnóstico'
  final double valor;
  final String tempo; // Ex: "30 min", "1h"

  Servico({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.valor,
    required this.tempo,
  });
}
```

### Modelo de Orçamento
```dart
// lib/models/orcamento.dart
class Orcamento {
  final String id;
  final String numero;
  final DateTime data;
  final String veiculoId;
  final String veiculo;
  final String proprietario;
  final List<ItemOrcamento> servicos;
  final double valor;
  final String status; // 'pendente', 'aprovado', 'recusado', 'concluido'
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
}

class ItemOrcamento {
  final String servicoId;
  final String nome;
  final int quantidade;
  final double valorUnitario;
  final double desconto; // percentual

  ItemOrcamento({
    required this.servicoId,
    required this.nome,
    required this.quantidade,
    required this.valorUnitario,
    this.desconto = 0,
  });

  double get subtotal => valorUnitario * quantidade;
  double get descontoValor => subtotal * (desconto / 100);
  double get total => subtotal - descontoValor;
}
```

### Modelo de Agendamento
```dart
// lib/models/agendamento.dart
class Agendamento {
  final String id;
  final DateTime data;
  final String hora;
  final String veiculo;
  final String proprietario;
  final String servico;
  final String status; // 'pendente', 'confirmado', 'concluido'

  Agendamento({
    required this.id,
    required this.data,
    required this.hora,
    required this.veiculo,
    required this.proprietario,
    required this.servico,
    required this.status,
  });
}
```

### Modelo de Oficina
```dart
// lib/models/oficina.dart
class Oficina {
  final String id;
  final String nome;
  final String endereco;
  final double distancia; // em km
  final double avaliacao;
  final int avaliacoes;
  final String telefone;
  final String horario;
  final List<String> especialidades;
  final String tempoEspera; // 'Baixo', 'Médio', 'Alto'
  final bool aberto;

  Oficina({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.distancia,
    required this.avaliacao,
    required this.avaliacoes,
    required this.telefone,
    required this.horario,
    required this.especialidades,
    required this.tempoEspera,
    required this.aberto,
  });
}
```

## 🎨 Exemplos de Telas para Implementar

### Home do Cliente
```dart
// lib/screens/cliente/home_cliente_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeClienteScreen extends StatelessWidget {
  const HomeClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card do usuário
          Card(
            color: const Color(0xFF2563EB),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, João Silva!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Bem-vindo de volta',
                              style: TextStyle(
                                color: Color(0xFFBFDBFE),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 24,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: const Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seus Veículos',
                          style: TextStyle(
                            color: Color(0xFFBFDBFE),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: const Text('ABC-1234 - Gol 2020'),
                              backgroundColor: Colors.white.withOpacity(0.2),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Chip(
                              label: const Text('DEF-5678 - Civic 2021'),
                              backgroundColor: Colors.white.withOpacity(0.2),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Menu de opções
          const Text(
            'O que você precisa?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildMenuItem(
            context,
            'Meus Veículos',
            'Atualize quilometragem e veja alertas',
            Icons.directions_car,
            const Color(0xFF4F46E5),
            '/cliente/veiculos',
            badge: 'Novo',
          ),
          _buildMenuItem(
            context,
            'Meus Orçamentos',
            'Visualize seus orçamentos',
            Icons.description,
            const Color(0xFF2563EB),
            '/cliente/orcamentos',
            badge: '2 novos',
          ),
          _buildMenuItem(
            context,
            'Histórico de Manutenção',
            'Veja o histórico dos seus veículos',
            Icons.history,
            const Color(0xFF10B981),
            '/cliente/historico',
          ),
          _buildMenuItem(
            context,
            'Solicitar Guincho',
            'Precisa de reboque?',
            Icons.local_shipping,
            const Color(0xFFEF4444),
            '/cliente/guincho',
            badge: '24h',
          ),
          _buildMenuItem(
            context,
            'Oficinas Credenciadas',
            'Encontre a mais próxima',
            Icons.location_on,
            const Color(0xFF8B5CF6),
            '/cliente/oficinas',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String titulo,
    String descricao,
    IconData icone,
    Color cor,
    String rota, {
    String? badge,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push(rota),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cor, cor.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icone, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              badge,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      descricao,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🎯 Widgets Reutilizáveis

### Custom Button
```dart
// lib/widgets/common/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final Color? cor;
  final IconData? icone;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.texto,
    this.onPressed,
    this.cor,
    this.icone,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: cor ?? const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icone != null) ...[
                  Icon(icone, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }
}
```

### Status Badge
```dart
// lib/widgets/common/status_badge.dart
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String texto;
  final Color cor;

  const StatusBadge({
    super.key,
    required this.texto,
    required this.cor,
  });

  factory StatusBadge.urgente() {
    return const StatusBadge(
      texto: 'Urgente',
      cor: Colors.red,
    );
  }

  factory StatusBadge.atencao() {
    return const StatusBadge(
      texto: 'Atenção',
      cor: Colors.orange,
    );
  }

  factory StatusBadge.ok() {
    return const StatusBadge(
      texto: 'OK',
      cor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.1),
        border: Border.all(color: cor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: cor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
```

## 🚀 Próximos Passos de Desenvolvimento

1. **Implementar Telas Restantes**
   - Seguir os exemplos fornecidos
   - Usar os modelos de dados criados
   - Reutilizar widgets comuns

2. **Adicionar Providers**
   - ServicoProvider
   - OrcamentoProvider
   - AgendamentoProvider

3. **Integração com Backend**
   - Adicionar Supabase
   - Implementar API calls
   - Gerenciar autenticação real

4. **Funcionalidades Avançadas**
   - Scanner de placa (camera)
   - Notificações push
   - Modo offline
   - Exportar PDF

## 📚 Recursos Úteis

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Provider Package](https://pub.dev/packages/provider)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Material Design 3](https://m3.material.io/)

## 💡 Dicas de Desenvolvimento

1. **Use Hot Reload**: Ctrl+S (ou Cmd+S) para ver mudanças instantâneas
2. **Debug**: Use `print()` ou breakpoints no VS Code
3. **Widgets**: Extraia widgets reutilizáveis para manter o código limpo
4. **State Management**: Use Provider para gerenciar estado global
5. **Testes**: Adicione testes unitários para lógica de negócio

---

**Desenvolvido para ProMec-GTI** 🔧
Versão Flutter 1.0.0
