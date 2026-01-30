# GreenLight/GRANIX - Product Requirements Document Updates

> **Status:** Draft
> **Data:** 2026-01-30
> **Versão:** 1.0

---

## 1. CORE FEATURE: Tarefas & Recompensas

### Fluxo Principal
**Ciclo Completo de Tarefa:**
1. Pai cria tarefa com valor e prazo
2. Filho visualiza tarefa no app
3. Filho executa a tarefa
4. Filho marca check de conclusão
5. Pai recebe notificação de aprovação
6. Pai aprova (ou rejeita com feedback)
7. Pagamento automático processado
8. Dinheiro creditado nos Objetivos do filho

### Métodos de Pagamento
- **PIX:** Débito instantâneo da conta bancária do pai
- **Débito em Cartão:** Cartão do pai vinculado ao app
- **Transferência Interna:** Saldo da carteira GreenLight do pai

### Exemplos de Tarefas e Valores Sugeridos
| Tarefa | Valor | Frequência |
|--------|-------|------------|
| Arrumar a cama | R$ 2,00 | Diária |
| Nota boa (7-9) | R$ 15,00 | Por prova |
| Lavar o carro | R$ 20,00 | Semanal |
| Tirar o lixo | R$ 3,00 | Diária |
| Ajudar no jantar | R$ 10,00 | Por vez |
| Organizar quarto | R$ 8,00 | Semanal |

### Features Avançadas

#### Recorrência
- Tarefas únicas (one-time)
- Tarefas recorrentes: diária, semanal, mensal
- Auto-renovação após conclusão
- Histórico de execução e performance

#### Streak Bonus
- **+20% bonus** para sequências consecutivas
- Exemplos:
  - 7 dias seguidos: bonus +20%
  - 14 dias: badge "Disciplina de Ferro"
  - 30 dias: bonus +50% especial

#### Foto de Prova
- Upload obrigatório/opcional (configurável pelo pai)
- Galeria de fotos no histórico
- Validação visual antes da aprovação
- Armazenamento seguro (S3/CloudFlare)

#### Timer
- Contador de tempo para tarefas
- Estimativa vs. tempo real
- Gamificação: "Fez em X minutos!"
- Histórico de eficiência

### Distribuição em 4 Objetivos

**Sistema de Objetivos (4 Potes):**
1. **Gastar** - Uso imediato (cartão, transferências)
2. **Guardar** - Metas de curto prazo (bicicleta, videogame)
3. **Doar** - Educação financeira e empatia (ONGs, projetos sociais)
4. **Investir** - Renda fixa (CDB, Tesouro Direto)

**Regras de Distribuição:**
- Pai define % padrão (ex: 40% Gastar, 30% Guardar, 10% Doar, 20% Investir)
- Filho pode ajustar em cada tarefa (educação de priorização)
- Dashboard visual mostra crescimento de cada pote
- Sugestões inteligentes baseadas em idade e metas

---

## 2. GRANIX Academy

### Formatos de Conteúdo

#### Vídeos Curtos
- **Duração:** 2-5 minutos
- **Estilo:** Animações, storytelling, exemplos práticos
- **Temas:** Juros compostos, inflação, orçamento, investimentos
- **Plataforma:** Player nativo com tracking de progresso

#### Quizzes Interativos
- **Formato:** Múltipla escolha, verdadeiro/falso, arrastar-e-soltar
- **Feedback:** Imediato com explicação detalhada
- **Repetição:** Permitida até acertar 80%+
- **Recompensa:** XP por quiz concluído

#### Quadrinhos Educativos
- **Personagem:** GRANIX (mascote árvore)
- **Histórias:** Situações do dia a dia com dilemas financeiros
- **Interação:** Escolhas do leitor afetam o desfecho
- **Arte:** Visual colorido e atrativo para crianças/adolescentes

#### Artigos Curtos
- **Tamanho:** 300-500 palavras
- **Tom:** Conversacional, sem jargão
- **Exemplos:** Casos reais de sucesso financeiro
- **Leitura:** 2-3 minutos

