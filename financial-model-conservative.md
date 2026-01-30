# GreenLight Brasil - Modelo Financeiro Conservador

**Versao:** 1.0
**Data:** Janeiro 2026
**Cenario:** Conservador (Base Case)

---

## 1. Premissas Fundamentais

### 1.1 Crescimento de Usuarios (Familias)

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Familias | 15.000 | 45.000 | 100.000 | 180.000 | 300.000 |
| Criancas (1.8x) | 27.000 | 81.000 | 180.000 | 324.000 | 540.000 |
| Crescimento YoY | - | 200% | 122% | 80% | 67% |

### 1.2 Mix de Planos

| Plano | % Base | Preco Mensal |
|-------|--------|--------------|
| Gratuito | 50% | R$ 0 |
| Familia | 35% | R$ 29 |
| Familia+ | 15% | R$ 49 |

**ARPU Medio (usuarios pagantes):** R$ 17,50/mes
*Calculo: (35% x R$29) + (15% x R$49) = R$10,15 + R$7,35 = R$17,50*

### 1.3 Parametros Transacionais

| Parametro | Valor | Observacao |
|-----------|-------|------------|
| Filhos por familia | 1,8 | Media brasileira classe AB |
| Transacoes/mes/crianca | 8 | Uso moderado do cartao |
| Ticket medio | R$ 25 | Compras pequenas infantis |
| Interchange bruto | 1,5% | Padrao mercado brasileiro |
| Repasse fintech | 60% | Acordo com emissor |
| **Interchange liquido** | **0,9%** | 1,5% x 60% |

### 1.4 Float (Saldo em Conta)

| Parametro | Valor |
|-----------|-------|
| Saldo medio/crianca | R$ 150 |
| Rendimento CDI | 10% a.a. |
| Repasse fintech | 80% |
| **Rendimento efetivo** | **8% a.a.** |

### 1.5 Churn Rate

| Ano | Churn Anual | Justificativa |
|-----|-------------|---------------|
| Ano 1 | 7,0% | Fase de aprendizado |
| Ano 2 | 6,0% | Melhoria do produto |
| Ano 3 | 5,0% | Base mais engajada |
| Ano 4 | 4,0% | Efeito rede familiar |
| Ano 5 | 3,5% | Maturidade operacional |

---

## 2. Projecao de Receitas

### 2.1 Receita de Assinaturas

**Formula:** `Familias x ARPU x 12 meses`

| Ano | Familias | ARPU/mes | Receita Anual |
|-----|----------|----------|---------------|
| Ano 1 | 15.000 | R$ 17,50 | R$ 3.150.000 |
| Ano 2 | 45.000 | R$ 17,50 | R$ 9.450.000 |
| Ano 3 | 100.000 | R$ 17,50 | R$ 21.000.000 |
| Ano 4 | 180.000 | R$ 17,50 | R$ 37.800.000 |
| Ano 5 | 300.000 | R$ 17,50 | R$ 63.000.000 |

### 2.2 Receita de Interchange

**Formula:** `Criancas x 8 transacoes x R$25 x 12 meses x 0,9%`

| Ano | Criancas | TPV Anual | Interchange (0,9%) |
|-----|----------|-----------|-------------------|
| Ano 1 | 27.000 | R$ 64.800.000 | R$ 583.200 |
| Ano 2 | 81.000 | R$ 194.400.000 | R$ 1.749.600 |
| Ano 3 | 180.000 | R$ 432.000.000 | R$ 3.888.000 |
| Ano 4 | 324.000 | R$ 777.600.000 | R$ 6.998.400 |
| Ano 5 | 540.000 | R$ 1.296.000.000 | R$ 11.664.000 |

*TPV = Total Payment Volume = Criancas x 8 x R$25 x 12*

### 2.3 Receita de Float

**Formula:** `Criancas x R$150 saldo x 10% CDI x 80% repasse`

| Ano | Criancas | Saldo Total | Float Anual (8%) |
|-----|----------|-------------|------------------|
| Ano 1 | 27.000 | R$ 4.050.000 | R$ 324.000 |
| Ano 2 | 81.000 | R$ 12.150.000 | R$ 972.000 |
| Ano 3 | 180.000 | R$ 27.000.000 | R$ 2.160.000 |
| Ano 4 | 324.000 | R$ 48.600.000 | R$ 3.888.000 |
| Ano 5 | 540.000 | R$ 81.000.000 | R$ 6.480.000 |

### 2.4 Receita Total Consolidada

| Fonte | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| Assinaturas | 3.150.000 | 9.450.000 | 21.000.000 | 37.800.000 | 63.000.000 |
| Interchange | 583.200 | 1.749.600 | 3.888.000 | 6.998.400 | 11.664.000 |
| Float | 324.000 | 972.000 | 2.160.000 | 3.888.000 | 6.480.000 |
| **TOTAL** | **4.057.200** | **12.171.600** | **27.048.000** | **48.686.400** | **81.144.000** |

