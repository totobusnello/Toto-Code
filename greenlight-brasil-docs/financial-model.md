# Modelo Financeiro - Fintech Educacao Financeira Familiar Brasil

> **Documento**: Modelo Financeiro Completo | Versao 2.0 | Janeiro 2026
>
> **Projeto**: Mesada Digital + Cartao Debito para Menores (6-17 anos)
> **Horizonte**: 5 Anos (2026-2030)
> **Meta SOM Ano 3**: 500.000 familias ativas

---

## Resumo Executivo

### Highlights Financeiros (Cenario Base)

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 50.000 | 200.000 | 500.000 | 850.000 | 1.200.000 |
| ARR | R$ 10,8M | R$ 47,5M | R$ 130,2M | R$ 240,5M | R$ 362,9M |
| Receita Total | R$ 12,4M | R$ 53,8M | R$ 145,6M | R$ 266,8M | R$ 398,9M |
| EBITDA | -R$ 15,8M | -R$ 12,4M | R$ 8,2M | R$ 58,7M | R$ 119,3M |
| Margem EBITDA | -127% | -23% | 6% | 22% | 30% |

### Necessidade de Capital Total

| Rodada | Timing | Valor | Valuation Pre-Money |
|--------|--------|-------|---------------------|
| Seed | M0 | R$ 8M | R$ 25M |
| Serie A | M12 | R$ 35M | R$ 100M |
| Serie B | M24 | R$ 80M | R$ 400M |
| **Total** | - | **R$ 123M** | - |

---

## 1. Premissas Fundamentais

### 1.1 Estrutura de Pricing

| Plano | Preco Mensal | Features | Mix Esperado |
|-------|--------------|----------|--------------|
| **Basico** | R$ 9,90 | Cartao virtual, 4 Baldes, PIX | 40% |
| **Plus** | R$ 19,90 | + Cartao fisico, Tarefas, Metas | 45% |
| **Premium** | R$ 34,90 | + Investimentos, Cashback, Multi-filhos | 15% |

**ARPU Medio Ponderado:**
```
ARPU = (0,40 x R$ 9,90) + (0,45 x R$ 19,90) + (0,15 x R$ 34,90)
ARPU = R$ 3,96 + R$ 8,96 + R$ 5,24
ARPU = R$ 18,16/mes
```

### 1.2 Evolucao do ARPU por Ano

| Ano | ARPU Mensal | Justificativa |
|-----|-------------|---------------|
| Ano 1 | R$ 16,50 | Maior peso no Basico (aquisicao) |
| Ano 2 | R$ 18,00 | Migracao para Plus |
| Ano 3 | R$ 19,50 | Mix estabilizado |
| Ano 4 | R$ 21,50 | Upsell + reajuste 5% |
| Ano 5 | R$ 23,00 | Premium cresce, reajuste inflacao |

### 1.3 Premissas de Retencao

| Ano | Churn Mensal | Churn Anual | Lifetime (meses) |
|-----|--------------|-------------|------------------|
| Ano 1 | 6,0% | 52% | 16,7 |
| Ano 2 | 4,5% | 42% | 22,2 |
| Ano 3 | 3,5% | 35% | 28,6 |
| Ano 4 | 3,0% | 31% | 33,3 |
| Ano 5 | 2,5% | 26% | 40,0 |

### 1.4 Premissas de Interchange

| Metrica | Valor |
|---------|-------|
| Volume transacao mensal/familia | R$ 450 |
| Taxa interchange bruta | 1,50% |
| Revenue share (fintech recebe) | 65% |
| **Receita interchange/familia/mes** | **R$ 4,39** |

---

## 2. Projecao de Usuarios (5 Anos)

### 2.1 Evolucao da Base

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| **Familias Inicio Ano** | 0 | 50.000 | 200.000 | 500.000 | 850.000 |
| **Novas Aquisicoes** | 70.000 | 220.000 | 450.000 | 550.000 | 580.000 |
| **Churn (familias)** | -20.000 | -70.000 | -150.000 | -200.000 | -230.000 |
| **Familias Fim Ano** | 50.000 | 200.000 | 500.000 | 850.000 | 1.200.000 |
| **Crescimento YoY** | - | 300% | 150% | 70% | 41% |

### 2.2 Metricas de Usuarios

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas (media) | 25.000 | 125.000 | 350.000 | 675.000 | 1.025.000 |
| Filhos por familia | 1,5 | 1,6 | 1,7 | 1,8 | 1,9 |
| Total criancas ativas | 37.500 | 200.000 | 595.000 | 1.215.000 | 1.947.500 |
| Cartoes emitidos (acum.) | 35.000 | 180.000 | 520.000 | 950.000 | 1.450.000 |
| MAU / Total | 85% | 82% | 80% | 78% | 76% |

---

## 3. P&L - Demonstracao de Resultados (5 Anos)

### 3.1 Receitas

