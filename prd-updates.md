# PRD Updates - GreenLight

> Documento simplificado com foco nas 3 features principais
> Data: 2026-01-30

---

## 1. CORE FEATURE: Tarefas & Recompensas

### Fluxo Completo
**Pai cria tarefa → Filho executa → Marca check → Pai aprova → Pagamento automático**

### Métodos de Pagamento
- **PIX**: Transferência instantânea da conta do pai
- **Débito cartão pai**: Cobrança direta no cartão vinculado
- **Transferência interna**: Saldo GreenLight do pai

### Exemplos de Tarefas & Valores
| Tarefa | Valor | Tipo |
|--------|-------|------|
| Arrumar cama | R$ 2 | Diária |
| Nota boa | R$ 15 | Por prova |
| Lavar carro | R$ 20 | Semanal |

### Features Avançadas
- **Recorrência**: Tarefas únicas, diárias, semanais, mensais
- **Streak Bonus**: +20% por sequências consecutivas (7 dias, 14 dias, 30 dias)
- **Foto de Prova**: Upload opcional/obrigatório para validação
- **Timer**: Cronômetro para medir tempo de execução

### Distribuição: 4 Objetivos (Potes)
Dinheiro recebido é automaticamente dividido entre:

1. **Gastar** - Uso imediato via cartão
2. **Guardar** - Metas de curto prazo
3. **Doar** - Causas sociais (educação + empatia)
4. **Investir** - Renda fixa de longo prazo

**Configuração**: Pai define % padrão, filho pode ajustar por tarefa

---

## 2. GRANIX Academy

### Formatos de Conteúdo
- **Vídeos curtos**: 2-5 min (estilo TikTok/YouTube Shorts)
- **Quizzes**: Interativos com feedback imediato
- **Quadrinhos**: Histórias com o mascote GRANIX
- **Artigos**: 300-500 palavras, linguagem simples
- **Simuladores**: Juros compostos, orçamento, investimentos

### Trilhas por Idade

| Trilha | Idade | Tópicos | Duração |
|--------|-------|---------|---------|
| **Semente** | 6-8 anos | O que é dinheiro, poupar, trocar | 8 aulas |
| **Broto** | 9-11 anos | Mesada, orçamento, primeiras compras | 12 aulas |
| **Árvore** | 12-14 anos | Investimentos básicos, empreendedorismo | 16 aulas |
| **Floresta** | 15-17 anos | Renda fixa/variável, impostos, carreira | 20 aulas |

### Gamificação

**Sistema de XP**:
- Quiz: 50 XP
- Vídeo: 30 XP
- Simulador: 40 XP
- Trilha completa: 500 XP

**Badges**:
- "Primeira Lição"
- "Maratonista" (7 dias seguidos)
- "Expert em Juros"

**Ranking**:
- Semanal (Top 10)
- Mensal (Hall da Fama)
- Entre amigos (opt-in)

**Recompensas Reais**:
- **R$ 5** por trilha completa
- **R$ 20 bonus** ao completar todas as 4 trilhas
- Certificados digitais compartilháveis

---

## 3. Monetização

### Planos de Assinatura

#### Grátis - R$ 0/mês
- **Limite**: 1 filho
- **Cartão**: Virtual apenas
- **Tarefas**: 5/mês
- **Academy**: 3 aulas grátis
- **Investimentos**: Não disponível

#### Família - R$ 29/mês
- **Limite**: 4 filhos
- **Cartão**: Físico + Virtual
- **Tarefas**: Ilimitadas
- **Academy**: Trilhas Semente + Broto
- **Investimentos**: Poupança simples
- **Extras**: Relatórios mensais

#### Família+ - R$ 49/mês
- **Limite**: 6 filhos
- **Cartão**: Físico + Virtual premium
- **Tarefas**: Ilimitadas
- **Academy**: Todas as trilhas (Semente até Floresta)
- **Investimentos**: CDB + Tesouro Direto
- **Cashback**: 1% em todas as compras
- **Extras**: Consultoria financeira (1x/trimestre), relatórios com IA

---

### Estrutura de Receitas

| Fonte | % Receita | Descrição |
|-------|-----------|-----------|
| **Assinatura** | 60% | Mensalidades Família e Família+ |
| **Interchange** | 25% | Taxa por transação de cartão (0,8-1,2%) |
| **Float** | 10% | Rendimento sobre saldo em conta (50% split com usuário) |
| **Taxa Investimento** | 5% | Comissão sobre produtos de investimento (0,5% aa) |

### Projeção Ano 1 (12.000 famílias pagantes)

**Receita Anual Estimada: R$ 5.501.000**

Breakdown:
- Assinaturas: R$ 4.656.000/ano (10.000 Família + 2.000 Família+)
- Interchange: R$ 720.000/ano (R$ 6M/mês em transações × 1%)
- Float: R$ 120.000/ano (R$ 2,4M saldo médio × 10% CDI × 50% split)
- Investimentos: R$ 5.000/ano (R$ 1M investido × 0,5% taxa)

**Métricas-Chave**:
- **LTV**: R$ 1.200 (36 meses)
- **CAC**: R$ 150-200
- **LTV/CAC**: 6:1
- **Churn Target**: <5%/mês

### Estratégia de Upsell

**Free → Família (15% conversão)**:
- Gatilho: Após 5 tarefas concluídas
- Incentivo: "Desbloqueie tarefas ilimitadas por R$ 29/mês"

**Família → Família+ (25% conversão)**:
- Gatilho: Filho completa trilha Academy
- Incentivo: "Libere todas as trilhas + investimentos por +R$ 20/mês"

---

## Próximos Passos

1. Prototipar fluxo de tarefas (Figma)
2. Validar pricing com 5-10 entrevistas com pais
3. Definir parceiros de pagamento (Stone, Adyen, Pagar.me)
4. Roadmap de produção de conteúdo Academy (Q1 2026)
5. Modelar CAC/LTV com campanha beta (50-100 famílias)

---

**Versão**: 1.0
**Status**: Draft para revisão
**Última atualização**: 2026-01-30