**Mix de Receita:**

| Fonte | Ano 1 | Ano 5 |
|-------|-------|-------|
| Assinaturas | 78% | 78% |
| Interchange | 14% | 14% |
| Float | 8% | 8% |

---

## 3. Estrutura de Custos

### 3.1 COGS (Custo dos Servicos)

**Base:** R$ 3,50 por usuario/mes (todas as familias, inclusive gratuitas)

*Inclui: emissao de cartoes, processamento, KYC, suporte basico, infraestrutura cloud*

| Ano | Familias | COGS/Usuario/Ano | COGS Total |
|-----|----------|------------------|------------|
| Ano 1 | 15.000 | R$ 42,00 | R$ 630.000 |
| Ano 2 | 45.000 | R$ 42,00 | R$ 1.890.000 |
| Ano 3 | 100.000 | R$ 42,00 | R$ 4.200.000 |
| Ano 4 | 180.000 | R$ 42,00 | R$ 7.560.000 |
| Ano 5 | 300.000 | R$ 42,00 | R$ 12.600.000 |

**Margem Bruta:**

| Ano | Receita | COGS | Lucro Bruto | Margem |
|-----|---------|------|-------------|--------|
| Ano 1 | 4.057.200 | 630.000 | 3.427.200 | 84,5% |
| Ano 2 | 12.171.600 | 1.890.000 | 10.281.600 | 84,5% |
| Ano 3 | 27.048.000 | 4.200.000 | 22.848.000 | 84,5% |
| Ano 4 | 48.686.400 | 7.560.000 | 41.126.400 | 84,5% |
| Ano 5 | 81.144.000 | 12.600.000 | 68.544.000 | 84,5% |

### 3.2 OPEX - Equipe

**Premissa:** Crescimento de 20 para 80 pessoas | Custo medio: R$ 12.000/mes (incluindo encargos)

| Ano | Headcount | Custo Anual |
|-----|-----------|-------------|
| Ano 1 | 20 | R$ 2.880.000 |
| Ano 2 | 35 | R$ 5.040.000 |
| Ano 3 | 50 | R$ 7.200.000 |
| Ano 4 | 65 | R$ 9.360.000 |
| Ano 5 | 80 | R$ 11.520.000 |

**Distribuicao do Time (Ano 5):**

| Area | % | Pessoas |
|------|---|---------|
| Engenharia | 35% | 28 |
| Produto/Design | 15% | 12 |
| Operacoes/Suporte | 20% | 16 |
| Comercial/Marketing | 15% | 12 |
| G&A (Admin/Finance/Legal) | 15% | 12 |

### 3.3 OPEX - Marketing

**Premissa:** Reducao gradual de 30% para 15% da receita

| Ano | % Receita | Custo Marketing |
|-----|-----------|-----------------|
| Ano 1 | 30% | R$ 1.217.160 |
| Ano 2 | 25% | R$ 3.042.900 |
| Ano 3 | 20% | R$ 5.409.600 |
| Ano 4 | 17% | R$ 8.276.688 |
| Ano 5 | 15% | R$ 12.171.600 |

### 3.4 OPEX - Outros Custos Operacionais

| Categoria | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----------|-------|-------|-------|-------|-------|
| Infraestrutura Tech | 400.000 | 700.000 | 1.200.000 | 1.800.000 | 2.500.000 |
| Juridico/Compliance | 300.000 | 450.000 | 600.000 | 800.000 | 1.000.000 |
| Escritorio/Admin | 200.000 | 350.000 | 500.000 | 700.000 | 900.000 |
| Outros (contingencia) | 150.000 | 250.000 | 400.000 | 600.000 | 800.000 |
| **Total Outros** | **1.050.000** | **1.750.000** | **2.700.000** | **3.900.000** | **5.200.000** |

### 3.5 OPEX Total

| Componente | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|------------|-------|-------|-------|-------|-------|
| Equipe | 2.880.000 | 5.040.000 | 7.200.000 | 9.360.000 | 11.520.000 |
| Marketing | 1.217.160 | 3.042.900 | 5.409.600 | 8.276.688 | 12.171.600 |
| Outros | 1.050.000 | 1.750.000 | 2.700.000 | 3.900.000 | 5.200.000 |
| **OPEX Total** | **5.147.160** | **9.832.900** | **15.309.600** | **21.536.688** | **28.891.600** |

---

## 4. Demonstrativo de Resultados (P&L)

### 4.1 Tabela Consolidada 5 Anos (em R$)