| Linha | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| **Assinaturas** | | | | | |
| Familias ativas (media) | 25.000 | 125.000 | 350.000 | 675.000 | 1.025.000 |
| ARPU mensal | R$ 16,50 | R$ 18,00 | R$ 19,50 | R$ 21,50 | R$ 23,00 |
| **Receita Assinaturas** | R$ 4,95M | R$ 27,0M | R$ 81,9M | R$ 174,2M | R$ 282,9M |
| | | | | | |
| **Interchange** | | | | | |
| Volume transacionado | R$ 135M | R$ 675M | R$ 1.890M | R$ 3.645M | R$ 5.535M |
| Taxa liquida (0,975%) | R$ 1,32M | R$ 6,58M | R$ 18,43M | R$ 35,54M | R$ 53,97M |
| | | | | | |
| **Outras Receitas** | | | | | |
| Cartao fisico (R$ 25) | R$ 0,88M | R$ 1,80M | R$ 2,50M | R$ 3,00M | R$ 3,50M |
| Cartao personalizado | R$ 0,15M | R$ 0,60M | R$ 1,50M | R$ 2,50M | R$ 3,50M |
| Parcerias/Cashback | R$ 0,10M | R$ 0,50M | R$ 1,50M | R$ 3,00M | R$ 5,00M |
| B2B White-label | R$ 0 | R$ 0,30M | R$ 1,50M | R$ 4,00M | R$ 8,00M |
| **Outras Receitas** | R$ 1,13M | R$ 3,20M | R$ 7,00M | R$ 12,50M | R$ 20,00M |
| | | | | | |
| **RECEITA BRUTA** | **R$ 7,40M** | **R$ 36,78M** | **R$ 107,33M** | **R$ 222,24M** | **R$ 356,87M** |
| (-) Impostos (8,65%) | R$ 0,64M | R$ 3,18M | R$ 9,28M | R$ 19,22M | R$ 30,87M |
| **RECEITA LIQUIDA** | **R$ 6,76M** | **R$ 33,60M** | **R$ 98,05M** | **R$ 203,02M** | **R$ 326,00M** |

### 3.2 ARR - Receita Recorrente Anual

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| MRR Assinaturas (fim ano) | R$ 825K | R$ 3,60M | R$ 9,75M | R$ 18,28M | R$ 27,60M |
| MRR Interchange (fim ano) | R$ 75K | R$ 0,36M | R$ 1,10M | R$ 2,05M | R$ 2,64M |
| **MRR Total** | R$ 0,90M | R$ 3,96M | R$ 10,85M | R$ 20,33M | R$ 30,24M |
| **ARR (MRR x 12)** | **R$ 10,8M** | **R$ 47,5M** | **R$ 130,2M** | **R$ 240,5M** | **R$ 362,9M** |

### 3.3 Custos e Despesas

| Categoria | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----------|-------|-------|-------|-------|-------|
| | | | | | |
| **COGS - Infraestrutura** | | | | | |
| BaaS (Dock/Pismo) | R$ 1,80M | R$ 5,40M | R$ 12,00M | R$ 21,00M | R$ 30,00M |
| Cloud (AWS/GCP) | R$ 0,48M | R$ 1,20M | R$ 2,40M | R$ 4,00M | R$ 5,50M |
| Cartoes (producao) | R$ 0,35M | R$ 1,45M | R$ 3,40M | R$ 4,30M | R$ 5,00M |
| Seguranca/Compliance | R$ 0,30M | R$ 0,60M | R$ 1,00M | R$ 1,50M | R$ 2,00M |
| **Total COGS** | **R$ 2,93M** | **R$ 8,65M** | **R$ 18,80M** | **R$ 30,80M** | **R$ 42,50M** |
| | | | | | |
| **LUCRO BRUTO** | **R$ 3,83M** | **R$ 24,95M** | **R$ 79,25M** | **R$ 172,22M** | **R$ 283,50M** |
| **Margem Bruta** | **57%** | **74%** | **81%** | **85%** | **87%** |
| | | | | | |
| **OPEX** | | | | | |
| | | | | | |
| **Pessoal** | | | | | |
| Headcount | 45 | 95 | 180 | 280 | 380 |
| Salarios + Encargos | R$ 7,20M | R$ 16,15M | R$ 32,40M | R$ 53,20M | R$ 76,00M |
| Beneficios | R$ 0,81M | R$ 1,71M | R$ 3,24M | R$ 5,04M | R$ 6,84M |
| Stock Options | R$ 0,30M | R$ 0,80M | R$ 1,80M | R$ 3,00M | R$ 4,50M |
| **Total Pessoal** | **R$ 8,31M** | **R$ 18,66M** | **R$ 37,44M** | **R$ 61,24M** | **R$ 87,34M** |
| | | | | | |
| **Marketing (CAC)** | | | | | |
| Performance (Meta/Google) | R$ 4,00M | R$ 8,80M | R$ 15,75M | R$ 16,50M | R$ 15,66M |
| Influenciadores | R$ 1,50M | R$ 3,30M | R$ 5,63M | R$ 5,50M | R$ 5,22M |
| Conteudo/SEO | R$ 0,35M | R$ 0,77M | R$ 1,35M | R$ 1,65M | R$ 1,74M |
| Parcerias Escolas | R$ 0,50M | R$ 1,10M | R$ 2,25M | R$ 3,30M | R$ 4,06M |
| Referral Program | R$ 0,70M | R$ 2,20M | R$ 4,50M | R$ 5,50M | R$ 5,80M |
| Branding/PR | R$ 0,45M | R$ 0,88M | R$ 1,58M | R$ 1,65M | R$ 1,74M |
| **Total Marketing** | **R$ 7,50M** | **R$ 17,05M** | **R$ 31,05M** | **R$ 34,10M** | **R$ 34,22M** |
| | | | | | |
| **Outros OPEX** | | | | | |
| Escritorio/Facilities | R$ 0,72M | R$ 1,52M | R$ 2,88M | R$ 4,48M | R$ 6,08M |
| Juridico/Contabil | R$ 0,45M | R$ 0,85M | R$ 1,50M | R$ 2,20M | R$ 3,00M |
| Viagens/Eventos | R$ 0,25M | R$ 0,55M | R$ 1,00M | R$ 1,50M | R$ 2,00M |
| Seguros | R$ 0,10M | R$ 0,25M | R$ 0,50M | R$ 0,80M | R$ 1,10M |
| Outros | R$ 0,30M | R$ 0,65M | R$ 1,20M | R$ 1,80M | R$ 2,40M |
| **Total Outros OPEX** | **R$ 1,82M** | **R$ 3,82M** | **R$ 7,08M** | **R$ 10,78M** | **R$ 14,58M** |
| | | | | | |
| **TOTAL OPEX** | **R$ 17,63M** | **R$ 39,53M** | **R$ 75,57M** | **R$ 106,12M** | **R$ 136,14M** |

