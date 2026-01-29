# Product Roadmap: Fintech de Educacao Financeira Familiar

> **Documento de Planejamento de Produto** | Versao 1.0 | Janeiro 2026
>
> **Projeto**: App de mesada digital estilo Greenlight para familias brasileiras
> **Nome do Produto**: NOS (placeholder - a definir em branding)
> **Timeline**: MVP em 6 meses, escala em 18 meses

---

## Indice

1. [Visao e Estrategia](#1-visao-e-estrategia)
2. [Roadmap Detalhado](#2-roadmap-detalhado)
3. [Priorizacao com RICE](#3-priorizacao-com-rice)
4. [OKRs por Trimestre](#4-okrs-por-trimestre)
5. [Go-to-Market Strategy](#5-go-to-market-strategy)
6. [Riscos e Mitigacoes](#6-riscos-e-mitigacoes)
7. [Team Structure](#7-team-structure)

---

## 1. Visao e Estrategia

### 1.1 Vision Statement

```
"Transformar a relacao das familias brasileiras com dinheiro,
criando uma geracao financeiramente educada desde a infancia."
```

**Em 5 anos**: Ser a principal plataforma de educacao financeira familiar do Brasil, com 500.000 familias ativas ensinando seus filhos a gerenciar dinheiro de forma responsavel.

### 1.2 Mission Statement

```
"Dar aos pais as ferramentas para ensinar educacao financeira
aos filhos de forma pratica, engajante e segura."
```

### 1.3 Proposta de Valor Unica

```
+----------------------------------------------------------------------+
|                    PROPOSTA DE VALOR                                  |
+----------------------------------------------------------------------+
|                                                                       |
|  PARA: Pais de criancas/adolescentes (6-17 anos)                     |
|  QUE:  Querem ensinar educacao financeira aos filhos                 |
|  O:    [NOME DO PRODUTO] e uma fintech familiar                      |
|  QUE:  Transforma mesada em ferramenta de educacao                   |
|                                                                       |
|  DIFERENTE DE: Nubank, C6, Inter (contas basicas)                    |
|  NOSSO PRODUTO: Ensina os 4 pilares: GASTAR, GUARDAR, DOAR, INVESTIR |
|                                                                       |
|  RESULTADO: Filhos aprendem gestao financeira na pratica,            |
|             pais acompanham com total controle e visibilidade        |
|                                                                       |
+----------------------------------------------------------------------+
```

### 1.4 Diferenciais Competitivos

| # | Diferencial | Descricao | Concorrentes |
|---|-------------|-----------|--------------|
| 1 | **Sistema de 4 Baldes** | Divisao automatica em Gastar/Guardar/Doar/Investir | Nenhum tem |
| 2 | **Juros Parentais** | Pais pagam "juros" no balde Guardar incentivando poupanca | Nenhum tem |
| 3 | **Gamificacao Educacional** | Trilhas, badges, desafios de educacao financeira | Parcialmente (Tindin, Blu) |
| 4 | **Tarefas Remuneradas** | Chores integrados com recompensas automaticas | Apenas Mozper, NextJoy |
| 5 | **Metas Compartilhaveis** | Avos/tios podem contribuir para metas do neto | Nenhum tem |
| 6 | **Investimentos Educativos** | Tesouro/CDB para menores com simulador didatico | Apenas C6, Inter (basico) |

### 1.5 Positioning vs Concorrentes

```
                     MAPA DE POSICIONAMENTO

     ALTO          +-------------------------+
     FOCO          |                    [NOS]|
     EDUCACIONAL   |              *          |
                   |                         |
                   |    Mozper*   Tindin*    |
                   |                         |
                   |   Blu*                  |
                   |                         |
     BAIXO         |Inter*  Nubank*  C6*    |
     FOCO          |                         |
     EDUCACIONAL   +-------------------------+
                   BASICO         COMPLETO
                   PRODUTO        PRODUTO
```

**Estrategia**: Ocupar o quadrante superior direito com produto completo + foco educacional alto.

### 1.6 Segmentacao de Mercado

| Segmento | Caracteristicas | % Target | Estrategia |
|----------|-----------------|----------|------------|
| **Early Adopters** | Pais tech-savvy, educacao superior, 28-40 anos | 15% | Lancamento beta, feedback |
| **Mainstream A/B** | Classes A/B, 2+ filhos, preocupados com educacao | 45% | Core target, pricing padrao |
| **Mainstream C** | Classe C, smartphone Android, sensivel a preco | 40% | Plano basico, parcerias escolas |

---

## 2. Roadmap Detalhado

### 2.0 Timeline Visual

```
2026                                                    2027
|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
J     F     M     A     M     J     J     A     S     O     N     D     J
|                                                                       |
|<-- FASE 0 -->|<---- FASE 1 ---->|<-- FASE 2 -->|<---- FASE 3 ---->|<-4>|
|  Discovery   |    MVP Core      |     PMF      |     Growth       |Scale|
|  2 meses     |    4 meses       |    4 meses   |     4 meses      | ... |
|              |                  |              |                   |     |
  Jan-Fev        Mar-Jun           Jul-Out        Nov-Fev'27         Mar+
```

---

### FASE 0: Discovery e Validacao (Janeiro - Fevereiro 2026)

**Objetivo**: Validar hipoteses de produto e garantir fit com mercado brasileiro.

#### 2.1.1 Entregaveis

| Semana | Atividade | Responsavel | Output |
|--------|-----------|-------------|--------|
| 1-2 | Entrevistas com 50 familias | Product/UX | Report de insights |
| 2-3 | Analise profunda de concorrentes | Product | Benchmark detalhado |
| 3-4 | Prototipo navegavel (Figma) | Design | Prototipo clicavel |
| 4-6 | Testes de usabilidade (15 familias) | UX Research | Report de usabilidade |
| 5-6 | Definicao de parceiro BaaS | Tech Lead + Legal | Contrato assinado |
| 6-8 | Especificacao tecnica MVP | Tech Lead | Tech Spec documento |

#### 2.1.2 Hipoteses a Validar

| # | Hipotese | Metrica de Sucesso | Metodo |
|---|----------|-------------------|--------|
| H1 | Pais querem ensinar educacao financeira digitalmente | >70% interesse | Survey |
| H2 | Sistema de 4 baldes e intuitivo e desejado | >80% compreensao | Teste prototipo |
| H3 | Pais pagariam R$19.90/mes pelo servico | >50% disposicao | Survey com preco |
| H4 | Criancas engajariam com metas visuais | >85% interesse | Teste com criancas |
| H5 | Parceiro BaaS atende requisitos tecnicos | Viavel | POC tecnica |

#### 2.1.3 Criterios de Go/No-Go

```
GO para MVP se:
[X] >= 4 de 5 hipoteses validadas
[X] Parceiro BaaS contratado
[X] Time core montado (5+ pessoas)
[X] Runway >= 18 meses

NO-GO / PIVOT se:
[ ] <3 hipoteses validadas
[ ] Nenhum BaaS viavel
[ ] Interesse <50%
```

#### 2.1.4 Budget Fase 0

| Item | Custo |
|------|-------|
| Pesquisa de usuario | R$ 25.000 |
| Ferramentas (Figma, Maze, etc) | R$ 5.000 |
| Consultoria juridica inicial | R$ 30.000 |
| Time (2 meses, 5 pessoas) | R$ 150.000 |
| **Total Fase 0** | **R$ 210.000** |

---

### FASE 1: MVP Core (Marco - Junho 2026)

**Objetivo**: Lancar MVP funcional com core features para 1.000 familias beta.

#### 2.2.1 Escopo do MVP

```
+-----------------------------------------------------------------------+
|                         MVP SCOPE (4 meses)                            |
+-----------------------------------------------------------------------+
|                                                                        |
|  INCLUIDO (Must Have)                EXCLUIDO (Nice to Have)          |
|  ------------------                  ----------------------            |
|  [X] Onboarding pai + filho          [ ] Cartao fisico                |
|  [X] Sistema de 4 Baldes             [ ] Balde DOAR ativo             |
|  [X] Cartao virtual                  [ ] Balde INVESTIR ativo         |
|  [X] PIX (enviar/receber)            [ ] Tarefas (chores)             |
|  [X] Mesada automatica               [ ] Gamificacao avancada         |
|  [X] Metas de poupanca               [ ] Cashback                     |
|  [X] Extrato por balde               [ ] Educacao financeira v2       |
|  [X] Controles parentais             [ ] Localizacao GPS              |
|  [X] Notificacoes push               [ ] Open Finance                 |
|  [X] Plano basico + Plus             [ ] Comunidade                   |
|                                                                        |
+-----------------------------------------------------------------------+
```

#### 2.2.2 Cronograma de Sprints

| Sprint | Periodo | Foco | Entregaveis |
|--------|---------|------|-------------|
| **Sprint 1** | Mar 1-15 | Setup | Ambiente, CI/CD, integracao BaaS iniciada |
| **Sprint 2** | Mar 16-31 | Conta | Cadastro pai, cadastro filho, KYC basico |
| **Sprint 3** | Abr 1-15 | Baldes | Sistema de 4 baldes, divisao automatica |
| **Sprint 4** | Abr 16-30 | Cartao | Cartao virtual, limites, bloqueio |
| **Sprint 5** | Mai 1-15 | PIX | PIX entrada/saida, chaves |
| **Sprint 6** | Mai 16-31 | Metas | Metas de poupanca, progresso visual |
| **Sprint 7** | Jun 1-15 | Mesada | Auto-mesada, transferencias |
| **Sprint 8** | Jun 16-30 | Polish | QA, performance, beta release |

#### 2.2.3 Marcos (Milestones)

| Marco | Data | Descricao | Criterio de Sucesso |
|-------|------|-----------|---------------------|
| M1 | 31/Mar | Integracao BaaS completa | Criar conta via API |
| M2 | 30/Abr | 4 Baldes funcionando | Divisao automatica OK |
| M3 | 31/Mai | Transacoes operacionais | PIX + Cartao virtual |
| M4 | 15/Jun | Beta interno | 50 familias testando |
| M5 | 30/Jun | **MVP RELEASE** | 1.000 familias beta |

#### 2.2.4 Tech Stack MVP

| Camada | Tecnologia | Justificativa |
|--------|------------|---------------|
| **Mobile** | React Native | Cross-platform, time unico |
| **Backend** | Node.js + TypeScript | Ecossistema robusto, BaaS compativel |
| **Database** | PostgreSQL + Redis | Relacional + cache |
| **BaaS** | Dock ou Matera | Conta + cartao + PIX |
| **Cloud** | AWS | Escalabilidade, compliance |
| **Analytics** | Amplitude | Product analytics |
| **Monitoring** | Datadog | Observabilidade |

#### 2.2.5 Budget Fase 1

| Item | Custo |
|------|-------|
| Time (4 meses, 12 pessoas) | R$ 720.000 |
| Infraestrutura cloud | R$ 40.000 |
| BaaS (setup + operacao) | R$ 80.000 |
| Ferramentas SaaS | R$ 30.000 |
| Legal/Compliance | R$ 50.000 |
| Contingencia (15%) | R$ 138.000 |
| **Total Fase 1** | **R$ 1.058.000** |

---

### FASE 2: Product-Market Fit (Julho - Outubro 2026)

**Objetivo**: Atingir 10.000 familias ativas com NPS > 50 e retention D30 > 40%.

#### 2.3.1 Features da Fase 2

| Feature | Prioridade | Sprint Target | Descricao |
|---------|------------|---------------|-----------|
| Cartao Fisico | P0 | Jul | Emissao e entrega de cartao fisico |
| Tarefas (Chores) | P0 | Jul-Ago | Sistema de tarefas com recompensas |
| Juros Parentais | P1 | Ago | Pais pagam % extra no balde Guardar |
| Round-ups | P1 | Ago | Arredondar compras para poupanca |
| Bloqueio Categorias | P1 | Set | Bloquear MCC especificos |
| Educacao v1 | P1 | Set | Quizzes e conteudo basico |
| Compartilhar Metas | P2 | Set-Out | Familia contribui para metas |
| Cashback | P2 | Out | % de volta em compras selecionadas |

#### 2.3.2 Metricas de PMF

| Metrica | Target PMF | Como Medir |
|---------|------------|------------|
| **NPS** | > 50 | Survey mensal |
| **Retention D30** | > 40% | Analytics |
| **Retention D90** | > 25% | Analytics |
| **Transacoes/familia/mes** | > 15 | Backend |
| **% usando 4 baldes** | > 60% | Analytics |
| **Organico/Total signups** | > 30% | Attribution |
| **ARPU** | > R$ 16 | Finance |

#### 2.3.3 Experimentos Planejados

| Experimento | Hipotese | Metrica | Variantes |
|-------------|----------|---------|-----------|
| Onboarding gamificado | +20% completacao | Signup completion | A: atual, B: badges |
| Notificacao metas | +15% poupanca | Depositos balde Guardar | A: sem, B: com push |
| Trial 30 dias (vs 14) | +10% conversao | Trial to paid | A: 14d, B: 30d |
| Desconto anual | +25% LTV | Annual subscriptions | A: sem, B: 20% off |

#### 2.3.4 Cronograma Fase 2

```
JULHO          AGOSTO         SETEMBRO       OUTUBRO
|--------------|--------------|--------------|--------------|
     Cartao         Juros         Educacao       Otimizacao
     Fisico         Parentais     v1             + Experimentos
                    Round-ups     Bloqueio
     Tarefas                      Categorias     Cashback
     pt1            Tarefas
                    pt2           Compartilhar
                                  Metas
```

#### 2.3.5 Budget Fase 2

| Item | Custo |
|------|-------|
| Time (4 meses, 18 pessoas) | R$ 1.440.000 |
| Marketing (user acquisition) | R$ 400.000 |
| Infraestrutura | R$ 80.000 |
| BaaS + cartoes fisicos | R$ 200.000 |
| UX Research continuo | R$ 60.000 |
| **Total Fase 2** | **R$ 2.180.000** |

---

### FASE 3: Growth (Novembro 2026 - Fevereiro 2027)

**Objetivo**: Escalar para 50.000 familias com CAC < R$ 100 e unit economics saudavel.

#### 2.4.1 Features da Fase 3

| Feature | Prioridade | Q | Descricao |
|---------|------------|---|-----------|
| Balde DOAR ativo | P0 | Nov | Doacoes para instituicoes parceiras |
| Programa Indicacao | P0 | Nov | Referral com bonus para ambos |
| App Redesign v2 | P1 | Dez | Melhorias de UX baseadas em dados |
| Educacao v2 | P1 | Dez | Trilhas por idade, certificados |
| Parcerias Escolas | P1 | Jan | Programa B2B para escolas |
| API Publica | P2 | Jan | Integracao com parceiros |
| Balde INVESTIR prep | P2 | Fev | Integracao com corretora |

#### 2.4.2 Estrategia de Growth

```
+-----------------------------------------------------------------------+
|                      GROWTH LOOPS                                      |
+-----------------------------------------------------------------------+
|                                                                        |
|  LOOP 1: Viral Loop (Indicacao)                                       |
|  Usuario feliz -> Indica amigo -> Amigo assina -> Bonus ambos         |
|  Target: K-factor > 0.3                                                |
|                                                                        |
|  LOOP 2: Content Loop                                                  |
|  Usuario compartilha meta -> Familia ve -> Pergunta sobre app         |
|  Target: 20% metas compartilhadas                                      |
|                                                                        |
|  LOOP 3: B2B Loop                                                      |
|  Escola parceira -> Pais alunos -> Adocao em massa                    |
|  Target: 50 escolas, 5.000 familias via B2B                           |
|                                                                        |
+-----------------------------------------------------------------------+
```

#### 2.4.3 Canais de Aquisicao

| Canal | Budget Mensal | CAC Target | Volume/Mes |
|-------|---------------|------------|------------|
| Meta Ads | R$ 150.000 | R$ 80 | 1.875 |
| Google Ads | R$ 80.000 | R$ 90 | 889 |
| Influenciadores | R$ 60.000 | R$ 70 | 857 |
| Parcerias Escolas | R$ 30.000 | R$ 40 | 750 |
| Referral | R$ 40.000 | R$ 50 | 800 |
| Organico | R$ 0 | R$ 0 | 500 |
| **Total** | **R$ 360.000** | **R$ 68** | **5.671** |

#### 2.4.4 Budget Fase 3

| Item | Custo |
|------|-------|
| Time (4 meses, 25 pessoas) | R$ 2.200.000 |
| Marketing (acquisition) | R$ 1.440.000 |
| Infraestrutura | R$ 160.000 |
| BaaS | R$ 300.000 |
| Parcerias/BD | R$ 100.000 |
| **Total Fase 3** | **R$ 4.200.000** |

---

### FASE 4: Escala (Marco 2027+)

**Objetivo**: Atingir 500.000 familias em 18 meses pos-lancamento.

#### 2.5.1 Features da Fase 4

| Feature | Q1 2027 | Q2 2027 | Q3 2027 | Q4 2027 |
|---------|---------|---------|---------|---------|
| Balde INVESTIR | X | | | |
| Tesouro Direto | X | | | |
| CDB Educacional | | X | | |
| Open Finance | | X | | |
| Localizacao GPS | | | X | |
| SOS/Emergencia | | | X | |
| Gamificacao v3 | | | | X |
| Comunidade | | | | X |

#### 2.5.2 Metas de Escala

| Metrica | Mar 2027 | Jun 2027 | Set 2027 | Dez 2027 |
|---------|----------|----------|----------|----------|
| Familias Ativas | 80.000 | 150.000 | 280.000 | 500.000 |
| MRR | R$ 1.4M | R$ 2.7M | R$ 5.0M | R$ 9.0M |
| NPS | 55 | 58 | 60 | 62 |
| LTV | R$ 280 | R$ 320 | R$ 360 | R$ 400 |
| LTV:CAC | 4.0x | 4.5x | 5.0x | 5.5x |

---

## 3. Priorizacao com RICE

### 3.1 Framework RICE

```
RICE Score = (Reach x Impact x Confidence) / Effort

Reach:     Usuarios impactados por trimestre (1-10)
Impact:    Quanto melhora a metrica key (0.25, 0.5, 1, 2, 3)
Confidence: Nivel de certeza (20%, 50%, 80%, 100%)
Effort:    Pessoa-meses necessarios (1-10)
```

### 3.2 Scoring de Features MVP

| # | Feature | Reach | Impact | Confidence | Effort | RICE | Prioridade |
|---|---------|-------|--------|------------|--------|------|------------|
| 1 | Sistema 4 Baldes | 10 | 3 | 90% | 4 | **6.75** | P0 |
| 2 | Cartao Virtual | 10 | 3 | 100% | 3 | **10.00** | P0 |
| 3 | PIX | 10 | 2 | 100% | 3 | **6.67** | P0 |
| 4 | Mesada Automatica | 10 | 2 | 90% | 2 | **9.00** | P0 |
| 5 | Metas Poupanca | 8 | 2 | 80% | 2 | **6.40** | P0 |
| 6 | Controles Parentais | 10 | 2 | 100% | 3 | **6.67** | P0 |
| 7 | Notificacoes Push | 10 | 1 | 100% | 1 | **10.00** | P0 |
| 8 | Onboarding | 10 | 2 | 100% | 2 | **10.00** | P0 |
| 9 | Extrato por Balde | 8 | 1 | 90% | 1 | **7.20** | P0 |
| 10 | Cartao Fisico | 7 | 2 | 80% | 3 | **3.73** | P1 |
| 11 | Tarefas (Chores) | 6 | 2 | 70% | 4 | **2.10** | P1 |
| 12 | Juros Parentais | 5 | 2 | 60% | 2 | **3.00** | P1 |
| 13 | Round-ups | 5 | 1 | 70% | 2 | **1.75** | P2 |
| 14 | Educacao v1 | 4 | 1 | 50% | 3 | **0.67** | P2 |
| 15 | Cashback | 3 | 1 | 50% | 3 | **0.50** | P2 |

### 3.3 Must Have vs Nice to Have

```
+-----------------------------------------------------------------------+
|                    MATRIZ MUST HAVE / NICE TO HAVE                     |
+-----------------------------------------------------------------------+
|                                                                        |
|  MUST HAVE (MVP - Sem isso nao lanca)                                 |
|  ------------------------------------                                  |
|  [X] Sistema de 4 Baldes (core differentiator)                        |
|  [X] Cartao Virtual + PIX (transacoes basicas)                        |
|  [X] Mesada Automatica (core use case)                                |
|  [X] Controles Parentais (seguranca)                                  |
|  [X] Metas de Poupanca (engajamento)                                  |
|  [X] Onboarding Familiar (ativacao)                                   |
|                                                                        |
|  SHOULD HAVE (PMF - Importante para retencao)                         |
|  -------------------------------------------                          |
|  [ ] Cartao Fisico                                                    |
|  [ ] Tarefas Remuneradas                                              |
|  [ ] Juros Parentais                                                  |
|  [ ] Bloqueio de Categorias                                           |
|                                                                        |
|  NICE TO HAVE (Growth - Diferencial competitivo)                      |
|  -----------------------------------------------                      |
|  [ ] Round-ups                                                        |
|  [ ] Cashback                                                         |
|  [ ] Educacao Gamificada                                              |
|  [ ] Compartilhar Metas                                               |
|  [ ] Balde DOAR ativo                                                 |
|                                                                        |
|  FUTURE (Escala - Expansao de produto)                                |
|  ------------------------------------                                  |
|  [ ] Balde INVESTIR                                                   |
|  [ ] Open Finance                                                     |
|  [ ] Localizacao GPS                                                  |
|  [ ] Comunidade                                                       |
|                                                                        |
+-----------------------------------------------------------------------+
```

---

## 4. OKRs por Trimestre

### 4.1 Q1 2026 (Jan-Mar): Discovery + MVP Start

```
OBJECTIVE 1: Validar oportunidade de mercado
├── KR1: Realizar 50 entrevistas com familias target
├── KR2: Atingir >70% de interesse em pesquisa quantitativa (n=500)
├── KR3: Validar prototipo com 15 familias (>80% compreensao)
└── KR4: Assinar contrato com parceiro BaaS

OBJECTIVE 2: Iniciar desenvolvimento do MVP
├── KR1: Completar setup tecnico (CI/CD, staging, prod)
├── KR2: Integrar APIs basicas do BaaS (criar conta, saldo)
├── KR3: Implementar 4 Baldes no backend
└── KR4: Contratar 8 pessoas do time core

OBJECTIVE 3: Garantir compliance regulatorio
├── KR1: Mapear 100% dos requisitos Bacen/LGPD
├── KR2: Elaborar RIPD (Relatorio de Impacto)
├── KR3: Definir politicas PLD/FT
└── KR4: Nomear DPO
```

### 4.2 Q2 2026 (Abr-Jun): MVP Launch

```
OBJECTIVE 1: Lancar MVP funcional
├── KR1: Completar 100% das features MVP
├── KR2: Taxa de crash < 0.1%
├── KR3: Tempo de onboarding < 5 minutos
└── KR4: Lancar na App Store e Play Store

OBJECTIVE 2: Adquirir primeiros usuarios
├── KR1: 1.000 familias cadastradas no beta
├── KR2: 500 familias ativas (>1 transacao)
├── KR3: NPS > 40 no beta
└── KR4: Coletar 200+ feedbacks qualitativos

OBJECTIVE 3: Validar core features
├── KR1: >70% dos usuarios usando 4 Baldes
├── KR2: >50% criando pelo menos 1 meta
├── KR3: >5 transacoes/familia/mes
└── KR4: Taxa de churn mensal < 15%
```

### 4.3 Q3 2026 (Jul-Set): Product-Market Fit

```
OBJECTIVE 1: Atingir Product-Market Fit
├── KR1: 10.000 familias ativas
├── KR2: NPS > 50
├── KR3: Retention D30 > 40%
├── KR4: Retention D90 > 25%

OBJECTIVE 2: Expandir funcionalidades
├── KR1: Lancar cartao fisico (5.000 emissoes)
├── KR2: Lancar tarefas com >30% de adocao
├── KR3: Implementar juros parentais
└── KR4: Lancar educacao financeira v1

OBJECTIVE 3: Otimizar unit economics
├── KR1: CAC < R$ 100
├── KR2: ARPU > R$ 16
├── KR3: LTV > R$ 180
└── KR4: LTV:CAC > 2.0x
```

### 4.4 Q4 2026 (Out-Dez): Growth Preparation

```
OBJECTIVE 1: Escalar base de usuarios
├── KR1: 30.000 familias ativas
├── KR2: MRR > R$ 450.000
├── KR3: Crescimento organico > 25%
└── KR4: K-factor > 0.2

OBJECTIVE 2: Preparar para growth
├── KR1: Lancar programa de indicacao
├── KR2: Fechar 20 parcerias com escolas
├── KR3: Implementar balde DOAR
└── KR4: Otimizar funil (conversao +20%)

OBJECTIVE 3: Fortalecer time
├── KR1: Time de 35 pessoas
├── KR2: Estruturar 3 squads independentes
├── KR3: Implementar OKRs em todos squads
└── KR4: Employee NPS > 60
```

### 4.5 Resumo de Metricas por Trimestre

| Metrica | Q1 | Q2 | Q3 | Q4 | Ano 1 |
|---------|----|----|----|----|-------|
| Familias Ativas | - | 500 | 10.000 | 30.000 | 30.000 |
| MRR | - | R$ 8k | R$ 160k | R$ 480k | R$ 480k |
| NPS | - | 40 | 50 | 55 | 55 |
| Retention D30 | - | 35% | 40% | 45% | 45% |
| CAC | - | R$ 120 | R$ 100 | R$ 85 | R$ 85 |
| LTV | - | R$ 120 | R$ 180 | R$ 220 | R$ 220 |
| Team Size | 8 | 18 | 25 | 35 | 35 |

---

## 5. Go-to-Market Strategy

### 5.1 Fases de Lancamento

```
+-----------------------------------------------------------------------+
|                      FASES DE LANCAMENTO                               |
+-----------------------------------------------------------------------+
|                                                                        |
|  FASE ALPHA (Abr-Mai 2026)                                            |
|  Audiencia: 100 familias (F&F + early adopters)                       |
|  Objetivo: Encontrar bugs criticos, validar fluxos                    |
|  Canal: Convite direto                                                 |
|                                                                        |
|  FASE BETA (Jun 2026)                                                 |
|  Audiencia: 1.000 familias                                            |
|  Objetivo: Validar escala, coletar feedback                           |
|  Canal: Waitlist + influenciadores micro                              |
|                                                                        |
|  LANCAMENTO PUBLICO (Jul 2026)                                        |
|  Audiencia: Ilimitada                                                 |
|  Objetivo: Aquisicao em escala                                        |
|  Canal: Multi-channel (ads, PR, parcerias)                            |
|                                                                        |
+-----------------------------------------------------------------------+
```

### 5.2 Canais de Aquisicao

| Canal | Fase | Investment | CAC Esperado | % Mix |
|-------|------|------------|--------------|-------|
| **Performance (Meta/Google)** | Public | Alto | R$ 80-100 | 35% |
| **Influenciadores** | Beta+ | Medio | R$ 60-80 | 20% |
| **Parcerias Escolas** | Growth | Medio | R$ 40-60 | 15% |
| **Referral Program** | Public | Baixo | R$ 50-70 | 15% |
| **Conteudo/SEO** | Ongoing | Baixo | R$ 30-50 | 10% |
| **PR/Imprensa** | Launch | Pontual | R$ 0 | 5% |

### 5.3 Parcerias Estrategicas

#### 5.3.1 Parcerias com Escolas

```
PROGRAMA ESCOLA PARCEIRA
------------------------

Proposta de valor para escola:
- Programa de educacao financeira gratuito para alunos
- Material didatico para professores
- Dashboard com progresso da turma
- Co-branding em comunicacoes

Proposta de valor para nos:
- Aquisicao de 50-200 familias por escola
- CAC muito baixo (R$ 40-60)
- Validacao de credibilidade
- Efeito de rede entre pais

Meta Ano 1: 50 escolas = 5.000 familias
```

#### 5.3.2 Parcerias Corporativas

| Tipo | Parceiro Exemplo | Modelo | Volume Potencial |
|------|------------------|--------|------------------|
| RH/Beneficios | Empresas 500+ func | Subsidio parcial | 10.000 familias |
| Cashback | Lojas infantis | Revenue share | +5% receita |
| Financeiro | Corretoras | White-label | 20.000 familias |
| Educacional | Kumon, CNA | Co-marketing | 5.000 familias |

### 5.4 Pricing Strategy

#### 5.4.1 Estrutura de Planos

| Plano | Preco | Features | Target |
|-------|-------|----------|--------|
| **Basico** | R$ 9,90/mes | 4 Baldes, Cartao Virtual, PIX, Mesada, Metas, 1 filho | Classe C, experimentadores |
| **Plus** | R$ 19,90/mes | Basico + Cartao Fisico + Tarefas + Juros Parentais + 3 filhos | Core target, familias A/B |
| **Premium** | R$ 34,90/mes | Plus + Investimentos + Cashback + 5 filhos + Prioridade suporte | Power users, early adopters |

#### 5.4.2 Estrategia de Pricing

```
PRINCÍPIOS DE PRICING
---------------------

1. TRIAL GRATUITO
   - 30 dias free do plano Plus
   - Nao pede cartao upfront
   - Converte para Basico se nao pagar

2. SIMPLICIDADE
   - 3 planos claros
   - Sem taxas escondidas
   - Upgrade/downgrade facil

3. VALUE-BASED
   - Preco baseado no valor percebido
   - Benchmark: Nubank e free, mas sem educacao
   - Premium justificado por investimentos + cashback

4. FAMILY-FRIENDLY
   - Preco por familia, nao por filho
   - Incentiva adicionar mais filhos
   - Desconto anual 20%
```

#### 5.4.3 Projecao de Mix de Planos

| Plano | Lancamento | 6 meses | 12 meses | 24 meses |
|-------|------------|---------|----------|----------|
| Basico | 50% | 40% | 35% | 30% |
| Plus | 40% | 45% | 50% | 50% |
| Premium | 10% | 15% | 15% | 20% |
| **ARPU** | R$ 14,88 | R$ 16,49 | R$ 17,49 | R$ 19,48 |

### 5.5 Launch Plan

#### 5.5.1 Timeline de Lancamento

```
JUNHO 2026 - LANCAMENTO MVP
---------------------------

Semana 1 (Jun 1-7): Preparacao
- [ ] Press kit finalizado
- [ ] App Store / Play Store submission
- [ ] Influenciadores briefados
- [ ] Equipe de suporte treinada

Semana 2 (Jun 8-14): Soft Launch
- [ ] Release beta aberto (1.000 usuarios)
- [ ] Monitoramento intensivo
- [ ] Correcoes de bugs criticos

Semana 3 (Jun 15-21): Ramp Up
- [ ] Aumento gradual de marketing
- [ ] Primeiros influenciadores postam
- [ ] PR com veiculos selecionados

Semana 4 (Jun 22-30): Full Launch
- [ ] Campanha de performance full
- [ ] Press release geral
- [ ] Lancamento programa indicacao
```

#### 5.5.2 Metricas de Sucesso do Lancamento

| Metrica | Alvo Semana 1 | Alvo Mes 1 | Alvo Mes 3 |
|---------|---------------|------------|------------|
| Downloads | 3.000 | 15.000 | 50.000 |
| Cadastros | 1.500 | 8.000 | 28.000 |
| Familias Ativas | 500 | 3.000 | 10.000 |
| Avaliacoes 4+ estrelas | 50 | 300 | 1.000 |
| NPS | 40 | 45 | 50 |

---

## 6. Riscos e Mitigacoes

### 6.1 Matriz de Riscos

| # | Risco | Categoria | Prob | Impacto | Score | Mitigacao |
|---|-------|-----------|------|---------|-------|-----------|
| R1 | Bacen rejeita modelo | Regulatorio | Media | Critico | 12 | Parceria com IP licenciada, consultoria especializada |
| R2 | BaaS falha/indisponivel | Tecnico | Baixa | Critico | 9 | SLA rigoroso, plano B com segundo provider |
| R3 | Nubank lanca 4 Baldes | Competitivo | Alta | Alto | 12 | Speed to market, diferenciacao continua |
| R4 | CAC acima do esperado | Financeiro | Media | Alto | 9 | Diversificar canais, otimizar funil |
| R5 | Churn alto (>10%/mes) | Produto | Media | Alto | 9 | Foco em engajamento, feedback continuo |
| R6 | Fraude em cartoes | Operacional | Media | Alto | 9 | Antifraude ML, limites conservadores |
| R7 | Vazamento de dados | Seguranca | Baixa | Critico | 9 | Pentest, SOC 2, criptografia e2e |
| R8 | Time key people saem | Pessoas | Media | Medio | 6 | Equity, cultura forte, redundancia |
| R9 | Nao atinge PMF | Produto | Media | Critico | 12 | Discovery rigoroso, pivotar rapido |
| R10 | Funding gap | Financeiro | Baixa | Critico | 9 | Runway 18m, pipeline de VCs |

### 6.2 Riscos de Produto

```
RISCO: Usuarios nao entendem 4 Baldes
Probabilidade: Media
Impacto: Alto

SINAIS DE ALERTA:
- <50% dos usuarios configuram % dos baldes
- Suporte recebe muitas duvidas sobre baldes
- Usuarios deixam 100% no balde Gastar

MITIGACAO:
1. Onboarding com tutorial interativo
2. Tooltips contextuais
3. Notificacoes educativas semanais
4. Simplificar UI se necessario

PLANO B:
- Oferecer modo "simples" (sem baldes) como opcao
- A/B test para entender preferencia
```

### 6.3 Riscos de Mercado

```
RISCO: Nubank/C6/Inter copia nosso diferencial
Probabilidade: Alta (12-18 meses)
Impacto: Alto

SINAIS DE ALERTA:
- Patentes registradas por concorrentes
- Vazamentos de roadmap
- Contratacoes de especialistas em educacao

MITIGACAO:
1. Executar rapido - first mover advantage
2. Construir marca associada a educacao financeira
3. Criar comunidade forte (network effect)
4. Inovar continuamente (sempre 6m a frente)

PLANO B:
- Pivotar para B2B (white-label para bancos menores)
- Foco em nicho (ex: escolas particulares)
```

### 6.4 Riscos Regulatorios

```
RISCO: Mudanca regulatoria do Bacen
Probabilidade: Baixa
Impacto: Critico

SINAIS DE ALERTA:
- Consultas publicas sobre contas de menores
- Mudancas em outros paises (referencia)
- Incidentes com concorrentes

MITIGACAO:
1. Relacionamento proativo com regulador
2. Compliance acima do minimo
3. Associacao de fintechs (ABFintechs)
4. Buffers conservadores em todas operacoes

PLANO B:
- Ajustar produto para nova regulacao
- Se necessario, operar como app de educacao (sem banking)
```

### 6.5 Plano de Contingencia

| Trigger | Acao Imediata | Responsavel | Timeline |
|---------|---------------|-------------|----------|
| CAC > R$ 150 por 2 meses | Pausar ads, revisar canais | CMO | 48h |
| Churn > 12% por 2 meses | Task force retencao | CPO | 1 semana |
| Runway < 12 meses | Cortar custos 30% | CEO/CFO | 2 semanas |
| NPS < 30 | Parar aquisicao, focar produto | CPO | Imediato |
| Downtime > 4h | War room, comunicacao clientes | CTO | Imediato |
| Breach de dados | Incident response, notificar | CISO/DPO | 72h max |

---

## 7. Team Structure

### 7.1 Evolucao do Time

```
EVOLUCAO DO HEADCOUNT
---------------------

Fase 0     Fase 1      Fase 2      Fase 3      Fase 4
(Jan-Fev)  (Mar-Jun)   (Jul-Out)   (Nov-Fev)   (Mar+)
    5          18          30          45          65
    |          |           |           |           |
    |          |           |           |           |
    |    +13   |    +12    |    +15    |    +20    |
    |----------|-----------|-----------|-----------|
    |          |           |           |           |
    v          v           v           v           v
  Core     MVP Team    PMF Team   Growth Team  Scale Team
```

### 7.2 Estrutura de Squads

#### Fase 1-2 (MVP a PMF): Estrutura Funcional

```
CEO
├── CTO (Engineering)
│   ├── Backend (4)
│   ├── Mobile (3)
│   ├── QA (2)
│   └── DevOps (1)
├── CPO (Product)
│   ├── Product Manager (1)
│   └── UX Designer (2)
├── CMO (Marketing)
│   ├── Growth (2)
│   └── Content (1)
├── COO (Operations)
│   ├── CX/Suporte (3)
│   └── Ops (1)
└── CFO (Finance)
    ├── Finance (1)
    └── Legal/Compliance (1)
```

#### Fase 3+ (Growth): Estrutura de Squads

```
CEO
├── CTO
│   ├── Platform Squad (Core banking, infra)
│   │   └── 1 TL + 3 Eng + 1 QA
│   ├── Experience Squad (App pai + filho)
│   │   └── 1 PM + 1 Designer + 3 Eng + 1 QA
│   └── Growth Squad (Aquisicao, conversao)
│       └── 1 PM + 1 Designer + 2 Eng + 1 Data
│
├── CPO
│   ├── Product Managers (3)
│   ├── UX Research (1)
│   └── Design (3)
│
├── CMO
│   ├── Performance (2)
│   ├── Brand/Content (2)
│   ├── Parcerias (2)
│   └── Comunidade (1)
│
├── COO
│   ├── Customer Success (5)
│   ├── Operations (2)
│   └── Antifraude (2)
│
└── CFO
    ├── Finance (2)
    ├── Legal (1)
    └── Compliance (2)
```

### 7.3 Hiring Plan

| Papel | Q1 | Q2 | Q3 | Q4 | Total Ano 1 |
|-------|----|----|----|----|-------------|
| **Engineering** | | | | | |
| Backend | 1 | 2 | 2 | 2 | 7 |
| Mobile | 1 | 2 | 1 | 1 | 5 |
| QA | - | 1 | 1 | 1 | 3 |
| DevOps/SRE | - | 1 | - | 1 | 2 |
| Data Engineer | - | - | 1 | 1 | 2 |
| **Product & Design** | | | | | |
| Product Manager | 1 | 1 | 1 | - | 3 |
| UX Designer | 1 | 1 | 1 | - | 3 |
| UX Researcher | - | - | 1 | - | 1 |
| **Marketing** | | | | | |
| Growth/Performance | - | 1 | 1 | 1 | 3 |
| Content/Brand | - | 1 | - | 1 | 2 |
| Parcerias/BD | - | - | 1 | 1 | 2 |
| **Operations** | | | | | |
| CX/Suporte | - | 2 | 2 | 2 | 6 |
| Ops | - | 1 | - | 1 | 2 |
| Antifraude | - | - | 1 | 1 | 2 |
| **Finance/Legal** | | | | | |
| Finance | - | 1 | - | 1 | 2 |
| Legal/Compliance | 1 | - | 1 | 1 | 3 |
| **Leadership** | | | | | |
| C-Level | 3 | - | 1 | - | 4 |
| **Total** | **8** | **14** | **14** | **14** | **50** |

### 7.4 Perfil das Contratacoes Chave

#### CTO (Co-founder level)

```
PERFIL: CTO
-----------
Background:
- 10+ anos em engenharia
- Experiencia em fintech ou banking
- Liderou times de 20+ pessoas
- Hands-on quando necessario

Skills:
- Arquitetura de sistemas financeiros
- Seguranca e compliance
- Gestao de times de alta performance
- Integracao com BaaS

Compensacao:
- R$ 35-45k/mes + equity significativo (5-10%)
```

#### Head of Growth

```
PERFIL: HEAD OF GROWTH
----------------------
Background:
- 7+ anos em growth/marketing
- Experiencia em consumer fintech ou app
- Cases de 0 a 100k usuarios
- Data-driven

Skills:
- Performance marketing (Meta, Google)
- Product-led growth
- Analytics e atribuicao
- Testes e experimentacao

Compensacao:
- R$ 25-35k/mes + equity (1-2%)
```

### 7.5 Cultura e Valores

```
+-----------------------------------------------------------------------+
|                        VALORES DO TIME                                 |
+-----------------------------------------------------------------------+
|                                                                        |
|  1. FAMILIA PRIMEIRO                                                   |
|     Criamos produtos que nos orgulhariamos de dar aos nossos filhos   |
|                                                                        |
|  2. EDUCACAO > LUCRO                                                   |
|     Decisoes sempre priorizando educacao financeira real               |
|                                                                        |
|  3. TRANSPARENCIA RADICAL                                              |
|     Informacao aberta, feedback direto, sem politica                  |
|                                                                        |
|  4. DONO, NAO INQUILINO                                               |
|     Todos tem equity, todos pensam como fundadores                    |
|                                                                        |
|  5. IMPACTO > ATIVIDADE                                               |
|     Medimos resultados, nao horas trabalhadas                         |
|                                                                        |
+-----------------------------------------------------------------------+
```

---

## Anexo A: Metricas de Referencia (Benchmarks)

### A.1 Greenlight (EUA)

| Metrica | Valor | Ano |
|---------|-------|-----|
| Usuarios | 6.5M familias | 2024 |
| Valuation | $2.3B | 2021 |
| Funding total | $556M | 2021 |
| Volume transacionado | $2B/ano | 2024 |
| Savings (poupanca) | $259M | 2024 |

### A.2 Concorrentes Brasil

| App | Downloads | Avaliacao | Familias Est. |
|-----|-----------|-----------|---------------|
| Nubank | N/A (junto) | 4.8 | 500k+ |
| Mozper | 400k | 4.2 | 100k |
| NextJoy | 100k | 3.8 | 50k |
| Inter Kids | N/A | 4.5 | 200k |

---

## Anexo B: Glossario

| Termo | Definicao |
|-------|-----------|
| **4 Baldes** | Sistema de divisao automatica da mesada em Gastar, Guardar, Doar, Investir |
| **BaaS** | Banking as a Service - infraestrutura bancaria terceirizada |
| **CAC** | Customer Acquisition Cost - custo para adquirir um cliente |
| **Churn** | Taxa de cancelamento mensal |
| **LTV** | Lifetime Value - valor total que um cliente gera |
| **MRR** | Monthly Recurring Revenue - receita recorrente mensal |
| **NPS** | Net Promoter Score - metrica de satisfacao (-100 a +100) |
| **PMF** | Product-Market Fit - momento em que produto atende mercado |
| **RICE** | Reach, Impact, Confidence, Effort - framework de priorizacao |

---

## Anexo C: Referencias Regulatorias

- Bacen - Instituicoes de Pagamento
- LGPD - Lei 13.709/2018
- Codigo Civil - Art. 1.634 (representacao de menores)
- Circular Bacen 3.978/2020 - PLD/FT

---

## Proximos Passos

| # | Acao | Responsavel | Deadline |
|---|------|-------------|----------|
| 1 | Validar roadmap com stakeholders | CEO | 15/Jan |
| 2 | Iniciar pesquisa de usuarios | CPO | 20/Jan |
| 3 | Fechar contrato BaaS | CTO + Legal | 28/Fev |
| 4 | Completar hiring Q1 | RH | 28/Fev |
| 5 | Kickoff desenvolvimento MVP | CTO | 01/Mar |

---

*Documento elaborado para planejamento estrategico de produto.*
*Sujeito a revisoes conforme aprendizados de mercado.*
*Versao: 1.0 | Janeiro 2026*
