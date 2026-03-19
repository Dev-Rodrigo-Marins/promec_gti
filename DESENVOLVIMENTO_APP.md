# ProMec-GTI - Guia de Desenvolvimento do App Mobile

## 📱 Sobre o Projeto

O **ProMec-GTI** é um sistema de gestão para oficinas mecânicas com interface mobile-first. Este documento contém todas as informações necessárias para desenvolver versões nativas do aplicativo.

---

## 🎨 Design e Funcionalidades

### Funcionalidades Principais
1. **Cadastrar Veículo** - Formulário completo para cadastro de veículos e proprietários
2. **Procurar Veículo** - Busca e visualização de veículos cadastrados
3. **Visualizar Agenda** - Gerenciamento de agendamentos de serviços
4. **Visualizar Orçamentos** - Controle de orçamentos e aprovações

### Esquema de Cores
- **Primary**: `#2563EB` (Blue 600) até `#1D4ED8` (Blue 700)
- **Success**: `#16A34A` (Green 600)
- **Warning**: `#CA8A04` (Yellow 600)
- **Error**: `#DC2626` (Red 600)
- **Purple**: `#9333EA` (Purple 600)
- **Orange**: `#EA580C` (Orange 600)
- **Background**: `#F8FAFC` (Slate 50)

---

## 🚀 Tecnologias Recomendadas

### Para React Native

#### 1. Criar o Projeto
```bash
npx react-native init ProMecGTI
cd ProMecGTI
```

#### 2. Instalar Dependências Essenciais
```bash
# Navegação
npm install @react-navigation/native @react-navigation/bottom-tabs @react-navigation/stack
npm install react-native-screens react-native-safe-area-context

# UI Components
npm install react-native-paper
npm install react-native-vector-icons

# Formulários
npm install react-hook-form

# Gradientes
npm install react-native-linear-gradient

# Date Picker (opcional)
npm install @react-native-community/datetimepicker
```

#### 3. Configuração do Android
No arquivo `android/app/build.gradle`:
```gradle
apply from: "../../node_modules/react-native-vector-icons/fonts.gradle"
```

---

### Para Flutter

#### 1. Criar o Projeto
```bash
flutter create promec_gti
cd promec_gti
```

#### 2. Adicionar Dependências no pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI e Navegação
  go_router: ^13.0.0
  
  # Estado
  provider: ^6.1.1
  
  # Formulários
  flutter_form_builder: ^9.1.1
  
  # Ícones
  lucide_icons: ^0.263.0
  
  # HTTP (para futuras integrações)
  http: ^1.1.0
```

---

## 📊 Estrutura de Dados

### Modelo de Veículo
```typescript
interface Veiculo {
  id: string;
  placa: string;
  marca: string;
  modelo: string;
  ano: string;
  cor: string;
  proprietario: string;
  telefone: string;
  email?: string;
  ultimaVisita?: string;
}
```

### Modelo de Agendamento
```typescript
interface Agendamento {
  id: string;
  data: string;
  hora: string;
  veiculo: string;
  proprietario: string;
  servico: string;
  status: 'pendente' | 'confirmado' | 'concluido';
}
```

### Modelo de Orçamento
```typescript
interface Orcamento {
  id: string;
  numero: string;
  data: string;
  veiculo: string;
  proprietario: string;
  servicos: string[];
  valor: number;
  status: 'pendente' | 'aprovado' | 'recusado';
}
```

---

## 🏗️ Arquitetura Recomendada

### Estrutura de Pastas (React Native)
```
src/
├── components/
│   ├── common/
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   ├── Input.tsx
│   │   └── Badge.tsx
│   └── layout/
│       ├── Header.tsx
│       └── BottomNav.tsx
├── screens/
│   ├── HomeScreen.tsx
│   ├── CadastrarVeiculoScreen.tsx
│   ├── ProcurarVeiculoScreen.tsx
│   ├── AgendaScreen.tsx
│   └── OrcamentosScreen.tsx
├── services/
│   ├── api.ts
│   └── storage.ts
├── types/
│   └── models.ts
├── navigation/
│   └── AppNavigator.tsx
└── App.tsx
```

### Estrutura de Pastas (Flutter)
```
lib/
├── models/
│   ├── veiculo.dart
│   ├── agendamento.dart
│   └── orcamento.dart
├── screens/
│   ├── home_screen.dart
│   ├── cadastrar_veiculo_screen.dart
│   ├── procurar_veiculo_screen.dart
│   ├── agenda_screen.dart
│   └── orcamentos_screen.dart
├── widgets/
│   ├── custom_button.dart
│   ├── custom_card.dart
│   └── bottom_navigation.dart
├── services/
│   ├── api_service.dart
│   └── storage_service.dart
└── main.dart
```

---

## 🔧 Implementação React Native

### Exemplo: Bottom Navigation
```tsx
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import Icon from 'react-native-vector-icons/Lucide';