### 3.4 EBITDA e Resultado

| Linha | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| Receita Liquida | R$ 6,76M | R$ 33,60M | R$ 98,05M | R$ 203,02M | R$ 326,00M |
| (-) COGS | R$ 2,93M | R$ 8,65M | R$ 18,80M | R$ 30,80M | R$ 42,50M |
| **Lucro Bruto** | R$ 3,83M | R$ 24,95M | R$ 79,25M | R$ 172,22M | R$ 283,50M |
| (-) OPEX Total | R$ 17,63M | R$ 39,53M | R$ 75,57M | R$ 106,12M | R$ 136,14M |
| **EBITDA** | **-R$ 13,80M** | **-R$ 14,58M** | **R$ 3,68M** | **R$ 66,10M** | **R$ 147,36M** |
| **Margem EBITDA** | **-204%** | **-43%** | **4%** | **33%** | **45%** |
| | | | | | |
| (-) D&A | R$ 0,50M | R$ 1,20M | R$ 2,50M | R$ 4,00M | R$ 5,50M |
| **EBIT** | -R$ 14,30M | -R$ 15,78M | R$ 1,18M | R$ 62,10M | R$ 141,86M |
| | | | | | |
| (+/-) Resultado Financeiro | R$ 0,80M | R$ 1,50M | R$ 2,00M | R$ 3,50M | R$ 5,00M |
| **EBT** | -R$ 13,50M | -R$ 14,28M | R$ 3,18M | R$ 65,60M | R$ 146,86M |
| | | | | | |
| (-) IR/CSLL (34%) | R$ 0 | R$ 0 | R$ 0 | R$ 9,86M | R$ 49,93M |
| **LUCRO LIQUIDO** | **-R$ 13,50M** | **-R$ 14,28M** | **R$ 3,18M** | **R$ 55,74M** | **R$ 96,93M** |
| **Margem Liquida** | -200% | -43% | 3% | 27% | 30% |

---

## 4. Unit Economics

### 4.1 CAC - Custo de Aquisicao de Cliente

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Investimento Marketing | R$ 7,50M | R$ 17,05M | R$ 31,05M | R$ 34,10M | R$ 34,22M |
| Novas Familias | 70.000 | 220.000 | 450.000 | 550.000 | 580.000 |
| **CAC** | **R$ 107** | **R$ 78** | **R$ 69** | **R$ 62** | **R$ 59** |
| Benchmark Mercado | R$ 120 | R$ 120 | R$ 120 | R$ 120 | R$ 120 |

**Evolucao do CAC:**
- Ano 1: CAC alto devido a fase de construcao de marca
- Anos 2-3: Reducao por otimizacao de campanhas e crescimento organico
- Anos 4-5: Estabilizacao com escala e referral maduro

### 4.2 LTV - Lifetime Value

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| ARPU Mensal (total) | R$ 20,89 | R$ 22,39 | R$ 23,89 | R$ 25,89 | R$ 27,39 |
| (-) Custo Variavel/usuario | R$ 9,77 | R$ 5,77 | R$ 4,48 | R$ 3,80 | R$ 3,46 |
| **Margem Bruta/usuario** | R$ 11,12 | R$ 16,62 | R$ 19,41 | R$ 22,09 | R$ 23,93 |
| Churn Mensal | 6,0% | 4,5% | 3,5% | 3,0% | 2,5% |
| Lifetime (meses) | 16,7 | 22,2 | 28,6 | 33,3 | 40,0 |
| **LTV** | **R$ 186** | **R$ 369** | **R$ 555** | **R$ 736** | **R$ 957** |

