# 🔧 ProMec-GTI - Sistema de Gestão de Oficina

Sistema completo de gestão para oficinas mecânicas com interface mobile-first, desenvolvido com React, TypeScript, TailwindCSS e React Router.

---

## 📱 Sobre o Projeto

O **ProMec-GTI** é uma solução completa que oferece duas áreas distintas:

### 🏢 **Área da Oficina**
Sistema completo para gerenciamento de oficinas mecânicas com:
- Cadastro de veículos e clientes
- Gerenciamento de serviços
- Criação de orçamentos
- Controle de agenda
- Histórico detalhado de manutenções

### 👤 **Área do Cliente**
Portal para clientes acompanharem seus veículos com:
- Atualização de quilometragem
- Alertas inteligentes de manutenção
- Visualização de orçamentos
- Histórico de manutenções
- Solicitação de guincho 24h
- Busca de oficinas credenciadas

---

## 🚀 Como Executar o Projeto

### Pré-requisitos
- Node.js 18+ instalado
- npm ou pnpm

### Instalação

```bash
# Clone o repositório (ou extraia os arquivos)
cd promec-gti

# Instale as dependências
npm install
# ou
pnpm install

# Execute o projeto
npm run dev
# ou
pnpm dev
```

O projeto estará disponível em: `http://localhost:5173`

---

## 📂 Estrutura do Projeto

```
promec-gti/
├── src/
│   ├── app/
│   │   ├── components/
│   │   │   ├── figma/
│   │   │   │   └── ImageWithFallback.tsx
│   │   │   ├── ui/                          # Componentes de UI (shadcn/ui)
│   │   │   │   ├── accordion.tsx
│   │   │   │   ├── alert-dialog.tsx
│   │   │   │   ├── badge.tsx
│   │   │   │   ├── button.tsx
│   │   │   │   ├── card.tsx
│   │   │   │   ├── dialog.tsx
│   │   │   │   ├── input.tsx
│   │   │   │   ├── label.tsx
│   │   │   │   ├── select.tsx
│   │   │   │   ├── sonner.tsx
│   │   │   │   ├── textarea.tsx
│   │   │   │   └── ... (outros componentes UI)
│   │   │   ├── Layout.tsx                   # Layout da área da oficina
│   │   │   └── LayoutCliente.tsx            # Layout da área do cliente
│   │   │
│   │   ├── pages/
│   │   │   ├── cliente/                     # Páginas da área do cliente
│   │   │   │   ├── HomeCliente.tsx          # Dashboard do cliente
│   │   │   │   ├── MeusVeiculos.tsx         # Gerenciamento de veículos e KM
│   │   │   │   ├── OrcamentosCliente.tsx    # Orçamentos do cliente
│   │   │   │   ├── HistoricoCliente.tsx     # Histórico de manutenções
│   │   │   │   ├── SolicitarGuincho.tsx     # Solicitação de guincho
│   │   │   │   └── OficinasCredenciadas.tsx # Busca de oficinas
│   │   │   │
│   │   │   ├── Home.tsx                     # Home da oficina
│   │   │   ├── Login.tsx                    # Tela de login
│   │   │   ├── CadastrarVeiculo.tsx         # Cadastro de veículos
│   │   │   ├── ProcurarVeiculo.tsx          # Busca de veículos
│   │   │   ├── Agenda.tsx                   # Agenda de serviços
│   │   │   ├── Orcamentos.tsx               # Gerenciamento de orçamentos
│   │   │   ├── CadastrarServicos.tsx        # CRUD de serviços
│   │   │   ├── MontarOrcamento.tsx          # Criação de orçamentos
│   │   │   └── HistoricoVeiculo.tsx         # Histórico detalhado
│   │   │
│   │   ├── routes.tsx                       # Configuração de rotas
│   │   └── App.tsx                          # Componente principal
│   │
│   └── styles/
│       ├── fonts.css                        # Importação de fontes
│       ├── index.css                        # CSS principal
│       ├── tailwind.css                     # Configuração Tailwind
│       └── theme.css                        # Tema customizado
│
├── package.json                             # Dependências do projeto
├── vite.config.ts                           # Configuração Vite
├── postcss.config.mjs                       # Configuração PostCSS
├── DESENVOLVIMENTO_APP.md                   # Guia para app nativo
└── README.md                                # Este arquivo
```

