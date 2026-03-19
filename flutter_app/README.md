# ProMec-GTI - Flutter

Sistema de Gestão de Oficina Mecânica desenvolvido em Flutter/Dart.

## 📱 Sobre o Projeto

O **ProMec-GTI** é um sistema completo de gestão para oficinas mecânicas e seus clientes, desenvolvido com Flutter para funcionar em Android e iOS.

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK 3.0.0 ou superior
- Dart 3.0.0 ou superior
- Android Studio / Xcode (para emuladores)
- Dispositivo Android/iOS ou emulador configurado

### Instalação

1. Clone o repositório
2. Entre na pasta do projeto Flutter:
```bash
cd flutter_app
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Execute o aplicativo:
```bash
flutter run
```

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada
├── routes/
│   └── app_router.dart      # Configuração de rotas
├── providers/
│   ├── auth_provider.dart   # Gerenciamento de autenticação
│   └── veiculo_provider.dart # Gerenciamento de veículos
├── models/
│   └── veiculo.dart         # Modelos de dados
├── screens/
│   ├── login/               # Tela de login
│   ├── cliente/             # Telas da área do cliente
│   └── oficina/             # Telas da área da oficina
└── widgets/
    └── layouts/             # Layouts compartilhados
```

## 🎨 Funcionalidades

### Área do Cliente
- ✅ Login diferenciado
- 🚗 Meus Veículos (com atualização de KM e alertas)
- 📄 Meus Orçamentos
- 📊 Histórico de Manutenção
- 🚛 Solicitar Guincho
- 📍 Oficinas Credenciadas

### Área da Oficina
- ✅ Login diferenciado
- 🚗 Cadastrar Veículo
- 🔍 Procurar Veículo
- 📅 Agenda de Serviços
- 📄 Gerenciar Orçamentos
- 🔧 Cadastrar Serviços
- ➕ Montar Orçamento
- 📊 Histórico do Veículo

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.0+** - Framework multiplataforma
- **Dart 3.0+** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **GoRouter** - Navegação
- **Google Fonts** - Tipografia
- **SharedPreferences** - Armazenamento local

## 📱 Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  go_router: ^13.0.0
  google_fonts: ^6.1.0
  lucide_icons_flutter: ^1.0.0
  shared_preferences: ^2.2.2
  fluttertoast: ^8.2.4
```

## 🎯 Próximos Passos

- [ ] Integração com backend (Supabase)
- [ ] Notificações push
- [ ] Scanner de placa com câmera
- [ ] Modo offline completo
- [ ] Exportação de relatórios em PDF
- [ ] Sistema de pagamento integrado

## 📄 Licença

Este projeto é de código aberto.

## 👥 Contribuindo

Contribuições são bem-vindas! Sinta-se livre para abrir issues e pull requests.

---

**Desenvolvido para ProMec-GTI** 🔧
Versão 1.0.0 - Março 2026