### 4.3 LTV/CAC Ratio

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 | Benchmark |
|---------|-------|-------|-------|-------|-------|-----------|
| LTV | R$ 186 | R$ 369 | R$ 555 | R$ 736 | R$ 957 | - |
| CAC | R$ 107 | R$ 78 | R$ 69 | R$ 62 | R$ 59 | < R$ 100 |
| **LTV/CAC** | **1,7x** | **4,7x** | **8,0x** | **11,9x** | **16,2x** | > 3x |

**Interpretacao:**
- Ano 1 (1,7x): Abaixo do ideal, normal para lancamento
- Ano 2 (4,7x): Acima do benchmark, modelo se provando
- Anos 3-5 (8x+): Excelente eficiencia, negocio altamente escalavel

### 4.4 Payback Period

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| CAC | R$ 107 | R$ 78 | R$ 69 | R$ 62 | R$ 59 |
| Margem Bruta/mes | R$ 11,12 | R$ 16,62 | R$ 19,41 | R$ 22,09 | R$ 23,93 |
| **Payback (meses)** | **9,6** | **4,7** | **3,6** | **2,8** | **2,5** |
| Benchmark | < 12 | < 12 | < 12 | < 12 | < 12 |

### 4.5 Resumo Unit Economics

```
+-----------------------------------------------------------------------+
|                    UNIT ECONOMICS - ANO 5                              |
+-----------------------------------------------------------------------+
|                                                                       |
|   ARPU Mensal Total        R$ 27,39                                   |
|   (-) Custo Variavel       R$  3,46                                   |
|   (=) Margem Bruta         R$ 23,93  (87%)                            |
|                                                                       |
|   Churn Mensal             2,5%                                       |
|   Lifetime                 40,0 meses                                 |
|   LTV                      R$ 957                                     |
|                                                                       |
|   CAC                      R$ 59                                      |
|   LTV:CAC                  16,2x                                      |
|   Payback                  2,5 meses                                  |
|                                                                       |
+-----------------------------------------------------------------------+
```

---

## 5. Custos Operacionais Detalhados

### 5.1 Tecnologia e Infraestrutura

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| **BaaS (Banking as a Service)** | | | | | |
| Fee fixo mensal | R$ 360K | R$ 600K | R$ 900K | R$ 1,20M | R$ 1,50M |
| Fee por conta (R$ 1,50) | R$ 90K | R$ 450K | R$ 1,26M | R$ 2,43M | R$ 3,69M |
| Fee por cartao (R$ 12) | R$ 420K | R$ 2,16M | R$ 6,24M | R$ 11,40M | R$ 17,40M |
| Fee transacao (R$ 0,12) | R$ 930K | R$ 2,19M | R$ 3,60M | R$ 5,97M | R$ 7,41M |
| **Subtotal BaaS** | R$ 1,80M | R$ 5,40M | R$ 12,00M | R$ 21,00M | R$ 30,00M |
| % Receita | 24% | 15% | 11% | 9% | 8% |
| | | | | | |
| **Cloud Computing** | | | | | |
| AWS/GCP | R$ 360K | R$ 900K | R$ 1,80M | R$ 3,00M | R$ 4,20M |
| CDN/Storage | R$ 60K | R$ 150K | R$ 300K | R$ 500K | R$ 650K |
| Monitoring/Observability | R$ 60K | R$ 150K | R$ 300K | R$ 500K | R$ 650K |
| **Subtotal Cloud** | R$ 480K | R$ 1,20M | R$ 2,40M | R$ 4,00M | R$ 5,50M |
| | | | | | |
| **Seguranca e Compliance** | | | | | |
| SOC 2/PCI-DSS | R$ 150K | R$ 300K | R$ 500K | R$ 750K | R$ 1,00M |
| Pentest/Bug Bounty | R$ 100K | R$ 200K | R$ 350K | R$ 500K | R$ 650K |
| Antifraude ML | R$ 50K | R$ 100K | R$ 150K | R$ 250K | R$ 350K |
| **Subtotal Seguranca** | R$ 300K | R$ 600K | R$ 1,00M | R$ 1,50M | R$ 2,00M |

### 5.2 Pessoal por Area

| Area | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------|-------|-------|-------|-------|-------|
| **Headcount** | | | | | |
| Engenharia | 15 | 32 | 60 | 90 | 120 |
| Produto | 4 | 8 | 15 | 22 | 30 |
| Design | 3 | 6 | 10 | 15 | 20 |
| Data/Analytics | 2 | 6 | 12 | 20 | 28 |
| Marketing | 5 | 10 | 18 | 25 | 32 |
| CX/Suporte | 8 | 18 | 40 | 70 | 100 |
| Financeiro | 3 | 5 | 8 | 12 | 16 |
| Juridico/Compliance | 2 | 4 | 7 | 10 | 14 |
| Operacoes | 2 | 4 | 7 | 12 | 16 |
| Lideranca | 5 | 6 | 7 | 8 | 8 |
| **Total Headcount** | **45** | **95** | **180** | **280** | **380** |
| | | | | | |
| **Custo Medio/Pessoa** | | | | | |
| Salario medio mensal | R$ 10.000 | R$ 11.000 | R$ 12.000 | R$ 13.000 | R$ 14.000 |
| + Encargos (68%) | R$ 6.800 | R$ 7.480 | R$ 8.160 | R$ 8.840 | R$ 9.520 |
| **Custo total/pessoa/mes** | R$ 16.800 | R$ 18.480 | R$ 20.160 | R$ 21.840 | R$ 23.520 |