---

## 🗺️ Rotas do Sistema

### 🔐 Autenticação
- `/login` - Tela de login (escolha entre Cliente ou Oficina)

### 🏢 Área da Oficina (`/`)
- `/` - Dashboard principal
- `/cadastrar-veiculo` - Cadastro de veículos
- `/procurar-veiculo` - Busca e listagem de veículos
- `/agenda` - Agenda de serviços
- `/orcamentos` - Gerenciamento de orçamentos
- `/cadastrar-servicos` - CRUD de serviços
- `/montar-orcamento` - Criar novos orçamentos
- `/historico-veiculo/:id` - Histórico completo de um veículo

### 👤 Área do Cliente (`/cliente`)
- `/cliente` - Dashboard do cliente
- `/cliente/veiculos` - **NOVO!** Gerenciar veículos e quilometragem
- `/cliente/orcamentos` - Visualizar e aprovar orçamentos
- `/cliente/historico` - Histórico de manutenções
- `/cliente/guincho` - Solicitar guincho 24h
- `/cliente/oficinas` - Buscar oficinas credenciadas

---

## ✨ Funcionalidades Principais

### 🏢 Para Oficinas

#### 1. **Gerenciamento de Veículos**
- Cadastro completo (placa, marca, modelo, proprietário, etc.)
- Busca inteligente por placa, proprietário ou modelo
- Histórico detalhado de cada veículo
- Visualização de todas as manutenções realizadas

#### 2. **Cadastro de Serviços**
- CRUD completo de serviços
- Categorização (Preventiva, Corretiva, Diagnóstico, Estética)
- Definição de valor e tempo estimado
- Organização automática por categoria

#### 3. **Montagem de Orçamentos**
- Seleção de veículo
- Busca e adição de serviços
- Quantidade ajustável
- Sistema de descontos por serviço
- Cálculos automáticos
- Definição de validade
- Observações personalizadas

#### 4. **Agenda de Serviços**
- Visualização por data
- Status: Confirmado, Pendente, Concluído
- Estatísticas (hoje, semana, mês)
- Informações completas do agendamento

#### 5. **Histórico Detalhado**
- Todos os serviços realizados
- Peças utilizadas com valores
- Mão de obra detalhada
- Observações técnicas
- Totais e subtotais

### 👤 Para Clientes

#### 1. **Meus Veículos** ⭐ NOVO
- Atualização de quilometragem
- **Sistema inteligente de alertas:**
  - 🔴 Urgente (revisão atrasada)
  - 🟡 Atenção (faltam ≤ 500 km)
  - 🔵 Próximo (faltam ≤ 2000 km)
  - 🟢 OK (mais de 2000 km)
- Estatísticas automáticas:
  - KM desde última revisão
  - Média mensal calculada
- Histórico de quilometragem
- Recomendações personalizadas

#### 2. **Meus Orçamentos**
- Visualização de orçamentos recebidos
- Filtros por status
- Aprovar/Recusar orçamentos
- Download em PDF
- Contato direto com oficina

#### 3. **Histórico de Manutenção**
- Visualização por veículo
- Manutenções preventivas e corretivas
- Valores investidos
- Próximas manutenções recomendadas

#### 4. **Solicitar Guincho**
- Serviço 24 horas
- Formulário completo
- Tempo estimado de chegada
- Rastreamento em tempo real
- Informações do motorista

#### 5. **Oficinas Credenciadas**
- Busca por proximidade
- Avaliações e reviews
- Especialidades
- Horário de funcionamento
- Tempo de espera estimado
- Navegação e contato