#### Simuladores
- **Calculadora de Juros Compostos:** Visualizar crescimento de R$ 100 em 10 anos
- **Orçamento Familiar:** Simular custos de uma casa
- **Investimentos:** Comparar rendimento de poupança vs. CDB
- **Metas:** Quanto economizar por mês para comprar algo

### Trilhas por Idade

#### Semente (6-8 anos)
- **Temas:** O que é dinheiro, trocar/guardar, diferenciar necessidade vs. desejo
- **Duração:** 8 aulas
- **Certificado:** "Pequeno Poupador"

#### Broto (9-11 anos)
- **Temas:** Mesada, orçamento simples, guardar para metas, conceito de juros
- **Duração:** 12 aulas
- **Certificado:** "Guardião do Cofrinho"

#### Árvore (12-14 anos)
- **Temas:** Cartões, crédito vs. débito, investimentos básicos, empreendedorismo
- **Duração:** 16 aulas
- **Certificado:** "Investidor Iniciante"

#### Floresta (15-17 anos)
- **Temas:** Renda fixa/variável, impostos, planejamento futuro, faculdade/carreira
- **Duração:** 20 aulas
- **Certificado:** "Estrategista Financeiro"

### Gamificação

#### Sistema de XP (Experience Points)
- **Quiz concluído:** 50 XP
- **Vídeo assistido:** 30 XP
- **Simulador usado:** 40 XP
- **Artigo lido:** 20 XP
- **Trilha completa:** 500 XP

#### Badges (Conquistas)
- "Primeira Lição" - Completar 1ª aula
- "Maratonista" - 7 dias seguidos estudando
- "Expert em Juros" - 100% na trilha de investimentos
- "Professor GRANIX" - Compartilhar aprendizado (feature social futura)

#### Ranking
- **Semanal:** Top 10 alunos da semana
- **Mensal:** Hall da Fama
- **Amigos:** Comparar progresso (opt-in, privacidade)
- **Família:** Ranking entre irmãos (saudável)

#### Recompensas Reais
- **R$ 5,00 por trilha completa** (creditado em "Guardar" ou "Investir")
- **R$ 20,00 bonus** ao completar todas as 4 trilhas
- **Badges físicas** (adesivos) para marcos especiais
- **Certificados digitais** compartilháveis (LinkedIn futuro)

---

## 3. Monetização

### Planos de Assinatura

#### Plano Grátis (Free)
**Preço:** R$ 0,00/mês

**Limites:**
- 1 filho vinculado
- Cartão virtual apenas (sem físico)
- 5 tarefas/mês
- GRANIX Academy: 3 aulas grátis
- Transferências PIX: até R$ 100/mês
- Sem investimentos

**Público-alvo:** Famílias testando o produto, baixa renda

---

#### Plano Família (Family)
**Preço:** R$ 29,00/mês

**Benefícios:**
- Até 4 filhos vinculados
- 1 cartão físico por filho (envio grátis)
- Tarefas ilimitadas
- GRANIX Academy: trilhas Semente + Broto completas
- Transferências PIX ilimitadas
- Notificações push em tempo real
- Relatórios mensais de gastos

**Público-alvo:** Famílias com 1-3 filhos, renda média

---

#### Plano Família+ (Family Plus)
**Preço:** R$ 49,00/mês

**Benefícios:**
- **Tudo do Plano Família, mais:**
- Até 6 filhos vinculados
- Investimentos em renda fixa (CDB, Tesouro Direto)
- GRANIX Academy: trilhas completas (Semente até Floresta)
- Cashback de 1% em todas as compras
- Consultoria financeira (1 sessão/trimestre via chat)
- Cartões personalizados (foto/nome customizado)
- Relatórios avançados com insights de IA

**Público-alvo:** Famílias com 3+ filhos, renda alta, foco em educação financeira

---

### Estrutura de Receitas

#### 60% - Assinaturas (Recurring Revenue)
- **MRR Projetado (Ano 1):**
  - 10.000 usuários Família: R$ 290.000/mês
  - 2.000 usuários Família+: R$ 98.000/mês
  - **Total MRR:** R$ 388.000/mês