### 5.3 Marketing por Canal

| Canal | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| Performance Digital | 53% | 52% | 51% | 48% | 46% |
| Influenciadores | 20% | 19% | 18% | 16% | 15% |
| Referral Program | 9% | 13% | 14% | 16% | 17% |
| Parcerias Escolas | 7% | 6% | 7% | 10% | 12% |
| Conteudo/SEO | 5% | 5% | 5% | 5% | 5% |
| Branding/PR | 6% | 5% | 5% | 5% | 5% |
| **Total** | 100% | 100% | 100% | 100% | 100% |

**Evolucao da Estrategia:**
- Anos 1-2: Foco em performance para aquisicao rapida
- Anos 3-4: Crescimento de referral e parcerias
- Ano 5: Mix equilibrado com forte presenca organica

---

## 6. Runway e Necessidade de Funding

### 6.1 Fluxo de Caixa Projetado

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| **Operacional** | | | | | |
| EBITDA | -R$ 13,80M | -R$ 14,58M | R$ 3,68M | R$ 66,10M | R$ 147,36M |
| (+/-) Var. Cap. Giro | R$ 1,20M | R$ 3,50M | R$ 6,00M | R$ 8,00M | R$ 10,00M |
| **FCO** | -R$ 12,60M | -R$ 11,08M | R$ 9,68M | R$ 74,10M | R$ 157,36M |
| | | | | | |
| **Investimentos** | | | | | |
| CAPEX | -R$ 1,50M | -R$ 3,00M | -R$ 5,00M | -R$ 7,00M | -R$ 9,00M |
| Software/Intangivel | -R$ 2,00M | -R$ 4,00M | -R$ 6,00M | -R$ 8,00M | -R$ 10,00M |
| **FCI** | -R$ 3,50M | -R$ 7,00M | -R$ 11,00M | -R$ 15,00M | -R$ 19,00M |
| | | | | | |
| **Financiamentos** | | | | | |
| Aporte Equity | R$ 43,00M | R$ 80,00M | R$ 0 | R$ 0 | R$ 0 |
| | | | | | |
| **Variacao Caixa** | R$ 26,90M | R$ 61,92M | -R$ 1,32M | R$ 59,10M | R$ 138,36M |
| **Caixa Inicial** | R$ 0 | R$ 26,90M | R$ 88,82M | R$ 87,50M | R$ 146,60M |
| **Caixa Final** | R$ 26,90M | R$ 88,82M | R$ 87,50M | R$ 146,60M | R$ 284,96M |

### 6.2 Necessidade de Capital por Rodada

| Rodada | Timing | Valor | Diluicao | Valuation Pre | Uso Principal |
|--------|--------|-------|----------|---------------|---------------|
| **Seed** | M0 | R$ 8M | 24% | R$ 25M | MVP, time core, beta |
| **Serie A** | M12 | R$ 35M | 26% | R$ 100M | Escala, time 95 pessoas |
| **Serie B** | M24 | R$ 80M | 17% | R$ 400M | Expansao nacional, 180+ pessoas |
| **Total** | - | R$ 123M | - | - | - |

### 6.3 Uso dos Recursos - Serie A (R$ 35M)

| Categoria | Valor | % |
|-----------|-------|---|
| Time (18 meses runway) | R$ 18,0M | 51% |
| Marketing/Aquisicao | R$ 10,0M | 29% |
| Infraestrutura/Tech | R$ 4,5M | 13% |
| Legal/Compliance | R$ 1,5M | 4% |
| Buffer | R$ 1,0M | 3% |
| **Total** | **R$ 35,0M** | 100% |

### 6.4 Runway por Fase

| Fase | Burn Mensal | Caixa | Runway |
|------|-------------|-------|--------|
| Pos-Seed | R$ 1,1M | R$ 8M | 7 meses |
| Pos-Serie A | R$ 2,2M | R$ 35M | 16 meses |
| Pos-Serie B | R$ 3,5M | R$ 80M | 23 meses |
| Breakeven+ | Cash positive | - | Indefinido |

---

## 7. Break-even Analysis

### 7.1 Break-even Operacional

| Metrica | Calculo |
|---------|---------|
| Custos Fixos Mensais (Ano 2) | R$ 3,0M |
| Margem Contribuicao/Familia | R$ 16,62 |
| **Break-even Familias** | **180.500 familias** |
| **Timing Break-even** | **Mes 26-28 (meio do Ano 3)** |

