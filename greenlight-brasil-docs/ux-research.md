# UX Research Plan - GreenLight Brasil

> **Documento de Planejamento UX** | Versão 1.0 | Janeiro 2026
>
> **Projeto**: Fintech de educação financeira familiar
> **Foco**: Personas, Jornadas, Research Plan, Design Principles

---

## Índice

1. [Personas](#1-personas)
2. [Jornadas de Usuário](#2-jornadas-de-usuário)
3. [Research Plan](#3-research-plan)
4. [Information Architecture](#4-information-architecture)
5. [Design Principles](#5-design-principles)
6. [Wireframes Prioritários](#6-wireframes-prioritários)
7. [Benchmark UX](#7-benchmark-ux)

---

## 1. Personas

### 1.1 Persona: Pai/Mãe - Classe A/B

```
┌─────────────────────────────────────────────────────────────────┐
│  👨‍💼 ROBERTO SILVA                                              │
│  "Quero preparar meus filhos para o futuro financeiro"         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  DADOS DEMOGRÁFICOS                                            │
│  • Idade: 38 anos                                              │
│  • Profissão: Gerente de TI                                    │
│  • Renda familiar: R$ 25.000/mês                               │
│  • Localização: São Paulo - SP                                 │
│  • Filhos: 2 (João, 14 anos e Maria, 9 anos)                  │
│  • Tech-savvy: Alto                                            │
│                                                                 │
│  COMPORTAMENTO                                                 │
│  • Usa apps bancários diariamente                              │
│  • Pesquisa antes de assinar serviços                          │
│  • Valoriza educação e desenvolvimento dos filhos              │
│  • Disposto a pagar por qualidade                              │
│                                                                 │
│  GOALS (Jobs to be Done)                                       │
│  ✓ Ensinar filhos a valorizar e gerenciar dinheiro            │
│  ✓ Ter controle sobre gastos dos filhos                       │
│  ✓ Automatizar mesada sem usar dinheiro físico                │
│  ✓ Preparar filhos para independência financeira              │
│                                                                 │
│  PAINS (Dores)                                                 │
│  ✗ Filhos não entendem o valor do dinheiro                    │
│  ✗ Mesada em dinheiro some sem saber onde foi                 │
│  ✗ Não consegue acompanhar gastos dos filhos                  │
│  ✗ Falta tempo para ensinar educação financeira               │
│                                                                 │
│  GAINS (Ganhos Esperados)                                      │
│  ★ Ver filhos tomando decisões financeiras conscientes        │
│  ★ Relatórios de como filhos gastam                           │
│  ★ Filhos aprendendo a poupar para objetivos                  │
│  ★ Tranquilidade de saber onde o dinheiro vai                 │
│                                                                 │
│  CITAÇÃO                                                       │
│  "Meus pais nunca me ensinaram sobre dinheiro. Não quero      │
│   repetir isso com meus filhos."                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 Persona: Pai/Mãe - Classe C

```
┌─────────────────────────────────────────────────────────────────┐
│  👩 MÁRCIA OLIVEIRA                                             │
│  "Quero que meus filhos tenham uma vida melhor que a minha"   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  DADOS DEMOGRÁFICOS                                            │
│  • Idade: 35 anos                                              │
│  • Profissão: Assistente administrativa                        │
│  • Renda familiar: R$ 5.500/mês                                │
│  • Localização: Guarulhos - SP                                 │
│  • Filhos: 1 (Lucas, 11 anos)                                  │
│  • Tech-savvy: Médio                                           │
│                                                                 │
│  COMPORTAMENTO                                                 │
│  • Usa PIX diariamente                                         │
│  • Pesquisa preços e promoções                                 │
│  • Preocupada com segurança financeira                         │
│  • Sensível a preço, busca custo-benefício                     │
│                                                                 │
│  GOALS                                                         │
│  ✓ Ensinar filho a não repetir seus erros financeiros         │
│  ✓ Controlar mesada sem complicação                           │
│  ✓ Filho aprender a poupar desde cedo                         │
│  ✓ Solução simples e acessível                                │
│                                                                 │
│  PAINS                                                         │
│  ✗ Filho pede dinheiro toda hora sem controle                 │
│  ✗ Não sabe quanto já deu de mesada no mês                    │
│  ✗ Apps de banco são complicados para filho usar              │
│  ✗ Preocupada se o custo vale a pena                          │
│                                                                 │
│  GAINS                                                         │
│  ★ Filho entender que dinheiro não "cai do céu"               │
│  ★ App fácil de usar para ela e para o filho                  │
│  ★ Preço justo pelo benefício                                  │
│  ★ Filho aprender a fazer escolhas                            │
│                                                                 │
│  CITAÇÃO                                                       │
│  "Cresci sem ter noção de dinheiro e sofri muito. Quero       │
│   que o Lucas aprenda desde cedo."                             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 1.3 Persona: Filho Criança (6-11 anos)

```
┌─────────────────────────────────────────────────────────────────┐
│  👧 MARIA SILVA                                                 │
│  "Quero comprar coisas legais e guardar para meu sonho!"      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  DADOS                                                         │
│  • Idade: 9 anos                                               │
│  • Escola: 4º ano fundamental                                  │
│  • Mesada atual: R$ 50/mês (em dinheiro)                      │
│  • Interesses: LOL Surprise, YouTube Kids, jogos              │
│  • Tech: Usa tablet da família                                 │
│                                                                 │
│  COMPORTAMENTO                                                 │
│  • Gasta mesada rapidamente em doces/brinquedos               │
│  • Não entende bem "quanto custa"                             │
│  • Adora jogos com recompensas visuais                        │
│  • Pede ajuda dos pais para usar apps                         │
│                                                                 │
│  GOALS                                                         │
│  ✓ Ter "dinheiro próprio" como os adultos                     │
│  ✓ Comprar brinquedos que quer                                │
│  ✓ Ganhar recompensas por ajudar em casa                      │
│  ✓ Guardar para algo grande (ex: boneca especial)             │
│                                                                 │
│  PAINS                                                         │
│  ✗ Mesada acaba rápido e não sabe por quê                     │
│  ✗ Não consegue comprar coisas "caras"                        │
│  ✗ Apps são difíceis de entender                              │
│  ✗ Números grandes confundem                                   │
│                                                                 │
│  GAINS                                                         │
│  ★ Ver o "cofrinho" crescer visualmente                       │
│  ★ Ganhar estrelinhas e medalhas                              │
│  ★ Conseguir comprar algo que guardou                         │
│  ★ Se sentir "grande" por ter cartão                          │
│                                                                 │
│  CITAÇÃO                                                       │
│  "Quero guardar dinheiro pra comprar a LOL gigante!"          │
│                                                                 │
│  NECESSIDADES DE UX                                            │
│  • Interface colorida e divertida                              │
│  • Ícones grandes e claros                                     │
│  • Feedback visual (animações, sons)                           │
│  • Números simplificados (moedas, não centavos)               │
│  • Gamificação forte                                           │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 1.4 Persona: Filho Adolescente (12-17 anos)

```
┌─────────────────────────────────────────────────────────────────┐
│  👦 JOÃO SILVA                                                  │
│  "Quero ter meu próprio dinheiro e privacidade"               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  DADOS                                                         │
│  • Idade: 14 anos                                              │
│  • Escola: 9º ano fundamental                                  │
│  • Mesada atual: R$ 150/mês                                   │
│  • Interesses: Games, música, sair com amigos                 │
│  • Tech: Smartphone próprio, heavy user                       │
│                                                                 │
│  COMPORTAMENTO                                                 │
│  • Usa PIX com amigos                                          │
│  • Compra skins de jogos, iFood, Spotify                      │
│  • Quer independência financeira                               │
│  • Compara com o que amigos têm                               │
│                                                                 │
│  GOALS                                                         │
│  ✓ Ter cartão próprio como os amigos                          │
│  ✓ Comprar o que quiser sem pedir pros pais                   │
│  ✓ Juntar para comprar PS5/PC gamer                           │
│  ✓ Começar a investir (viu no TikTok)                         │
│                                                                 │
│  PAINS                                                         │
│  ✗ Pais controlam demais os gastos                            │
│  ✗ Vergonha de pedir dinheiro pros pais na frente dos amigos │
│  ✗ Não consegue juntar dinheiro (gasta tudo)                  │
│  ✗ Apps "de criança" são vergonhosos                          │
│                                                                 │
│  GAINS                                                         │
│  ★ Cartão com design legal pra mostrar pros amigos            │
│  ★ Independência para gastar                                   │
│  ★ Ver investimentos crescendo                                 │
│  ★ App que parece "de adulto"                                 │
│                                                                 │
│  CITAÇÃO                                                       │
│  "Quero juntar pro PS5, mas é difícil não gastar com iFood"   │
│                                                                 │
│  NECESSIDADES DE UX                                            │
│  • Interface moderna, não infantil                             │
│  • Design que não dê vergonha de mostrar                      │
│  • Funcionalidades de "gente grande" (investir)               │
│  • Privacidade (pais não verem TUDO)                          │
│  • Comparação social positiva (challenges)                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. Jornadas de Usuário

### 2.1 Jornada: Descoberta e Cadastro (Pai)

```
┌─────────────────────────────────────────────────────────────────┐
│  JORNADA: DESCOBERTA → CADASTRO → ATIVAÇÃO                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  FASE 1: DESCOBERTA                                            │
│  ─────────────────────                                         │
│  Touchpoints:                                                  │
│  • Instagram/TikTok (ad de outro pai usando)                  │
│  • Indicação de amigo                                          │
│  • Busca Google "mesada digital filhos"                       │
│  • Matéria em portal de notícias                              │
│                                                                 │
│  Pensamento:                                                   │
│  "Isso existe? Parece interessante..."                        │
│                                                                 │
│  Emoção: 😐 Curiosidade                                        │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  FASE 2: CONSIDERAÇÃO                                          │
│  ─────────────────────                                         │
│  Touchpoints:                                                  │
│  • Landing page do app                                         │
│  • Reviews na App Store                                        │
│  • Vídeos de demonstração                                      │
│  • Comparação com Nubank/C6                                    │
│                                                                 │
│  Pensamento:                                                   │
│  "Será que é seguro? Quanto custa? Vale a pena?"              │
│                                                                 │
│  Emoção: 🤔 Avaliação                                          │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  FASE 3: CADASTRO                                              │
│  ─────────────────                                             │
│  Touchpoints:                                                  │
│  • Download do app                                             │
│  • Tela de cadastro (nome, email, CPF)                        │
│  • Verificação de identidade (selfie + doc)                   │
│  • Escolha de plano                                            │
│                                                                 │
│  Pensamento:                                                   │
│  "Espero que seja rápido... por que precisa de selfie?"       │
│                                                                 │
│  Emoção: 😤 Ansiedade (se demorar) → 😊 Alívio (se rápido)     │
│                                                                 │
│  MOMENTO CRÍTICO: KYC deve ser < 3 minutos                    │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  FASE 4: ATIVAÇÃO (AHA MOMENT!)                                │
│  ─────────────────────────────                                 │
│  Touchpoints:                                                  │
│  • Adicionar primeiro filho                                    │
│  • Configurar os 4 Baldes (%)                                  │
│  • Primeira transferência de mesada                           │
│  • Ver notificação: "Maria recebeu R$ 50!"                    │
│                                                                 │
│  Pensamento:                                                   │
│  "Uau, ela já pode ver o dinheiro dividido!"                  │
│                                                                 │
│  Emoção: 🎉 Satisfação / Empolgação                            │
│                                                                 │
│  ★ AHA MOMENT: Ver os 4 baldes com valores pela 1ª vez        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 Jornada: Uso Diário (Filho)

```
┌─────────────────────────────────────────────────────────────────┐
│  JORNADA: DIA TÍPICO DO FILHO ADOLESCENTE                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  🌅 MANHÃ (7h)                                                 │
│  ──────────────                                                │
│  • Abre app para ver saldo antes de sair                      │
│  • Checa se mesada caiu (é dia 5)                             │
│  • Vê notificação: "Sua mesada chegou! 🎉"                    │
│  • Animação mostra divisão nos 4 baldes                       │
│                                                                 │
│  Emoção: 😊 Feliz (dinheiro novo!)                             │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  🏫 ESCOLA (12h)                                               │
│  ──────────────                                                │
│  • Amigos vão na cantina                                       │
│  • Paga lanche com cartão virtual (Apple Pay)                 │
│  • Push notification para pai: "João gastou R$ 8 - Cantina"   │
│  • Saldo GASTAR atualiza instantaneamente                     │
│                                                                 │
│  Emoção: 😎 Orgulho (tem cartão como os amigos)               │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  🏠 TARDE (16h)                                                │
│  ─────────────                                                 │
│  • Vê que completou tarefa "Arrumar quarto"                   │
│  • Marca como concluída no app                                │
│  • Pai aprova pelo app dele                                    │
│  • +R$ 15 cai automaticamente no saldo                        │
│                                                                 │
│  Emoção: 💪 Realização (ganhou por mérito)                     │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  🌙 NOITE (20h)                                                │
│  ─────────────                                                 │
│  • Quer pedir iFood com amigos online                         │
│  • Vê saldo GASTAR: R$ 47                                     │
│  • Pedido seria R$ 35                                          │
│  • Decide pedir algo mais barato (R$ 25)                      │
│  • Checa meta "PS5": R$ 1.200 / R$ 3.000                      │
│  • Transfere R$ 10 extra pro balde GUARDAR                    │
│                                                                 │
│  Emoção: 🎯 Determinação (quer atingir meta)                   │
│                                                                 │
│  ★ MOMENTO DE APRENDIZADO: Trade-off consciente               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 2.3 Jornada: Atingir Meta de Poupança

```
┌─────────────────────────────────────────────────────────────────┐
│  JORNADA: META DE POUPANÇA (PlayStation 5)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  SEMANA 1: CRIAR META                                          │
│  ────────────────────                                          │
│  • João cria meta "PlayStation 5"                             │
│  • Coloca foto do PS5                                          │
│  • Define valor: R$ 3.000                                      │
│  • Define prazo: 10 meses                                      │
│  • App sugere: "Guarde R$ 300/mês"                            │
│                                                                 │
│  Emoção: 🌟 Empolgação / Motivação                             │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  MÊS 1-3: PROGRESSO INICIAL                                    │
│  ──────────────────────────                                    │
│  • Recebe mesada todo mês                                      │
│  • 30% vai automático pro GUARDAR                             │
│  • Faz tarefas extras para acelerar                           │
│  • Barra de progresso: 10% → 25% → 40%                        │
│  • Notificações motivacionais do app                          │
│                                                                 │
│  Emoção: 📈 Progresso / Ansiedade                              │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  MÊS 4-6: TENTAÇÃO E PERSISTÊNCIA                              │
│  ────────────────────────────────                              │
│  • Vê jogo novo que quer comprar (R$ 200)                     │
│  • App pergunta: "Tirar da meta PS5?"                         │
│  • Mostra impacto: "Atrasa 2 meses"                           │
│  • João decide NÃO tirar                                       │
│  • Compartilha meta com avô (que contribui R$ 200)            │
│                                                                 │
│  Emoção: 😤 Frustração → 💪 Determinação                        │
│                                                                 │
│  ★ MOMENTO EDUCACIONAL: Entendeu trade-off                    │
│                                                                 │
│  ─────────────────────────────────────────────────────────────  │
│                                                                 │
│  MÊS 10: CONQUISTA!                                            │
│  ──────────────────                                            │
│  • Barra chega em 100%                                         │
│  • Animação de celebração 🎉🎊                                  │
│  • Badge desbloqueado: "Sonho Realizado"                      │
│  • Notificação para pai: "João atingiu a meta!"               │
│  • Dinheiro liberado para saque/compra                        │
│  • João compra o PS5 com PRÓPRIO dinheiro                     │
│                                                                 │
│  Emoção: 🏆 Orgulho / Realização MÁXIMA                        │
│                                                                 │
│  ★ AHA MOMENT SUPREMO: "Eu consegui sozinho!"                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 3. Research Plan

### 3.1 Metodologias Recomendadas

| Fase | Método | Participantes | Objetivo |
|------|--------|---------------|----------|
| Discovery | Entrevistas em profundidade | 12 pais + 8 filhos | Validar dores e necessidades |
| Discovery | Survey quantitativo | 500+ respostas | Quantificar demanda |
| Ideação | Card sorting | 8 pais + 8 filhos | Validar arquitetura |
| Prototipação | Teste de usabilidade | 6 pais + 6 filhos | Validar fluxos |
| Beta | Diary study | 20 famílias | Uso real por 2 semanas |
| Pós-launch | NPS mensal | Todos usuários | Medir satisfação |

### 3.2 Roteiro de Entrevista - Pais

```
AQUECIMENTO (5 min)
─────────────────
1. Me conta um pouco sobre sua família
2. Quantos filhos tem e que idade?
3. Como é a rotina financeira da casa?

COMPORTAMENTO ATUAL (10 min)
────────────────────────────
4. Seus filhos recebem mesada? Como funciona?
5. Como você dá dinheiro para eles hoje?
6. Eles têm acesso a algum app de banco?
7. Quais problemas você enfrenta com isso?

EDUCAÇÃO FINANCEIRA (10 min)
────────────────────────────
8. Você ensina educação financeira pros seus filhos?
9. Como você aprendeu sobre dinheiro?
10. O que gostaria que seus filhos aprendessem?

EXPLORAÇÃO DE SOLUÇÃO (10 min)
──────────────────────────────
11. [Mostrar conceito dos 4 Baldes]
    O que acha dessa ideia?
12. O que mais gostou? O que menos?
13. Quanto pagaria por mês por isso?
14. O que faria você cancelar o serviço?

FECHAMENTO (5 min)
──────────────────
15. Algo mais que gostaria de comentar?
16. Posso entrar em contato para testes futuros?
```

### 3.3 Roteiro de Entrevista - Filhos

```
NOTA: Entrevista realizada com pai presente (LGPD/consentimento)

AQUECIMENTO (3 min)
─────────────────
1. Qual seu nome e idade?
2. O que você gosta de fazer?
3. Você ganha mesada?

DINHEIRO HOJE (5 min)
─────────────────────
4. O que você faz com seu dinheiro?
5. Você guarda dinheiro? Pra quê?
6. Como você paga por coisas? (dinheiro, pix, cartão)

EXPLORAÇÃO (10 min)
───────────────────
7. [Mostrar protótipo do app]
   O que você acha?
8. O que parece legal?
9. O que parece chato ou difícil?
10. Você usaria isso todo dia?

GAMIFICAÇÃO (5 min)
───────────────────
11. [Mostrar badges e desafios]
    O que acha de ganhar medalhas?
12. Mostraria pros seus amigos?

FECHAMENTO (2 min)
──────────────────
13. Quer falar mais alguma coisa?
```

### 3.4 Métricas de UX

| Métrica | Descrição | Meta |
|---------|-----------|------|
| **SUS Score** | System Usability Scale | > 75 |
| **NPS** | Net Promoter Score | > 50 |
| **Task Success Rate** | % tarefas completadas sem ajuda | > 85% |
| **Time on Task** | Tempo médio por tarefa crítica | < benchmark |
| **Error Rate** | % de erros por fluxo | < 5% |
| **CSAT** | Customer Satisfaction | > 4.2/5 |

---

## 4. Information Architecture

### 4.1 Sitemap - App do Pai

```
📱 APP PAI
│
├── 🏠 Home
│   ├── Resumo de todos os filhos
│   │   ├── Foto + Nome + Saldo total
│   │   └── Última transação
│   ├── Alertas pendentes
│   │   ├── Tarefas para aprovar
│   │   └── Solicitações dos filhos
│   └── Ações rápidas
│       ├── [+ Transferir]
│       └── [Ver relatório]
│
├── 👨‍👩‍👧‍👦 Filhos
│   ├── Lista de filhos
│   └── [Perfil Individual]
│       ├── Visão geral (4 baldes)
│       ├── Extrato completo
│       ├── Controles parentais
│       │   ├── Limites de gasto
│       │   ├── Categorias bloqueadas
│       │   └── Horários permitidos
│       ├── Mesada
│       │   ├── Configurar automática
│       │   └── Vincular a tarefas
│       ├── Tarefas
│       │   ├── Criar tarefa
│       │   ├── Aprovar concluídas
│       │   └── Histórico
│       └── Cartão
│           ├── Ver cartão virtual
│           ├── Pedir físico
│           └── Bloquear/Desbloquear
│
├── 💸 Transferir
│   ├── Para filho (qual balde?)
│   ├── PIX
│   └── Histórico
│
├── 📊 Relatórios
│   ├── Gastos por categoria
│   ├── Evolução por filho
│   ├── Tarefas concluídas
│   └── Exportar dados
│
├── 🎓 Para Pais
│   ├── Dicas de educação financeira
│   ├── Artigos
│   └── Vídeos
│
└── ⚙️ Configurações
    ├── Minha conta
    ├── Plano/Assinatura
    ├── Notificações
    ├── Segurança
    └── Ajuda/FAQ
```

### 4.2 Sitemap - App do Filho

```
📱 APP FILHO
│
├── 🏠 Home (4 Baldes)
│   ├── 💳 GASTAR (destaque)
│   │   └── Saldo disponível
│   ├── 🐷 GUARDAR
│   │   └── Total + Meta principal
│   ├── 🎁 DOAR
│   │   └── Saldo para doações
│   ├── 📈 INVESTIR
│   │   └── Valor + Rendimento
│   ├── Tarefas pendentes (preview)
│   └── Última transação
│
├── 💰 Meus Baldes
│   ├── GASTAR
│   │   ├── Saldo
│   │   ├── Cartão virtual
│   │   ├── Extrato
│   │   └── [Transferir para outro balde]
│   ├── GUARDAR
│   │   ├── Total guardado
│   │   ├── Minhas metas
│   │   │   ├── [Criar meta]
│   │   │   ├── [Depositar]
│   │   │   └── [Compartilhar]
│   │   └── Histórico
│   ├── DOAR
│   │   ├── Saldo
│   │   ├── Instituições parceiras
│   │   ├── [Doar agora]
│   │   └── Histórico de doações
│   └── INVESTIR
│       ├── Valor investido
│       ├── Rendimento
│       ├── [Simulador]
│       ├── [Investir mais]
│       └── Histórico
│
├── ✅ Tarefas
│   ├── Pendentes (hoje/semana)
│   ├── [Marcar como feita]
│   ├── Concluídas
│   └── Histórico de ganhos
│
├── 🎮 Aprender
│   ├── Meu nível (XP)
│   ├── Desafio do dia
│   ├── Trilhas de conteúdo
│   ├── Quizzes
│   ├── Minhas conquistas (badges)
│   └── Ranking de amigos
│
└── ⚙️ Configurações
    ├── Meu perfil (avatar, tema)
    ├── Notificações
    └── Ajuda
```

---

## 5. Design Principles

### 5.1 Princípios Gerais

| # | Princípio | Descrição | Exemplo |
|---|-----------|-----------|---------|
| 1 | **Educação invisível** | Ensinar sem parecer aula | Aprender fazendo, não lendo |
| 2 | **Feedback instantâneo** | Toda ação tem resposta visual | Animação ao transferir dinheiro |
| 3 | **Progressão visível** | Mostrar evolução claramente | Barras de progresso, níveis |
| 4 | **Segurança transparente** | Pais no controle, filhos com autonomia | Limites visíveis para ambos |
| 5 | **Simplicidade radical** | Menos é mais | 3 cliques para qualquer ação |

### 5.2 Princípios para Crianças (6-11)

```
VISUAL
───────
✓ Cores vibrantes e alegres
✓ Ícones grandes (min 44px touch target)
✓ Fontes legíveis (min 16px)
✓ Ilustrações amigáveis
✓ Animações celebratórias

INTERAÇÃO
──────────
✓ Gestos simples (tap, não swipe complexo)
✓ Feedback sonoro opcional
✓ Confirmação antes de ações importantes
✓ Undo fácil para erros
✓ Tutoriais interativos

LINGUAGEM
──────────
✓ Palavras simples e curtas
✓ Números arredondados (R$ 50, não R$ 49,99)
✓ Metáforas visuais (cofrinho, não "poupança")
✓ Tom amigável e encorajador
✓ Celebrar pequenas vitórias
```

### 5.3 Princípios para Adolescentes (12-17)

```
VISUAL
───────
✓ Design moderno, não infantil
✓ Modo escuro disponível
✓ Customização (temas, cores)
✓ Sem elementos "bobos"
✓ Visual que dá orgulho de mostrar

INTERAÇÃO
──────────
✓ Gestos avançados OK
✓ Atalhos para power users
✓ Menos confirmações
✓ Notificações inteligentes
✓ Integração com wallets (Apple/Google Pay)

LINGUAGEM
──────────
✓ Tom casual, não paternal
✓ Gírias OK quando apropriado
✓ Sem excesso de emojis
✓ Dados precisos (centavos importam)
✓ Comparações com mercado real
```

### 5.4 Acessibilidade

| Requisito | Implementação |
|-----------|---------------|
| Contraste | WCAG AA mínimo (4.5:1) |
| Fontes | Escaláveis, min 16px |
| Touch targets | Mínimo 44x44px |
| Cores | Não usar cor como único indicador |
| Screen reader | Labels em todos elementos |
| Motion | Respeitar prefers-reduced-motion |

---

## 6. Wireframes Prioritários

### 6.1 Home com 4 Baldes (Filho)

```
┌─────────────────────────────────────┐
│ ☰                        🔔 ⚙️     │
├─────────────────────────────────────┤
│                                     │
│        Olá, João! 👋                │
│                                     │
│  ╔═══════════════════════════════╗  │
│  ║     💰 MEU DINHEIRO           ║  │
│  ║     Total: R$ 1.715           ║  │
│  ╠═══════════════════════════════╣  │
│  ║                               ║  │
│  ║  ┌───────────┐ ┌───────────┐  ║  │
│  ║  │ 💳        │ │ 🐷        │  ║  │
│  ║  │ GASTAR    │ │ GUARDAR   │  ║  │
│  ║  │           │ │           │  ║  │
│  ║  │ R$ 150    │ │ R$ 1.200  │  ║  │
│  ║  │           │ │ ████░ 40% │  ║  │
│  ║  └───────────┘ └───────────┘  ║  │
│  ║                               ║  │
│  ║  ┌───────────┐ ┌───────────┐  ║  │
│  ║  │ 🎁        │ │ 📈        │  ║  │
│  ║  │ DOAR      │ │ INVESTIR  │  ║  │
│  ║  │           │ │           │  ║  │
│  ║  │ R$ 45     │ │ R$ 320    │  ║  │
│  ║  │           │ │ +2.3%     │  ║  │
│  ║  └───────────┘ └───────────┘  ║  │
│  ║                               ║  │
│  ╚═══════════════════════════════╝  │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ ✅ TAREFAS DE HOJE          │    │
│  │ ☐ Arrumar quarto    R$ 10   │    │
│  │ ☑ Fazer lição       R$ 8    │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │ 📜 ÚLTIMA TRANSAÇÃO         │    │
│  │ iFood • -R$ 25 • há 2h      │    │
│  └─────────────────────────────┘    │
│                                     │
├─────────────────────────────────────┤
│  🏠    💰    🎯    ✅    🎮        │
│ Home  Baldes Metas Tarefas Aprender│
└─────────────────────────────────────┘
```

### 6.2 Tela de Meta (Filho)

```
┌─────────────────────────────────────┐
│ ←  Minha Meta                       │
├─────────────────────────────────────┤
│                                     │
│         ┌─────────────┐             │
│         │   🎮        │             │
│         │   [img]     │             │
│         │  PS5        │             │
│         └─────────────┘             │
│                                     │
│        PlayStation 5                │
│                                     │
│  ┌─────────────────────────────┐    │
│  │                             │    │
│  │  ████████████░░░░░░░ 40%    │    │
│  │                             │    │
│  │  R$ 1.200 de R$ 3.000       │    │
│  │                             │    │
│  └─────────────────────────────┘    │
│                                     │
│  📅 Prazo: Dezembro 2026            │
│  💰 Faltam: R$ 1.800                │
│  📊 Guardar R$ 180/mês p/ atingir  │
│                                     │
│  ┌─────────────────────────────┐    │
│  │                             │    │
│  │     [+ DEPOSITAR AGORA]     │    │
│  │                             │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │    [📤 COMPARTILHAR]        │    │
│  │  (Avós podem contribuir!)   │    │
│  └─────────────────────────────┘    │
│                                     │
│  ─────────────────────────────────  │
│                                     │
│  HISTÓRICO                          │
│  ├ Hoje      +R$ 30 (Mesada)       │
│  ├ 15/Jan    +R$ 200 (Vovô)        │
│  ├ 10/Jan    +R$ 20 (Tarefa)       │
│  └ 05/Jan    +R$ 30 (Mesada)       │
│                                     │
└─────────────────────────────────────┘
```

### 6.3 Configurar Mesada (Pai)

```
┌─────────────────────────────────────┐
│ ←  Configurar Mesada - João         │
├─────────────────────────────────────┤
│                                     │
│  VALOR DA MESADA                    │
│  ┌─────────────────────────────┐    │
│  │                             │    │
│  │      R$ [  100  ]           │    │
│  │                             │    │
│  └─────────────────────────────┘    │
│                                     │
│  FREQUÊNCIA                         │
│  ┌─────────────────────────────┐    │
│  │ ○ Semanal (toda segunda)    │    │
│  │ ● Mensal (dia 5)            │    │
│  │ ○ Quinzenal                 │    │
│  └─────────────────────────────┘    │
│                                     │
│  ════════════════════════════════   │
│  🌟 DIVISÃO NOS 4 BALDES            │
│  ════════════════════════════════   │
│                                     │
│  💳 Gastar                          │
│  ├────────────●────────┤ 50%        │
│  R$ 50                              │
│                                     │
│  🐷 Guardar                         │
│  ├───────●─────────────┤ 30%        │
│  R$ 30                              │
│                                     │
│  🎁 Doar                            │
│  ├──●──────────────────┤ 10%        │
│  R$ 10                              │
│                                     │
│  📈 Investir                        │
│  ├──●──────────────────┤ 10%        │
│  R$ 10                              │
│                                     │
│  ─────────────────────────────────  │
│  Total: 100%  =  R$ 100             │
│                                     │
│  VINCULAR A TAREFAS?                │
│  ┌─────────────────────────────┐    │
│  │ ○ Não, pagar sempre         │    │
│  │ ● Sim, se completar 80%     │    │
│  └─────────────────────────────┘    │
│                                     │
│  ┌─────────────────────────────┐    │
│  │                             │    │
│  │     [  SALVAR MESADA  ]     │    │
│  │                             │    │
│  └─────────────────────────────┘    │
│                                     │
└─────────────────────────────────────┘
```

---

## 7. Benchmark UX

### 7.1 Análise de Concorrentes

| App | Pontos Fortes | Pontos Fracos | Oportunidades |
|-----|---------------|---------------|---------------|
| **Greenlight** | 4 Baldes, gamificação, investimentos | Só EUA, preço alto | Replicar modelo no BR |
| **Nubank** | UX excelente, confiança | Sem educação, sem tarefas | Ser o "Nubank educativo" |
| **Mozper** | Foco educação, Brasil | Interface básica | Melhor UX + mais features |
| **GoHenry** | Conteúdo educativo | Não tem PIX | Adaptar ao Brasil |

### 7.2 Best Practices de Apps Infantis

```
DO (Fazer)
───────────
✓ Recompensas frequentes e pequenas
✓ Progressão visível e constante
✓ Celebrar cada conquista
✓ Permitir personalização
✓ Linguagem positiva sempre
✓ Feedback imediato a cada ação
✓ Tutoriais interativos
✓ Modo "sem internet" básico

DON'T (Evitar)
──────────────
✗ Punições ou linguagem negativa
✗ Muita informação de uma vez
✗ Fluxos longos sem salvamento
✗ Depender apenas de texto
✗ Forçar compras in-app
✗ Notificações excessivas
✗ Comparações que causem vergonha
✗ Timers ou pressão de tempo
```

### 7.3 Padrões de Gamificação

| Elemento | Implementação | Benefício |
|----------|---------------|-----------|
| **XP/Níveis** | Ganhar XP por tarefas, poupar, aprender | Senso de progressão |
| **Badges** | "Poupador Iniciante", "Investidor Mirim" | Reconhecimento |
| **Streaks** | "7 dias poupando!" | Hábito |
| **Challenges** | Desafio semanal de economia | Engajamento |
| **Leaderboard** | Ranking entre amigos (opt-in) | Social/competição saudável |
| **Avatar** | Personalizar personagem | Identidade |
| **Celebrações** | Confetti ao atingir meta | Dopamina |

---

## Próximos Passos

1. **Semana 1-2**: Recrutar 12 pais + 8 filhos para entrevistas
2. **Semana 3-4**: Conduzir entrevistas e sintetizar insights
3. **Semana 5-6**: Card sorting e validação de IA
4. **Semana 7-8**: Protótipos de alta fidelidade
5. **Semana 9-10**: Testes de usabilidade
6. **Semana 11-12**: Iteração e handoff para dev

---

*Documento gerado em Janeiro 2026 | UX Research Plan v1.0*