const Tab = createBottomTabNavigator();

function AppNavigator() {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarIcon: ({ focused, color, size }) => {
          let iconName;
          
          switch (route.name) {
            case 'Home':
              iconName = 'home';
              break;
            case 'Cadastrar':
              iconName = 'car';
              break;
            case 'Buscar':
              iconName = 'search';
              break;
            case 'Agenda':
              iconName = 'calendar';
              break;
            case 'Orçamentos':
              iconName = 'file-text';
              break;
          }
          
          return <Icon name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: '#2563EB',
        tabBarInactiveTintColor: '#64748B',
      })}
    >
      <Tab.Screen name="Home" component={HomeScreen} />
      <Tab.Screen name="Cadastrar" component={CadastrarVeiculoScreen} />
      <Tab.Screen name="Buscar" component={ProcurarVeiculoScreen} />
      <Tab.Screen name="Agenda" component={AgendaScreen} />
      <Tab.Screen name="Orçamentos" component={OrcamentosScreen} />
    </Tab.Navigator>
  );
}
```

### Exemplo: Card Component
```tsx
import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';

interface CardProps {
  children: React.ReactNode;
  onPress?: () => void;
}

export function Card({ children, onPress }: CardProps) {
  const Component = onPress ? TouchableOpacity : View;
  
  return (
    <Component 
      style={styles.card} 
      onPress={onPress}
      activeOpacity={0.7}
    >
      {children}
    </Component>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginVertical: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
});
```

---

## 🔧 Implementação Flutter

### Exemplo: Bottom Navigation
```dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    HomeScreen(),
    CadastrarVeiculoScreen(),
    ProcurarVeiculoScreen(),
    AgendaScreen(),
    OrcamentosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF2563EB),
        unselectedItemColor: Color(0xFF64748B),
        items: [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.car),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.calendar),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.fileText),
            label: 'Orçamentos',
          ),
        ],
      ),
    );
  }
}
```

### Exemplo: Card Widget
```dart
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  
  const CustomCard({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
```

---

## 💾 Persistência de Dados

### Opções para React Native
1. **AsyncStorage** - Para dados simples
```bash
npm install @react-native-async-storage/async-storage
```

2. **SQLite** - Para dados relacionais
```bash
npm install react-native-sqlite-storage
```

3. **Realm** - Para banco de dados mobile robusto
```bash
npm install realm
```

### Opções para Flutter
1. **SharedPreferences** - Para dados simples
```yaml
shared_preferences: ^2.2.2
```

2. **SQLite** - Para dados relacionais
```yaml
sqflite: ^2.3.0
```

3. **Hive** - Para banco NoSQL rápido
```yaml
hive: ^2.2.3
hive_flutter: ^1.1.0
```

---

## 🌐 Integração com Backend

### Supabase (Recomendado)

#### React Native
```bash
npm install @supabase/supabase-js
```

```typescript
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'SUA_URL_SUPABASE';
const supabaseKey = 'SUA_CHAVE_PUBLICA';

export const supabase = createClient(supabaseUrl, supabaseKey);
```

#### Flutter
```yaml
supabase_flutter: ^2.0.0
```

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

await Supabase.initialize(
  url: 'SUA_URL_SUPABASE',
  anonKey: 'SUA_CHAVE_PUBLICA',
);

final supabase = Supabase.instance.client;
```

### Estrutura de Tabelas Supabase
```sql
-- Tabela de Veículos
CREATE TABLE veiculos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  placa VARCHAR(10) NOT NULL UNIQUE,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  ano VARCHAR(4) NOT NULL,
  cor VARCHAR(30),
  proprietario VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Agendamentos
CREATE TABLE agendamentos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  veiculo_id UUID REFERENCES veiculos(id),
  data DATE NOT NULL,
  hora TIME NOT NULL,
  servico TEXT NOT NULL,
  status VARCHAR(20) DEFAULT 'pendente',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Tabela de Orçamentos
CREATE TABLE orcamentos (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  numero VARCHAR(20) UNIQUE NOT NULL,
  veiculo_id UUID REFERENCES veiculos(id),
  servicos JSONB NOT NULL,
  valor DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) DEFAULT 'pendente',
  created_at TIMESTAMP DEFAULT NOW()
);
```

---

## 📱 Recursos Nativos

### Permissões Necessárias

#### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" /> <!-- Para escanear placas -->
<uses-permission android:name="android.permission.CALL_PHONE" /> <!-- Para ligar direto -->
```

#### iOS (Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Precisamos acessar a câmera para escanear placas de veículos</string>
<key>NSContactsUsageDescription</key>
<string>Precisamos acessar os contatos para facilitar o cadastro</string>
```

---

## 🎯 Roadmap de Desenvolvimento

### Fase 1 - MVP (2-3 semanas)
- [ ] Configuração do projeto
- [ ] Navegação entre telas
- [ ] Tela inicial com menu
- [ ] Cadastro de veículos (local)
- [ ] Listagem de veículos

### Fase 2 - Funcionalidades Core (3-4 semanas)
- [ ] Sistema de agendamentos
- [ ] Sistema de orçamentos
- [ ] Busca e filtros
- [ ] Persistência local de dados

### Fase 3 - Backend (2-3 semanas)
- [ ] Integração com Supabase
- [ ] Sincronização de dados
- [ ] Sistema de autenticação
- [ ] Backup em nuvem

### Fase 4 - Recursos Avançados (3-4 semanas)
- [ ] Scanner de placa com câmera
- [ ] Notificações push
- [ ] Relatórios e estatísticas
- [ ] Exportação de dados (PDF)
- [ ] Modo offline completo

### Fase 5 - Polimento (2 semanas)
- [ ] Testes de usabilidade
- [ ] Otimização de performance
- [ ] Correção de bugs
- [ ] Preparação para publicação

---

## 📚 Recursos Úteis

### Documentação
- [React Native](https://reactnative.dev/)
- [Flutter](https://flutter.dev/)
- [Supabase](https://supabase.com/docs)
- [React Navigation](https://reactnavigation.org/)

### Tutoriais Recomendados
- [React Native Full Course](https://www.youtube.com/results?search_query=react+native+full+course)
- [Flutter Complete Guide](https://www.youtube.com/results?search_query=flutter+complete+guide)
- [Supabase Tutorial](https://www.youtube.com/results?search_query=supabase+tutorial)

---

## 🤝 Contribuindo

Este projeto está aberto para melhorias! Algumas ideias:
- Sistema de notificações para lembrar clientes
- Integração com WhatsApp para envio de orçamentos
- Sistema de estoque de peças
- Controle financeiro integrado
- Dashboard com métricas da oficina

---

## 📄 Licença

Este projeto é de código aberto. Sinta-se livre para usar e modificar conforme necessário.

---

## 💡 Dicas Finais

1. **Comece Simples**: Implemente primeiro a versão offline com dados mockados
2. **Teste Continuamente**: Teste em dispositivos reais, não só em emuladores
3. **UX First**: Priorize a experiência do usuário, mantenha a interface intuitiva
4. **Performance**: Otimize listas longas com FlatList (RN) ou ListView.builder (Flutter)
5. **Segurança**: Nunca exponha chaves de API no código, use variáveis de ambiente

---

**Desenvolvido para ProMec-GTI** 🔧
Versão 1.0 - Março 2026
```