### 7.2 Evolucao para Break-even

| Mes | Familias | Receita Mensal | Custos Mensais | Resultado | Acumulado |
|-----|----------|----------------|----------------|-----------|-----------|
| 6 | 25.000 | R$ 0,52M | R$ 1,42M | -R$ 0,90M | -R$ 5,4M |
| 12 | 50.000 | R$ 1,05M | R$ 1,75M | -R$ 0,70M | -R$ 13,8M |
| 18 | 120.000 | R$ 2,69M | R$ 3,00M | -R$ 0,31M | -R$ 22,0M |
| 24 | 200.000 | R$ 4,48M | R$ 4,10M | R$ 0,38M | -R$ 28,4M |
| **28** | **250.000** | **R$ 5,98M** | **R$ 5,98M** | **R$ 0** | -R$ 28,4M |
| 36 | 500.000 | R$ 11,95M | R$ 8,50M | R$ 3,45M | -R$ 5,0M |
| 48 | 850.000 | R$ 22,00M | R$ 13,50M | R$ 8,50M | R$ 80,0M |
| 60 | 1.200.000 | R$ 32,87M | R$ 19,00M | R$ 13,87M | R$ 230,0M |

### 7.3 Grafico Break-even

```
Resultado Mensal (R$ milhoes)

 15  |                                                    ████
 12  |                                              ██████████
  9  |                                        ██████████████████
  6  |                                  ██████████████████████████
  3  |                            ██████████████████████████████████
  0  |----------------------████████████████████████████████████████  <- Break-even M28
 -1  |████████████████████████████████████████████████████████████
 -2  |██████████████████████████████████████████████████████████
     +------------------------------------------------------------
       M6   M12   M18   M24   M30   M36   M42   M48   M54   M60
```

### 7.4 Cash Position ao Longo do Tempo

```
Caixa (R$ milhoes)

 285 |                                                    ████
 240 |                                              ██████████
 195 |                                        ██████████████████
 150 |                            ████████████████████████████████
 105 |              ██████████████████████████████████████████████
  60 |    ████████████████████████████████████████████████████████
  15 |████████████████████████████████████████████████████████████
     +------------------------------------------------------------
       M6   M12   M18   M24   M30   M36   M42   M48   M54   M60
```

---

## 8. Cenarios (Conservador / Base / Otimista)

### 8.1 Definicao dos Cenarios

| Variavel | Conservador | Base | Otimista |
|----------|-------------|------|----------|
| Crescimento Usuarios | -35% | 0% | +40% |
| ARPU | -10% | 0% | +12% |
| Churn | +40% | 0% | -25% |
| CAC | +25% | 0% | -15% |
| Custos Pessoal | +10% | 0% | -5% |

### 8.2 Cenario Conservador

**Premissas:**
- Concorrencia mais acirrada (bancos entram agressivamente)
- Aquisicao mais lenta e cara
- Retencao abaixo do esperado

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 32.500 | 110.000 | 260.000 | 420.000 | 560.000 |
| ARR | R$ 6,3M | R$ 25,4M | R$ 65,0M | R$ 113,4M | R$ 158,8M |
| Receita Total | R$ 7,2M | R$ 28,8M | R$ 72,5M | R$ 125,0M | R$ 173,6M |
| EBITDA | -R$ 14,8M | -R$ 18,7M | -R$ 12,5M | R$ 8,2M | R$ 28,5M |
| Margem EBITDA | -206% | -65% | -17% | 7% | 16% |
| Break-even | Mes 42 | - | - | - | - |
| Funding Adicional | +R$ 25M | - | - | - | - |

### 8.3 Cenario Base

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 50.000 | 200.000 | 500.000 | 850.000 | 1.200.000 |
| ARR | R$ 10,8M | R$ 47,5M | R$ 130,2M | R$ 240,5M | R$ 362,9M |
| Receita Total | R$ 12,4M | R$ 53,8M | R$ 145,6M | R$ 266,8M | R$ 398,9M |
| EBITDA | -R$ 13,8M | -R$ 14,6M | R$ 3,7M | R$ 66,1M | R$ 147,4M |
| Margem EBITDA | -204% | -43% | 4% | 33% | 45% |
| Break-even | Mes 28 | - | - | - | - |

### 8.4 Cenario Otimista

**Premissas:**
- Produto viral (forte boca-a-boca)
- Parcerias estrategicas com grandes redes
- Execucao excepcional do time

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias Ativas | 70.000 | 300.000 | 780.000 | 1.400.000 | 2.100.000 |
| ARR | R$ 16,2M | R$ 76,0M | R$ 215,3M | R$ 420,0M | R$ 680,4M |
| Receita Total | R$ 18,5M | R$ 86,0M | R$ 240,5M | R$ 465,0M | R$ 745,0M |
| EBITDA | -R$ 10,5M | -R$ 4,0M | R$ 32,5M | R$ 135,0M | R$ 295,0M |
| Margem EBITDA | -57% | -5% | 14% | 29% | 40% |
| Break-even | Mes 20 | - | - | - | - |