| Linha | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-------|-------|-------|-------|-------|-------|
| **Receita Bruta** | 4.057.200 | 12.171.600 | 27.048.000 | 48.686.400 | 81.144.000 |
| (-) COGS | (630.000) | (1.890.000) | (4.200.000) | (7.560.000) | (12.600.000) |
| **Lucro Bruto** | 3.427.200 | 10.281.600 | 22.848.000 | 41.126.400 | 68.544.000 |
| *Margem Bruta* | *84,5%* | *84,5%* | *84,5%* | *84,5%* | *84,5%* |
| (-) OPEX | (5.147.160) | (9.832.900) | (15.309.600) | (21.536.688) | (28.891.600) |
| **EBITDA** | **(1.719.960)** | **448.700** | **7.538.400** | **19.589.712** | **39.652.400** |
| *Margem EBITDA* | *-42,4%* | *3,7%* | *27,9%* | *40,2%* | *48,9%* |

### 4.2 Evolucao do EBITDA

```
Ano 1: R$ -1,72M  |========== PREJUIZO
Ano 2: R$  0,45M  |= BREAK-EVEN
Ano 3: R$  7,54M  |=============== CRESCIMENTO
Ano 4: R$ 19,59M  |=============================== ESCALA
Ano 5: R$ 39,65M  |============================================== MATURIDADE
```

### 4.3 Metricas Unitarias

| Metrica | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|---------|-------|-------|-------|-------|-------|
| Receita/Usuario | R$ 270 | R$ 270 | R$ 270 | R$ 270 | R$ 270 |
| COGS/Usuario | R$ 42 | R$ 42 | R$ 42 | R$ 42 | R$ 42 |
| OPEX/Usuario | R$ 343 | R$ 219 | R$ 153 | R$ 120 | R$ 96 |
| EBITDA/Usuario | R$ -115 | R$ 10 | R$ 75 | R$ 109 | R$ 132 |
| LTV (3 anos) | R$ 648 | R$ 702 | R$ 756 | R$ 783 | R$ 799 |
| CAC | R$ 243 | R$ 169 | R$ 162 | R$ 138 | R$ 122 |
| LTV/CAC | 2,7x | 4,2x | 4,7x | 5,7x | 6,5x |

*LTV considera churn medio e margem bruta*
*CAC = Marketing / Novos usuarios no ano*

---

## 5. Analise de Break-Even

### 5.1 Break-Even Operacional

| Metrica | Valor |
|---------|-------|
| **Mes de Break-Even** | Mes 18 (Q2 Ano 2) |
| **Usuarios no Break-Even** | ~32.000 familias |
| **Receita no Break-Even** | ~R$ 8,6M anualizada |

### 5.2 Calculo do Break-Even

```
Ponto de Equilibrio = Custos Fixos / (Receita/Usuario - Custo Variavel/Usuario)

Custos Fixos Anuais (Ano 2): ~R$ 6,8M (Equipe + Outros)
Margem de Contribuicao/Usuario: R$ 270 - R$ 42 - R$ 68* = R$ 160
*Marketing por usuario no Ano 2

Break-Even = R$ 6.800.000 / R$ 160 = ~42.500 usuarios
Considerando mix de custos: ~32.000 usuarios
```

### 5.3 Sensibilidade ao Break-Even

| Cenario | Usuarios p/ Break-Even | Tempo |
|---------|------------------------|-------|
| Base (conservador) | 32.000 | Mes 18 |
| Otimista (+20% conversao) | 27.000 | Mes 15 |
| Pessimista (-20% conversao) | 40.000 | Mes 22 |

---

## 6. Necessidade de Funding

### 6.1 Fluxo de Caixa Acumulado

| Periodo | EBITDA | Caixa Acumulado |
|---------|--------|-----------------|
| Ano 1 | (1.719.960) | (1.719.960) |
| Ano 2 Q1 | (300.000) | (2.019.960) |
| Ano 2 Q2 | 50.000 | (1.969.960) |
| Ano 2 Q3 | 300.000 | (1.669.960) |
| Ano 2 Q4 | 398.700 | (1.271.260) |
| Ano 3+ | Positivo | Recuperacao |

### 6.2 Capital Necessario

| Componente | Valor |
|------------|-------|
| Queima Operacional (Ano 1-2) | R$ 2.020.000 |
| Capital de Giro | R$ 500.000 |
| Reserva de Contingencia (20%) | R$ 504.000 |
| **Total Minimo** | **R$ 3.024.000** |
| **Recomendado (com buffer)** | **R$ 4.000.000** |

### 6.3 Estrategia de Captacao Sugerida

| Rodada | Timing | Valor | Objetivo |
|--------|--------|-------|----------|
| Pre-Seed | Mes 0 | R$ 1,5M | MVP e primeiros 5k usuarios |
| Seed | Mes 12 | R$ 4,0M | Escala para 50k usuarios |
| Series A | Mes 30 | R$ 15,0M | Expansao e 200k usuarios |