- **ARR (Annual Recurring Revenue):** R$ 4.656.000/ano
- **Churn Target:** <5%/mês

---

#### 25% - Interchange (Taxas de Transação)
- **Fonte:** Percentual sobre transações de cartão (débito/crédito)
- **Taxa Média:** 0,8% - 1,2% por transação
- **Volume Estimado:**
  - 12.000 usuários pagos × R$ 500/mês em transações = R$ 6M/mês
  - Interchange médio 1%: R$ 60.000/mês
- **Projeção Anual:** R$ 720.000/ano

**Fontes de Interchange:**
- Bandeiras (Visa, Mastercard): 0,5-0,8%
- Adquirentes (Stone, Cielo): 0,3-0,5%
- Parceria com banco emissor: split 50/50

---

#### 10% - Float (Juros sobre Saldo)
- **Conceito:** Investir saldo médio dos usuários em renda fixa (CDI)
- **Saldo Médio por Usuário:** R$ 200
- **Base de Usuários Pagos:** 12.000
- **Saldo Total:** R$ 2.400.000
- **Rendimento CDI (10%aa):** R$ 240.000/ano
- **% Repassado ao GreenLight:** 50% = R$ 120.000/ano

**Transparência:**
- 50% do rendimento vai para o usuário (pote "Investir")
- 50% fica com o GreenLight (receita de float)
- Divulgação clara na política de investimentos

---

#### 5% - Taxa de Investimento (Asset Management)
- **Produtos:** CDB, Tesouro Direto (Plano Família+ apenas)
- **Taxa de Performance:** 0,5% ao ano sobre valor investido
- **Base Investida Estimada:** R$ 1.000.000 (ano 1)
- **Receita Anual:** R$ 5.000/ano (início)
- **Crescimento:** 200% ao ano (à medida que base matura)

**Parcerias:**
- Corretoras (XP, Rico, NuInvest): white-label de produtos
- Fundos de renda fixa conservadores (rating AAA)
- Compliance: CVM, regulação de asset management

---

### Projeção Consolidada de Receitas (Ano 1)

| Fonte | Receita Anual | % do Total |
|-------|---------------|------------|
| Assinaturas (MRR) | R$ 4.656.000 | 60% |
| Interchange | R$ 720.000 | 25% |
| Float | R$ 120.000 | 10% |
| Taxa Investimento | R$ 5.000 | 5% |
| **TOTAL** | **R$ 5.501.000** | **100%** |

**LTV/CAC Target:**
- LTV (Lifetime Value): R$ 1.200 (36 meses × R$ 33 ARPU)
- CAC (Custo de Aquisição): R$ 150-200
- **LTV/CAC Ratio:** 6:1 (saudável)

---

### Estratégia de Upsell

**Free → Família:**
- Gatilho: Após 5 tarefas (limite do Free)
- Incentivo: "Desbloqueie tarefas ilimitadas por R$ 29/mês"
- Taxa de Conversão Target: 15%

**Família → Família+:**
- Gatilho: Filho completa trilha Academy no plano Família
- Incentivo: "Libere todas as trilhas + investimentos por +R$ 20/mês"
- Taxa de Conversão Target: 25%

---

### Métricas de Sucesso

**Mês 1-3 (Validação):**
- 1.000 usuários ativos (80% Free, 20% pagos)
- NPS > 50
- Churn < 8%

**Mês 4-6 (Crescimento):**
- 5.000 usuários ativos
- 30% conversão Free → Família
- MRR: R$ 100.000

**Mês 7-12 (Escala):**
- 12.000 usuários ativos
- MRR: R$ 388.000
- CAC payback < 6 meses

---

**Próximos Passos:**
1. Validar preços com pesquisa de mercado (5-10 entrevistas com pais)
2. Prototipar fluxo de tarefas (Figma)
3. Definir parceiros de pagamento (Stone, Adyen, Pagar.me)
4. Roadmap Academy (produção de conteúdo Q1 2026)

---

*Este documento será atualizado conforme feedback de stakeholders e validação de mercado.*