### 8.5 Comparativo Visual - ARR

```
ARR (R$ milhoes) - Ano 5

Otimista     |████████████████████████████████████████████████████  R$ 680M
Base         |████████████████████████████████████                  R$ 363M
Conservador  |████████████████████                                  R$ 159M
             +------------------------------------------------------
               0    100    200    300    400    500    600    700
```

### 8.6 Comparativo Visual - EBITDA Ano 5

```
EBITDA (R$ milhoes) - Ano 5

Otimista     |████████████████████████████████████████████████████  R$ 295M
Base         |████████████████████████████████                      R$ 147M
Conservador  |██████████                                            R$ 28M
             +------------------------------------------------------
               0     50    100    150    200    250    300
```

### 8.7 Probabilidade Ponderada

| Cenario | Probabilidade | ARR Ano 5 | EBITDA Ano 5 |
|---------|---------------|-----------|--------------|
| Conservador | 25% | R$ 159M | R$ 28M |
| Base | 55% | R$ 363M | R$ 147M |
| Otimista | 20% | R$ 680M | R$ 295M |
| | | | |
| **Valor Esperado** | 100% | **R$ 375M** | **R$ 147M** |

---

## 9. Metricas de Eficiencia

### 9.1 Metricas SaaS Chave

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 | Benchmark |
|---------|-------|-------|-------|-------|-------|-----------|
| **Crescimento** | | | | | | |
| ARR Growth YoY | - | 340% | 174% | 85% | 51% | > 100% (early) |
| Net Revenue Retention | 88% | 95% | 102% | 105% | 108% | > 100% |
| | | | | | | |
| **Eficiencia** | | | | | | |
| Magic Number | 0,31 | 0,65 | 1,12 | 1,85 | 2,24 | > 0,75 |
| CAC Payback (meses) | 9,6 | 4,7 | 3,6 | 2,8 | 2,5 | < 12 |
| LTV/CAC | 1,7x | 4,7x | 8,0x | 11,9x | 16,2x | > 3x |
| | | | | | | |
| **Escala** | | | | | | |
| Receita/Funcionario | R$ 164K | R$ 354K | R$ 545K | R$ 725K | R$ 858K | > R$ 300K |
| Usuarios/Funcionario | 1.111 | 2.105 | 2.778 | 3.036 | 3.158 | - |
| | | | | | | |
| **Rentabilidade** | | | | | | |
| Margem Bruta | 57% | 74% | 81% | 85% | 87% | > 70% |
| Margem EBITDA | -204% | -43% | 4% | 33% | 45% | > 20% (mature) |
| Rule of 40 | -163% | 297% | 178% | 118% | 96% | > 40% |

### 9.2 Comparativo com Greenlight (EUA)

| Metrica | Greenlight Ano 3 | Nossa Projecao Ano 3 |
|---------|------------------|----------------------|
| Usuarios | ~500K | 500K |
| ARR | ~$30M | R$ 130M (~$26M) |
| Funding Acumulado | ~$80M | R$ 123M (~$25M) |
| Valuation | ~$400M | R$ 400M (~$80M) |
| Headcount | ~150 | 180 |

---

## 10. Analise de Sensibilidade

### 10.1 Sensibilidade ao Churn (Impacto no LTV Ano 3)

| Churn Mensal | Lifetime | LTV | vs Base |
|--------------|----------|-----|---------|
| 2,5% | 40,0 | R$ 776 | +40% |
| 3,0% | 33,3 | R$ 647 | +17% |
| **3,5% (Base)** | **28,6** | **R$ 555** | **-** |
| 4,0% | 25,0 | R$ 485 | -13% |
| 5,0% | 20,0 | R$ 388 | -30% |
| 6,0% | 16,7 | R$ 324 | -42% |

### 10.2 Sensibilidade ao ARPU (Impacto no ARR Ano 5)

| ARPU Mensal | ARR Ano 5 | vs Base |
|-------------|-----------|---------|
| R$ 26,00 | R$ 410M | +13% |
| R$ 24,50 | R$ 386M | +6% |
| **R$ 23,00 (Base)** | **R$ 363M** | **-** |
| R$ 21,50 | R$ 339M | -7% |
| R$ 20,00 | R$ 315M | -13% |

### 10.3 Matriz de Sensibilidade (Usuarios x ARPU)

**ARR Ano 5 (R$ milhoes):**

| Usuarios \ ARPU | R$ 20 | R$ 21,50 | R$ 23 | R$ 24,50 | R$ 26 |
|-----------------|-------|----------|-------|----------|-------|
| 900K | 216 | 232 | 248 | 265 | 281 |
| 1.050K | 252 | 271 | 290 | 309 | 328 |
| **1.200K** | 288 | 310 | **363** | 353 | 374 |
| 1.350K | 324 | 348 | 373 | 397 | 421 |
| 1.500K | 360 | 387 | 414 | 441 | 468 |

### 10.4 Tornado Chart - EBITDA Ano 5

