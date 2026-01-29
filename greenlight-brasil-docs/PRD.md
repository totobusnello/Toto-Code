# PRD: Fintech de Educação Financeira Familiar - Inspirado no Greenlight

> **Documento de Produto** | Versão 1.0 | Janeiro 2026
>
> **Projeto**: App de mesada digital e educação financeira para famílias brasileiras
> **Autor**: Toto (CPO) | Gerado com auxílio de Claude Code

---

## Índice

1. [Resumo Executivo](#1-resumo-executivo)
2. [Análise do Greenlight (Referência)](#2-análise-do-greenlight-referência)
3. [Análise de Mercado Brasil](#3-análise-de-mercado-brasil)
4. [Funcionalidades Essenciais](#4-funcionalidades-essenciais)
5. [Arquitetura de Informação e Sitemap](#5-arquitetura-de-informação-e-sitemap)
6. [Jornadas de Usuário](#6-jornadas-de-usuário)
7. [Wireframes (ASCII)](#7-wireframes-ascii)
8. [Requisitos Técnicos](#8-requisitos-técnicos)
9. [Regras de Negócio Brasil](#9-regras-de-negócio-brasil)
10. [Monetização e Pricing](#10-monetização-e-pricing)
11. [Métricas e KPIs](#11-métricas-e-kpis)
12. [Plano de MVP](#12-plano-de-mvp)
13. [Riscos e Compliance](#13-riscos-e-compliance)
14. [Backlog Inicial](#14-backlog-inicial)

---

## 1. Resumo Executivo

### 1.1 Visão do Produto

Criar uma **fintech familiar brasileira** que permita pais ensinarem educação financeira aos filhos através de uma plataforma digital completa com:

- **Conta digital para menores** (6-17 anos) com supervisão parental
- **Cartão de débito** físico e virtual para crianças/adolescentes
- **Sistema de mesada digital** automatizado
- **Tarefas e recompensas** (chores) gamificadas
- **Metas de economia** com incentivos
- **Educação financeira** através de jogos e conteúdo
- **Controles parentais** completos (limites, categorias, localização)

### 1.2 Problema a Resolver

- **47% dos brasileiros** têm dificuldades em organizar o orçamento (Pesquisa Onze)
- **59% admitem** não saber como fazer planejamento financeiro
- **Falta de educação financeira** desde a infância
- Pais não têm ferramentas adequadas para ensinar finanças aos filhos
- Mesada em dinheiro físico não ensina gestão digital moderna

### 1.3 Proposta de Valor

> "Transforme a mesada em uma ferramenta de educação financeira. Seus filhos aprendem a ganhar, poupar, gastar e investir - com você no controle."

**Diferenciais:**
- 100% adaptado à realidade brasileira (PIX, boleto, CPF)
- Gamificação com elementos culturais brasileiros
- Integração com principais bancos via Open Finance
- Conteúdo educacional em português
- Compliance total com Bacen e LGPD

---

## 2. Análise do Greenlight (Referência)

### 2.1 Sobre o Greenlight

O [Greenlight](https://greenlight.com/) é a principal fintech de educação financeira familiar dos EUA:

- **+6 milhões de usuários** (Janeiro 2025)
- **Nota 3.8/5** no Trustpilot (+5.500 reviews)
- **Rating B** no BBB (Better Business Bureau)
- **Premiado** como melhor cartão de débito para crianças (Investopedia 2025)

### 2.2 🌟 O GRANDE DIFERENCIAL: Sistema de 4 Baldes (Money Management)

> **CORE FEATURE** - Este é o coração do produto Greenlight e deve ser o centro da nossa proposta de valor.

O Greenlight revolucionou a educação financeira infantil com o conceito de **"4 Baldes"** - cada centavo que entra na conta da criança é automaticamente dividido em 4 categorias que ensinam os pilares da gestão financeira:

```
┌─────────────────────────────────────────────────────────────────┐
│           💰 SISTEMA DE 4 BALDES (MONEY MANAGEMENT)             │
│                                                                 │
│  Cada mesada/ganho é dividido automaticamente:                  │
│                                                                 │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐│
│  │   💳        │ │   🐷        │ │   🎁        │ │   📈        ││
│  │   SPEND     │ │   SAVE      │ │   GIVE      │ │   INVEST    ││
│  │   (Gastar)  │ │   (Poupar)  │ │   (Doar)    │ │  (Investir) ││
│  │             │ │             │ │             │ │             ││
│  │   40%       │ │   30%       │ │   10%       │ │   20%       ││
│  │   padrão    │ │   padrão    │ │   padrão    │ │   padrão    ││
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘│
│                                                                 │
│  📊 RESULTADO 2024 (Greenlight):                                │
│  • $2 BILHÕES gerenciados por crianças                         │
│  • $259 milhões poupados                                       │
│  • Investimentos DOBRARAM vs 2023                              │
│  • 6.5 milhões de famílias ativas                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Como Funciona Cada Balde:

| Balde | Função | Benefício Educacional |
|-------|--------|----------------------|
| **💳 SPEND** | Saldo disponível para gastos com cartão | Aprende a fazer trade-offs, priorizar compras, viver dentro do orçamento |
| **🐷 SAVE** | Poupança com metas visuais (ex: "PS5") | Aprende gratificação adiada, planejamento, disciplina |
| **🎁 GIVE** | Reserva para doações e presentes | Aprende generosidade, empatia, responsabilidade social |
| **📈 INVEST** | Investimentos com aprovação dos pais | Aprende juros compostos, mercado financeiro, pensar no longo prazo |

#### Regras de Alocação:

1. **Pais definem %** - Percentual de cada balde é configurável
2. **Mesada auto-divide** - Cada depósito é automaticamente distribuído
3. **Filho pode realocar** - Com aprovação dos pais, pode mover entre baldes
4. **Metas vinculadas** - Balde SAVE pode ter múltiplas metas com progresso visual
5. **Juros incentivados** - Pais podem pagar "juros" extras no balde SAVE (ex: 10%/mês)

#### Por que isso é REVOLUCIONÁRIO:

> "Antes do Greenlight, mesada era: recebe R$50 → gasta R$50. Fim."
>
> "Com o sistema de baldes: recebe R$50 → R$20 para gastar, R$15 para a meta do PS5, R$5 para doar, R$10 investindo. A criança PENSA sobre dinheiro."

**Este sistema DEVE ser o centro do nosso produto brasileiro.**

---

### 2.3 Funcionalidades Complementares do Greenlight

| Categoria | Funcionalidades |
|-----------|-----------------|
| **Conta & Cartão** | Cartão de débito Mastercard, conta FDIC-insured até $250k, cartão virtual |
| **Controles Parentais** | Limites de gasto, bloqueio de categorias, desligar cartão, alertas em tempo real |
| **Mesada** | Auto-Allowance (semanal/mensal), transferências automáticas |
| **Tarefas (Chores)** | Criar tarefas, definir valores, aprovar conclusão, pagar automaticamente |
| **Poupança** | Metas customizadas, compartilhar com família, Round Ups, juros pagos pelos pais |
| **Investimentos** | Investir a partir de $1, ações fracionadas, ETFs (plano Max) |
| **Educação** | Level Up (jogo de literacia financeira), desafios, quizzes |
| **Segurança** | Localização, SOS alerts, Zero Liability Mastercard |
| **Cashback** | Cashback em compras (plano Max) |

### 2.4 Planos e Preços (EUA)

| Plano | Preço/mês | Principais Features |
|-------|-----------|---------------------|
| **Core** | $4.99 | Cartão, controles básicos, mesada, tarefas, 2% juros poupança |
| **Max** | $9.98 | Core + Investimentos + Cashback |
| **Infinity** | $14.98 | Max + Localização + SOS + Proteção identidade |
| **Family Shield** | Mais caro | Infinity + Features premium família |

*Todos os planos suportam até 5 crianças*

### 2.5 Modelo de Negócio Greenlight

1. **Assinaturas** (receita principal)
2. **Interchange fees** (taxa do Mastercard por transação)
3. **Spread de juros** (diferença entre juros pagos e investidos)
4. **Parcerias com bancos** (white-label para instituições)

---

## 3. Análise de Mercado Brasil

### 3.1 Concorrentes Diretos

| App | Banco | Faixa Etária | Pontos Fortes | Pontos Fracos |
|-----|-------|--------------|---------------|---------------|
| **Nubank Família** | Nubank | 6-17 anos | Marca forte, UX excelente | Poucas features educacionais |
| **C6 Yellow** | C6 Bank | <18 anos | CDB 102% CDI, cartões coloridos | Sem gamificação |
| **NextJoy** | Bradesco | 0-17 anos | Personagens Disney, trilhas educativas | Precisa ser correntista Next |
| **Inter Kids/You** | Inter | 0-17 anos | Completo, investimentos | Interface complexa |
| **PicPay Família** | PicPay | 0-17 anos | Cofrinhos, rendimento CDI+ | Menos foco educacional |
| **Mozper** | Independente | Crianças | 400k downloads em 10 meses | Ainda em crescimento |
| **Tindin** | Independente | Crianças | Gamificação forte | Menos recursos bancários |
| **Blu by BS2** | BS2 | Crianças | Gamificação, doações | Marca menos conhecida |

### 3.2 Oportunidades de Diferenciação

1. **🌟 Sistema de 4 Baldes (PRINCIPAL DIFERENCIAL)** - NENHUM concorrente brasileiro tem. Nubank, C6, Inter = saldo único. Nós teremos Gastar/Poupar/Doar/Investir separados.
2. **Gamificação superior** - Nenhum concorrente tem nível Greenlight
3. **Investimentos educativos** - Poucos oferecem para menores
4. **Conteúdo educacional** - Trilhas completas em português
5. **Comunidade** - Desafios entre amigos/famílias
6. **Open Finance** - Visão consolidada de todas as contas
7. **Sem necessidade de conta em banco específico** - Independente

### 3.3 TAM/SAM/SOM

- **TAM**: 50 milhões de famílias brasileiras
- **SAM**: 15 milhões de famílias classes A/B/C com filhos 6-17 anos
- **SOM (3 anos)**: 500.000 famílias ativas (3.3% do SAM)

---

## 4. Funcionalidades Essenciais

### 4.0 🌟 CORE FEATURE: Sistema de 4 Baldes (Money Management)

> **ESTA É A FUNCIONALIDADE MAIS IMPORTANTE DO PRODUTO**
>
> Sem ela, somos apenas mais um app de mesada. Com ela, somos uma ferramenta de educação financeira transformadora.

```
┌─────────────────────────────────────────────────────────────────┐
│           IMPLEMENTAÇÃO DOS 4 BALDES - MVP                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  BALDE 1: 💳 GASTAR (Spend)                                    │
│  ├── Saldo disponível para cartão de débito                    │
│  ├── Único balde que permite gastos                            │
│  ├── Limites configurados pelo pai                             │
│  └── Notificações em tempo real                                │
│                                                                 │
│  BALDE 2: 🐷 GUARDAR (Save) - MVP                              │
│  ├── Criar metas visuais com nome e imagem                     │
│  ├── Barra de progresso                                        │
│  ├── "Juros" pagos pelos pais (incentivo)                      │
│  ├── Round-ups automáticos (arredondar compras)                │
│  └── Compartilhar com família (avós podem contribuir)          │
│                                                                 │
│  BALDE 3: 🎁 DOAR (Give) - Pós-MVP                             │
│  ├── Reserva para doações                                      │
│  ├── Lista de instituições parceiras                           │
│  ├── Doar para amigos/família                                  │
│  └── Histórico de doações                                      │
│                                                                 │
│  BALDE 4: 📈 INVESTIR (Invest) - Futuro                        │
│  ├── Tesouro Direto Educacional                                │
│  ├── CDB com liquidez                                          │
│  ├── Simulador antes de investir                               │
│  └── Aprovação parental obrigatória                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Regras de Alocação (Configurável pelo Pai):

| Configuração | Padrão | Mínimo | Máximo |
|--------------|--------|--------|--------|
| % para Gastar | 50% | 10% | 90% |
| % para Guardar | 30% | 5% | 80% |
| % para Doar | 10% | 0% | 50% |
| % para Investir | 10% | 0% | 50% |

#### Fluxo de Mesada com 4 Baldes:

```
Pai deposita R$ 100 (mesada)
         │
         ▼
┌─────────────────────────────────────┐
│     DISTRIBUIÇÃO AUTOMÁTICA         │
├─────────────────────────────────────┤
│  💳 Gastar:   R$ 50 (50%)          │
│  🐷 Guardar:  R$ 30 (30%)          │
│  🎁 Doar:     R$ 10 (10%)          │
│  📈 Investir: R$ 10 (10%)          │
└─────────────────────────────────────┘
         │
         ▼
Filho recebe notificação:
"Sua mesada chegou! 🎉
 R$50 para gastar
 R$30 guardado para o PS5 (agora tem R$180!)
 R$10 para ajudar outros
 R$10 investido para o futuro"
```

---

### 4.1 MVP (Prioridade Alta)

| # | Feature | Descrição | Usuário |
|---|---------|-----------|---------|
| 1 | **🌟 Sistema de 4 Baldes** | Divisão automática: Gastar/Guardar/Doar/Investir | Ambos |
| 2 | **Conta Digital Menor** | Conta simplificada para 6-17 anos vinculada ao responsável | Filho |
| 3 | **Cartão Virtual** | Cartão pré-pago virtual (usa saldo do balde GASTAR) | Filho |
| 4 | **Controles Parentais** | Limites, % dos baldes, notificações | Pai |
| 5 | **Mesada Automática** | Transferência automática com divisão nos baldes | Pai→Filho |
| 6 | **Metas de Poupança** | Metas visuais vinculadas ao balde GUARDAR | Filho |
| 7 | **PIX** | Enviar/receber via PIX (do balde GASTAR) | Ambos |
| 8 | **Extrato por Balde** | Visualização de transações por categoria | Ambos |
| 9 | **Onboarding Familiar** | Cadastro pai + convite filho + config baldes | Ambos |
| 10 | **Notificações Push** | Alertas de transações e metas | Ambos |

### 4.2 Pós-MVP (Prioridade Média)

| # | Feature | Descrição |
|---|---------|-----------|
| 11 | **Cartão Físico** | Cartão de débito físico personalizado |
| 12 | **Tarefas (Chores)** | Criar tarefas domésticas com recompensa |
| 13 | **Balde DOAR ativo** | Doações para instituições parceiras |
| 14 | **Juros Parentais** | Pais pagam % extra no balde GUARDAR |
| 15 | **Bloqueio de Categorias** | Bloquear gastos em categorias específicas |
| 16 | **Educação Financeira v1** | Quizzes e conteúdo básico |
| 17 | **Round-ups** | Arredondar compras para o balde GUARDAR |
| 18 | **Cashback** | % de volta para o balde GUARDAR |

### 4.3 Futuro (Prioridade Baixa)

| # | Feature | Descrição |
|---|---------|-----------|
| 19 | **Balde INVESTIR ativo** | Tesouro Direto, CDB, fundos para menores |
| 20 | **Localização** | GPS do filho em tempo real |
| 21 | **SOS/Emergência** | Botão de emergência com localização |
| 22 | **Open Finance** | Agregar contas de outros bancos |
| 23 | **Gamificação Avançada** | Níveis, badges, competições |
| 24 | **Comunidade** | Desafios entre amigos |
| 25 | **Conta Conjunta Irmãos** | Poupança compartilhada no balde GUARDAR |

---

## 5. Arquitetura de Informação e Sitemap

### 5.1 App do Pai/Responsável

```
📱 APP PAI
│
├── 🏠 Home (Dashboard)
│   ├── Resumo filhos (saldo, última transação)
│   ├── Alertas pendentes
│   └── Ações rápidas (transferir, ver extrato)
│
├── 👨‍👩‍👧‍👦 Filhos
│   ├── Lista de filhos
│   ├── [Filho Individual]
│   │   ├── Perfil
│   │   ├── Saldo e Extrato
│   │   ├── Controles (limites, categorias)
│   │   ├── Cartão (virtual/físico)
│   │   ├── Mesada (config automática)
│   │   └── Tarefas (criar, aprovar)
│   └── Adicionar filho
│
├── 💸 Transferir
│   ├── Para filho
│   ├── Via PIX
│   └── Histórico
│
├── 📊 Relatórios
│   ├── Gastos por categoria
│   ├── Evolução poupança
│   └── Tarefas concluídas
│
├── 🎓 Educação
│   ├── Progresso dos filhos
│   ├── Sugestões de atividades
│   └── Artigos para pais
│
├── ⚙️ Configurações
│   ├── Perfil
│   ├── Segurança (PIN, biometria)
│   ├── Notificações
│   ├── Plano/Assinatura
│   └── Ajuda
│
└── 🔔 Notificações
    ├── Transações filhos
    ├── Tarefas pendentes
    └── Alertas de segurança
```

### 5.2 App do Filho

```
📱 APP FILHO
│
├── 🏠 Home (VISÃO DOS 4 BALDES)
│   ├── 💳 Balde GASTAR (saldo disponível)
│   ├── 🐷 Balde GUARDAR (total + meta principal)
│   ├── 🎁 Balde DOAR (saldo para doações)
│   ├── 📈 Balde INVESTIR (valor investido)
│   ├── Última transação
│   └── Tarefas pendentes
│
├── 💰 Meus Baldes (TELA CENTRAL)
│   ├── Visão detalhada dos 4 baldes
│   ├── Transferir entre baldes
│   ├── Histórico por balde
│   └── Configuração de metas por balde
│
├── 💳 Gastar (Balde 1)
│   ├── Saldo disponível
│   ├── Cartão virtual (número, CVV)
│   ├── Cartão físico (status, pedir)
│   ├── Extrato de gastos
│   └── Limites (definidos pelo pai)
│
├── 🐷 Guardar (Balde 2)
│   ├── Total guardado
│   ├── Minhas metas (com progresso)
│   ├── Criar nova meta
│   ├── "Juros" dos pais (se ativo)
│   └── Compartilhar meta com família
│
├── 🎁 Doar (Balde 3)
│   ├── Saldo para doações
│   ├── Instituições parceiras
│   ├── Doar agora
│   └── Histórico de doações
│
├── 📈 Investir (Balde 4)
│   ├── Valor investido
│   ├── Rendimento
│   ├── Simulador
│   └── Investir (com aprovação do pai)
│
├── ✅ Tarefas
│   ├── Pendentes
│   ├── Concluídas
│   ├── Marcar como feito
│   └── Histórico de ganhos
│
├── 🎮 Aprender
│   ├── Quizzes
│   ├── Desafios
│   ├── Badges conquistados
│   └── Ranking (se houver amigos)
│
└── ⚙️ Configurações
    ├── Perfil (avatar, tema)
    ├── Notificações
    └── Ajuda
```

### 5.3 Site Institucional

```
🌐 WEBSITE
│
├── Home
│   ├── Hero (proposta de valor)
│   ├── Funcionalidades principais
│   ├── Depoimentos
│   ├── Planos e preços
│   └── CTA (baixar app)
│
├── Funcionalidades
│   ├── Cartão para crianças
│   ├── Controles parentais
│   ├── Mesada automática
│   ├── Educação financeira
│   └── Poupança e metas
│
├── Planos
│   ├── Comparativo
│   ├── FAQ preços
│   └── Garantias
│
├── Segurança
│   ├── Como protegemos
│   ├── LGPD
│   └── Regulamentação
│
├── Blog
│   ├── Educação financeira
│   ├── Dicas para pais
│   └── Novidades
│
├── Sobre
│   ├── Nossa história
│   ├── Time
│   └── Carreiras
│
├── Ajuda/FAQ
│
└── Área do Cliente (login)
```

---

## 6. Jornadas de Usuário

### 6.1 Jornada: Cadastro do Pai

```
┌─────────────────────────────────────────────────────────────────┐
│ CADASTRO PAI/RESPONSÁVEL                                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. DOWNLOAD        2. CRIAR CONTA      3. VERIFICAÇÃO         │
│  ┌─────────┐       ┌─────────────┐     ┌─────────────┐         │
│  │ App     │  ───► │ Nome        │ ──► │ CPF         │         │
│  │ Store   │       │ Email       │     │ Selfie+Doc  │         │
│  │ Play    │       │ Celular     │     │ Validação   │         │
│  └─────────┘       │ Senha       │     └─────────────┘         │
│                    └─────────────┘            │                 │
│                                               ▼                 │
│  6. DASHBOARD      5. ESCOLHER PLANO   4. CONFIRMAR            │
│  ┌─────────┐       ┌─────────────┐     ┌─────────────┐         │
│  │ Home    │  ◄─── │ Core        │ ◄── │ SMS/Email   │         │
│  │ Vazia   │       │ Premium     │     │ Código      │         │
│  │ +Filho  │       │ Pagamento   │     └─────────────┘         │
│  └─────────┘       └─────────────┘                             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.2 Jornada: Adicionar Filho

```
┌─────────────────────────────────────────────────────────────────┐
│ ADICIONAR FILHO À CONTA                                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. INICIAR         2. DADOS FILHO      3. VERIFICAR           │
│  ┌─────────┐       ┌─────────────┐     ┌─────────────┐         │
│  │ + Add   │  ───► │ Nome        │ ──► │ CPF filho   │         │
│  │ Filho   │       │ Data nasc.  │     │ Documento   │         │
│  │ Botão   │       │ Apelido     │     │ (se >16)    │         │
│  └─────────┘       └─────────────┘     └─────────────┘         │
│                                               │                 │
│                                               ▼                 │
│  6. FILHO ATIVO    5. FILHO ACEITA     4. ENVIAR CONVITE       │
│  ┌─────────┐       ┌─────────────┐     ┌─────────────┐         │
│  │ Conta   │  ◄─── │ Baixa app   │ ◄── │ WhatsApp    │         │
│  │ Criada  │       │ Usa código  │     │ SMS         │         │
│  │ Cartão  │       │ Cria PIN    │     │ QR Code     │         │
│  └─────────┘       └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.3 Jornada: Filho Faz Compra

```
┌─────────────────────────────────────────────────────────────────┐
│ FILHO FAZ COMPRA COM CARTÃO                                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  FILHO                          PAI                             │
│  ┌─────────┐                   ┌─────────┐                     │
│  │ Compra  │                   │         │                     │
│  │ R$ 50   │                   │         │                     │
│  │ iFood   │                   │         │                     │
│  └────┬────┘                   │         │                     │
│       │                        │         │                     │
│       ▼                        │         │                     │
│  ┌─────────┐                   │         │                     │
│  │ Sistema │───────────────────┼────────►│  🔔 Push            │
│  │ Valida  │  Notificação      │         │  "João gastou       │
│  │ Limite  │  em tempo real    │         │   R$50 no iFood"    │
│  └────┬────┘                   │         │                     │
│       │                        └─────────┘                     │
│       ▼                                                        │
│  ┌─────────┐                                                   │
│  │ ✓ Aprov.│  Saldo: R$ 150 → R$ 100                          │
│  │ Compra  │  Extrato atualizado                               │
│  │ OK      │  Categorizado: Alimentação                        │
│  └─────────┘                                                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.4 Jornada: Configurar Mesada Automática (com 4 Baldes)

```
┌─────────────────────────────────────────────────────────────────┐
│ PAI CONFIGURA MESADA AUTOMÁTICA COM DIVISÃO EM 4 BALDES         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. Acessar config filho                                       │
│       │                                                        │
│       ▼                                                        │
│  2. ┌─────────────────────────────┐                           │
│     │ CONFIGURAR MESADA           │                           │
│     ├─────────────────────────────┤                           │
│     │ Valor total: [R$ __100__]   │                           │
│     │                             │                           │
│     │ Frequência:                 │                           │
│     │ ○ Semanal (toda segunda)    │                           │
│     │ ● Mensal (dia 5)            │                           │
│     │ ○ Quinzenal                 │                           │
│     │                             │                           │
│     │ ═══════════════════════════ │                           │
│     │ 🌟 DIVISÃO NOS 4 BALDES:    │                           │
│     │ ═══════════════════════════ │                           │
│     │                             │                           │
│     │ 💳 Gastar:   [__50_]% R$ 50 │                           │
│     │ 🐷 Guardar:  [__30_]% R$ 30 │                           │
│     │ 🎁 Doar:     [__10_]% R$ 10 │                           │
│     │ 📈 Investir: [__10_]% R$ 10 │                           │
│     │             ────────────    │                           │
│     │             100%    R$ 100  │                           │
│     │                             │                           │
│     │ ═══════════════════════════ │                           │
│     │                             │                           │
│     │ Vincular a tarefas?         │                           │
│     │ ○ Não, pagar sempre         │                           │
│     │ ● Sim, só se completar 80%  │                           │
│     │                             │                           │
│     │ [  ATIVAR MESADA  ]         │                           │
│     └─────────────────────────────┘                           │
│       │                                                        │
│       ▼                                                        │
│  3. Sistema agenda transferências                              │
│  4. Filho recebe notificação detalhada:                        │
│     ┌─────────────────────────────┐                           │
│     │ 🎉 Sua mesada chegou!       │                           │
│     │                             │                           │
│     │ 💳 R$ 50 para gastar        │                           │
│     │ 🐷 R$ 30 para guardar       │                           │
│     │    (Meta PS5: R$ 230/3000)  │                           │
│     │ 🎁 R$ 10 para doar          │                           │
│     │ 📈 R$ 10 investido          │                           │
│     └─────────────────────────────┘                           │
│  5. Todo mês: transferência automática com divisão             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.5 Jornada: Criar e Completar Tarefa

```
┌─────────────────────────────────────────────────────────────────┐
│ FLUXO DE TAREFAS (CHORES)                                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PAI CRIA                      FILHO FAZ                       │
│  ┌─────────────┐              ┌─────────────┐                  │
│  │ + Nova      │              │ 🔔 Nova     │                  │
│  │ Tarefa      │─────────────►│ tarefa!     │                  │
│  └─────────────┘              └──────┬──────┘                  │
│        │                             │                          │
│        ▼                             ▼                          │
│  ┌─────────────┐              ┌─────────────┐                  │
│  │ Descrição:  │              │ Ver tarefa  │                  │
│  │ "Arrumar    │              │ Arrumar     │                  │
│  │  quarto"    │              │ quarto      │                  │
│  │             │              │ R$ 10       │                  │
│  │ Valor: R$10 │              │ Prazo: Hoje │                  │
│  │ Prazo: Hoje │              │             │                  │
│  │ Recorrente: │              │ [CONCLUIR]  │                  │
│  │ Semanal     │              └──────┬──────┘                  │
│  └─────────────┘                     │                          │
│                                      ▼                          │
│  PAI APROVA                   ┌─────────────┐                  │
│  ┌─────────────┐              │ ✓ Marquei   │                  │
│  │ 🔔 João     │◄─────────────│ como feito  │                  │
│  │ completou   │              │ (foto?)     │                  │
│  │ tarefa      │              └─────────────┘                  │
│  └──────┬──────┘                                               │
│         │                                                       │
│         ▼                                                       │
│  ┌─────────────┐              ┌─────────────┐                  │
│  │ [APROVAR]   │─────────────►│ 🎉 +R$ 10   │                  │
│  │ [REJEITAR]  │  Auto-paga   │ Saldo novo! │                  │
│  └─────────────┘              └─────────────┘                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 6.6 Jornada: Meta de Poupança

```
┌─────────────────────────────────────────────────────────────────┐
│ FILHO CRIA META DE POUPANÇA                                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. Criar Meta                                                 │
│  ┌─────────────────────────────┐                               │
│  │ 🎯 NOVA META                │                               │
│  │                             │                               │
│  │ Nome: [PlayStation 5____]   │                               │
│  │ Valor: [R$ 3.000________]   │                               │
│  │ Prazo: [Dezembro 2026___]   │                               │
│  │ Imagem: [📷 Adicionar]      │                               │
│  │                             │                               │
│  │ [ CRIAR META ]              │                               │
│  └─────────────────────────────┘                               │
│                                                                 │
│  2. Acompanhar Progresso                                       │
│  ┌─────────────────────────────┐                               │
│  │ 🎮 PlayStation 5            │                               │
│  │                             │                               │
│  │ ████████░░░░░░░░░░░░ 40%    │                               │
│  │ R$ 1.200 de R$ 3.000        │                               │
│  │                             │                               │
│  │ Faltam: R$ 1.800            │                               │
│  │ Prazo: 10 meses             │                               │
│  │ Guardar/mês: R$ 180         │                               │
│  │                             │                               │
│  │ [+ DEPOSITAR] [COMPARTILHAR]│                               │
│  └─────────────────────────────┘                               │
│                                                                 │
│  3. Compartilhar com Família (avós podem contribuir!)          │
│  4. Celebrar quando atingir 🎉                                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 7. Wireframes (ASCII)

### 7.1 Tela Home - App Pai

```
┌────────────────────────────────────┐
│ ☰                    🔔  👤        │
├────────────────────────────────────┤
│                                    │
│  Olá, Roberto! 👋                  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  SEUS FILHOS                 │  │
│  ├──────────────────────────────┤  │
│  │  👦 João         R$ 150,00   │  │
│  │     Última: iFood -R$35      │  │
│  │     [Ver] [Transferir]       │  │
│  ├──────────────────────────────┤  │
│  │  👧 Maria        R$ 280,00   │  │
│  │     Última: Shopee -R$42     │  │
│  │     [Ver] [Transferir]       │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  ⚠️ AÇÕES PENDENTES          │  │
│  │  • João completou 2 tarefas  │  │
│  │  • Maria pediu +R$50         │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  📊 RESUMO DO MÊS            │  │
│  │  Mesadas pagas: R$ 400       │  │
│  │  Tarefas completadas: 12     │  │
│  │  Economizado: R$ 180         │  │
│  └──────────────────────────────┘  │
│                                    │
├────────────────────────────────────┤
│  🏠    👨‍👩‍👧‍👦    💸    📊    ⚙️     │
│ Home  Filhos  Transf Report Config │
└────────────────────────────────────┘
```

### 7.2 🌟 Tela Home - App Filho (VISÃO DOS 4 BALDES)

```
┌────────────────────────────────────┐
│                          🔔  ⚙️    │
├────────────────────────────────────┤
│                                    │
│           Oi, João! 🎮             │
│                                    │
│  ╔══════════════════════════════╗  │
│  ║    🌟 MEUS 4 BALDES 🌟       ║  │
│  ╠══════════════════════════════╣  │
│  ║                              ║  │
│  ║  ┌────────┐  ┌────────┐     ║  │
│  ║  │💳GASTAR│  │🐷GUARDAR│     ║  │
│  ║  │        │  │        │     ║  │
│  ║  │R$ 150  │  │R$ 1.200│     ║  │
│  ║  │        │  │PS5 40% │     ║  │
│  ║  └────────┘  └────────┘     ║  │
│  ║                              ║  │
│  ║  ┌────────┐  ┌────────┐     ║  │
│  ║  │🎁 DOAR │  │📈INVEST│     ║  │
│  ║  │        │  │        │     ║  │
│  ║  │R$ 45   │  │R$ 320  │     ║  │
│  ║  │        │  │ +2.3%  │     ║  │
│  ║  └────────┘  └────────┘     ║  │
│  ║                              ║  │
│  ║  Total: R$ 1.715,00         ║  │
│  ╚══════════════════════════════╝  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  🎯 META PRINCIPAL           │  │
│  │  PlayStation 5               │  │
│  │  ████████░░░░░░░░ 40%        │  │
│  │  R$ 1.200 / R$ 3.000         │  │
│  │  Faltam R$ 180/mês p/ dez    │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  ✅ TAREFAS DE HOJE          │  │
│  │  ☐ Arrumar quarto     R$ 10  │  │
│  │  ☐ Lavar louça        R$ 5   │  │
│  │  ☑ Fazer lição        R$ 8   │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  📜 ÚLTIMAS TRANSAÇÕES       │  │
│  │  Ontem  iFood      -R$ 35 💳 │  │
│  │  Seg    Mesada     +R$100 🔄 │  │
│  │  Dom    →Guardar   -R$ 20 🐷 │  │
│  └──────────────────────────────┘  │
│                                    │
├────────────────────────────────────┤
│  🏠    💰    🐷    ✅    🎮       │
│ Home  Baldes Metas Tarefas Aprender│
└────────────────────────────────────┘
```

### 7.3 Tela Cartão Virtual

```
┌────────────────────────────────────┐
│  ←  Meu Cartão                     │
├────────────────────────────────────┤
│                                    │
│  ┌──────────────────────────────┐  │
│  │  ╔══════════════════════════╗│  │
│  │  ║                          ║│  │
│  │  ║  🏦 NOME DO APP          ║│  │
│  │  ║                          ║│  │
│  │  ║  5432 •••• •••• 1234     ║│  │
│  │  ║                          ║│  │
│  │  ║  JOÃO SILVA              ║│  │
│  │  ║  VAL 12/28    CVV •••    ║│  │
│  │  ║                          ║│  │
│  │  ╚══════════════════════════╝│  │
│  └──────────────────────────────┘  │
│                                    │
│       [👁 Ver dados completos]     │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  AÇÕES                       │  │
│  │                              │  │
│  │  📋 Copiar número            │  │
│  │  🔒 Bloquear temporário      │  │
│  │  📱 Adicionar ao Google Pay  │  │
│  │  💳 Pedir cartão físico      │  │
│  │                              │  │
│  └──────────────────────────────┘  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  LIMITES (definidos pelo pai)│  │
│  │  Diário:  R$ 100 / R$ 200    │  │
│  │  Mensal:  R$ 800 / R$ 1.000  │  │
│  └──────────────────────────────┘  │
│                                    │
├────────────────────────────────────┤
│  🏠    💳    🎯    ✅    🎮       │
└────────────────────────────────────┘
```

### 7.4 🌟 Tela "Meus Baldes" - Detalhe (TELA CENTRAL)

```
┌────────────────────────────────────┐
│  ←  Meus Baldes                    │
├────────────────────────────────────┤
│                                    │
│  Total: R$ 1.715,00                │
│                                    │
│  ╔══════════════════════════════╗  │
│  ║  💳 GASTAR                   ║  │
│  ║  ════════════════════════    ║  │
│  ║  Saldo: R$ 150,00            ║  │
│  ║  Limite diário: R$ 200       ║  │
│  ║  Usado hoje: R$ 50           ║  │
│  ║                              ║  │
│  ║  [💳 Ver Cartão] [📜 Extrato]║  │
│  ╚══════════════════════════════╝  │
│                                    │
│  ╔══════════════════════════════╗  │
│  ║  🐷 GUARDAR                  ║  │
│  ║  ════════════════════════    ║  │
│  ║  Total: R$ 1.200,00          ║  │
│  ║  ┌────────────────────────┐  ║  │
│  ║  │🎮 PS5      ████░░ 40%  │  ║  │
│  ║  │   R$1.200 / R$3.000    │  ║  │
│  ║  └────────────────────────┘  ║  │
│  ║  Juros dos pais: +R$ 12/mês  ║  │
│  ║                              ║  │
│  ║  [🎯 Metas] [+ Depositar]   ║  │
│  ╚══════════════════════════════╝  │
│                                    │
│  ╔══════════════════════════════╗  │
│  ║  🎁 DOAR                     ║  │
│  ║  ════════════════════════    ║  │
│  ║  Saldo: R$ 45,00             ║  │
│  ║  Doado este ano: R$ 120      ║  │
│  ║                              ║  │
│  ║  [❤️ Doar Agora]             ║  │
│  ╚══════════════════════════════╝  │
│                                    │
│  ╔══════════════════════════════╗  │
│  ║  📈 INVESTIR                 ║  │
│  ║  ════════════════════════    ║  │
│  ║  Investido: R$ 320,00        ║  │
│  ║  Rendimento: +R$ 7,36 (2.3%) ║  │
│  ║                              ║  │
│  ║  [📊 Ver Mais] [+ Investir] ║  │
│  ╚══════════════════════════════╝  │
│                                    │
│  ┌──────────────────────────────┐  │
│  │  🔄 TRANSFERIR ENTRE BALDES  │  │
│  └──────────────────────────────┘  │
│                                    │
├────────────────────────────────────┤
│  🏠    💰    🐷    ✅    🎮       │
└────────────────────────────────────┘
```

### 7.5 Tela Controles Parentais

```
┌────────────────────────────────────┐
│  ←  Controles - João               │
├────────────────────────────────────┤
│                                    │
│  CARTÃO                            │
│  ┌──────────────────────────────┐  │
│  │  Cartão ativo      [====●]   │  │
│  └──────────────────────────────┘  │
│                                    │
│  LIMITES DE GASTO                  │
│  ┌──────────────────────────────┐  │
│  │  Limite diário               │  │
│  │  R$ [____200____]            │  │
│  │                              │  │
│  │  Limite mensal               │  │
│  │  R$ [___1.000___]            │  │
│  │                              │  │
│  │  Limite por transação        │  │
│  │  R$ [____100____]            │  │
│  └──────────────────────────────┘  │
│                                    │
│  CATEGORIAS BLOQUEADAS            │
│  ┌──────────────────────────────┐  │
│  │  ☑ Jogos de azar             │  │
│  │  ☑ Bebidas alcoólicas        │  │
│  │  ☑ Tabacaria                 │  │
│  │  ☐ Jogos online              │  │
│  │  ☐ Streaming                 │  │
│  │  ☐ Fast food                 │  │
│  └──────────────────────────────┘  │
│                                    │
│  NOTIFICAÇÕES                      │
│  ┌──────────────────────────────┐  │
│  │  Toda compra       [====●]   │  │
│  │  Acima de R$ 50    [====●]   │  │
│  │  Categoria block.  [====●]   │  │
│  └──────────────────────────────┘  │
│                                    │
│       [ SALVAR ALTERAÇÕES ]        │
│                                    │
├────────────────────────────────────┤
│  🏠    👨‍👩‍👧‍👦    💸    📊    ⚙️     │
└────────────────────────────────────┘
```

### 7.6 Tela Educação Financeira (Gamificação)

```
┌────────────────────────────────────┐
│  ←  Aprender                       │
├────────────────────────────────────┤
│                                    │
│  ┌──────────────────────────────┐  │
│  │  🏆 NÍVEL 7 - Poupador Pro   │  │
│  │  ████████████░░░░░░ 650 XP   │  │
│  │  Faltam 150 XP pro nível 8   │  │
│  └──────────────────────────────┘  │
│                                    │
│  🎯 DESAFIO DO DIA                 │
│  ┌──────────────────────────────┐  │
│  │  "Economize R$ 10 hoje"      │  │
│  │  Recompensa: 50 XP + Badge   │  │
│  │  ████████░░░░ 80%            │  │
│  │  [VER DETALHES]              │  │
│  └──────────────────────────────┘  │
│                                    │
│  📚 TRILHAS DE APRENDIZADO         │
│  ┌──────────────────────────────┐  │
│  │  ✅ Básico: O que é dinheiro │  │
│  │  ✅ Básico: Poupar vs Gastar │  │
│  │  🔓 Inter: Juros compostos   │  │
│  │  🔒 Inter: Investimentos     │  │
│  │  🔒 Avançado: Bolsa          │  │
│  └──────────────────────────────┘  │
│                                    │
│  🏅 MINHAS CONQUISTAS              │
│  ┌──────────────────────────────┐  │
│  │  🥇 🥈 🏅 🎖️ ⭐ 🌟 + 5 mais   │  │
│  │  [Ver todas]                 │  │
│  └──────────────────────────────┘  │
│                                    │
│  📊 QUIZ RÁPIDO                    │
│  ┌──────────────────────────────┐  │
│  │  Teste seus conhecimentos!   │  │
│  │  [COMEÇAR QUIZ - 20 XP]      │  │
│  └──────────────────────────────┘  │
│                                    │
├────────────────────────────────────┤
│  🏠    💳    🎯    ✅    🎮       │
└────────────────────────────────────┘
```

---

## 8. Requisitos Técnicos

### 8.1 Arquitetura Geral

```
┌─────────────────────────────────────────────────────────────────┐
│                        ARQUITETURA                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐                        │
│  │   iOS   │  │ Android │  │   Web   │      CLIENTS           │
│  │   App   │  │   App   │  │   App   │                        │
│  └────┬────┘  └────┬────┘  └────┬────┘                        │
│       │            │            │                              │
│       └────────────┼────────────┘                              │
│                    │                                           │
│              ┌─────┴─────┐                                     │
│              │    CDN    │  CloudFront / Cloudflare            │
│              │    WAF    │                                     │
│              └─────┬─────┘                                     │
│                    │                                           │
│              ┌─────┴─────┐                                     │
│              │    API    │  API Gateway                        │
│              │  Gateway  │  Rate Limiting                      │
│              └─────┬─────┘  Auth                               │
│                    │                                           │
│       ┌────────────┼────────────┐                              │
│       │            │            │                              │
│  ┌────┴────┐ ┌─────┴─────┐ ┌────┴────┐                        │
│  │ Account │ │Transaction│ │Notificat│     MICROSERVICES      │
│  │ Service │ │  Service  │ │ Service │                        │
│  └────┬────┘ └─────┬─────┘ └────┬────┘                        │
│       │            │            │                              │
│  ┌────┴────┐ ┌─────┴─────┐ ┌────┴────┐                        │
│  │  Card   │ │  Chores   │ │Education│                        │
│  │ Service │ │  Service  │ │ Service │                        │
│  └────┬────┘ └─────┬─────┘ └────┬────┘                        │
│       │            │            │                              │
│       └────────────┼────────────┘                              │
│                    │                                           │
│              ┌─────┴─────┐                                     │
│              │  Message  │  Kafka / RabbitMQ                   │
│              │   Queue   │                                     │
│              └─────┬─────┘                                     │
│                    │                                           │
│       ┌────────────┼────────────┐                              │
│       │            │            │                              │
│  ┌────┴────┐ ┌─────┴─────┐ ┌────┴────┐                        │
│  │PostgreSQL│ │   Redis   │ │  S3     │     DATA LAYER        │
│  │(Primary)│ │  (Cache)  │ │(Assets) │                        │
│  └─────────┘ └───────────┘ └─────────┘                        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 8.2 Stack Tecnológico

#### Frontend (Mobile)
| Componente | Tecnologia | Justificativa |
|------------|------------|---------------|
| Framework | **React Native** | Cross-platform, comunidade ativa |
| State | Redux Toolkit + RTK Query | Padrão de mercado, cache |
| UI Kit | React Native Paper | Material Design, acessibilidade |
| Navigation | React Navigation 6 | Padrão da indústria |
| Forms | React Hook Form + Zod | Performance, validação |
| Analytics | Firebase + Amplitude | Métricas e comportamento |

#### Frontend (Web)
| Componente | Tecnologia | Justificativa |
|------------|------------|---------------|
| Framework | **Next.js 14** | SSR, SEO, App Router |
| Styling | Tailwind CSS | Produtividade, consistência |
| Components | shadcn/ui | Acessível, customizável |
| State | Zustand | Simples, performático |

#### Backend
| Componente | Tecnologia | Justificativa |
|------------|------------|---------------|
| Runtime | **Node.js 20 LTS** | Performance, ecossistema |
| Framework | NestJS | Estruturado, TypeScript nativo |
| ORM | **Prisma** | Type-safe, migrations |
| API Style | REST + GraphQL (futuro) | Flexibilidade |
| Auth | Passport + JWT | Padrão, extensível |
| Docs | Swagger/OpenAPI | Auto-documentação |

#### Infraestrutura
| Componente | Tecnologia | Justificativa |
|------------|------------|---------------|
| Cloud | **AWS** ou **GCP** | Compliance, escalabilidade |
| Container | Docker + ECS/GKE | Portabilidade |
| CI/CD | GitHub Actions | Integração nativa |
| Monitoring | DataDog / New Relic | APM completo |
| Logs | CloudWatch / Loki | Centralizado |

#### Banco de Dados
| Componente | Tecnologia | Justificativa |
|------------|------------|---------------|
| Primary DB | **PostgreSQL 15** | ACID, confiável, Prisma |
| Cache | Redis | Performance, sessões |
| Search | Elasticsearch | Busca de transações |
| Queue | RabbitMQ / SQS | Mensageria assíncrona |

### 8.3 Integrações Externas

```
┌─────────────────────────────────────────────────────────────────┐
│                      INTEGRAÇÕES                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PAGAMENTOS & BANKING                                          │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐  │
│  │  Dock / Swap    │ │  Pismo          │ │  Matera         │  │
│  │  (BaaS)         │ │  (Processadora) │ │  (BaaS)         │  │
│  │  • Conta digital│ │  • Cartões      │ │  • PIX          │  │
│  │  • PIX          │ │  • Ledger       │ │  • Boleto       │  │
│  │  • Cartão       │ │  • Core banking │ │  • TED          │  │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘  │
│                                                                 │
│  CARTÕES                                                       │
│  ┌─────────────────┐ ┌─────────────────┐                      │
│  │  Visa Direct    │ │  Mastercard     │                      │
│  │  • Emissão      │ │  • Emissão      │                      │
│  │  • Tokenização  │ │  • Digital 1st  │                      │
│  └─────────────────┘ └─────────────────┘                      │
│                                                                 │
│  KYC & COMPLIANCE                                              │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐  │
│  │  Serpro         │ │  BigData Corp   │ │  Idwall         │  │
│  │  • CPF          │ │  • Score        │ │  • OCR docs     │  │
│  │  • CNPJ         │ │  • Antifraude   │ │  • Facematch    │  │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘  │
│                                                                 │
│  COMUNICAÇÃO                                                   │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐  │
│  │  Firebase       │ │  Twilio/Zenvia  │ │  SendGrid       │  │
│  │  • Push         │ │  • SMS          │ │  • Email        │  │
│  │  • Analytics    │ │  • WhatsApp     │ │  • Templates    │  │
│  └─────────────────┘ └─────────────────┘ └─────────────────┘  │
│                                                                 │
│  OPEN FINANCE (Futuro)                                         │
│  ┌─────────────────┐ ┌─────────────────┐                      │
│  │  Belvo          │ │  Pluggy         │                      │
│  │  • Agregação    │ │  • Agregação    │                      │
│  │  • Dados bancár.│ │  • Extrato      │                      │
│  └─────────────────┘ └─────────────────┘                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 8.4 Requisitos de Segurança

| Área | Requisito | Implementação |
|------|-----------|---------------|
| **Autenticação** | Multi-fator obrigatório para pais | SMS + Email + Biometria |
| **Autorização** | RBAC (pai, filho, admin) | Políticas granulares |
| **Criptografia** | Dados em repouso e trânsito | AES-256, TLS 1.3 |
| **PCI-DSS** | Dados de cartão | Tokenização via processadora |
| **LGPD** | Dados pessoais | Consentimento, anonimização |
| **Antifraude** | Transações suspeitas | ML + regras + 3DS |
| **Audit Log** | Todas ações críticas | Log imutável |
| **Pentest** | Testes periódicos | Anual mínimo |

---

## 9. Regras de Negócio Brasil

### 9.1 Regulamentação Bancária

| Aspecto | Regra | Fonte |
|---------|-------|-------|
| **Tipo de instituição** | IP (Instituição de Pagamento) ou parceria com banco | Bacen |
| **Capital mínimo IP** | R$ 2 milhões (emissora de moeda eletrônica) | Res. 80/2021 |
| **Conta para menor** | Necessita representação legal (pai/mãe/tutor) | Código Civil |
| **PIX para menor** | Permitido com conta própria e supervisão | Bacen |
| **Limite PIX** | Horário noturno: R$ 1.000 (padrão) | Bacen |

### 9.2 Regras de Conta de Menor

```
┌─────────────────────────────────────────────────────────────────┐
│              REGRAS CONTA MENOR DE IDADE                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  FAIXA ETÁRIA         PERMISSÕES              RESTRIÇÕES       │
│  ─────────────────────────────────────────────────────────────  │
│  6-11 anos            • Ver saldo             • Sem PIX para   │
│  (Criança)            • Cartão virtual          terceiros      │
│                       • Compras online        • Limite R$ 200  │
│                       • Tarefas/metas           diário         │
│                       • Educação              • Só recebe de   │
│                                                 pais           │
│  ─────────────────────────────────────────────────────────────  │
│  12-15 anos           • Tudo acima            • PIX só para    │
│  (Pré-adolescente)    • Cartão físico           contatos       │
│                       • PIX (limitado)          aprovados      │
│                       • Poupança              • Limite R$ 500  │
│                                                 diário         │
│  ─────────────────────────────────────────────────────────────  │
│  16-17 anos           • Tudo acima            • Investimentos  │
│  (Adolescente)        • PIX completo            com aprovação  │
│                       • Investimentos         • Limite R$ 1000 │
│                       • Saques ATM              diário         │
│                                                                 │
│  SEMPRE OBRIGATÓRIO:                                           │
│  • CPF do menor                                                │
│  • Vinculação a responsável legal                              │
│  • Supervisão parental nas configurações                       │
│  • Pai pode bloquear/limitar a qualquer momento                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 9.3 LGPD - Proteção de Dados de Menores

| Requisito | Implementação |
|-----------|---------------|
| **Consentimento parental** | Obrigatório para <18 anos, verificável |
| **Minimização de dados** | Coletar apenas o necessário |
| **Direito ao esquecimento** | Processo de exclusão completa |
| **Portabilidade** | Exportar dados em formato aberto |
| **Transparência** | Política clara, linguagem acessível |
| **Encarregado (DPO)** | Obrigatório, contato público |

### 9.4 Regras de Mesada e Tarefas

```python
# Pseudocódigo - Regras de Mesada Automática

REGRAS_MESADA = {
    "frequencias": ["semanal", "quinzenal", "mensal"],
    "valor_minimo": 10.00,  # R$
    "valor_maximo": 5000.00,  # R$
    "dia_pagamento": {
        "semanal": "segunda",  # ou escolher
        "quinzenal": [1, 15],
        "mensal": 5  # dia do mês
    },
    "vinculo_tarefas": {
        "nenhum": "paga sempre",
        "parcial": "paga se completar X%",
        "total": "só paga se completar 100%"
    }
}

def calcular_mesada(filho, config):
    tarefas_periodo = get_tarefas_periodo(filho)
    taxa_conclusao = tarefas_periodo.concluidas / tarefas_periodo.total

    if config.vinculo == "nenhum":
        return config.valor
    elif config.vinculo == "parcial":
        if taxa_conclusao >= config.percentual_minimo:
            return config.valor
        else:
            return config.valor * taxa_conclusao
    else:  # total
        return config.valor if taxa_conclusao == 1.0 else 0
```

### 9.5 Limites e Controles

| Controle | Valor Padrão | Configurável |
|----------|--------------|--------------|
| Limite diário | R$ 200 | Sim, pelo pai |
| Limite mensal | R$ 2.000 | Sim, pelo pai |
| Limite por transação | R$ 100 | Sim, pelo pai |
| PIX diário | R$ 500 | Sim, pelo pai |
| PIX noturno (22h-6h) | R$ 200 | Sim, reduzir |
| Saque ATM | R$ 300/dia | Sim, pelo pai |
| Categorias bloqueadas | Jogos azar, álcool, tabaco | + customizáveis |

---

## 10. Monetização e Pricing

### 10.1 Modelo de Receita

```
┌─────────────────────────────────────────────────────────────────┐
│                    FONTES DE RECEITA                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  PRIMÁRIA (70%)                                                │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  ASSINATURAS MENSAIS                                     │  │
│  │  • Plano Básico: R$ 9,90/mês                            │  │
│  │  • Plano Família: R$ 19,90/mês                          │  │
│  │  • Plano Premium: R$ 34,90/mês                          │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  SECUNDÁRIA (25%)                                              │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  INTERCHANGE (Taxa de transação)                         │  │
│  │  • ~1.5% por transação no débito                        │  │
│  │  • Receita proporcional ao volume                        │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  TERCIÁRIA (5%)                                                │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  OUTROS                                                  │  │
│  │  • Cartão físico adicional: R$ 25                       │  │
│  │  • Cartão personalizado: R$ 35                          │  │
│  │  • Parcerias (cashback selecionado)                     │  │
│  │  • B2B (white-label para bancos/escolas)                │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 10.2 Tabela de Preços Sugerida

| Plano | Preço/mês | Filhos | Features |
|-------|-----------|--------|----------|
| **Básico** | R$ 9,90 | 1 | Conta, cartão virtual, mesada, limites básicos, extrato |
| **Família** | R$ 19,90 | Até 3 | Básico + cartão físico, tarefas, metas poupança, notificações avançadas |
| **Premium** | R$ 34,90 | Até 5 | Família + investimentos, educação completa, cashback 1%, relatórios, suporte prioritário |

**Comparativo com mercado:**
- Greenlight (EUA): $4.99 - $14.98/mês
- Mozper (BR): Gratuito (monetiza via interchange)
- Tindin (BR): Gratuito com premium
- **Nossa proposta**: Preço médio, mais features que concorrentes gratuitos

### 10.3 Projeção de Receita (3 anos)

| Métrica | Ano 1 | Ano 2 | Ano 3 |
|---------|-------|-------|-------|
| Usuários ativos | 50.000 | 200.000 | 500.000 |
| ARPU (mensal) | R$ 15 | R$ 18 | R$ 22 |
| MRR | R$ 750k | R$ 3.6M | R$ 11M |
| ARR | R$ 9M | R$ 43M | R$ 132M |
| Churn mensal | 8% | 5% | 3% |

---

## 11. Métricas e KPIs

### 11.1 Métricas de Aquisição

| Métrica | Descrição | Meta MVP |
|---------|-----------|----------|
| **CAC** | Custo de Aquisição de Cliente | < R$ 80 |
| **Downloads** | Total de downloads (iOS + Android) | 100k em 6 meses |
| **Conversion Rate** | Download → Cadastro completo | > 25% |
| **Activation Rate** | Cadastro → Primeiro filho adicionado | > 60% |
| **Virality (K-factor)** | Indicações por usuário | > 0.3 |

### 11.2 Métricas de Engajamento

| Métrica | Descrição | Meta MVP |
|---------|-----------|----------|
| **DAU/MAU** | Usuários ativos diários/mensais | > 30% |
| **Transações/mês** | Média por conta de filho | > 15 |
| **Tarefas criadas** | Média por família/mês | > 8 |
| **Tarefas concluídas** | Taxa de conclusão | > 70% |
| **Tempo no app** | Sessão média (filho) | > 5 min |
| **Educação** | Lições completadas/mês | > 4 |

### 11.3 Métricas Financeiras

| Métrica | Descrição | Meta MVP |
|---------|-----------|----------|
| **MRR** | Receita Recorrente Mensal | R$ 500k em 12 meses |
| **ARPU** | Receita média por usuário | R$ 15/mês |
| **LTV** | Lifetime Value | > R$ 300 |
| **LTV:CAC** | Ratio saudável | > 3:1 |
| **Churn** | Cancelamentos mensais | < 5% |
| **NRR** | Net Revenue Retention | > 105% |

### 11.4 Métricas de Produto

| Métrica | Descrição | Meta |
|---------|-----------|------|
| **NPS** | Net Promoter Score | > 50 |
| **App Store Rating** | Nota média | > 4.5 |
| **Crash Rate** | Taxa de crashes | < 0.5% |
| **Uptime** | Disponibilidade | > 99.9% |
| **Response Time** | API p95 | < 200ms |

### 11.5 Dashboard de KPIs

```
┌─────────────────────────────────────────────────────────────────┐
│                    DASHBOARD EXECUTIVO                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  📈 CRESCIMENTO              💰 FINANCEIRO                     │
│  ┌─────────────────┐        ┌─────────────────┐               │
│  │ MAU: 45.2k      │        │ MRR: R$ 678k    │               │
│  │ ▲ 12% vs mês    │        │ ▲ 8% vs mês     │               │
│  │                 │        │                 │               │
│  │ Novos: 8.4k     │        │ ARPU: R$ 15     │               │
│  │ Churn: 2.1k     │        │ Churn: 4.6%     │               │
│  └─────────────────┘        └─────────────────┘               │
│                                                                 │
│  👨‍👩‍👧‍👦 ENGAJAMENTO           🎯 PRODUTO                        │
│  ┌─────────────────┐        ┌─────────────────┐               │
│  │ DAU/MAU: 32%    │        │ NPS: 52         │               │
│  │                 │        │                 │               │
│  │ Trans/mês: 18   │        │ App Rating: 4.6 │               │
│  │ Tarefas: 72%    │        │ Crashes: 0.3%   │               │
│  └─────────────────┘        └─────────────────┘               │
│                                                                 │
│  ═══════════════════════════════════════════════════════════  │
│  TENDÊNCIA MENSAL                                              │
│                                                                 │
│  MAU  ▁▂▃▄▅▆▇█▇█  +45% (6 meses)                              │
│  MRR  ▁▂▃▄▅▆▇███  +62% (6 meses)                              │
│  NPS  ▃▄▄▅▅▆▆▇▇█  +18 pts (6 meses)                           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 12. Plano de MVP

### 12.1 Escopo do MVP

```
┌─────────────────────────────────────────────────────────────────┐
│                      MVP - ESCOPO MÍNIMO                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ✅ INCLUÍDO NO MVP                ❌ FORA DO MVP              │
│  ─────────────────────────────     ─────────────────────────   │
│  • Cadastro pai (KYC básico)       • Cartão físico            │
│  • Adicionar 1 filho               • Investimentos            │
│  • Conta digital do filho          • Localização/GPS          │
│  • Cartão virtual                  • SOS/Emergência           │
│  • PIX (enviar/receber)            • Open Finance             │
│  • Transferência pai→filho         • Gamificação avançada     │
│  • Extrato de transações           • Comunidade/Social        │
│  • Limites de gasto básicos        • Cashback                 │
│  • Notificações push               • Múltiplos filhos (>1)    │
│  • Mesada automática               • Doações                  │
│  • Tarefas simples                 • B2B/White-label          │
│  • 1 meta de poupança                                         │
│  • Educação (5 lições)                                        │
│  • Plano único (Família)                                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 12.2 Cronograma de Desenvolvimento

```
┌─────────────────────────────────────────────────────────────────┐
│              TIMELINE MVP (6 MESES)                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  MÊS 1-2: FUNDAÇÃO                                             │
│  ├── Arquitetura e setup de infra                              │
│  ├── Integração BaaS (Dock/Pismo/Matera)                       │
│  ├── Backend: Auth, Accounts, KYC                              │
│  ├── Mobile: Setup RN, navegação, auth                         │
│  └── Design System e componentes base                          │
│                                                                 │
│  MÊS 3: CORE BANKING                                           │
│  ├── Conta digital do menor                                    │
│  ├── Cartão virtual (emissão, tokenização)                     │
│  ├── PIX básico (enviar/receber)                               │
│  ├── Transferências internas                                    │
│  └── Extrato e saldo                                           │
│                                                                 │
│  MÊS 4: CONTROLES PARENTAIS                                    │
│  ├── Dashboard do pai                                          │
│  ├── Limites de gasto (diário/mensal/categoria)                │
│  ├── Notificações em tempo real                                │
│  ├── Mesada automática                                         │
│  └── Bloqueio de cartão                                        │
│                                                                 │
│  MÊS 5: FEATURES FAMÍLIA                                       │
│  ├── Sistema de tarefas (CRUD + aprovação)                     │
│  ├── Metas de poupança                                         │
│  ├── Educação financeira v1 (5 lições)                         │
│  ├── App do filho (home, cartão, tarefas)                      │
│  └── Onboarding completo                                       │
│                                                                 │
│  MÊS 6: POLISH & LAUNCH                                        │
│  ├── Testes de segurança e pentest                             │
│  ├── Compliance final (LGPD, Bacen)                            │
│  ├── Beta fechado (500 famílias)                               │
│  ├── Ajustes de UX baseado em feedback                         │
│  └── Lançamento App Store / Play Store                         │
│                                                                 │
│  ═══════════════════════════════════════════════════════════  │
│  MILESTONES                                                    │
│  ─────────────────────────────────────────────────────────────  │
│  M1 (Mês 2): Backend funcional + Auth                          │
│  M2 (Mês 3): Primeira transação PIX                            │
│  M3 (Mês 4): Controles parentais funcionando                   │
│  M4 (Mês 5): Beta interno completo                             │
│  M5 (Mês 6): Launch público                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 12.3 Time Mínimo Necessário

| Função | Quantidade | Responsabilidades |
|--------|------------|-------------------|
| **Tech Lead/Arquiteto** | 1 | Arquitetura, decisões técnicas, code review |
| **Backend Engineer** | 2 | APIs, integrações, core banking |
| **Mobile Engineer** | 2 | React Native (iOS + Android) |
| **Frontend Engineer** | 1 | Web (landing, admin) |
| **Designer (UI/UX)** | 1 | Interfaces, fluxos, design system |
| **Product Manager** | 1 | Roadmap, priorização, stakeholders |
| **QA Engineer** | 1 | Testes, automação, qualidade |
| **DevOps/SRE** | 1 (part-time) | Infra, CI/CD, monitoring |
| **Total** | **9-10 pessoas** | |

### 12.4 Orçamento Estimado MVP

| Categoria | Mensal | 6 Meses |
|-----------|--------|---------|
| **Time (9 pessoas)** | R$ 180.000 | R$ 1.080.000 |
| **Infraestrutura** | R$ 15.000 | R$ 90.000 |
| **BaaS/Processadora** | R$ 10.000 | R$ 60.000 |
| **Ferramentas/SaaS** | R$ 8.000 | R$ 48.000 |
| **Jurídico/Compliance** | R$ 15.000 | R$ 90.000 |
| **Marketing (pré-launch)** | R$ 20.000 | R$ 120.000 |
| **Buffer (15%)** | R$ 37.000 | R$ 222.000 |
| **TOTAL** | **R$ 285.000** | **R$ 1.710.000** |

---

## 13. Riscos e Compliance

### 13.1 Matriz de Riscos

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| **Regulatório** - Bacen não aprovar | Média | Crítico | Parceria com IP licenciada, consultoria jurídica |
| **BaaS** - Problemas com parceiro | Média | Alto | Contrato com SLA, plano B (outro BaaS) |
| **Segurança** - Vazamento de dados | Baixa | Crítico | Pentest, bug bounty, criptografia, SOC 2 |
| **Fraude** - Uso indevido por menores | Média | Alto | Controles robustos, ML antifraude |
| **Mercado** - Concorrência bancos | Alta | Médio | Diferenciação, foco em educação |
| **Churn** - Pais cancelarem | Média | Alto | Engajamento, valor percebido, NPS |
| **Técnico** - Indisponibilidade | Baixa | Alto | Multi-AZ, disaster recovery |

### 13.2 Requisitos Regulatórios

```
┌─────────────────────────────────────────────────────────────────┐
│               COMPLIANCE REGULATÓRIO                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  OPÇÃO A: PARCERIA COM IP/BANCO                                │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  • Parceiro já licenciado (Dock, Pismo, etc.)           │  │
│  │  • Tempo: imediato                                       │  │
│  │  • Custo: % sobre receita (1-3%)                        │  │
│  │  • Recomendado para MVP                                  │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  OPÇÃO B: LICENÇA PRÓPRIA (IP)                                 │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │  • Capital mínimo: R$ 2 milhões                         │  │
│  │  • Tempo aprovação: 12-24 meses                         │  │
│  │  • Requisitos: diretoria qualificada, compliance,       │  │
│  │    auditoria, capital regulatório                       │  │
│  │  • Recomendado após validação do modelo                 │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                 │
│  OBRIGATÓRIO (AMBAS OPÇÕES)                                    │
│  ─────────────────────────────────────────────────────────────  │
│  ☑ LGPD - Adequação completa                                   │
│  ☑ PLD/FT - Prevenção à lavagem de dinheiro                    │
│  ☑ KYC - Know Your Customer (pai e filho)                      │
│  ☑ PCI-DSS - Se processar dados de cartão                      │
│  ☑ Termos de uso específicos para menores                      │
│  ☑ Consentimento parental verificável                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 13.3 Checklist LGPD para Menores

- [ ] Política de privacidade em linguagem clara e acessível
- [ ] Mecanismo de consentimento parental verificável
- [ ] Minimização de coleta de dados
- [ ] Criptografia de dados pessoais
- [ ] Processo de exclusão de dados (direito ao esquecimento)
- [ ] Registro de atividades de tratamento
- [ ] Relatório de Impacto à Proteção de Dados (RIPD)
- [ ] DPO nomeado e com contato público
- [ ] Treinamento da equipe em proteção de dados
- [ ] Contratos com terceiros com cláusulas de proteção

---

## 14. Backlog Inicial

### 14.1 Épicos

| ID | Épico | Descrição | Prioridade |
|----|-------|-----------|------------|
| E01 | **Onboarding** | Cadastro de pais e filhos | Must Have |
| E02 | **Conta Digital** | Conta, saldo, extrato | Must Have |
| E03 | **Cartão** | Virtual e físico | Must Have |
| E04 | **PIX** | Enviar e receber | Must Have |
| E05 | **Controles Parentais** | Limites, bloqueios, notificações | Must Have |
| E06 | **Mesada** | Automática e manual | Must Have |
| E07 | **Tarefas** | Criar, completar, aprovar | Should Have |
| E08 | **Poupança** | Metas e objetivos | Should Have |
| E09 | **Educação** | Conteúdo e gamificação | Should Have |
| E10 | **Relatórios** | Dashboards para pais | Could Have |
| E11 | **Investimentos** | Tesouro, CDB, fundos | Won't Have (MVP) |
| E12 | **Localização** | GPS e SOS | Won't Have (MVP) |

### 14.2 Features por Épico

#### E01 - Onboarding
| ID | Feature | Story Points |
|----|---------|--------------|
| F01.1 | Cadastro do responsável | 8 |
| F01.2 | Verificação de identidade (KYC) | 13 |
| F01.3 | Adicionar filho | 5 |
| F01.4 | Convite para filho (deep link) | 5 |
| F01.5 | Onboarding filho (aceitar convite) | 5 |
| F01.6 | Tutorial interativo | 3 |

#### E02 - Conta Digital
| ID | Feature | Story Points |
|----|---------|--------------|
| F02.1 | Criação de conta do menor | 8 |
| F02.2 | Visualização de saldo | 2 |
| F02.3 | Extrato de transações | 5 |
| F02.4 | Detalhes de transação | 3 |
| F02.5 | Filtros de extrato | 3 |
| F02.6 | Categorização automática | 5 |

#### E03 - Cartão
| ID | Feature | Story Points |
|----|---------|--------------|
| F03.1 | Emissão de cartão virtual | 8 |
| F03.2 | Visualização de dados do cartão | 3 |
| F03.3 | Copiar número do cartão | 1 |
| F03.4 | Bloquear/desbloquear cartão | 3 |
| F03.5 | Solicitar cartão físico | 5 |
| F03.6 | Ativar cartão físico | 3 |
| F03.7 | Adicionar ao Google/Apple Pay | 8 |

#### E04 - PIX
| ID | Feature | Story Points |
|----|---------|--------------|
| F04.1 | Cadastrar chave PIX | 5 |
| F04.2 | Enviar PIX | 8 |
| F04.3 | Receber PIX | 5 |
| F04.4 | QR Code PIX | 5 |
| F04.5 | Copia e cola | 3 |
| F04.6 | Histórico de PIX | 3 |
| F04.7 | Limites de PIX (pai configura) | 5 |

#### E05 - Controles Parentais
| ID | Feature | Story Points |
|----|---------|--------------|
| F05.1 | Definir limite diário | 3 |
| F05.2 | Definir limite mensal | 3 |
| F05.3 | Definir limite por transação | 3 |
| F05.4 | Bloquear categorias de gasto | 5 |
| F05.5 | Notificação de compra em tempo real | 5 |
| F05.6 | Desligar cartão remotamente | 2 |
| F05.7 | Aprovar/rejeitar transações (opcional) | 8 |

#### E06 - Mesada
| ID | Feature | Story Points |
|----|---------|--------------|
| F06.1 | Transferir valor manual | 3 |
| F06.2 | Configurar mesada automática | 5 |
| F06.3 | Escolher frequência (semanal/mensal) | 2 |
| F06.4 | Vincular mesada a tarefas | 5 |
| F06.5 | Histórico de mesadas | 2 |
| F06.6 | Pausar mesada temporariamente | 2 |

#### E07 - Tarefas
| ID | Feature | Story Points |
|----|---------|--------------|
| F07.1 | Criar tarefa (pai) | 5 |
| F07.2 | Definir valor da recompensa | 2 |
| F07.3 | Definir prazo | 2 |
| F07.4 | Tarefas recorrentes | 5 |
| F07.5 | Ver tarefas pendentes (filho) | 3 |
| F07.6 | Marcar tarefa como concluída | 2 |
| F07.7 | Aprovar conclusão (pai) | 3 |
| F07.8 | Pagamento automático após aprovação | 3 |
| F07.9 | Adicionar foto como prova | 3 |

#### E08 - Poupança
| ID | Feature | Story Points |
|----|---------|--------------|
| F08.1 | Criar meta de poupança | 5 |
| F08.2 | Definir valor alvo e prazo | 2 |
| F08.3 | Adicionar imagem à meta | 2 |
| F08.4 | Depositar na meta | 3 |
| F08.5 | Visualizar progresso | 2 |
| F08.6 | Compartilhar meta com família | 5 |
| F08.7 | Família pode contribuir | 5 |
| F08.8 | Round-ups (arredondar compras) | 8 |

#### E09 - Educação Financeira
| ID | Feature | Story Points |
|----|---------|--------------|
| F09.1 | Trilha de conteúdo básico | 8 |
| F09.2 | Quizzes interativos | 5 |
| F09.3 | Sistema de XP e níveis | 5 |
| F09.4 | Badges/conquistas | 5 |
| F09.5 | Desafios diários | 5 |
| F09.6 | Ranking entre amigos | 8 |

### 14.3 User Stories (Amostra)

#### Onboarding

```gherkin
US01: Cadastro de Responsável
COMO pai/mãe
QUERO criar minha conta no app
PARA poder gerenciar as finanças dos meus filhos

Critérios de Aceite:
- Campos: nome, email, celular, CPF, senha
- Validação de CPF (formato e existência)
- Senha com mínimo 8 caracteres, 1 número, 1 especial
- Verificação de celular via SMS
- Aceite de termos de uso e política de privacidade
```

```gherkin
US02: Adicionar Filho
COMO pai/mãe cadastrado
QUERO adicionar meu filho ao app
PARA que ele tenha sua própria conta

Critérios de Aceite:
- Campos: nome do filho, data nascimento, CPF (opcional <16)
- Validação de idade (6-17 anos)
- Geração de código de convite
- Envio de convite por WhatsApp ou SMS
- Máximo de filhos conforme plano
```

#### Cartão

```gherkin
US03: Ver Cartão Virtual
COMO filho
QUERO ver os dados do meu cartão virtual
PARA fazer compras online

Critérios de Aceite:
- Mostrar número mascarado por padrão (últimos 4 dígitos)
- Botão para revelar número completo (com autenticação)
- Mostrar nome, validade, CVV
- Botão copiar número
- Animação de flip do cartão
```

#### Controles

```gherkin
US04: Configurar Limites
COMO pai/mãe
QUERO definir limites de gasto do meu filho
PARA controlar quanto ele pode gastar

Critérios de Aceite:
- Limite diário: R$ 10 a R$ 5.000
- Limite mensal: R$ 50 a R$ 20.000
- Limite por transação: R$ 5 a R$ 2.000
- Limite de PIX: R$ 10 a R$ 5.000
- Salvar alterações com confirmação
- Notificar filho sobre mudanças
```

#### Mesada

```gherkin
US05: Configurar Mesada Automática
COMO pai/mãe
QUERO configurar uma mesada automática
PARA não esquecer de pagar toda semana/mês

Critérios de Aceite:
- Valor: R$ 10 a R$ 5.000
- Frequência: semanal, quinzenal, mensal
- Dia do pagamento configurável
- Opção de vincular a conclusão de tarefas
- Previsão das próximas 3 transferências
- Botão de pausar/retomar
```

#### Tarefas

```gherkin
US06: Criar Tarefa para Filho
COMO pai/mãe
QUERO criar uma tarefa com recompensa
PARA ensinar meu filho a ganhar dinheiro

Critérios de Aceite:
- Campos: título, descrição, valor, prazo
- Valor: R$ 1 a R$ 500
- Opção de tarefa única ou recorrente
- Seleção de filho (se tiver mais de um)
- Notificação push para o filho
- Preview antes de criar
```

```gherkin
US07: Completar Tarefa
COMO filho
QUERO marcar uma tarefa como concluída
PARA receber minha recompensa

Critérios de Aceite:
- Botão "Concluir" na tarefa
- Opção de adicionar foto como prova
- Feedback visual de tarefa pendente de aprovação
- Notificação para o pai aprovar
- Animação de celebração ao ser aprovada
```

---

## Anexo A: Glossário

| Termo | Definição |
|-------|-----------|
| **BaaS** | Banking as a Service - Infraestrutura bancária via API |
| **CAC** | Customer Acquisition Cost - Custo para adquirir um cliente |
| **Churn** | Taxa de cancelamento/abandono de clientes |
| **DAU/MAU** | Daily/Monthly Active Users - Usuários ativos |
| **IP** | Instituição de Pagamento - Tipo de licença Bacen |
| **Interchange** | Taxa cobrada nas transações de cartão |
| **KYC** | Know Your Customer - Verificação de identidade |
| **LGPD** | Lei Geral de Proteção de Dados |
| **LTV** | Lifetime Value - Valor do cliente ao longo do tempo |
| **MRR** | Monthly Recurring Revenue - Receita recorrente mensal |
| **NPS** | Net Promoter Score - Métrica de satisfação |
| **PCI-DSS** | Padrão de segurança para dados de cartão |
| **PIX** | Sistema de pagamento instantâneo brasileiro |
| **PLD/FT** | Prevenção à Lavagem de Dinheiro e Financiamento ao Terrorismo |

---

## Anexo B: Referências

### Fontes Utilizadas

- [Greenlight](https://greenlight.com/) - Site oficial
- [Greenlight App Store](https://apps.apple.com/us/app/greenlight-kids-teen-banking/id1049340702) - Review e features
- [FinanceBuzz - Greenlight Review](https://financebuzz.com/greenlight-review) - Análise completa
- [Nubank Conta para Menores](https://nubank.com.br/nu/conta/para-menor-de-18-anos)
- [C6 Bank - Mesada Educativa](https://www.c6bank.com.br/blog/mesada-educativa)
- [Banco Inter - Com quantos anos pode ter PIX](https://blog.inter.co/com-quantos-anos-pode-ter-pix/)
- [Serasa - PIX para menores](https://www.serasa.com.br/blog/com-quantos-anos-pode-ter-pix/)
- [Exame - Mozper](https://exame.com/bussola/app-para-controlar-mesada-dos-filhos-atinge-400-mil-downloads-em-10-meses/)

### Regulamentação

- Banco Central do Brasil - Resolução BCB nº 80/2021 (Instituições de Pagamento)
- Lei 13.709/2018 - LGPD
- Código Civil Brasileiro - Artigos sobre capacidade civil de menores

---

*Documento gerado em Janeiro 2026 | Versão 1.0*
*Para dúvidas: [equipe de produto]*