---

## 🎨 Design System

### Cores Principais
```css
/* Primary */
--blue-600: #2563EB
--blue-700: #1D4ED8

/* Categorias de Serviço */
--green-600: #16A34A    /* Preventiva */
--orange-600: #EA580C   /* Corretiva */
--purple-600: #9333EA   /* Diagnóstico */

/* Status */
--red-600: #DC2626      /* Urgente/Erro */
--yellow-600: #CA8A04   /* Atenção */
--blue-600: #2563EB     /* Info */
--green-600: #16A34A    /* Sucesso */

/* Background */
--slate-50: #F8FAFC
```

### Componentes UI
O projeto utiliza componentes do **shadcn/ui** customizados:
- Button
- Card
- Input
- Select
- Badge
- Dialog
- Textarea
- Toast (Sonner)
- E mais...

---

## 📊 Fluxos de Uso

### Fluxo 1: Cliente Atualiza Quilometragem

```
1. Cliente acessa /cliente/veiculos
2. Visualiza status atual de cada veículo
3. Clica em "Atualizar" no veículo desejado
4. Insere nova quilometragem
5. Sistema valida e calcula status
6. Recebe alerta se necessário
7. Vê recomendação de manutenção
8. Pode solicitar orçamento diretamente
```

### Fluxo 2: Oficina Cria Orçamento

```
1. Oficina acessa /montar-orcamento
2. Seleciona o veículo do cliente
3. Busca serviços necessários
4. Adiciona serviços ao orçamento
5. Ajusta quantidades e descontos
6. Define validade e observações
7. Visualiza resumo com total
8. Salva orçamento
9. Cliente recebe notificação
```

### Fluxo 3: Cliente Solicita Guincho

```
1. Cliente acessa /cliente/guincho
2. Preenche formulário:
   - Seleciona veículo
   - Informa localização
   - Define destino
   - Descreve problema
3. Vê valor estimado
4. Confirma solicitação
5. Recebe informações do guincho
6. Acompanha em tempo real
7. Pode contatar motorista
```

---

## 🔧 Tecnologias Utilizadas

### Core
- **React 18.3.1** - Biblioteca principal
- **TypeScript** - Tipagem estática
- **Vite 6.3.5** - Build tool
- **React Router 7.13.0** - Roteamento

### UI/Styling
- **TailwindCSS 4.1.12** - Framework CSS
- **Radix UI** - Componentes primitivos acessíveis
- **Lucide React** - Ícones
- **Motion** - Animações
- **Sonner** - Sistema de toast

### Forms & Data
- **React Hook Form 7.55.0** - Gerenciamento de formulários
- **Date-fns** - Manipulação de datas

### Outras
- **Class Variance Authority** - Variantes de classes CSS
- **clsx / tailwind-merge** - Merge de classes CSS

---

## 📱 Recursos Mobile-First

O sistema foi desenvolvido com foco mobile:

- ✅ Layout otimizado para celular (max-width: 448px)
- ✅ Bottom Navigation fixo
- ✅ Cards touch-friendly
- ✅ Inputs e botões em tamanhos adequados
- ✅ Scroll otimizado
- ✅ Feedback visual em toques (active:scale)
- ✅ Sticky headers
- ✅ Responsive em todas as telas

---

## 🔐 Sistema de Login

O login possui dois fluxos:

### Etapa 1: Seleção de Tipo
- Cliente → Redireciona para `/cliente`
- Oficina → Redireciona para `/`

### Etapa 2: Autenticação
- E-mail
- Senha (com opção de mostrar/ocultar)
- Lembrar-me
- Recuperação de senha
- Link para cadastro

---

## 📈 Próximos Passos

### Backend (Supabase Recomendado)
- [ ] Implementar autenticação
- [ ] Criar tabelas de banco de dados
- [ ] Sincronização de dados
- [ ] Upload de imagens
- [ ] Sistema de notificações