```
Impacto no EBITDA Ano 5 (+/- 20% em cada variavel)

Usuarios        |████████████████████████████████████████| +/- R$ 42M
Churn           |██████████████████████████████████      | +/- R$ 35M
ARPU            |████████████████████████████            | +/- R$ 28M
Custo Pessoal   |██████████████████████                  | +/- R$ 21M
CAC             |████████████████                        | +/- R$ 14M
BaaS            |████████████                            | +/- R$ 10M
                +----------------------------------------+
                -50M  -40M  -30M  -20M  -10M   0   +10M  +20M  +30M  +40M  +50M
```

---

## 11. Riscos e Mitigacoes

### 11.1 Matriz de Riscos

| Risco | Prob. | Impacto | Score | Mitigacao |
|-------|-------|---------|-------|-----------|
| Regulatorio Bacen | Media | Critico | 15 | Parceria com BaaS licenciado, compliance desde MVP |
| Entrada grandes bancos | Alta | Alto | 16 | Diferenciacao (4 Baldes), foco em educacao financeira |
| Churn acima esperado | Media | Alto | 12 | Gamificacao, engajamento, valor percebido continuo |
| CAC insustentavel | Media | Alto | 12 | Multi-canal, referral program, parcerias escolas |
| Falha de execucao time | Media | Alto | 12 | Contratacoes senior, advisors experientes |
| Fraude/Seguranca | Baixa | Critico | 10 | SOC 2, PCI-DSS, pentest, antifraude ML |
| Economia brasileira | Media | Medio | 9 | Foco classes A/B, pricing flexivel |
| Custos BaaS acima | Media | Medio | 9 | Negociar volume, avaliar multi-provider |

### 11.2 Plano de Contingencia

| Trigger | Acao Imediata | Responsavel |
|---------|---------------|-------------|
| CAC > R$ 140 por 3 meses | Pausar performance, dobrar organico | CMO |
| Churn > 6% por 3 meses | Task force retencao, entrevistas usuarios | CPO |
| Runway < 9 meses | Cortar 25% custos, iniciar bridge | CEO/CFO |
| NPS < 40 | Revisao produto, sprint de qualidade | CPO |
| Conversao < 30% trial | A/B testing, onboarding redesign | Growth |

---

## 12. Valuation e Retorno Investidores

### 12.1 Multiplos de Mercado (Fintechs Similares)

| Empresa | ARR | Multiplo | Valuation |
|---------|-----|----------|-----------|
| Greenlight (2024) | $80M | 28x | $2.3B |
| Step (2023) | $40M | 25x | $1.0B |
| GoHenry (2022) | $35M | 20x | $700M |
| **Media Fintechs Kids** | - | **24x** | - |

### 12.2 Projecao de Valuation

| Momento | ARR | Multiplo | Valuation |
|---------|-----|----------|-----------|
| Seed (M0) | R$ 0 | - | R$ 25M (pre-revenue) |
| Serie A (M12) | R$ 11M | 9x | R$ 100M |
| Serie B (M24) | R$ 48M | 8x | R$ 400M |
| Serie C (M42) | R$ 180M | 7x | R$ 1,26B |
| Exit (Ano 5) | R$ 363M | 6x | R$ 2,18B |

### 12.3 Retorno para Investidores (Exit Ano 5)

| Investidor | Investimento | % Pos-Diluicao | Valor Exit | Multiplo | IRR |
|------------|--------------|----------------|------------|----------|-----|
| Fundadores | - | 38% | R$ 828M | - | - |
| Seed | R$ 8M | 11% | R$ 240M | 30x | 98% |
| Serie A | R$ 35M | 15% | R$ 327M | 9,3x | 68% |
| Serie B | R$ 80M | 11% | R$ 240M | 3,0x | 44% |
| ESOP | - | 8% | R$ 174M | - | - |
| Outros | - | 17% | R$ 370M | - | - |
| **Total** | **R$ 123M** | 100% | **R$ 2,18B** | - | - |

---

## Anexos

### A. Glossario

| Termo | Definicao |
|-------|-----------|
| ARR | Annual Recurring Revenue = MRR x 12 |
| MRR | Monthly Recurring Revenue |
| ARPU | Average Revenue Per User |
| CAC | Customer Acquisition Cost |
| LTV | Lifetime Value |
| Churn | Taxa mensal de cancelamento |
| Payback | Meses para recuperar CAC |
| Magic Number | (ARR Novo Trimestre) / (Marketing Trimestre Anterior) |
| Rule of 40 | Growth Rate + EBITDA Margin |
| NRR | Net Revenue Retention |

### B. Fontes

1. IBGE 2024 - Dados demograficos familias brasileiras
2. Greenlight Financial Reports 2024 - Benchmark metricas
3. CB Insights Fintech Report 2025 - Multiplos de mercado
4. Pesquisa TIC Domicilios 2024 - Penetracao digital
5. Entrevistas com operadores BaaS Brasil (Dock, Pismo, Zoop)

---

*Documento elaborado para fins de planejamento estrategico e captacao de investimentos.*
*As projecoes sao estimativas baseadas em premissas que podem variar.*
*Versao 2.0 | Janeiro 2026*