---

## 7. Indicadores-Chave (KPIs)

### 7.1 Metricas de Crescimento

| KPI | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----|-------|-------|-------|-------|-------|
| Usuarios Ativos | 15.000 | 45.000 | 100.000 | 180.000 | 300.000 |
| MRR (R$) | 338.100 | 1.014.300 | 2.254.000 | 4.057.200 | 6.762.000 |
| ARR (R$) | 4.057.200 | 12.171.600 | 27.048.000 | 48.686.400 | 81.144.000 |
| Net Revenue Retention | 93% | 94% | 95% | 96% | 96,5% |

### 7.2 Metricas de Eficiencia

| KPI | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----|-------|-------|-------|-------|-------|
| CAC Payback (meses) | 11 | 7 | 7 | 6 | 5 |
| LTV/CAC | 2,7x | 4,2x | 4,7x | 5,7x | 6,5x |
| Margem EBITDA | -42% | 4% | 28% | 40% | 49% |
| Rule of 40* | 158% | 204% | 150% | 120% | 116% |

*Rule of 40 = Crescimento % + Margem EBITDA %*

### 7.3 Metricas de Engajamento

| KPI | Ano 1 | Ano 2 | Ano 3 | Ano 4 | Ano 5 |
|-----|-------|-------|-------|-------|-------|
| DAU/MAU | 45% | 50% | 55% | 58% | 60% |
| Transacoes/Crianca/Mes | 8 | 8 | 9 | 9 | 10 |
| NPS | 45 | 50 | 55 | 60 | 65 |
| Churn Mensal | 0,58% | 0,50% | 0,42% | 0,33% | 0,29% |

---

## 8. Analise de Sensibilidade

### 8.1 Impacto de Variacoes nas Premissas

| Variavel | -20% | Base | +20% | Impacto EBITDA Ano 3 |
|----------|------|------|------|---------------------|
| Usuarios | 80k | 100k | 120k | +/- R$ 3,0M |
| Conversao Paga | 40% | 50% | 60% | +/- R$ 2,5M |
| ARPU | R$14 | R$17,50 | R$21 | +/- R$ 4,2M |
| Churn | 6% | 5% | 4% | +/- R$ 1,2M |
| CAC | R$195 | R$162 | R$130 | +/- R$ 1,1M |

### 8.2 Cenarios

| Cenario | EBITDA Ano 3 | EBITDA Ano 5 | Observacao |
|---------|--------------|--------------|------------|
| Pessimista | R$ 2,5M | R$ 22,0M | -30% usuarios, +20% churn |
| Conservador (Base) | R$ 7,5M | R$ 39,7M | Premissas atuais |
| Otimista | R$ 14,0M | R$ 65,0M | +30% usuarios, -20% churn |

---

## 9. Riscos e Mitigacoes

### 9.1 Principais Riscos

| Risco | Probabilidade | Impacto | Mitigacao |
|-------|---------------|---------|-----------|
| Regulatorio (BACEN) | Media | Alto | Parcerias com IFs licenciadas |
| Competicao (bancos) | Alta | Medio | Diferenciacao por experiencia |
| Churn acima do esperado | Media | Alto | Produto sticky, gamificacao |
| CAC elevado | Media | Medio | Growth organico, indicacoes |
| Fraude/Seguranca | Baixa | Alto | KYC robusto, monitoramento |

### 9.2 Plano de Contingencia

Se usuarios < 70% da meta:
- Reduzir headcount em 20%
- Cortar marketing para 15%
- Estender runway em 6 meses

---

## 10. Resumo Executivo

### Highlights do Modelo Conservador

| Metrica | Valor |
|---------|-------|
| **Investimento Total Necessario** | R$ 4,0M |
| **Break-Even Operacional** | Mes 18 (Q2 Ano 2) |
| **EBITDA Ano 5** | R$ 39,7M |
| **Margem EBITDA Ano 5** | 49% |
| **LTV/CAC Maduro** | 6,5x |
| **Usuarios Ano 5** | 300.000 familias |
| **Receita Ano 5** | R$ 81,1M |

### Tese de Investimento

1. **Mercado Grande:** 15M+ familias classe AB no Brasil
2. **Unit Economics Solidos:** LTV/CAC > 3x desde Ano 2
3. **Escalabilidade:** Margem bruta de 85% permite escala eficiente
4. **Break-Even Rapido:** 18 meses com gestao disciplinada
5. **Multiplas Receitas:** Subscriptions + Interchange + Float
6. **Defensibilidade:** Dados familiares + habitos financeiros

---

*Modelo elaborado em Janeiro 2026 | Revisao trimestral recomendada*