### Features Adicionais
- [ ] Scanner de placa com câmera
- [ ] Notificações push
- [ ] Chat com oficina
- [ ] Pagamento integrado
- [ ] Relatórios em PDF
- [ ] Dashboard com gráficos
- [ ] Sistema de avaliações
- [ ] Programa de fidelidade

### App Nativo
- [ ] Converter para React Native
- [ ] Converter para Flutter
- [ ] Publicar nas lojas

> 📘 Veja o arquivo `DESENVOLVIMENTO_APP.md` para guia completo de desenvolvimento mobile.

---

## 🎯 Como Usar Este Projeto

### Para Desenvolvimento Web
1. Clone/extraia os arquivos
2. Execute `npm install`
3. Execute `npm run dev`
4. Acesse `http://localhost:5173`

### Para Desenvolvimento Mobile
1. Leia o arquivo `DESENVOLVIMENTO_APP.md`
2. Escolha React Native ou Flutter
3. Siga as instruções de setup
4. Use este projeto como referência visual

### Para Produção
```bash
# Build do projeto
npm run build

# Preview do build
npm run preview
```

---

## 🤝 Contribuindo

Sugestões de melhorias:

1. **Backend Integration**
   - Integrar com Supabase
   - API REST
   - GraphQL

2. **Features Premium**
   - Assinatura para oficinas
   - Análise de dados com IA
   - Previsão de manutenções

3. **UX Improvements**
   - Onboarding interativo
   - Tutorial guiado
   - Modo escuro

4. **Integrações**
   - WhatsApp Business
   - Google Maps
   - Sistemas de pagamento

---

## 📄 Licença

Este projeto é de código aberto. Use e modifique livremente.

---

## 📞 Suporte

Para dúvidas ou sugestões:
- Leia a documentação completa
- Verifique os arquivos de exemplo
- Consulte o guia de desenvolvimento mobile

---

## 🎨 Screenshots

### Área da Oficina
- ✅ Dashboard com menu principal
- ✅ Cadastro de veículos
- ✅ Busca de veículos
- ✅ Cadastro de serviços
- ✅ Montagem de orçamentos
- ✅ Agenda de serviços
- ✅ Histórico detalhado

### Área do Cliente
- ✅ Dashboard personalizado
- ✅ Meus Veículos com alertas inteligentes
- ✅ Orçamentos com aprovação
- ✅ Histórico de manutenções
- ✅ Solicitação de guincho
- ✅ Busca de oficinas

---

## 🚀 Início Rápido

```bash
# 1. Instalar dependências
npm install

# 2. Executar em desenvolvimento
npm run dev

# 3. Acessar
# Área da Oficina: http://localhost:5173
# Área do Cliente: http://localhost:5173/cliente
# Login: http://localhost:5173/login
```

---

## 📚 Estrutura de Dados

### Veículo
```typescript
{
  id: number;
  placa: string;
  marca: string;
  modelo: string;
  ano: string;
  cor: string;
  proprietario: string;
  telefone: string;
  email?: string;
  kmAtual: number;
  ultimaRevisao: number;
  proximaRevisao: number;
}
```

### Serviço
```typescript
{
  id: number;
  nome: string;
  categoria: "Preventiva" | "Corretiva" | "Diagnóstico" | "Estética";
  valor: number;
  tempo: string;
}
```

### Orçamento
```typescript
{
  id: number;
  numero: string;
  data: string;
  veiculo: string;
  servicos: Array<{
    id: number;
    nome: string;
    quantidade: number;
    desconto: number;
    valor: number;
  }>;
  valor: number;
  status: "pendente" | "aprovado" | "recusado";
  validade: string;
}
```

---

**ProMec-GTI** - Sistema Completo de Gestão de Oficina 🔧
Desenvolvido com ❤️ usando React + TypeScript + TailwindCSS

Versão 1.0 - Março 2026
