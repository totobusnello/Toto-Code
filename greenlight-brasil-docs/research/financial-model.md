# Modelo Financeiro - Fintech de Educacao Financeira Familiar

> **Documento**: Modelo Financeiro e Projecoes | Versao 1.0 | Janeiro 2026
>
> **Projeto**: Fintech de mesada digital e educacao financeira para familias brasileiras
> **Horizonte**: 5 anos (2026-2030)

---

## Indice

1. [Resumo Executivo](#1-resumo-executivo)
2. [Premissas do Modelo](#2-premissas-do-modelo)
3. [Projecao de Usuarios](#3-projecao-de-usuarios)
4. [Projecao de Receita](#4-projecao-de-receita)
5. [Estrutura de Custos](#5-estrutura-de-custos)
6. [Unit Economics](#6-unit-economics)
7. [Ponto de Equilibrio](#7-ponto-de-equilibrio)
8. [Analise de Cenarios](#8-analise-de-cenarios)
9. [Tabelas de Projecao Ano a Ano](#9-tabelas-de-projecao-ano-a-ano)
10. [Analise de Sensibilidade](#10-analise-de-sensibilidade)
11. [Metricas de Investimento](#11-metricas-de-investimento)
12. [Riscos e Mitigacoes](#12-riscos-e-mitigacoes)

---

## 1. Resumo Executivo

### 1.1 Visao Geral do Negocio

Fintech de educacao financeira familiar com foco no mercado brasileiro, oferecendo:
- Conta digital para menores (6-17 anos)
- Cartao de debito fisico e virtual
- Sistema de 4 Baldes (Gastar/Guardar/Doar/Investir) - **diferencial unico no Brasil**
- Mesada digital automatizada com divisao inteligente
- Gamificacao e educacao financeira

### 1.2 Highlights Financeiros (Cenario Base)

| Metrica | Ano 1 | Ano 3 | Ano 5 |
|---------|-------|-------|-------|
| Familias Ativas | 25.000 | 180.000 | 500.000 |
| MRR | R$ 412k | R$ 3.5M | R$ 11.2M |
| ARR | R$ 4.9M | R$ 42M | R$ 134M |
| Margem Bruta | 45% | 62% | 72% |
| EBITDA | -R$ 8.2M | R$ 4.8M | R$ 48M |
| Break-even | Mes 28 | - | - |

### 1.3 Necessidade de Capital

| Fase | Valor | Uso Principal |
|------|-------|---------------|
| Seed | R$ 3.5M | MVP + Lancamento |
| Serie A | R$ 18M | Escala + Time |
| Serie B | R$ 50M | Expansao Nacional |

---

## 2. Premissas do Modelo

### 2.1 Premissas de Mercado

| Premissa | Valor | Fonte/Justificativa |
|----------|-------|---------------------|
| TAM (Total Addressable Market) | 50M familias | IBGE - Total familias Brasil |
| SAM (Serviceable Addressable Market) | 15M familias | Classes A/B/C com filhos 6-17 anos |
| SOM (Serviceable Obtainable Market) | 750k familias | 5% do SAM em 5 anos |
| Penetracao digital em familias | 78% | Pesquisa TIC Domicilios |
| Crescimento mercado fintech kids | 35% a.a. | Projecao baseada em EUA |

### 2.2 Premissas de Pricing

| Plano | Preco Mensal | Filhos Inclusos | Mix Esperado |
|-------|--------------|-----------------|--------------|
| **Basico** | R$ 9,90 | 1 filho | 35% |
| **Familia** | R$ 19,90 | Ate 3 filhos | 45% |
| **Premium** | R$ 34,90 | Ate 5 filhos | 20% |

**ARPU Calculado:**
```
ARPU = (0.35 x R$9.90) + (0.45 x R$19.90) + (0.20 x R$34.90)
ARPU = R$3.47 + R$8.96 + R$6.98
ARPU = R$19.41/mes (media ponderada)
```

**Ajuste por periodo:**
- Ano 1: R$ 16.50 (maior peso no basico, fase de conquista)
- Ano 2: R$ 18.20 (migracao para planos superiores)
- Ano 3: R$ 19.50 (mix estabilizado)
- Ano 4-5: R$ 22.40 (upsell + novos features)

### 2.3 Premissas de Aquisicao

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Downloads mensais | 8.000 | 18.000 | 35.000 | 50.000 | 65.000 |
| Download -> Cadastro | 30% | 35% | 38% | 40% | 42% |
| Cadastro -> Ativacao | 55% | 60% | 65% | 68% | 70% |
| Trial -> Pagante | 40% | 45% | 50% | 52% | 55% |
| Conversao total | 6.6% | 9.5% | 12.4% | 14.1% | 16.2% |

### 2.4 Premissas de Retencao (Churn)

| Periodo | Churn Mensal | Churn Anual | Justificativa |
|---------|--------------|-------------|---------------|
| Ano 1 | 8.0% | 62% | Produto novo, ajustes |
| Ano 2 | 6.0% | 52% | Melhoria de produto |
| Ano 3 | 4.5% | 42% | Engajamento consolidado |
| Ano 4 | 3.5% | 35% | Habito formado |
| Ano 5 | 3.0% | 31% | Maturidade |

**Lifetime medio:**
```
Lifetime = 1 / Churn Mensal
Ano 1: 1/0.08 = 12.5 meses
Ano 3: 1/0.045 = 22.2 meses
Ano 5: 1/0.03 = 33.3 meses
```

### 2.5 Premissas de Transacoes (Interchange)

| Metrica | Valor | Observacao |
|---------|-------|------------|
| Mesada media mensal | R$ 150 | Por familia |
| Transacoes cartao/mes | 12 | Por familia ativa |
| Ticket medio transacao | R$ 35 | Baseado em Greenlight |
| Volume mensal/familia | R$ 420 | 12 x R$35 |
| Taxa interchange | 1.50% | Debito Mastercard/Visa Brasil |
| Revenue share BaaS | 60% | Fica com a fintech |
| Receita interchange/familia | R$ 3.78 | R$420 x 1.5% x 60% |

### 2.6 Premissas Macroeconomicas

| Premissa | Valor |
|----------|-------|
| Inflacao anual (IPCA) | 4.5% |
| Reajuste de precos | Ano 2: 5%, Ano 4: 8% |
| CDI referencia | 11.5% a.a. |
| Dolar (referencia) | R$ 5.20 |

---

## 3. Projecao de Usuarios

### 3.1 Funil de Aquisicao Detalhado

```
                    ANO 1           ANO 2           ANO 3           ANO 4           ANO 5
                    -----           -----           -----           -----           -----
Downloads          96.000         216.000         420.000         600.000         780.000
                      |               |               |               |               |
                    30%             35%             38%             40%             42%
                      v               v               v               v               v
Cadastros          28.800          75.600         159.600         240.000         327.600
                      |               |               |               |               |
                    55%             60%             65%             68%             70%
                      v               v               v               v               v
Ativados           15.840          45.360         103.740         163.200         229.320
                      |               |               |               |               |
                    40%             45%             50%             52%             55%
                      v               v               v               v               v
Pagantes            6.336          20.412          51.870          84.864         126.126
(Novas familias)
```

### 3.2 Evolucao da Base de Usuarios

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| **Base Inicial** | 0 | 25.000 | 72.000 | 180.000 | 320.000 |
| **Novas Familias** | 31.680 | 63.504 | 155.610 | 220.000 | 270.000 |
| **Churn (familias)** | -6.680 | -16.504 | -55.610 | -80.000 | -90.000 |
| **Base Final** | 25.000 | 72.000 | 172.000 | 320.000 | 500.000 |
| **Crescimento YoY** | - | 188% | 139% | 86% | 56% |

**Calculo do Churn:**
- Ano 1: Base media 12.500 x 8% x 12 meses (ajustado) = 6.680
- Ano 2: Base media 48.500 x 6% x 12 meses (ajustado) = 16.504
- E assim por diante...

### 3.3 Metricas de Usuarios Derivadas

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Filhos por familia | 1.4 | 1.5 | 1.6 | 1.7 | 1.8 |
| Total de criancas | 35.000 | 108.000 | 275.200 | 544.000 | 900.000 |
| Cartoes emitidos | 28.000 | 90.000 | 240.000 | 480.000 | 800.000 |
| MAU (Monthly Active) | 20.000 | 61.200 | 154.800 | 291.200 | 460.000 |
| DAU/MAU Ratio | 28% | 30% | 32% | 33% | 35% |

---

## 4. Projecao de Receita

### 4.1 Receita por Fonte (Cenario Base)

#### 4.1.1 Receita de Assinaturas (70% do total)

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| Base media mensal | 12.500 | 48.500 | 126.000 | 250.000 | 410.000 |
| ARPU mensal | R$ 16.50 | R$ 18.20 | R$ 19.50 | R$ 21.00 | R$ 22.40 |
| MRR Assinaturas | R$ 206k | R$ 883k | R$ 2.46M | R$ 5.25M | R$ 9.18M |
| ARR Assinaturas | R$ 2.47M | R$ 10.6M | R$ 29.5M | R$ 63.0M | R$ 110.2M |

#### 4.1.2 Receita de Interchange (25% do total)

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| Familias ativas cartao | 10.000 | 43.650 | 117.600 | 240.000 | 400.000 |
| Volume transacionado/mes | R$ 4.2M | R$ 18.3M | R$ 49.4M | R$ 100.8M | R$ 168M |
| Receita interchange/mes | R$ 37.8k | R$ 165k | R$ 445k | R$ 907k | R$ 1.51M |
| Receita interchange/ano | R$ 453k | R$ 1.98M | R$ 5.34M | R$ 10.9M | R$ 18.1M |

#### 4.1.3 Outras Receitas (5% do total)

| Fonte | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| Cartao fisico (R$25) | R$ 350k | R$ 600k | R$ 900k | R$ 1.2M | R$ 1.5M |
| Cartao personalizado (R$35) | R$ 70k | R$ 180k | R$ 400k | R$ 720k | R$ 1.0M |
| Parcerias/Cashback | R$ 50k | R$ 200k | R$ 450k | R$ 800k | R$ 1.2M |
| B2B (white-label) | R$ 0 | R$ 100k | R$ 400k | R$ 1.0M | R$ 2.5M |
| **Total Outras** | R$ 470k | R$ 1.08M | R$ 2.15M | R$ 3.72M | R$ 6.2M |

### 4.2 Receita Total Consolidada

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| **Assinaturas** | R$ 2.47M | R$ 10.6M | R$ 29.5M | R$ 63.0M | R$ 110.2M |
| **Interchange** | R$ 0.45M | R$ 1.98M | R$ 5.34M | R$ 10.9M | R$ 18.1M |
| **Outras** | R$ 0.47M | R$ 1.08M | R$ 2.15M | R$ 3.72M | R$ 6.2M |
| **Receita Bruta Total** | R$ 3.39M | R$ 13.66M | R$ 36.99M | R$ 77.62M | R$ 134.5M |
| **(-) Impostos (9.25% PIS/COFINS)** | R$ 0.31M | R$ 1.26M | R$ 3.42M | R$ 7.18M | R$ 12.44M |
| **Receita Liquida** | R$ 3.08M | R$ 12.4M | R$ 33.57M | R$ 70.44M | R$ 122.06M |

### 4.3 Evolucao MRR e ARR

```
MRR (em milhares de R$)

Ano 5  |                                              ████████████  11.200
Ano 4  |                              ██████████████████████        6.480
Ano 3  |                    ███████████████████                     3.080
Ano 2  |          ██████████████                                    1.138
Ano 1  |  ████████                                                    283
       +----------------------------------------------------------------
         Q1   Q2   Q3   Q4   Q1   Q2   Q3   Q4   Q1   Q2   Q3   Q4
```

### 4.4 Mix de Receita ao Longo do Tempo

| Fonte | Ano 1 | Ano 3 | Ano 5 |
|-------|-------|-------|-------|
| Assinaturas | 73% | 80% | 82% |
| Interchange | 13% | 14% | 13% |
| Outras | 14% | 6% | 5% |

---

## 5. Estrutura de Custos

### 5.1 Custo de Aquisicao de Clientes (CAC)

#### 5.1.1 Investimento em Marketing

| Canal | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| Performance (Meta/Google) | R$ 1.8M | R$ 3.2M | R$ 5.5M | R$ 7.0M | R$ 8.5M |
| Influenciadores | R$ 400k | R$ 800k | R$ 1.5M | R$ 2.0M | R$ 2.5M |
| Conteudo/SEO | R$ 150k | R$ 300k | R$ 500k | R$ 700k | R$ 900k |
| Parcerias escolas | R$ 100k | R$ 400k | R$ 800k | R$ 1.2M | R$ 1.5M |
| PR/Eventos | R$ 150k | R$ 300k | R$ 500k | R$ 600k | R$ 700k |
| Referral program | R$ 200k | R$ 500k | R$ 1.0M | R$ 1.5M | R$ 2.0M |
| **Total Marketing** | R$ 2.8M | R$ 5.5M | R$ 9.8M | R$ 13.0M | R$ 16.1M |

#### 5.1.2 Calculo do CAC

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Investimento Marketing | R$ 2.8M | R$ 5.5M | R$ 9.8M | R$ 13.0M | R$ 16.1M |
| Novas Familias Pagantes | 31.680 | 63.504 | 155.610 | 220.000 | 270.000 |
| **CAC** | R$ 88 | R$ 87 | R$ 63 | R$ 59 | R$ 60 |
| Benchmark mercado | R$ 100 | R$ 100 | R$ 100 | R$ 100 | R$ 100 |

**Melhoria no CAC**: Devido a:
- Maior conversao organica (marca)
- Referral program maduro
- Parcerias escolas gerando leads qualificados
- Otimizacao de campanhas com dados historicos

### 5.2 Custo de Infraestrutura e BaaS

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| **BaaS (Dock/Pismo)** | | | | | |
| - Fee fixo mensal | R$ 180k | R$ 360k | R$ 480k | R$ 600k | R$ 720k |
| - Fee por conta (R$2/conta) | R$ 50k | R$ 144k | R$ 344k | R$ 640k | R$ 1.0M |
| - Fee por cartao (R$8) | R$ 224k | R$ 720k | R$ 1.92M | R$ 3.84M | R$ 6.4M |
| - Fee por transacao (R$0.15) | R$ 216k | R$ 943k | R$ 2.54M | R$ 5.18M | R$ 8.64M |
| **Subtotal BaaS** | R$ 670k | R$ 2.17M | R$ 5.28M | R$ 10.26M | R$ 16.76M |
| | | | | | |
| **Cloud (AWS)** | R$ 180k | R$ 420k | R$ 780k | R$ 1.2M | R$ 1.8M |
| **Outros SaaS** | R$ 120k | R$ 240k | R$ 360k | R$ 480k | R$ 600k |
| **Seguranca/Compliance** | R$ 100k | R$ 200k | R$ 350k | R$ 500k | R$ 650k |
| | | | | | |
| **Total Infraestrutura** | R$ 1.07M | R$ 3.03M | R$ 6.77M | R$ 12.44M | R$ 19.81M |

**Custo por usuario:**
| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Custo infra/familia/mes | R$ 7.13 | R$ 5.21 | R$ 4.48 | R$ 4.15 | R$ 4.03 |

### 5.3 Custo de Time (Headcount)

#### 5.3.1 Evolucao do Time

| Area | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------|-------|-------|-------|-------|-------|
| Engenharia | 8 | 18 | 32 | 45 | 55 |
| Produto | 2 | 5 | 8 | 12 | 15 |
| Design | 2 | 4 | 6 | 8 | 10 |
| Dados/Analytics | 1 | 3 | 6 | 10 | 14 |
| Marketing | 3 | 6 | 10 | 14 | 18 |
| CX/Suporte | 4 | 12 | 25 | 40 | 55 |
| Financeiro | 2 | 4 | 6 | 8 | 10 |
| Juridico/Compliance | 1 | 2 | 4 | 6 | 8 |
| Operacoes | 2 | 4 | 6 | 8 | 10 |
| Lideranca/C-Level | 4 | 5 | 6 | 7 | 8 |
| **Total** | 29 | 63 | 109 | 158 | 203 |

#### 5.3.2 Custo de Pessoal

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| Salarios brutos | R$ 3.5M | R$ 8.2M | R$ 15.3M | R$ 23.7M | R$ 32.5M |
| Encargos (70%) | R$ 2.45M | R$ 5.74M | R$ 10.71M | R$ 16.59M | R$ 22.75M |
| Beneficios | R$ 520k | R$ 1.13M | R$ 1.96M | R$ 2.84M | R$ 3.65M |
| Stock Options (custo) | R$ 200k | R$ 500k | R$ 1.0M | R$ 1.5M | R$ 2.0M |
| **Total Pessoal** | R$ 6.67M | R$ 15.57M | R$ 28.97M | R$ 44.63M | R$ 60.9M |

**Custo medio por colaborador:**
| Ano | Colaboradores | Custo Total | Custo Medio/Mes |
|-----|---------------|-------------|-----------------|
| 1 | 29 | R$ 6.67M | R$ 19.2k |
| 3 | 109 | R$ 28.97M | R$ 22.1k |
| 5 | 203 | R$ 60.9M | R$ 25.0k |

### 5.4 Outros Custos Operacionais

| Categoria | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----------|-------|-------|-------|-------|-------|
| Escritorio/Facilities | R$ 360k | R$ 720k | R$ 1.2M | R$ 1.68M | R$ 2.1M |
| Viagens/Eventos | R$ 100k | R$ 200k | R$ 350k | R$ 500k | R$ 650k |
| Juridico externo | R$ 200k | R$ 350k | R$ 500k | R$ 700k | R$ 900k |
| Contabilidade/Auditoria | R$ 80k | R$ 150k | R$ 250k | R$ 400k | R$ 550k |
| Seguros | R$ 50k | R$ 100k | R$ 200k | R$ 350k | R$ 500k |
| Outros | R$ 150k | R$ 280k | R$ 400k | R$ 550k | R$ 700k |
| **Total Outros** | R$ 940k | R$ 1.8M | R$ 2.9M | R$ 4.18M | R$ 5.4M |

### 5.5 Resumo da Estrutura de Custos

| Categoria | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----------|-------|-------|-------|-------|-------|
| Marketing (CAC) | R$ 2.8M | R$ 5.5M | R$ 9.8M | R$ 13.0M | R$ 16.1M |
| Infraestrutura/BaaS | R$ 1.07M | R$ 3.03M | R$ 6.77M | R$ 12.44M | R$ 19.81M |
| Pessoal | R$ 6.67M | R$ 15.57M | R$ 28.97M | R$ 44.63M | R$ 60.9M |
| Outros Operacionais | R$ 0.94M | R$ 1.8M | R$ 2.9M | R$ 4.18M | R$ 5.4M |
| **Custo Total** | R$ 11.48M | R$ 25.9M | R$ 48.44M | R$ 74.25M | R$ 102.21M |

---

## 6. Unit Economics

### 6.1 LTV (Lifetime Value)

#### 6.1.1 Calculo do LTV

```
LTV = ARPU x Margem Bruta x Lifetime (meses)

Onde:
- ARPU = Receita media por usuario por mes
- Margem Bruta = (Receita - Custos Variaveis) / Receita
- Lifetime = 1 / Churn Mensal
```

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| ARPU Total (assin + interchange) | R$ 18.52 | R$ 20.42 | R$ 21.94 | R$ 23.57 | R$ 25.17 |
| Custos Variaveis/usuario | R$ 7.13 | R$ 5.21 | R$ 4.48 | R$ 4.15 | R$ 4.03 |
| **Margem Bruta/usuario** | R$ 11.39 | R$ 15.21 | R$ 17.46 | R$ 19.42 | R$ 21.14 |
| Margem Bruta % | 61.5% | 74.5% | 79.6% | 82.4% | 84.0% |
| Churn Mensal | 8.0% | 6.0% | 4.5% | 3.5% | 3.0% |
| Lifetime (meses) | 12.5 | 16.7 | 22.2 | 28.6 | 33.3 |
| **LTV** | R$ 142 | R$ 254 | R$ 388 | R$ 555 | R$ 704 |

#### 6.1.2 Evolucao do LTV

```
LTV (R$)

700 |                                            ██
600 |                                  ████████████
500 |                        ████████████████████████
400 |              ██████████████████████████████████
300 |        ██████████████████████████████████████
200 |  ██████████████████████████████████████████
100 |████████████████████████████████████████████
  0 +----------------------------------------
      Ano 1    Ano 2    Ano 3    Ano 4    Ano 5
```

### 6.2 CAC (Customer Acquisition Cost)

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Total Marketing | R$ 2.8M | R$ 5.5M | R$ 9.8M | R$ 13.0M | R$ 16.1M |
| Novas Familias | 31.680 | 63.504 | 155.610 | 220.000 | 270.000 |
| **CAC** | R$ 88 | R$ 87 | R$ 63 | R$ 59 | R$ 60 |

### 6.3 LTV:CAC Ratio

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 | Benchmark |
|---------|-------|-------|-------|-------|-------|-----------|
| LTV | R$ 142 | R$ 254 | R$ 388 | R$ 555 | R$ 704 | - |
| CAC | R$ 88 | R$ 87 | R$ 63 | R$ 59 | R$ 60 | < R$ 100 |
| **LTV:CAC** | 1.61x | 2.92x | 6.16x | 9.41x | 11.73x | > 3x |

**Interpretacao:**
- **Ano 1 (1.61x)**: Abaixo do ideal, esperado para fase de lancamento
- **Ano 2 (2.92x)**: Proximo do benchmark, modelo comecando a se provar
- **Ano 3+ (6x+)**: Excelente, negocio altamente eficiente

### 6.4 Payback Period (Meses para Recuperar CAC)

```
Payback = CAC / (ARPU x Margem Bruta)
```

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| CAC | R$ 88 | R$ 87 | R$ 63 | R$ 59 | R$ 60 |
| Margem Bruta Mensal | R$ 11.39 | R$ 15.21 | R$ 17.46 | R$ 19.42 | R$ 21.14 |
| **Payback (meses)** | 7.7 | 5.7 | 3.6 | 3.0 | 2.8 |
| Benchmark | < 12 | < 12 | < 12 | < 12 | < 12 |

### 6.5 Resumo Unit Economics

```
+-------------------------------------------------------------------+
|                    UNIT ECONOMICS - ANO 5                          |
+-------------------------------------------------------------------+
|                                                                   |
|  ARPU Mensal          R$ 25.17                                    |
|  (-) Custo Variavel   R$  4.03                                    |
|  (=) Margem Bruta     R$ 21.14  (84%)                             |
|                                                                   |
|  Lifetime             33.3 meses                                  |
|  LTV                  R$ 704                                      |
|                                                                   |
|  CAC                  R$ 60                                       |
|  LTV:CAC              11.73x                                      |
|  Payback              2.8 meses                                   |
|                                                                   |
+-------------------------------------------------------------------+
```

---

## 7. Ponto de Equilibrio (Break-even)

### 7.1 Break-even Operacional

#### 7.1.1 Analise de Custos Fixos vs Variaveis

| Tipo | Componentes | Ano 1 | Ano 3 | Ano 5 |
|------|-------------|-------|-------|-------|
| **Custos Fixos** | Pessoal, Escritorio, BaaS fixo | R$ 7.79M | R$ 32.27M | R$ 67.2M |
| **Custos Variaveis** | Infra/usuario, BaaS variavel | R$ 0.89M | R$ 5.77M | R$ 16.16M |
| **Marketing** | Aquisicao | R$ 2.8M | R$ 9.8M | R$ 16.1M |
| **Total** | | R$ 11.48M | R$ 47.84M | R$ 99.46M |

#### 7.1.2 Calculo do Break-even

```
Break-even (familias) = Custos Fixos / Margem Contribuicao por Familia

Margem Contribuicao = ARPU - Custo Variavel/usuario
```

| Metrica | Calculo |
|---------|---------|
| Custos Fixos Mensais (Ano 2) | R$ 1.46M |
| Margem Contribuicao/Familia | R$ 15.21 |
| **Break-even Mensal** | 96.000 familias |

**Ponto de Break-even: ~96.000 familias ativas** (Mes 28 aproximadamente)

### 7.2 Projecao de Cash Flow para Break-even

| Mes | Familias | Receita | Custos | Resultado | Acumulado |
|-----|----------|---------|--------|-----------|-----------|
| 6 | 8.000 | R$ 148k | R$ 890k | -R$ 742k | -R$ 4.5M |
| 12 | 25.000 | R$ 463k | R$ 956k | -R$ 493k | -R$ 8.2M |
| 18 | 50.000 | R$ 1.02M | R$ 1.45M | -R$ 430k | -R$ 10.9M |
| 24 | 72.000 | R$ 1.47M | R$ 1.85M | -R$ 380k | -R$ 13.2M |
| 28 | 96.000 | R$ 1.96M | R$ 1.96M | R$ 0 | -R$ 14.0M |
| 36 | 172.000 | R$ 3.53M | R$ 2.64M | R$ 890k | -R$ 8.5M |
| 48 | 320.000 | R$ 6.58M | R$ 4.15M | R$ 2.43M | R$ 15.1M |
| 60 | 500.000 | R$ 11.2M | R$ 6.35M | R$ 4.85M | R$ 62.8M |

### 7.3 Grafico de Break-even

```
Resultado Mensal (R$ milhoes)

 5.0 |                                            ████
 4.0 |                                      ██████████
 3.0 |                                ████████████████
 2.0 |                          ██████████████████████
 1.0 |                    ██████████████████████████████
 0.0 |---------------████████████████████████████████████  <- Break-even (Mes 28)
-0.5 |██████████████████████████████████████████████████
-1.0 |████████████████████████████████████████████████
     +--------------------------------------------------
       M6   M12   M18   M24   M30   M36   M42   M48   M54   M60
```

### 7.4 Cash Runway

| Cenario | Necessidade Pre-Break-even | Rodada Necessaria |
|---------|---------------------------|-------------------|
| Conservador | R$ 18M | Seed (R$4M) + Serie A (R$20M) |
| Base | R$ 14M | Seed (R$3.5M) + Serie A (R$15M) |
| Otimista | R$ 10M | Seed (R$3M) + Serie A (R$10M) |

---

## 8. Analise de Cenarios

### 8.1 Definicao dos Cenarios

| Variavel | Conservador | Base | Otimista |
|----------|-------------|------|----------|
| Crescimento usuarios | -30% | 0% | +40% |
| ARPU | -15% | 0% | +10% |
| Churn | +25% | 0% | -20% |
| CAC | +20% | 0% | -15% |
| Custo Time | +10% | 0% | -5% |

### 8.2 Cenario Conservador

**Premissas ajustadas:**
- Crescimento mais lento (dificuldade de aquisicao)
- ARPU menor (maior peso no plano basico)
- Churn mais alto (concorrencia mais acirrada)
- CAC mais elevado (mercado mais competitivo)

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 17.500 | 45.000 | 100.000 | 180.000 | 280.000 |
| MRR | R$ 210k | R$ 670k | R$ 1.6M | R$ 3.2M | R$ 5.4M |
| ARR | R$ 2.5M | R$ 8.0M | R$ 19.2M | R$ 38.4M | R$ 64.8M |
| Custo Total | R$ 10.5M | R$ 22.0M | R$ 38.0M | R$ 56.0M | R$ 74.0M |
| **EBITDA** | -R$ 8.0M | -R$ 14.0M | -R$ 18.8M | -R$ 17.6M | -R$ 9.2M |
| Break-even | Mes 54+ | - | - | - | - |

### 8.3 Cenario Base

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 25.000 | 72.000 | 172.000 | 320.000 | 500.000 |
| MRR | R$ 412k | R$ 1.31M | R$ 3.35M | R$ 6.48M | R$ 11.2M |
| ARR | R$ 4.9M | R$ 15.7M | R$ 40.2M | R$ 77.8M | R$ 134.4M |
| Custo Total | R$ 11.48M | R$ 25.9M | R$ 48.4M | R$ 74.3M | R$ 102.2M |
| **EBITDA** | -R$ 8.2M | -R$ 12.5M | -R$ 11.6M | R$ 0.3M | R$ 28.0M |
| Break-even | Mes 28 | - | - | - | - |

### 8.4 Cenario Otimista

**Premissas ajustadas:**
- Viralidade alta (produto diferenciado)
- ARPU maior (migracao para Premium)
- Churn baixo (engajamento forte)
- CAC eficiente (marketing de performance otimizado)

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 35.000 | 110.000 | 280.000 | 520.000 | 800.000 |
| MRR | R$ 630k | R$ 2.2M | R$ 6.2M | R$ 12.5M | R$ 21.0M |
| ARR | R$ 7.6M | R$ 26.4M | R$ 74.4M | R$ 150.0M | R$ 252.0M |
| Custo Total | R$ 11.0M | R$ 28.0M | R$ 58.0M | R$ 95.0M | R$ 135.0M |
| **EBITDA** | -R$ 5.6M | -R$ 4.8M | R$ 12.0M | R$ 48.0M | R$ 107.0M |
| Break-even | Mes 22 | - | - | - | - |

### 8.5 Comparativo de Cenarios

```
ARR (R$ milhoes)

     Otimista
      /
260 |                                            ██
220 |                                      ██████
180 |                                ██████
140 |                          ██████      Base
100 |                    ██████         ██████
 60 |              ██████         ██████    Conservador
 20 |        ██████         ██████    ██████
  0 +----------------------------------------
      Ano 1    Ano 2    Ano 3    Ano 4    Ano 5
```

### 8.6 Probabilidade dos Cenarios

| Cenario | Probabilidade | Justificativa |
|---------|---------------|---------------|
| Conservador | 25% | Concorrencia intensa, execucao abaixo |
| Base | 55% | Execucao conforme planejado |
| Otimista | 20% | Viralidade alta, produto excepcional |

**Valor Esperado ARR Ano 5:**
```
E(ARR) = 25% x R$64.8M + 55% x R$134.4M + 20% x R$252.0M
E(ARR) = R$16.2M + R$73.9M + R$50.4M
E(ARR) = R$140.5M
```

---

## 9. Tabelas de Projecao Ano a Ano

### 9.1 DRE Projetada (Cenario Base)

| Linha | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| **Receita Bruta** | 3.39M | 13.66M | 36.99M | 77.62M | 134.50M |
| (-) Deducoes | (0.31M) | (1.26M) | (3.42M) | (7.18M) | (12.44M) |
| **Receita Liquida** | 3.08M | 12.40M | 33.57M | 70.44M | 122.06M |
| | | | | | |
| (-) Custo Infraestrutura | (1.07M) | (3.03M) | (6.77M) | (12.44M) | (19.81M) |
| **Lucro Bruto** | 2.01M | 9.37M | 26.80M | 58.00M | 102.25M |
| **Margem Bruta** | 65% | 76% | 80% | 82% | 84% |
| | | | | | |
| (-) Marketing | (2.80M) | (5.50M) | (9.80M) | (13.00M) | (16.10M) |
| (-) Pessoal | (6.67M) | (15.57M) | (28.97M) | (44.63M) | (60.90M) |
| (-) Outros Opex | (0.94M) | (1.80M) | (2.90M) | (4.18M) | (5.40M) |
| **EBITDA** | (8.40M) | (13.50M) | (14.87M) | (3.81M) | 19.85M |
| **Margem EBITDA** | -273% | -109% | -44% | -5% | 16% |
| | | | | | |
| (-) D&A | (0.20M) | (0.50M) | (0.90M) | (1.40M) | (2.00M) |
| **EBIT** | (8.60M) | (14.00M) | (15.77M) | (5.21M) | 17.85M |
| | | | | | |
| (-) Despesas Financeiras | (0.10M) | (0.30M) | (0.50M) | (0.70M) | (0.90M) |
| (+) Receitas Financeiras | 0.30M | 0.80M | 1.50M | 2.50M | 3.50M |
| **Lucro Antes IR** | (8.40M) | (13.50M) | (14.77M) | (3.41M) | 20.45M |
| | | | | | |
| (-) IR/CSLL (34%) | 0 | 0 | 0 | 0 | (6.95M) |
| **Lucro Liquido** | (8.40M) | (13.50M) | (14.77M) | (3.41M) | 13.50M |
| **Margem Liquida** | -273% | -109% | -44% | -5% | 11% |

### 9.2 Balanco Projetado (Cenario Base)

| Linha | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| **ATIVO** | | | | | |
| Caixa e Equivalentes | 9.60M | 14.10M | 17.33M | 31.92M | 62.42M |
| Contas a Receber | 0.28M | 1.14M | 3.08M | 6.47M | 11.21M |
| Outros Ativos Circulantes | 0.50M | 1.00M | 1.50M | 2.00M | 2.50M |
| **Ativo Circulante** | 10.38M | 16.24M | 21.91M | 40.39M | 76.13M |
| | | | | | |
| Imobilizado | 0.50M | 1.20M | 2.00M | 3.00M | 4.00M |
| Intangivel (Software) | 1.50M | 3.00M | 5.00M | 7.50M | 10.00M |
| (-) Depreciacao Acumulada | (0.20M) | (0.70M) | (1.60M) | (3.00M) | (5.00M) |
| **Ativo Nao Circulante** | 1.80M | 3.50M | 5.40M | 7.50M | 9.00M |
| | | | | | |
| **TOTAL ATIVO** | 12.18M | 19.74M | 27.31M | 47.89M | 85.13M |
| | | | | | |
| **PASSIVO** | | | | | |
| Fornecedores | 0.50M | 1.20M | 2.50M | 4.00M | 5.50M |
| Salarios a Pagar | 0.56M | 1.30M | 2.41M | 3.72M | 5.08M |
| Receita Diferida | 0.41M | 1.31M | 3.35M | 6.48M | 11.20M |
| Outros Passivos Circulantes | 0.30M | 0.60M | 0.90M | 1.20M | 1.50M |
| **Passivo Circulante** | 1.77M | 4.41M | 9.16M | 15.40M | 23.28M |
| | | | | | |
| Divida LP | 0 | 0 | 0 | 0 | 0 |
| **Passivo Nao Circulante** | 0 | 0 | 0 | 0 | 0 |
| | | | | | |
| **PATRIMONIO LIQUIDO** | | | | | |
| Capital Social | 18.00M | 36.00M | 54.00M | 54.00M | 54.00M |
| Prejuizos Acumulados | (7.59M) | (20.67M) | (35.85M) | (21.51M) | 7.85M |
| **Total PL** | 10.41M | 15.33M | 18.15M | 32.49M | 61.85M |
| | | | | | |
| **TOTAL PASSIVO + PL** | 12.18M | 19.74M | 27.31M | 47.89M | 85.13M |

### 9.3 Fluxo de Caixa Projetado (Cenario Base)

| Linha | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| **OPERACIONAL** | | | | | |
| Lucro Liquido | (8.40M) | (13.50M) | (14.77M) | (3.41M) | 13.50M |
| (+) Depreciacao | 0.20M | 0.50M | 0.90M | 1.40M | 2.00M |
| (+/-) Var Capital Giro | 1.00M | 2.00M | 3.00M | 4.00M | 5.00M |
| **FCO** | (7.20M) | (11.00M) | (10.87M) | 1.99M | 20.50M |
| | | | | | |
| **INVESTIMENTO** | | | | | |
| (-) Capex | (0.80M) | (1.90M) | (2.80M) | (3.90M) | (4.50M) |
| (-) Investimento Intangivel | (1.50M) | (1.50M) | (2.00M) | (2.50M) | (2.50M) |
| **FCI** | (2.30M) | (3.40M) | (4.80M) | (6.40M) | (7.00M) |
| | | | | | |
| **FINANCIAMENTO** | | | | | |
| (+) Aporte de Capital | 18.00M | 18.00M | 18.00M | 0 | 0 |
| (-) Pagamento Dividendos | 0 | 0 | 0 | 0 | 0 |
| **FCF** | 18.00M | 18.00M | 18.00M | 0 | 0 |
| | | | | | |
| **Variacao Caixa** | 8.50M | 3.60M | 2.33M | (4.41M) | 13.50M |
| **Caixa Inicial** | 1.10M | 9.60M | 13.20M | 15.53M | 11.12M |
| **Caixa Final** | 9.60M | 13.20M | 15.53M | 11.12M | 24.62M |

### 9.4 Metricas Operacionais Chave

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| **Usuarios** | | | | | |
| Familias Ativas (final) | 25.000 | 72.000 | 172.000 | 320.000 | 500.000 |
| Criancas Ativas | 35.000 | 108.000 | 275.200 | 544.000 | 900.000 |
| Churn Mensal | 8.0% | 6.0% | 4.5% | 3.5% | 3.0% |
| | | | | | |
| **Receita** | | | | | |
| MRR (final) | 412k | 1.31M | 3.35M | 6.48M | 11.2M |
| ARR | 4.9M | 15.7M | 40.2M | 77.8M | 134.4M |
| ARPU | R$ 16.50 | R$ 18.20 | R$ 19.50 | R$ 21.00 | R$ 22.40 |
| | | | | | |
| **Unit Economics** | | | | | |
| CAC | R$ 88 | R$ 87 | R$ 63 | R$ 59 | R$ 60 |
| LTV | R$ 142 | R$ 254 | R$ 388 | R$ 555 | R$ 704 |
| LTV:CAC | 1.61x | 2.92x | 6.16x | 9.41x | 11.73x |
| Payback (meses) | 7.7 | 5.7 | 3.6 | 3.0 | 2.8 |
| | | | | | |
| **Eficiencia** | | | | | |
| Receita/Funcionario | 117k | 217k | 339k | 491k | 663k |
| Usuarios/Funcionario | 862 | 1.143 | 1.578 | 2.025 | 2.463 |
| Magic Number | 0.35 | 0.58 | 0.86 | 1.12 | 1.32 |

---

## 10. Analise de Sensibilidade

### 10.1 Sensibilidade ao Churn

Impacto no LTV (Ano 3) com diferentes niveis de churn:

| Churn Mensal | Lifetime (meses) | LTV | Variacao vs Base |
|--------------|------------------|-----|------------------|
| 3.0% | 33.3 | R$ 581 | +50% |
| 3.5% | 28.6 | R$ 499 | +29% |
| 4.0% | 25.0 | R$ 437 | +13% |
| **4.5% (Base)** | 22.2 | **R$ 388** | - |
| 5.0% | 20.0 | R$ 349 | -10% |
| 6.0% | 16.7 | R$ 292 | -25% |
| 7.0% | 14.3 | R$ 250 | -36% |

### 10.2 Sensibilidade ao ARPU

Impacto no ARR Ano 5 com diferentes ARPUs:

| ARPU Mensal | ARR Ano 5 | Variacao vs Base |
|-------------|-----------|------------------|
| R$ 25.00 | R$ 150.0M | +12% |
| R$ 23.50 | R$ 141.0M | +5% |
| **R$ 22.40 (Base)** | **R$ 134.4M** | - |
| R$ 21.00 | R$ 126.0M | -6% |
| R$ 19.50 | R$ 117.0M | -13% |
| R$ 18.00 | R$ 108.0M | -20% |

### 10.3 Sensibilidade ao Crescimento de Usuarios

Impacto no ARR Ano 5 com diferentes taxas de crescimento:

| Crescimento vs Base | Usuarios Ano 5 | ARR Ano 5 | Variacao |
|---------------------|----------------|-----------|----------|
| +40% | 700.000 | R$ 188.2M | +40% |
| +20% | 600.000 | R$ 161.3M | +20% |
| **Base** | **500.000** | **R$ 134.4M** | - |
| -20% | 400.000 | R$ 107.5M | -20% |
| -40% | 300.000 | R$ 80.6M | -40% |

### 10.4 Matriz de Sensibilidade (ARPU x Churn)

**LTV resultante (R$):**

|  | Churn 3% | Churn 4% | Churn 4.5% | Churn 5% | Churn 6% |
|--|----------|----------|------------|----------|----------|
| ARPU R$25 | 750 | 563 | 500 | 450 | 375 |
| ARPU R$23 | 690 | 518 | 460 | 414 | 345 |
| **ARPU R$22** | **660** | **495** | **440** | **396** | **330** |
| ARPU R$20 | 600 | 450 | 400 | 360 | 300 |
| ARPU R$18 | 540 | 405 | 360 | 324 | 270 |

### 10.5 Tornado Chart - Impacto no EBITDA Ano 5

```
Sensibilidade EBITDA Ano 5 (+/- 20% em cada variavel)

Churn           |████████████████████████████████████| +/- R$ 12.5M
ARPU            |██████████████████████████████      | +/- R$ 10.8M
Usuarios        |████████████████████████████        | +/- R$ 9.6M
Custo Pessoal   |██████████████████████              | +/- R$ 7.2M
CAC             |████████████████                    | +/- R$ 5.4M
Infra/BaaS      |██████████████                      | +/- R$ 4.8M
                +------------------------------------+
                 -15M   -10M   -5M    0    +5M  +10M  +15M
```

---

## 11. Metricas de Investimento

### 11.1 Necessidade de Capital

| Rodada | Timing | Valor | Uso dos Recursos |
|--------|--------|-------|------------------|
| **Seed** | M0 | R$ 3.5M | MVP, time core, lancamento beta |
| **Serie A** | M12-15 | R$ 18M | Escala, time completo, marketing |
| **Serie B** | M30-36 | R$ 50M | Expansao nacional, novas features |
| **Total** | - | R$ 71.5M | - |

### 11.2 Uso dos Recursos (Serie A)

| Categoria | Valor | % |
|-----------|-------|---|
| Time (18 meses) | R$ 10.8M | 60% |
| Marketing/Aquisicao | R$ 4.5M | 25% |
| Infraestrutura | R$ 1.8M | 10% |
| Legal/Compliance | R$ 0.9M | 5% |
| **Total** | R$ 18.0M | 100% |

### 11.3 Valuation Implicito

| Rodada | ARR Momento | Multiplo | Valuation Pre-money |
|--------|-------------|----------|---------------------|
| Seed | R$ 0 | - | R$ 12M |
| Serie A | R$ 5M | 8x | R$ 40M |
| Serie B | R$ 40M | 6x | R$ 240M |
| Exit (Ano 5) | R$ 134M | 5x | R$ 670M |

### 11.4 Retorno para Investidores

**Cenario Base - Exit Ano 5 a 5x ARR:**

| Investidor | Entrada | Valor Investido | Diluicao | % Final | Valor Exit | Multiplo |
|------------|---------|-----------------|----------|---------|------------|----------|
| Fundadores | M0 | R$ 0 | - | 45% | R$ 302M | - |
| Seed | M0 | R$ 3.5M | 22% | 15% | R$ 101M | 28.9x |
| Serie A | M15 | R$ 18M | 31% | 22% | R$ 147M | 8.2x |
| Serie B | M33 | R$ 50M | 17% | 12% | R$ 80M | 1.6x |
| ESOP | - | - | - | 6% | R$ 40M | - |
| **Total** | - | R$ 71.5M | - | 100% | R$ 670M | - |

### 11.5 IRR Projetada

| Cenario | Valuation Exit | IRR Seed | IRR Serie A |
|---------|----------------|----------|-------------|
| Conservador | R$ 324M (5x ARR) | 72% | 45% |
| Base | R$ 672M (5x ARR) | 98% | 68% |
| Otimista | R$ 1.26B (5x ARR) | 124% | 92% |

---

## 12. Riscos e Mitigacoes

### 12.1 Matriz de Riscos

| Risco | Probabilidade | Impacto | Score | Mitigacao |
|-------|---------------|---------|-------|-----------|
| Regulatorio (Bacen) | Media | Alto | 12 | Compliance desde MVP, parceria BaaS licenciado |
| Concorrencia bancos | Alta | Medio | 12 | Diferenciacao (4 baldes), foco em educacao |
| Churn elevado | Media | Alto | 12 | Engajamento, gamificacao, valor percebido |
| Falha execucao time | Media | Alto | 12 | Contratacoes senior, advisors |
| Custo BaaS acima | Media | Medio | 9 | Negociar volume, multi-provider |
| Fraude/Seguranca | Baixa | Critico | 9 | SOC 2, pentest, antifraude ML |
| Captacao nao atingida | Media | Alto | 12 | Metricas solidas, multiplos VCs |
| Economia brasileira | Media | Medio | 9 | Foco classes A/B, pricing flexivel |

### 12.2 Cenario de Stress

**Premissas de Stress:**
- Crescimento 50% menor que base
- Churn 50% maior que base
- CAC 30% maior que base
- Delay de 6 meses no break-even

| Metrica | Base | Stress | Diferenca |
|---------|------|--------|-----------|
| Usuarios Ano 5 | 500k | 250k | -50% |
| ARR Ano 5 | R$ 134M | R$ 54M | -60% |
| Break-even | Mes 28 | Mes 42+ | +14 meses |
| Necessidade Capital | R$ 71.5M | R$ 95M | +33% |

### 12.3 Plano de Contingencia

| Trigger | Acao | Responsavel |
|---------|------|-------------|
| CAC > R$ 120 por 3 meses | Pausar performance, focar organico | CMO |
| Churn > 8% por 3 meses | Task force retencao | CPO |
| Runway < 9 meses | Cortar custos 20%, bridge round | CEO/CFO |
| Usuarios < 80% meta | Pivotar pricing, freemium | CEO |

---

## Anexo A: Glossario de Metricas

| Metrica | Definicao | Formula |
|---------|-----------|---------|
| **ARR** | Annual Recurring Revenue | MRR x 12 |
| **MRR** | Monthly Recurring Revenue | Soma assinaturas ativas |
| **ARPU** | Average Revenue Per User | Receita Total / Usuarios |
| **CAC** | Customer Acquisition Cost | Marketing / Novos Clientes |
| **LTV** | Lifetime Value | ARPU x Margem x Lifetime |
| **Churn** | Taxa de cancelamento | Cancelados / Base Inicial |
| **NRR** | Net Revenue Retention | (MRR final - Churn + Expansao) / MRR inicial |
| **Payback** | Meses para recuperar CAC | CAC / (ARPU x Margem) |
| **Magic Number** | Eficiencia de vendas | Nova ARR / Marketing (trimestre anterior) |
| **Burn Rate** | Queima mensal de caixa | Custos - Receitas |
| **Runway** | Meses de caixa restantes | Caixa / Burn Rate |

---

## Anexo B: Fontes e Referencias

1. **Greenlight Financial Reports** - Benchmark de metricas
2. **IBGE 2024** - Dados demograficos familias brasileiras
3. **Pesquisa TIC Domicilios 2024** - Penetracao digital
4. **CB Insights Fintech Report 2025** - Multiplos de mercado
5. **SimilarWeb/Sensor Tower** - Downloads concorrentes Brasil
6. **Entrevistas com operadores BaaS** - Custos infraestrutura

---

*Documento elaborado para fins de planejamento estrategico e captacao de investimentos.*
*As projecoes sao estimativas baseadas em premissas que podem nao se concretizar.*
*Versao: 1.0 | Janeiro 2026*
