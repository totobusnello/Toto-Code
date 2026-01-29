# Arquitetura de Dados - Fintech de Educacao Financeira Familiar

> Plano completo de arquitetura de dados para plataforma de mesada digital e cartao para menores de idade no Brasil.

**Versao:** 1.0
**Data:** Janeiro 2026
**Classificacao:** Confidencial
**Responsavel:** Equipe de Engenharia de Dados

---

## Sumario Executivo

Este documento define a estrategia e arquitetura de dados para uma fintech brasileira de educacao financeira familiar, processando:

- **500.000 familias** em 3 anos
- **~2 milhoes de transacoes/dia** no pico
- **4 baldes financeiros** (Gastar/Guardar/Doar/Investir)
- **Compliance total** com LGPD, Bacen, PLD/FT

### Principios Fundamentais

```
+-------------------------------------------------------------------+
|                    PRINCIPIOS DE DADOS                            |
+-------------------------------------------------------------------+
|  1. SEGURANCA PRIMEIRO - Dados de menores sao sagrados           |
|  2. COMPLIANCE BY DESIGN - LGPD/Bacen integrados na arquitetura  |
|  3. TEMPO REAL - Pais precisam ver transacoes instantaneamente   |
|  4. ESCALABILIDADE - Crescer 10x sem reprojetar                  |
|  5. CUSTO-EFICIENCIA - Otimizar sem comprometer qualidade        |
+-------------------------------------------------------------------+
```

---

## 1. Data Strategy

### 1.1 Visao de Dados da Empresa

```
+-----------------------------------------------------------------------+
|                         VISAO DE DADOS                                |
+-----------------------------------------------------------------------+
|                                                                       |
|  "Transformar dados financeiros familiares em insights educacionais   |
|   que empoderam pais e filhos a construirem habitos financeiros       |
|   saudaveis, garantindo privacidade, seguranca e conformidade         |
|   regulatoria em todas as etapas."                                    |
|                                                                       |
+-----------------------------------------------------------------------+
```

### 1.2 Pilares Estrategicos de Dados

| Pilar | Descricao | Metricas de Sucesso |
|-------|-----------|---------------------|
| **Confiabilidade** | Dados sempre disponiveis e corretos | 99.9% uptime, <0.01% erro |
| **Tempo Real** | Transacoes visiveis em segundos | Latencia <5s para notificacoes |
| **Privacidade** | Protecao maxima para dados de menores | Zero vazamentos, 100% LGPD |
| **Insights** | Dados geram valor educacional | NPS >70 em features de insights |
| **Eficiencia** | Custo otimizado por transacao | <R$0.001 por transacao processada |

### 1.3 Data Governance Principles

```yaml
Governance_Framework:
  ownership:
    dados_usuarios: Product Team (Data Owner)
    dados_transacionais: Finance Team (Data Owner)
    dados_compliance: Legal Team (Data Owner)
    dados_analytics: Data Team (Data Owner)

  stewardship:
    definicao: "Responsavel tecnico pela qualidade e integridade"
    modelo: Federated Data Stewardship
    por_dominio:
      - users: Backend Lead
      - transactions: Payment Lead
      - analytics: Data Engineer Lead
      - compliance: Security Lead

  principios:
    - Dados tem dono claro e documentado
    - Qualidade e validada na origem
    - Acesso e baseado em need-to-know
    - Linhagem e rastreavel fim-a-fim
    - Retencao segue politica definida
    - Mudancas passam por change management
```

### 1.4 Data Ownership Matrix

| Dominio de Dados | Data Owner | Data Steward | Classificacao |
|------------------|------------|--------------|---------------|
| Usuarios (Pais) | Head of Product | Backend Lead | PII Sensivel |
| Usuarios (Filhos) | Head of Product | Backend Lead | PII Critico |
| Transacoes | CFO | Payment Lead | Financeiro |
| Baldes/Metas | Head of Product | Backend Lead | Operacional |
| KYC/Documentos | Head of Compliance | Security Lead | PII Critico |
| Logs de Auditoria | Head of Security | Security Lead | Compliance |
| Analytics/Metricas | Head of Data | Data Lead | Interno |

### 1.5 Data Quality Dimensions

```
+------------------+------------------+------------------+
|   COMPLETUDE     |    PRECISAO      |   CONSISTENCIA   |
|   Todos campos   |   Valores        |   Mesmos dados   |
|   obrigatorios   |   corretos e     |   iguais em      |
|   preenchidos    |   validados      |   todos sistemas |
+------------------+------------------+------------------+
|   UNICIDADE      |   VALIDADE       |   ATUALIDADE     |
|   Sem            |   Dados no       |   Dados          |
|   duplicatas     |   formato        |   frescos e      |
|   indevidas      |   esperado       |   atualizados    |
+------------------+------------------+------------------+
```

---

## 2. Data Architecture

### 2.1 Arquitetura de Alto Nivel

```
+-----------------------------------------------------------------------------------+
|                              ARQUITETURA DE DADOS                                 |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  +-------------+     +------------------+     +------------------+                |
|  | MOBILE APP  |---->|   API GATEWAY    |---->|   MICROSERVICES  |                |
|  | iOS/Android |     |   (Kong/AWS)     |     |   (K8s/ECS)      |                |
|  +-------------+     +------------------+     +--------+---------+                |
|                                                        |                          |
|                                          +-------------+-------------+            |
|                                          |             |             |            |
|                                    +-----v----+ +-----v----+ +------v-----+      |
|                                    |  Users   | | Payments | |   Tasks    |      |
|                                    | Service  | |  Service | |  Service   |      |
|                                    +-----+----+ +-----+----+ +------+-----+      |
|                                          |           |              |            |
|  +-----------------------------------------------------------------------------------+
|  |                            DATA LAYER                                         |
|  +-----------------------------------------------------------------------------------+
|  |                                                                               |
|  |  +-----------------+     +------------------+     +------------------+        |
|  |  |   PostgreSQL    |     |     Redis        |     |   Elasticsearch  |        |
|  |  |   (OLTP/RDS)    |     |   (Cache/Session)|     |   (Search/Logs)  |        |
|  |  +-----------------+     +------------------+     +------------------+        |
|  |           |                                                                   |
|  |           | CDC (Debezium)                                                    |
|  |           v                                                                   |
|  |  +------------------+     +------------------+     +------------------+        |
|  |  |   Apache Kafka   |---->|   Spark/Flink    |---->|   Data Lake      |        |
|  |  |   (Event Stream) |     |   (Processing)   |     |   (S3/Delta)     |        |
|  |  +------------------+     +------------------+     +------------------+        |
|  |                                                            |                  |
|  |                                                            v                  |
|  |                                              +------------------+             |
|  |                                              |   Data Warehouse |             |
|  |                                              |   (BigQuery/     |             |
|  |                                              |    Snowflake)    |             |
|  |                                              +------------------+             |
|  |                                                            |                  |
|  |                                              +-------------+-------------+    |
|  |                                              |             |             |    |
|  |                                        +-----v----+ +-----v----+ +------v--+  |
|  |                                        |   BI     | |    ML    | | Reports |  |
|  |                                        | Metabase | | Platform | |  Bacen  |  |
|  |                                        +----------+ +----------+ +---------+  |
|  +-------------------------------------------------------------------------------+
+-----------------------------------------------------------------------------------+
```

### 2.2 OLTP vs OLAP Separation

```
+---------------------------+---------------------------+
|          OLTP             |          OLAP             |
|    (Transacional)         |    (Analitico)            |
+---------------------------+---------------------------+
|                           |                           |
| Banco: PostgreSQL (RDS)   | Banco: BigQuery/Snowflake |
| Uso: Operacoes diarias    | Uso: Analytics/Reports    |
| Latencia: <50ms           | Latencia: Segundos        |
| Modelo: Normalizado (3NF) | Modelo: Dimensional       |
| Escala: Vertical + Read   | Escala: Horizontal        |
|         Replicas          |         Massivo           |
| Retencao: 90 dias hot     | Retencao: Anos            |
| Usuarios: App/APIs        | Usuarios: Analistas/BI    |
|                           |                           |
+---------------------------+---------------------------+
            |                           ^
            |     CDC (Debezium)        |
            +---------------------------+
                    via Kafka
```

### 2.3 Data Lake vs Data Warehouse

| Aspecto | Data Lake (S3/Delta) | Data Warehouse (BigQuery) |
|---------|---------------------|---------------------------|
| **Proposito** | Armazenar todos dados brutos | Analytics e reporting |
| **Formato** | Parquet, Delta, JSON | Tabelas estruturadas |
| **Schema** | Schema-on-read | Schema-on-write |
| **Usuarios** | Data Engineers, ML | Analistas, Business |
| **Custo** | Baixo (storage) | Medio (query-based) |
| **Governanca** | Catalogo (Glue/Unity) | Nativo |
| **Uso Principal** | Raw data, ML features | Dashboards, Reports |

### 2.4 Decisao de Arquitetura: Lakehouse

```
Escolha: LAKEHOUSE ARCHITECTURE (Delta Lake + BigQuery)

Justificativa:
+-----------------------------------------------------------------------+
| LAKEHOUSE = Data Lake + Data Warehouse combinados                     |
+-----------------------------------------------------------------------+
|                                                                       |
| [Raw Data] --> [Bronze] --> [Silver] --> [Gold] --> [Serving]        |
|     S3         Delta        Delta        Delta      BigQuery          |
|                                                                       |
| Beneficios:                                                           |
| - ACID transactions no Data Lake (Delta Lake)                         |
| - Schema evolution sem downtime                                       |
| - Time travel para compliance/auditoria                               |
| - Unificacao de batch e streaming                                     |
| - Custo otimizado (storage barato + compute sob demanda)              |
+-----------------------------------------------------------------------+
```

### 2.5 Real-time vs Batch Processing

```
+-----------------------------------------------------------------------------------+
|                    ESTRATEGIA DE PROCESSAMENTO                                    |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  REAL-TIME (Streaming)              |  BATCH (Scheduled)                         |
|  Latencia: <5 segundos              |  Latencia: Minutos a horas                 |
|                                     |                                             |
|  Casos de Uso:                      |  Casos de Uso:                             |
|  - Notificacoes de transacao        |  - Relatorios consolidados                 |
|  - Alertas de fraude                |  - ETL para Data Warehouse                 |
|  - Saldo em tempo real              |  - Agregacoes diarias/mensais              |
|  - Controle parental                |  - Reports regulatorios (Bacen)            |
|  - Velocity checks                  |  - Feature engineering para ML             |
|                                     |  - Backup e arquivamento                   |
|                                     |                                             |
|  Stack:                             |  Stack:                                     |
|  - Apache Kafka                     |  - Apache Spark                            |
|  - Kafka Streams / Flink            |  - Airflow (orquestracao)                  |
|  - Redis (cache/state)              |  - dbt (transformacoes)                    |
|                                     |                                             |
+-----------------------------------------------------------------------------------+
```

### 2.6 Event-Driven Architecture

```
+-----------------------------------------------------------------------------------+
|                         EVENT-DRIVEN ARCHITECTURE                                 |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  +-------------+                                                                  |
|  | User Action |                                                                  |
|  | (Transacao) |                                                                  |
|  +------+------+                                                                  |
|         |                                                                         |
|         v                                                                         |
|  +-------------+     +------------------+                                         |
|  | API Service |---->|   Event Bus      |                                         |
|  | (Producer)  |     |   (Kafka)        |                                         |
|  +-------------+     +--------+---------+                                         |
|                               |                                                   |
|         +--------------------+|+--------------------+--------------------+        |
|         |                    ||                     |                    |        |
|         v                    vv                     v                    v        |
|  +-------------+     +-------------+        +-------------+      +-------------+  |
|  | Notification|     | Analytics   |        | Fraud       |      | Compliance  |  |
|  | Service     |     | Pipeline    |        | Detection   |      | Logger      |  |
|  +-------------+     +-------------+        +-------------+      +-------------+  |
|                                                                                   |
+-----------------------------------------------------------------------------------+

Topicos Kafka:
  - transactions.created     (transacao criada)
  - transactions.approved    (transacao aprovada)
  - transactions.declined    (transacao recusada)
  - users.created            (usuario cadastrado)
  - users.updated            (usuario atualizado)
  - buckets.transfer         (transferencia entre baldes)
  - goals.achieved           (meta alcancada)
  - tasks.completed          (tarefa completada)
  - alerts.fraud             (alerta de fraude)
  - compliance.audit         (evento de auditoria)
```

### 2.7 Kafka Topics Design

```yaml
Kafka_Topics:
  naming_convention: "{domain}.{entity}.{action}"

  domains:
    users:
      - users.parent.created
      - users.parent.updated
      - users.child.created
      - users.child.updated
      - users.kyc.completed
      - users.kyc.failed

    transactions:
      - transactions.card.authorized
      - transactions.card.captured
      - transactions.card.declined
      - transactions.pix.sent
      - transactions.pix.received
      - transactions.internal.transfer

    buckets:
      - buckets.balance.updated
      - buckets.transfer.completed
      - buckets.allowance.deposited

    goals:
      - goals.created
      - goals.updated
      - goals.achieved

    tasks:
      - tasks.created
      - tasks.completed
      - tasks.reward.paid

    compliance:
      - compliance.audit.log
      - compliance.pld.alert
      - compliance.lgpd.request

  partitioning:
    strategy: "Por user_id (hash) para garantir ordem por usuario"
    partitions: 12 (escalavel para 48)

  retention:
    default: 7 dias
    compliance: 30 dias
    audit: 90 dias (depois move para S3)
```

---

## 3. Data Model

### 3.1 Entidades Principais (ERD Simplificado)

```
+-----------------------------------------------------------------------------------+
|                              MODELO DE DADOS                                      |
+-----------------------------------------------------------------------------------+

                              +------------------+
                              |     FAMILY       |
                              +------------------+
                              | id (PK)          |
                              | name             |
                              | plan_type        |
                              | created_at       |
                              +--------+---------+
                                       |
                    +------------------+------------------+
                    |                                     |
           +--------v--------+                   +--------v--------+
           |     PARENT      |                   |      CHILD      |
           +-----------------+                   +-----------------+
           | id (PK)         |                   | id (PK)         |
           | family_id (FK)  |                   | family_id (FK)  |
           | cpf_hash        |                   | parent_id (FK)  |
           | email           |                   | name_encrypted  |
           | phone_encrypted |                   | birth_date      |
           | status          |                   | avatar_url      |
           +-----------------+                   | status          |
                    |                            +--------+--------+
                    |                                     |
                    |                            +--------v--------+
                    |                            |     ACCOUNT     |
                    |                            +-----------------+
                    |                            | id (PK)         |
                    +--------------------------->| child_id (FK)   |
                                                 | type            |
                                                 | status          |
                                                 +--------+--------+
                                                          |
                    +-------------------------------------+
                    |                    |                |
           +--------v--------+  +--------v--------+  +----v-----------+
           |     BUCKET      |  |   TRANSACTION   |  |      CARD      |
           +-----------------+  +-----------------+  +-----------------+
           | id (PK)         |  | id (PK)         |  | id (PK)        |
           | account_id (FK) |  | account_id (FK) |  | account_id(FK) |
           | type (ENUM)     |  | bucket_id (FK)  |  | token          |
           | balance         |  | type            |  | last_four      |
           | target_amount   |  | amount          |  | status         |
           | icon            |  | merchant        |  | daily_limit    |
           +-----------------+  | category        |  +-----------------+
                    |           | status          |
                    |           | created_at      |
           +--------v--------+  +-----------------+
           |      GOAL       |           |
           +-----------------+  +--------v--------+
           | id (PK)         |  |   ALLOWANCE     |
           | bucket_id (FK)  |  +-----------------+
           | name            |  | id (PK)         |
           | target_amount   |  | child_id (FK)   |
           | deadline        |  | amount          |
           | status          |  | frequency       |
           +-----------------+  | next_date       |
                               | bucket_split    |
                               +-----------------+

           +-----------------+  +-----------------+
           |      TASK       |  |    DONATION     |
           +-----------------+  +-----------------+
           | id (PK)         |  | id (PK)         |
           | child_id (FK)   |  | child_id (FK)   |
           | parent_id (FK)  |  | ngo_id (FK)     |
           | description     |  | amount          |
           | reward_amount   |  | status          |
           | status          |  | created_at      |
           | due_date        |  +-----------------+
           +-----------------+
```

### 3.2 Schema PostgreSQL Detalhado

```sql
-- ============================================================================
-- SCHEMA: core (Dados principais)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS core;

-- Familias
CREATE TABLE core.families (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    plan_type VARCHAR(20) NOT NULL DEFAULT 'free',  -- free, basic, premium
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_plan_type CHECK (plan_type IN ('free', 'basic', 'premium')),
    CONSTRAINT chk_status CHECK (status IN ('active', 'suspended', 'cancelled'))
);

-- Pais/Responsaveis
CREATE TABLE core.parents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    family_id UUID NOT NULL REFERENCES core.families(id),

    -- PII Criptografado
    cpf_encrypted BYTEA NOT NULL,
    cpf_hash VARCHAR(64) NOT NULL UNIQUE,  -- Para busca
    name_encrypted BYTEA NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_encrypted BYTEA NOT NULL,

    -- Metadados
    role VARCHAR(20) NOT NULL DEFAULT 'primary',  -- primary, secondary
    status VARCHAR(20) NOT NULL DEFAULT 'pending_kyc',
    kyc_status VARCHAR(20) DEFAULT 'pending',
    kyc_completed_at TIMESTAMPTZ,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_login_at TIMESTAMPTZ,

    CONSTRAINT chk_parent_status CHECK (status IN ('pending_kyc', 'active', 'suspended', 'blocked'))
);

CREATE INDEX idx_parents_family ON core.parents(family_id);
CREATE INDEX idx_parents_email ON core.parents(email);
CREATE INDEX idx_parents_cpf_hash ON core.parents(cpf_hash);

-- Filhos
CREATE TABLE core.children (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    family_id UUID NOT NULL REFERENCES core.families(id),
    parent_id UUID NOT NULL REFERENCES core.parents(id),  -- Responsavel principal

    -- PII Criptografado (Dados de menor - CRITICO)
    name_encrypted BYTEA NOT NULL,
    cpf_encrypted BYTEA,  -- Opcional para menores
    cpf_hash VARCHAR(64) UNIQUE,
    birth_date DATE NOT NULL,

    -- Perfil
    avatar_url VARCHAR(500),
    nickname VARCHAR(50),

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'active',

    -- Consentimento LGPD
    consent_version VARCHAR(10) NOT NULL,
    consent_date TIMESTAMPTZ NOT NULL,
    consent_parent_id UUID NOT NULL REFERENCES core.parents(id),

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_child_age CHECK (
        birth_date >= CURRENT_DATE - INTERVAL '17 years' AND
        birth_date <= CURRENT_DATE - INTERVAL '6 years'
    )
);

CREATE INDEX idx_children_family ON core.children(family_id);
CREATE INDEX idx_children_parent ON core.children(parent_id);

-- ============================================================================
-- SCHEMA: financial (Dados financeiros)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS financial;

-- Contas
CREATE TABLE financial.accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES core.children(id),

    -- Identificacao
    account_number VARCHAR(20) NOT NULL UNIQUE,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'active',

    -- Limites
    daily_spend_limit DECIMAL(10,2) NOT NULL DEFAULT 100.00,
    monthly_spend_limit DECIMAL(10,2) NOT NULL DEFAULT 1000.00,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_accounts_child ON financial.accounts(child_id);

-- Baldes (Gastar, Guardar, Doar, Investir)
CREATE TABLE financial.buckets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES financial.accounts(id),

    type VARCHAR(20) NOT NULL,  -- spend, save, donate, invest
    name VARCHAR(50) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,

    -- Configuracao
    icon VARCHAR(50),
    color VARCHAR(7),  -- Hex color
    auto_split_pct DECIMAL(5,2) DEFAULT 0,  -- Percentual do allowance

    -- Status
    is_active BOOLEAN NOT NULL DEFAULT true,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_bucket_type CHECK (type IN ('spend', 'save', 'donate', 'invest')),
    CONSTRAINT chk_balance_positive CHECK (balance >= 0),
    CONSTRAINT chk_auto_split CHECK (auto_split_pct >= 0 AND auto_split_pct <= 100)
);

CREATE INDEX idx_buckets_account ON financial.buckets(account_id);
CREATE UNIQUE INDEX idx_buckets_account_type ON financial.buckets(account_id, type);

-- Transacoes (PARTICIONADA por data)
CREATE TABLE financial.transactions (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL,
    bucket_id UUID NOT NULL,

    -- Tipo e Status
    type VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',

    -- Valores
    amount DECIMAL(12,2) NOT NULL,
    fee DECIMAL(10,2) DEFAULT 0,

    -- Origem/Destino
    counterparty_type VARCHAR(20),  -- merchant, pix, internal, allowance
    counterparty_id VARCHAR(100),   -- Merchant ID, chave PIX, etc.
    counterparty_name VARCHAR(200),

    -- Merchant (para cartao)
    merchant_category_code VARCHAR(4),
    merchant_name VARCHAR(200),
    merchant_city VARCHAR(100),

    -- PIX
    pix_key VARCHAR(100),
    pix_e2e_id VARCHAR(50),

    -- Metadados
    description VARCHAR(500),
    metadata JSONB,

    -- Autorizacao/Approval
    authorization_code VARCHAR(50),
    parent_approval_required BOOLEAN DEFAULT false,
    parent_approved_by UUID,
    parent_approved_at TIMESTAMPTZ,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    processed_at TIMESTAMPTZ,

    PRIMARY KEY (id, created_at),

    CONSTRAINT chk_tx_type CHECK (type IN (
        'card_purchase', 'card_refund',
        'pix_send', 'pix_receive',
        'allowance_credit', 'bucket_transfer',
        'task_reward', 'donation',
        'fee', 'adjustment'
    )),
    CONSTRAINT chk_tx_status CHECK (status IN (
        'pending', 'authorized', 'captured', 'settled',
        'declined', 'reversed', 'refunded', 'cancelled'
    ))
) PARTITION BY RANGE (created_at);

-- Particoes por mes (criar automaticamente via cron)
CREATE TABLE financial.transactions_2026_01 PARTITION OF financial.transactions
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE financial.transactions_2026_02 PARTITION OF financial.transactions
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
-- ... criar particoes futuras automaticamente

-- Indices nas transacoes
CREATE INDEX idx_tx_account ON financial.transactions(account_id, created_at DESC);
CREATE INDEX idx_tx_bucket ON financial.transactions(bucket_id, created_at DESC);
CREATE INDEX idx_tx_status ON financial.transactions(status, created_at DESC);
CREATE INDEX idx_tx_type ON financial.transactions(type, created_at DESC);

-- Mesada (Allowance)
CREATE TABLE financial.allowances (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES core.children(id),
    parent_id UUID NOT NULL REFERENCES core.parents(id),

    -- Configuracao
    amount DECIMAL(10,2) NOT NULL,
    frequency VARCHAR(20) NOT NULL,  -- weekly, biweekly, monthly
    day_of_week INTEGER,  -- 0-6 para weekly
    day_of_month INTEGER, -- 1-31 para monthly

    -- Split entre baldes (JSONB)
    bucket_split JSONB NOT NULL DEFAULT '{"spend": 50, "save": 30, "donate": 10, "invest": 10}',

    -- Status
    is_active BOOLEAN NOT NULL DEFAULT true,
    next_deposit_date DATE NOT NULL,
    last_deposit_date DATE,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_frequency CHECK (frequency IN ('weekly', 'biweekly', 'monthly')),
    CONSTRAINT chk_amount_positive CHECK (amount > 0)
);

-- Cartoes
CREATE TABLE financial.cards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES financial.accounts(id),

    -- Token (nunca armazenar PAN)
    card_token VARCHAR(100) NOT NULL,  -- Token do BaaS
    last_four VARCHAR(4) NOT NULL,
    brand VARCHAR(20) NOT NULL,  -- visa, mastercard

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'active',

    -- Limites
    daily_limit DECIMAL(10,2) NOT NULL DEFAULT 100.00,
    transaction_limit DECIMAL(10,2) NOT NULL DEFAULT 50.00,

    -- Controles parentais
    allowed_categories JSONB,  -- Lista de MCCs permitidos
    blocked_categories JSONB,  -- Lista de MCCs bloqueados
    allowed_merchants JSONB,   -- Lista de merchants permitidos
    blocked_merchants JSONB,   -- Lista de merchants bloqueados

    -- Horarios permitidos
    allowed_hours_start TIME DEFAULT '06:00',
    allowed_hours_end TIME DEFAULT '22:00',

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    activated_at TIMESTAMPTZ,

    CONSTRAINT chk_card_status CHECK (status IN ('pending', 'active', 'blocked', 'cancelled', 'lost'))
);

-- ============================================================================
-- SCHEMA: engagement (Metas, Tarefas, Doacoes)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS engagement;

-- Metas de poupanca
CREATE TABLE engagement.goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bucket_id UUID NOT NULL REFERENCES financial.buckets(id),
    child_id UUID NOT NULL REFERENCES core.children(id),

    -- Definicao
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),

    -- Valores
    target_amount DECIMAL(10,2) NOT NULL,
    current_amount DECIMAL(10,2) NOT NULL DEFAULT 0,

    -- Prazo
    deadline DATE,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    achieved_at TIMESTAMPTZ,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_goal_status CHECK (status IN ('active', 'achieved', 'cancelled'))
);

-- Tarefas
CREATE TABLE engagement.tasks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES core.children(id),
    parent_id UUID NOT NULL REFERENCES core.parents(id),

    -- Definicao
    title VARCHAR(200) NOT NULL,
    description TEXT,

    -- Recompensa
    reward_amount DECIMAL(10,2) NOT NULL,
    reward_bucket_type VARCHAR(20) DEFAULT 'spend',

    -- Recorrencia
    is_recurring BOOLEAN DEFAULT false,
    recurrence_pattern VARCHAR(20),  -- daily, weekly, monthly

    -- Prazo
    due_date TIMESTAMPTZ,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    completed_at TIMESTAMPTZ,
    approved_at TIMESTAMPTZ,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_task_status CHECK (status IN ('pending', 'completed', 'approved', 'rejected', 'expired'))
);

-- ONGs parceiras
CREATE TABLE engagement.ngos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Identificacao
    name VARCHAR(200) NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(500),
    website VARCHAR(255),

    -- Categoria
    category VARCHAR(50),  -- educacao, saude, meio-ambiente, animais

    -- Status
    is_active BOOLEAN NOT NULL DEFAULT true,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Doacoes
CREATE TABLE engagement.donations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    child_id UUID NOT NULL REFERENCES core.children(id),
    ngo_id UUID NOT NULL REFERENCES engagement.ngos(id),
    transaction_id UUID NOT NULL,

    -- Valores
    amount DECIMAL(10,2) NOT NULL,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'pending',

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- ============================================================================
-- SCHEMA: compliance (Auditoria e Regulatorio)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS compliance;

-- Audit Log (APPEND-ONLY, IMUTAVEL)
CREATE TABLE compliance.audit_logs (
    id BIGSERIAL,
    event_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Evento
    event_type VARCHAR(50) NOT NULL,
    event_action VARCHAR(50) NOT NULL,

    -- Ator
    actor_type VARCHAR(20) NOT NULL,  -- user, system, admin
    actor_id UUID,
    actor_ip INET,
    actor_user_agent TEXT,

    -- Recurso
    resource_type VARCHAR(50) NOT NULL,
    resource_id UUID,

    -- Mudancas
    old_values JSONB,
    new_values JSONB,

    -- Contexto
    request_id UUID,
    session_id UUID,

    PRIMARY KEY (id, event_time)
) PARTITION BY RANGE (event_time);

-- Particoes mensais para audit
CREATE TABLE compliance.audit_logs_2026_01 PARTITION OF compliance.audit_logs
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

-- PLD/FT Alertas
CREATE TABLE compliance.pld_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Referencia
    user_id UUID NOT NULL,
    transaction_id UUID,

    -- Alerta
    alert_type VARCHAR(50) NOT NULL,
    risk_score INTEGER NOT NULL,
    description TEXT NOT NULL,

    -- Investigacao
    status VARCHAR(20) NOT NULL DEFAULT 'open',
    assigned_to UUID,
    resolution TEXT,
    resolved_at TIMESTAMPTZ,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_pld_status CHECK (status IN ('open', 'investigating', 'escalated', 'resolved', 'reported'))
);

-- LGPD Requests
CREATE TABLE compliance.lgpd_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Solicitante
    requestor_type VARCHAR(20) NOT NULL,  -- parent, child, authority
    requestor_id UUID NOT NULL,
    subject_id UUID NOT NULL,  -- Titular dos dados

    -- Requisicao
    request_type VARCHAR(30) NOT NULL,
    description TEXT,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'received',
    due_date DATE NOT NULL,

    -- Processamento
    processed_by UUID,
    processed_at TIMESTAMPTZ,
    response TEXT,

    -- Timestamps
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_lgpd_type CHECK (request_type IN (
        'access', 'correction', 'deletion', 'portability',
        'revoke_consent', 'information', 'opposition'
    )),
    CONSTRAINT chk_lgpd_status CHECK (status IN (
        'received', 'in_progress', 'completed', 'rejected', 'extended'
    ))
);
```

### 3.3 Partitioning Strategy

```yaml
Partitioning_Strategy:
  transactions:
    tipo: Range by created_at
    granularidade: Mensal
    particoes_ativas: 3 meses (hot)
    particoes_arquivadas: Move para S3 apos 6 meses

    beneficios:
      - Queries por data sao O(1) em vez de O(n)
      - DROP PARTITION para exclusao rapida
      - Backup/restore granular
      - Vacuuming mais eficiente

    automacao: |
      -- Job Airflow para criar particoes futuras
      -- Executa no dia 15 de cada mes, cria particao para mes+2

  audit_logs:
    tipo: Range by event_time
    granularidade: Mensal
    retencao: 5 anos em storage frio

  usuarios:
    tipo: Nao particionado (volume menor)
    estrategia: Read replicas para escala de leitura
```

### 3.4 Indices Strategy

```sql
-- Indices Compostos para queries frequentes

-- Dashboard do filho: transacoes recentes
CREATE INDEX idx_tx_child_recent ON financial.transactions(account_id, created_at DESC)
    WHERE status IN ('captured', 'settled');

-- Dashboard do pai: todas transacoes dos filhos
CREATE INDEX idx_tx_family ON financial.transactions(account_id, type, created_at DESC);

-- Alertas de fraude: transacoes pendentes/recentes
CREATE INDEX idx_tx_fraud_check ON financial.transactions(status, created_at)
    WHERE status = 'pending';

-- Relatorios Bacen: por periodo e tipo
CREATE INDEX idx_tx_bacen ON financial.transactions(type, created_at)
    INCLUDE (amount, status);

-- Busca por CPF (usando hash)
CREATE INDEX idx_parent_cpf ON core.parents(cpf_hash);

-- Indices parciais para otimizar espaco
CREATE INDEX idx_active_children ON core.children(family_id)
    WHERE status = 'active';

CREATE INDEX idx_active_allowances ON financial.allowances(next_deposit_date)
    WHERE is_active = true;
```

---

## 4. Data Pipeline

### 4.1 Pipeline Architecture

```
+-----------------------------------------------------------------------------------+
|                           DATA PIPELINE ARCHITECTURE                              |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  SOURCES                    INGESTION              PROCESSING         SERVING    |
|                                                                                   |
|  +-----------+             +----------+                                          |
|  | PostgreSQL|---(CDC)---->|  Kafka   |                                          |
|  | (OLTP)    |   Debezium  | Connect  |                                          |
|  +-----------+             +----+-----+                                          |
|                                 |                                                 |
|  +-----------+             +----v-----+           +------------+                 |
|  | BaaS APIs |---(Events)->|  Kafka   |---------->|   Flink    |                 |
|  | (Dock)    |   Webhook   | Topics   |  Stream   | (Real-time)|                 |
|  +-----------+             +----+-----+           +------+-----+                 |
|                                 |                        |                        |
|  +-----------+             +----v-----+           +------v-----+    +----------+ |
|  | App Events|---(SDK)---->| Kafka    |           |   Redis    |--->| APIs     | |
|  | (Mobile)  |   Producer  | Topics   |           | (Cache)    |    | (Backend)| |
|  +-----------+             +----+-----+           +------------+    +----------+ |
|                                 |                                                 |
|                            +----v-----+           +------------+                 |
|                            |   S3     |---------->|   Spark    |                 |
|                            | Raw Zone |   Batch   | (ETL)      |                 |
|                            +----------+           +------+-----+                 |
|                                                          |                        |
|                                                   +------v-----+    +----------+ |
|                                                   | Delta Lake |    | BigQuery | |
|                                                   | Bronze/    |--->| (DW)     | |
|                                                   | Silver/Gold|    +----+-----+ |
|                                                   +------------+         |        |
|                                                                    +-----v----+  |
|                                                                    | Metabase |  |
|                                                                    | (BI)     |  |
|                                                                    +----------+  |
+-----------------------------------------------------------------------------------+
```

### 4.2 CDC (Change Data Capture) com Debezium

```yaml
CDC_Configuration:
  connector: Debezium PostgreSQL Connector
  deployment: Kafka Connect (K8s)

  sources:
    - name: postgres-core
      tables:
        - core.families
        - core.parents
        - core.children
      topic_prefix: "cdc.core"

    - name: postgres-financial
      tables:
        - financial.accounts
        - financial.buckets
        - financial.transactions
        - financial.cards
      topic_prefix: "cdc.financial"

    - name: postgres-engagement
      tables:
        - engagement.goals
        - engagement.tasks
        - engagement.donations
      topic_prefix: "cdc.engagement"

  configuration:
    slot.name: debezium_slot
    publication.name: debezium_publication
    snapshot.mode: initial  # Full snapshot on start
    decimal.handling.mode: precise
    time.precision.mode: adaptive_time_microseconds

  transformations:
    - type: route
      topic.regex: "(.*)"
      topic.replacement: "cdc.$1"
    - type: unwrap
      drop.tombstones: false
    - type: filter
      condition: "op != 'd' OR __deleted == true"
```

### 4.3 ETL/ELT Flows

```
+-----------------------------------------------------------------------------------+
|                              ETL/ELT DATA FLOWS                                   |
+-----------------------------------------------------------------------------------+

FLOW 1: Transacoes para Analytics (Near Real-time)
+----------------------------------------------------------------------------+
|                                                                            |
|  [PostgreSQL] --CDC--> [Kafka] --Flink--> [Delta Bronze] --Spark--> [Gold] |
|       |                   |                    |                      |    |
|    Source              Stream              Landing               Aggregated|
|   (5 sec)            Processing            (Raw)                  (Curated)|
|                       (30 sec)           (1 min)                  (5 min)  |
+----------------------------------------------------------------------------+

FLOW 2: Relatorios Regulatorios (Batch)
+----------------------------------------------------------------------------+
|                                                                            |
|  [Delta Gold] --Spark--> [Staging] --dbt--> [BigQuery] --Exports--> [Bacen]|
|       |                      |                   |                    |    |
|    Source               Transform            Load                  Report  |
|   (Daily)               (2 hours)          (30 min)               (Daily)  |
+----------------------------------------------------------------------------+

FLOW 3: Feature Store para ML (Batch + Stream)
+----------------------------------------------------------------------------+
|                                                                            |
|  [Delta Silver] --Spark--> [Features] --Feast--> [Redis] --ML--> [Scoring]|
|        |                       |                    |               |      |
|    Historical              Compute              Online            Real-    |
|    Features               Features              Store             time     |
|    (Daily)                (Hourly)            (Cached)           Inference |
+----------------------------------------------------------------------------+
```

### 4.4 Airflow DAG Structure

```python
# Estrutura de DAGs Airflow

dags/
  |-- data_ingestion/
  |     |-- dag_cdc_health_check.py       # Monitora saude do CDC
  |     |-- dag_api_ingestion.py          # Ingere dados de APIs externas
  |
  |-- data_processing/
  |     |-- dag_bronze_to_silver.py       # Limpeza e validacao
  |     |-- dag_silver_to_gold.py         # Agregacoes e metricas
  |     |-- dag_partition_management.py   # Cria/arquiva particoes
  |
  |-- data_quality/
  |     |-- dag_great_expectations.py     # Testes de qualidade
  |     |-- dag_anomaly_detection.py      # Detecta anomalias
  |
  |-- analytics/
  |     |-- dag_daily_metrics.py          # KPIs diarios
  |     |-- dag_weekly_reports.py         # Relatorios semanais
  |     |-- dag_monthly_cohorts.py        # Analise de cohort
  |
  |-- compliance/
  |     |-- dag_bacen_reports.py          # Relatorios Bacen
  |     |-- dag_pld_screening.py          # Screening PLD/FT
  |     |-- dag_data_retention.py         # Aplica politicas de retencao
  |     |-- dag_lgpd_requests.py          # Processa requests LGPD
  |
  |-- ml/
        |-- dag_feature_engineering.py    # Gera features
        |-- dag_model_training.py         # Treina modelos
        |-- dag_model_validation.py       # Valida modelos
```

### 4.5 DAG Exemplo: Bronze to Silver

```python
# dag_bronze_to_silver.py

from airflow import DAG
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator
from airflow.providers.slack.operators.slack_webhook import SlackWebhookOperator
from airflow.sensors.external_task import ExternalTaskSensor
from datetime import datetime, timedelta

default_args = {
    'owner': 'data-engineering',
    'depends_on_past': True,
    'email': ['data-alerts@empresa.com.br'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'execution_timeout': timedelta(hours=2),
}

with DAG(
    'bronze_to_silver',
    default_args=default_args,
    description='Process raw data from Bronze to Silver layer',
    schedule_interval='*/15 * * * *',  # A cada 15 minutos
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=['data-processing', 'bronze', 'silver'],
) as dag:

    # Processa transacoes
    process_transactions = SparkSubmitOperator(
        task_id='process_transactions',
        application='s3://spark-jobs/bronze_to_silver/transactions.py',
        conn_id='spark_default',
        conf={
            'spark.sql.shuffle.partitions': '200',
            'spark.dynamicAllocation.enabled': 'true',
        },
        application_args=[
            '--source', 's3://data-lake/bronze/transactions/',
            '--target', 's3://data-lake/silver/transactions/',
            '--date', '{{ ds }}',
        ],
    )

    # Processa usuarios
    process_users = SparkSubmitOperator(
        task_id='process_users',
        application='s3://spark-jobs/bronze_to_silver/users.py',
        conn_id='spark_default',
        application_args=[
            '--source', 's3://data-lake/bronze/users/',
            '--target', 's3://data-lake/silver/users/',
            '--date', '{{ ds }}',
        ],
    )

    # Quality checks
    quality_check = SparkSubmitOperator(
        task_id='quality_check',
        application='s3://spark-jobs/quality/silver_quality_check.py',
        conn_id='spark_default',
        application_args=[
            '--layer', 'silver',
            '--date', '{{ ds }}',
        ],
    )

    # Notifica sucesso
    notify_success = SlackWebhookOperator(
        task_id='notify_success',
        http_conn_id='slack_webhook',
        message=':white_check_mark: Bronze to Silver completed for {{ ds }}',
        channel='#data-alerts',
    )

    [process_transactions, process_users] >> quality_check >> notify_success
```

### 4.6 Data Quality Checks

```yaml
Data_Quality_Framework:
  tool: Great Expectations + dbt tests

  checks_por_camada:
    bronze:
      - schema_match: Verifica schema esperado
      - not_null: Campos obrigatorios preenchidos
      - freshness: Dados nao podem ter mais de 1 hora

    silver:
      - uniqueness: PKs sao unicas
      - referential_integrity: FKs existem
      - value_range: Valores dentro do esperado
      - business_rules: Regras de negocio validas

    gold:
      - aggregation_consistency: Soma bate com detalhes
      - trend_analysis: Sem anomalias estatisticas
      - completeness: Todas dimensoes populadas

  expectations_examples:
    transactions:
      - expect_column_values_to_not_be_null:
          column: id
      - expect_column_values_to_be_between:
          column: amount
          min_value: 0.01
          max_value: 50000.00
      - expect_column_values_to_be_in_set:
          column: status
          value_set: [pending, authorized, captured, settled, declined]
      - expect_column_pair_values_A_to_be_greater_than_B:
          column_A: processed_at
          column_B: created_at
          or_equal: true

  alerting:
    critical_failure: PagerDuty + Slack
    warning: Slack only
    info: Dashboard only
```

### 4.7 Lineage Tracking

```
+-----------------------------------------------------------------------------------+
|                              DATA LINEAGE                                         |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  Tool: Apache Atlas / OpenMetadata / DataHub                                     |
|                                                                                   |
|  Exemplo de Lineage:                                                              |
|                                                                                   |
|  [PostgreSQL.financial.transactions]                                             |
|           |                                                                       |
|           v                                                                       |
|  [Kafka.cdc.financial.transactions]                                              |
|           |                                                                       |
|           +------------------+                                                    |
|           |                  |                                                    |
|           v                  v                                                    |
|  [S3.bronze.transactions]  [Flink.realtime_aggregations]                         |
|           |                  |                                                    |
|           v                  v                                                    |
|  [S3.silver.transactions]  [Redis.balance_cache]                                 |
|           |                                                                       |
|           v                                                                       |
|  [S3.gold.daily_transactions]                                                    |
|           |                                                                       |
|           +------------------+------------------+                                 |
|           |                  |                  |                                 |
|           v                  v                  v                                 |
|  [BigQuery.transactions]  [BigQuery.kpis]  [Bacen.reports]                       |
|           |                  |                                                    |
|           v                  v                                                    |
|  [Metabase.dashboards]    [ML.feature_store]                                     |
|                                                                                   |
+-----------------------------------------------------------------------------------+
```

---

## 5. Analytics & BI

### 5.1 KPIs e Metricas de Negocio

```yaml
KPIs_Hierarquia:

  # NIVEL 1: North Star Metrics
  north_star:
    - name: Monthly Active Families (MAF)
      formula: "COUNT(DISTINCT family_id WHERE has_transaction_last_30_days)"
      target: 50K Y1, 200K Y2, 500K Y3

    - name: Allowance Engagement Rate
      formula: "families_using_allowance / total_active_families"
      target: ">70%"

    - name: Financial Education Score
      formula: "Composite score baseado em uso dos 4 baldes"
      target: ">75/100"

  # NIVEL 2: Metricas de Produto
  produto:
    acquisition:
      - name: New Family Signups
        granularity: daily, weekly, monthly
      - name: KYC Completion Rate
        formula: "kyc_completed / signups"
      - name: Time to First Transaction
        formula: "AVG(first_transaction_date - signup_date)"

    activation:
      - name: Card Activation Rate
        formula: "cards_activated / cards_issued"
      - name: First Allowance Setup Rate
      - name: First Purchase Rate (Child)

    retention:
      - name: D7/D30/D90 Retention
      - name: Monthly Churn Rate
      - name: Allowance Continuity Rate
        formula: "families_with_3_consecutive_allowances / total"

    engagement:
      - name: Transactions per Child per Month
      - name: Goals Created per Child
      - name: Tasks Completed per Month
      - name: Bucket Transfer Frequency

    revenue:
      - name: ARPU (Average Revenue Per User)
      - name: Plan Conversion Rate (Free to Paid)
      - name: Transaction Volume (TPV)
      - name: Interchange Revenue

  # NIVEL 3: Metricas Operacionais
  operacionais:
    transacoes:
      - Authorization Success Rate
      - Decline Rate by Reason
      - Fraud Rate
      - Chargeback Rate

    performance:
      - API Latency P50/P95/P99
      - Transaction Processing Time
      - Notification Delivery Time

    suporte:
      - Ticket Volume
      - First Response Time
      - Resolution Time
      - CSAT Score
```

### 5.2 Dashboard Structure

```
+-----------------------------------------------------------------------------------+
|                           DASHBOARD HIERARCHY                                     |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  EXECUTIVE DASHBOARD (CEO/Board)                                                 |
|  +-----------------------------------------------------------------------+       |
|  | - MAF Growth      - Revenue Trend    - Unit Economics                 |       |
|  | - Burn Rate       - Runway           - Key Milestones                 |       |
|  +-----------------------------------------------------------------------+       |
|                                     |                                             |
|         +---------------------------+---------------------------+                 |
|         |                           |                           |                 |
|         v                           v                           v                 |
|  PRODUCT DASHBOARD           FINANCE DASHBOARD           OPS DASHBOARD           |
|  +-------------------+      +-------------------+      +-------------------+      |
|  | - Signups/Day     |      | - TPV             |      | - Uptime          |      |
|  | - Activation      |      | - Revenue         |      | - Error Rate      |      |
|  | - Retention       |      | - Cost per Tx     |      | - Latency         |      |
|  | - Feature Usage   |      | - Fraud Losses    |      | - Incidents       |      |
|  | - NPS             |      | - Chargebacks     |      | - Queue Depth     |      |
|  +-------------------+      +-------------------+      +-------------------+      |
|         |                           |                           |                 |
|         v                           v                           v                 |
|  GROWTH DASHBOARD            RISK DASHBOARD            SUPPORT DASHBOARD         |
|  +-------------------+      +-------------------+      +-------------------+      |
|  | - CAC/LTV         |      | - Fraud Alerts    |      | - Ticket Volume   |      |
|  | - Channel Perf    |      | - PLD Alerts      |      | - CSAT            |      |
|  | - Cohort Analysis |      | - Risk Scores     |      | - Response Time   |      |
|  | - Funnel          |      | - Compliance      |      | - Top Issues      |      |
|  +-------------------+      +-------------------+      +-------------------+      |
|                                                                                   |
+-----------------------------------------------------------------------------------+
```

### 5.3 Dashboard Specifications

```yaml
Dashboards:

  executive_dashboard:
    refresh: Hourly
    access: C-Level, Board
    metrics:
      - MAF with trend
      - MRR/ARR
      - Growth Rate (MoM, YoY)
      - Cash Position
      - Key Milestones Progress
    visualizations:
      - KPI cards with sparklines
      - Trend charts (6 months)
      - Geographic heat map
      - Cohort retention matrix

  product_dashboard:
    refresh: Real-time (5 min)
    access: Product Team
    metrics:
      - Daily Active Users
      - Feature Adoption Matrix
      - Funnel Conversion
      - Session Duration
      - Error Rate by Feature
    visualizations:
      - Funnel chart
      - Feature matrix heatmap
      - Time series with annotations
      - A/B test results

  operations_dashboard:
    refresh: Real-time (1 min)
    access: Engineering, Ops
    metrics:
      - API Health Status
      - Error Rate by Endpoint
      - Latency Percentiles
      - Queue Depth
      - Database Connections
    visualizations:
      - Status grid
      - Latency histogram
      - Error breakdown pie
      - Infrastructure topology

  finance_dashboard:
    refresh: Hourly
    access: Finance Team
    metrics:
      - Daily TPV
      - Revenue by Stream
      - Fraud/Chargeback Rate
      - Cost per Transaction
      - Interchange Revenue
    visualizations:
      - Revenue waterfall
      - Cost breakdown
      - Fraud trend
      - Reconciliation status
```

### 5.4 Self-Service Analytics

```yaml
Self_Service_Strategy:

  tool_stack:
    exploration: Metabase (primary)
    advanced: Jupyter Notebooks (data team)
    spreadsheets: Google Sheets (with BigQuery connector)

  data_access_tiers:
    tier_1_public:
      access: All employees
      data: Aggregated metrics, no PII
      examples:
        - Daily transaction counts
        - Feature usage %
        - Error rates

    tier_2_team:
      access: Specific teams (approved)
      data: Team-relevant granular data
      examples:
        - Transaction details (masked PII)
        - User segments
        - Cohort data

    tier_3_restricted:
      access: Data team + approved analysts
      data: Full access with audit
      examples:
        - Raw event data
        - PII (for specific use cases)
        - Financial details

  semantic_layer:
    tool: dbt Metrics Layer
    purpose: Single source of truth for metric definitions
    governance: Data team owns definitions, business approves

  training:
    - SQL Basics for Business (quarterly)
    - Metabase Power User (monthly)
    - Data Ethics & Privacy (mandatory)
```

### 5.5 BI Tools Comparison

| Criterio | Metabase | Looker | Tableau | Escolha |
|----------|----------|--------|---------|---------|
| **Custo** | Open Source | $$$$ | $$$ | Metabase |
| **Facilidade** | Alta | Media | Media | Metabase |
| **Embedding** | Bom | Excelente | Bom | Looker |
| **Governanca** | Basica | Excelente | Boa | Looker |
| **Scale** | Milhares users | Enterprise | Enterprise | - |
| **Setup** | Rapido | Semanas | Semanas | Metabase |

**Recomendacao**: Comecar com **Metabase** (custo zero, setup rapido), migrar para **Looker** quando scale justificar ($500K+ ARR).

---

## 6. Machine Learning

### 6.1 ML Use Cases

```yaml
ML_Use_Cases:

  # PRIORIDADE 1: Fraude e Seguranca
  fraud_detection:
    descricao: Detectar transacoes fraudulentas em tempo real
    tipo: Classification (Binary)
    latencia: <100ms
    features:
      - Device fingerprint
      - Transaction velocity
      - Merchant risk score
      - Geographic anomaly
      - Behavioral baseline deviation
    modelo: XGBoost + Neural Network ensemble
    metricas:
      - Precision: >95%
      - Recall: >80%
      - False Positive Rate: <1%
    impacto: Reducao de fraude em 70%

  # PRIORIDADE 2: Churn Prediction
  churn_prediction:
    descricao: Prever familias em risco de cancelamento
    tipo: Classification (Binary)
    latencia: Batch (daily)
    features:
      - Days since last transaction
      - Allowance consistency
      - App engagement metrics
      - Support ticket history
      - Feature adoption score
    modelo: Random Forest + Logistic Regression
    metricas:
      - AUC-ROC: >0.85
      - Precision@10%: >60%
    impacto: Reducao de churn em 20%

  # PRIORIDADE 3: Recomendacoes
  spending_recommendations:
    descricao: Sugerir categorias de gastos para educacao financeira
    tipo: Recommendation
    latencia: <500ms
    features:
      - Spending history by category
      - Age-appropriate categories
      - Goals set
      - Bucket distribution
    modelo: Collaborative Filtering + Content-Based
    metricas:
      - CTR: >5%
      - Engagement lift: >15%
    impacto: Aumento de engagement em 25%

  # PRIORIDADE 4: Anomaly Detection
  behavioral_anomaly:
    descricao: Detectar mudancas de comportamento suspeitas
    tipo: Anomaly Detection
    latencia: Near real-time (1 min)
    features:
      - Login patterns
      - Device changes
      - Transaction patterns
      - Navigation patterns
    modelo: Isolation Forest + Autoencoder
    metricas:
      - Anomaly detection rate: >90%
      - False positive rate: <5%
    impacto: Account takeover prevention

  # PRIORIDADE 5: Personalizacao
  goal_amount_suggestion:
    descricao: Sugerir valores de meta baseado em capacidade
    tipo: Regression
    latencia: <200ms
    features:
      - Average allowance
      - Spending patterns
      - Saving rate
      - Goal history
    modelo: Gradient Boosting
    metricas:
      - MAE: <R$20
      - Goal completion rate lift: >10%
```

### 6.2 Feature Store Architecture

```
+-----------------------------------------------------------------------------------+
|                            FEATURE STORE (Feast)                                  |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  OFFLINE STORE                              ONLINE STORE                          |
|  (BigQuery/Delta Lake)                      (Redis)                               |
|                                                                                   |
|  +-------------------------+                +-------------------------+           |
|  | Historical Features     |                | Real-time Features      |           |
|  | - Transaction history   |                | - Current balance       |           |
|  | - Aggregations          |   Materialize  | - Recent tx count       |           |
|  | - User profiles         | -------------> | - Session metrics       |           |
|  | - Behavioral patterns   |   (Scheduled)  | - Device fingerprint    |           |
|  +-------------------------+                +-------------------------+           |
|           |                                          |                            |
|           v                                          v                            |
|  +-------------------------+                +-------------------------+           |
|  | Training Pipeline       |                | Inference Pipeline      |           |
|  | (Batch)                 |                | (Real-time)             |           |
|  +-------------------------+                +-------------------------+           |
|                                                                                   |
+-----------------------------------------------------------------------------------+

Feature Groups:

  user_features:
    - user_id (entity)
    - account_age_days
    - total_transactions_count
    - avg_transaction_amount_30d
    - allowance_amount
    - goals_count
    - tasks_completed_count

  transaction_features:
    - transaction_id (entity)
    - amount
    - merchant_category
    - merchant_risk_score
    - hour_of_day
    - day_of_week
    - is_weekend
    - distance_from_last_tx

  device_features:
    - device_id (entity)
    - device_type
    - os_version
    - app_version
    - is_rooted
    - trust_score

  behavioral_features:
    - user_id (entity)
    - avg_session_duration_7d
    - login_frequency_7d
    - typical_login_hour
    - typical_transaction_amount
    - category_preferences (vector)
```

### 6.3 Model Serving Architecture

```
+-----------------------------------------------------------------------------------+
|                          MODEL SERVING ARCHITECTURE                               |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  +-------------+     +------------------+     +------------------+                |
|  | API Request |---->|   API Gateway    |---->|  Feature Fetch   |                |
|  | (Tx Auth)   |     |   (Kong)         |     |  (Redis/Feast)   |                |
|  +-------------+     +------------------+     +--------+---------+                |
|                                                        |                          |
|                                               +--------v---------+                |
|                                               |   ML Service     |                |
|                                               |   (FastAPI)      |                |
|                                               +--------+---------+                |
|                                                        |                          |
|                          +-----------------------------+--------------------+     |
|                          |                             |                    |     |
|                   +------v------+              +-------v------+     +-------v----+|
|                   | Fraud Model |              | Churn Model  |     | Recommend  ||
|                   | (XGBoost)   |              | (RF)         |     | (ALS)      ||
|                   | Latency:<50ms              | Batch        |     | <200ms     ||
|                   +------+------+              +--------------+     +------------+|
|                          |                                                        |
|                   +------v------+                                                 |
|                   |   Decision  |                                                 |
|                   |   Engine    |                                                 |
|                   +------+------+                                                 |
|                          |                                                        |
|                   +------v------+                                                 |
|                   |  Response   |  -> Approve/Decline/Review                     |
|                   +-------------+                                                 |
|                                                                                   |
+-----------------------------------------------------------------------------------+
```

### 6.4 MLOps Pipeline

```yaml
MLOps_Pipeline:

  experiment_tracking:
    tool: MLflow
    metrics_logged:
      - Training metrics (AUC, F1, etc.)
      - Feature importance
      - Model parameters
      - Training data version

  model_registry:
    tool: MLflow Model Registry
    stages:
      - Development (dev experiments)
      - Staging (validated, testing)
      - Production (live)
      - Archived (deprecated)

  training_pipeline:
    orchestration: Airflow
    compute: Databricks / SageMaker
    frequency:
      fraud_model: Weekly
      churn_model: Monthly
      recommendation: Daily (incremental)

  validation:
    steps:
      - Data quality check
      - Feature drift detection
      - Model performance comparison
      - A/B test results analysis
    gates:
      - AUC improvement > 1% or stable
      - No significant feature drift
      - Latency within SLA

  deployment:
    strategy: Blue/Green with canary
    canary_percentage: 5%
    canary_duration: 24 hours
    rollback: Automatic if metrics degrade

  monitoring:
    tool: Evidently AI
    metrics:
      - Prediction distribution
      - Feature drift
      - Model performance decay
      - Latency percentiles
    alerts:
      - Performance drop > 5%
      - Feature drift detected
      - Latency SLA breach
```

---

## 7. Compliance & Auditoria

### 7.1 Audit Logs Design

```yaml
Audit_Log_Architecture:

  principios:
    - IMUTABILIDADE: Logs nunca podem ser alterados ou deletados
    - COMPLETUDE: Toda acao relevante e logada
    - RASTREABILIDADE: Quem, quando, o que, de onde
    - RETENCAO: 5+ anos conforme regulacao

  eventos_auditados:
    autenticacao:
      - login_success
      - login_failure
      - logout
      - mfa_challenge
      - password_change
      - session_expired

    dados_usuario:
      - user_created
      - user_updated
      - user_deleted
      - pii_accessed
      - pii_exported

    transacoes:
      - transaction_created
      - transaction_authorized
      - transaction_declined
      - transaction_reversed

    configuracoes:
      - limit_changed
      - card_blocked
      - allowance_configured
      - parental_control_updated

    administrativo:
      - admin_access
      - config_changed
      - permission_granted
      - permission_revoked

  schema:
    ```sql
    CREATE TABLE compliance.audit_logs (
        id BIGSERIAL,
        event_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),

        -- Evento
        event_type VARCHAR(50) NOT NULL,
        event_action VARCHAR(50) NOT NULL,
        event_outcome VARCHAR(20) NOT NULL,  -- success, failure, error

        -- Ator (quem fez)
        actor_type VARCHAR(20) NOT NULL,  -- user, system, admin, api
        actor_id UUID,
        actor_email VARCHAR(255),
        actor_ip INET,
        actor_user_agent TEXT,
        actor_device_id VARCHAR(100),

        -- Recurso (o que foi afetado)
        resource_type VARCHAR(50) NOT NULL,
        resource_id UUID,
        resource_name VARCHAR(200),

        -- Mudancas
        old_values JSONB,
        new_values JSONB,

        -- Contexto
        request_id UUID NOT NULL,
        session_id UUID,
        correlation_id UUID,

        -- Metadados
        metadata JSONB,

        -- Compliance tags
        pii_involved BOOLEAN DEFAULT false,
        minor_data_involved BOOLEAN DEFAULT false,

        PRIMARY KEY (id, event_time)
    ) PARTITION BY RANGE (event_time);
    ```

  storage_tiers:
    hot: 90 dias em PostgreSQL
    warm: 1 ano em S3 (Parquet comprimido)
    cold: 5+ anos em S3 Glacier

  imutabilidade:
    - Write-Once policy no S3
    - Database triggers previnem UPDATE/DELETE
    - Hash chain para detectar tampering
```

### 7.2 Data Retention Policies

```yaml
Data_Retention:

  por_categoria:

    dados_cadastrais:
      descricao: Nome, email, telefone, endereco
      retencao_ativa: Enquanto conta ativa
      retencao_apos_encerramento: 5 anos
      base_legal: Obrigacao legal (Bacen, Receita)
      acao_pos_retencao: Anonimizacao

    dados_menores:
      descricao: Dados de criancas/adolescentes
      retencao_ativa: Enquanto conta ativa
      retencao_apos_encerramento: 5 anos
      base_legal: LGPD Art. 14 + obrigacao legal
      acao_pos_retencao: Exclusao definitiva
      tratamento_especial: Criptografia adicional, acesso restrito

    dados_transacionais:
      descricao: Historico de transacoes
      retencao: 10 anos
      base_legal: Bacen, Lei 9.613/98 (PLD)
      acao_pos_retencao: Agregacao estatistica

    documentos_kyc:
      descricao: RG, CNH, selfie, comprovantes
      retencao_apos_encerramento: 5 anos
      base_legal: Circular 3.978 Bacen (PLD/FT)
      acao_pos_retencao: Exclusao definitiva

    logs_auditoria:
      descricao: Audit trail completo
      retencao: 5 anos (minimo)
      base_legal: PCI-DSS, LGPD, Bacen
      acao_pos_retencao: Arquivamento permanente (anonimizado)

    logs_aplicacao:
      descricao: Logs tecnicos
      retencao: 1 ano
      base_legal: Operacional
      acao_pos_retencao: Exclusao

    dados_analytics:
      descricao: Metricas agregadas
      retencao: Indefinida
      base_legal: Legitimo interesse
      requisito: Deve ser anonimizado

  automacao:
    ferramenta: Airflow DAG
    frequencia: Diaria
    processo:
      1. Identificar dados com retencao expirada
      2. Verificar se ha hold legal
      3. Aplicar acao (anonimizar/excluir)
      4. Registrar em audit log
      5. Gerar relatorio de compliance
```

### 7.3 PII Handling

```yaml
PII_Classification:

  categorias:
    pii_critico:
      campos: [cpf, rg, biometria_facial, dados_cartao]
      tratamento:
        - Criptografia AES-256 em repouso
        - Tokenizacao para dados de cartao
        - Acesso via vault (HashiCorp)
        - Logging de todo acesso
        - Retencao minima necessaria

    pii_sensivel:
      campos: [nome_completo, endereco, telefone, email]
      tratamento:
        - Criptografia em repouso
        - Mascaramento em logs
        - Acesso controlado por role

    pii_menor:
      campos: [nome_crianca, foto_crianca, dados_educacionais]
      tratamento:
        - Criptografia com chave separada
        - Acesso apenas com justificativa
        - Audit log obrigatorio
        - Consentimento parental verificado

  mascaramento:
    regras:
      cpf: "***.***.XXX-XX"  # Mostra ultimos 5
      telefone: "(**) ****-XXXX"  # Mostra ultimos 4
      email: "j***@g***.com"  # Preserva dominio parcial
      cartao: "**** **** **** 1234"
      nome_filho: "Primeiro nome apenas" (para terceiros)

    aplicacao:
      - Logs de aplicacao
      - Exports de dados
      - Dashboards (exceto tier restrito)
      - Comunicacoes internas
```

### 7.4 Right to be Forgotten (LGPD)

```yaml
RTBF_Process:

  fluxo:
    1_solicitacao:
      canais: [app, email, telefone]
      dados_necessarios:
        - Identificacao do solicitante
        - Comprovacao de titularidade
        - Escopo da solicitacao
      prazo_resposta: 15 dias

    2_verificacao:
      checks:
        - Solicitante e titular ou responsavel legal
        - Conta nao tem pendencias financeiras
        - Nao ha investigacao em andamento
        - Dados nao estao em hold legal

    3_analise:
      classificacao_dados:
        deletaveis: [marketing, preferencias, analytics]
        anonimizaveis: [transacoes historicas]
        retidos: [compliance, legal, fiscal]
      comunicacao: Informar ao titular o que sera feito

    4_execucao:
      sistemas:
        - PostgreSQL: DELETE/UPDATE para anonimizar
        - Data Lake: Marca como excluido, purge em batch
        - Backups: Marca para exclusao no proximo ciclo
        - Logs: Mantem anonimizado (compliance)
        - Cache: Invalidacao imediata

    5_confirmacao:
      registro: Audit log da exclusao
      comunicacao: Email de confirmacao ao titular
      certificado: Gerar certificado de exclusao

  automacao:
    dag_lgpd_deletion:
      trigger: Request approved
      steps:
        - Snapshot pre-exclusao (compliance)
        - Executar exclusao em todos sistemas
        - Verificar completude
        - Gerar relatorio
        - Notificar DPO
```

### 7.5 Relatorios Regulatorios (Bacen)

```yaml
Bacen_Reports:

  relatorios_obrigatorios:

    demonstrativo_movimentacao:
      frequencia: Mensal
      prazo: Ate dia 15 do mes seguinte
      conteudo:
        - Volume de transacoes
        - Valor total movimentado
        - Quantidade de contas ativas
        - Saldo total em custod
      formato: XML (layout Bacen)

    relatorio_pld:
      frequencia: Mensal + sob demanda
      prazo: Ate dia 10 do mes seguinte
      conteudo:
        - Comunicacoes de operacoes suspeitas
        - Analises de PEP
        - Alertas gerados
      sistema: SISCOAF

    cadastro_clientes:
      frequencia: Diaria
      conteudo:
        - Novos clientes (KYC)
        - Atualizacoes cadastrais
        - Encerramentos
      formato: API Bacen

    cartoes_pre_pagos:
      frequencia: Mensal
      conteudo:
        - Cartoes emitidos
        - Volume de carga
        - Transacoes por tipo
        - Fraudes identificadas

  pipeline:
    dag_bacen_reports:
      schedule: "0 6 1-15 * *"  # Dias 1-15, 6h
      steps:
        1. Extrair dados do periodo
        2. Aplicar regras de agregacao
        3. Validar contra schema Bacen
        4. Gerar arquivo no formato exigido
        5. Submeter via API/upload
        6. Arquivar comprovante
        7. Notificar compliance team
```

---

## 8. Data Security

### 8.1 Encryption Strategy

```yaml
Encryption:

  at_rest:
    database:
      tipo: Transparent Data Encryption (TDE)
      algoritmo: AES-256
      gerenciamento_chaves: AWS KMS / Azure Key Vault
      rotacao: Automatica a cada 90 dias

    campos_sensiveis:
      tipo: Application-level encryption
      algoritmo: AES-256-GCM
      chaves: Separadas por tenant (family_id)
      campos: [cpf, telefone, nome_completo, endereco]

    data_lake:
      tipo: Server-side encryption
      algoritmo: AES-256 (SSE-S3 com KMS)

    backups:
      tipo: Encryption at rest
      chave: Separada da producao

  in_transit:
    external:
      protocolo: TLS 1.3
      cipher_suites:
        - TLS_AES_256_GCM_SHA384
        - TLS_CHACHA20_POLY1305_SHA256
      certificate_pinning: Obrigatorio no mobile

    internal:
      protocolo: mTLS entre servicos
      certificados: Gerenciados por cert-manager (K8s)
      rotacao: Automatica (90 dias)

    database:
      conexoes: SSL obrigatorio
      verificacao: Full certificate validation

  key_management:
    provider: AWS KMS (primary), HashiCorp Vault (secrets)
    hierarquia:
      master_key: KMS managed (nunca exportada)
      data_keys: Geradas por entidade/tenant
      ephemeral_keys: Para sessoes temporarias
    auditoria: CloudTrail para todas operacoes de chave
```

### 8.2 Access Control (RBAC)

```yaml
RBAC_Model:

  roles:
    # Roles de Produto (Usuarios)
    parent_primary:
      descricao: Responsavel principal da familia
      permissoes:
        - Gerenciar todos filhos
        - Configurar allowances
        - Ver todas transacoes
        - Definir controles parentais
        - Solicitar exclusao de dados

    parent_secondary:
      descricao: Segundo responsavel
      permissoes:
        - Ver transacoes dos filhos
        - Aprovar tarefas
        - Ver configuracoes (read-only)

    child:
      descricao: Menor de idade
      permissoes:
        - Ver proprio saldo e transacoes
        - Criar metas
        - Realizar transacoes (com limites)
        - Nao pode alterar configuracoes

    # Roles Internas (Funcionarios)
    support_l1:
      descricao: Suporte nivel 1
      permissoes:
        - Ver dados mascarados
        - Consultar status de conta
        - Registrar tickets
      dados_sensiveis: Nao

    support_l2:
      descricao: Suporte nivel 2
      permissoes:
        - Ver dados parciais (com aprovacao)
        - Bloquear/desbloquear contas
        - Reverter transacoes
      dados_sensiveis: Limitado (audit obrigatorio)

    compliance_analyst:
      descricao: Analista de compliance
      permissoes:
        - Ver todos dados para investigacao
        - Gerar relatorios regulatorios
        - Marcar contas para review
      dados_sensiveis: Sim (audit completo)

    data_engineer:
      descricao: Engenheiro de dados
      permissoes:
        - Acesso a Data Lake (dados anonimizados)
        - Executar pipelines
        - Criar dashboards
      dados_sensiveis: Apenas agregados/anonimizados

    admin:
      descricao: Administrador de sistema
      permissoes:
        - Gerenciar roles e permissoes
        - Acesso a infraestrutura
        - Audit logs
      dados_sensiveis: Configuracao, nao dados de cliente

  implementacao:
    ferramenta: Casbin / Open Policy Agent (OPA)
    integracao: JWT claims + policy evaluation
    cache: Redis (5 min TTL)
    auditoria: Toda verificacao de permissao logada
```

### 8.3 Data Masking

```yaml
Data_Masking:

  dinamico:
    descricao: Mascaramento em tempo de query
    ferramenta: PostgreSQL Row Level Security + Views

    exemplo:
      ```sql
      -- View com mascaramento dinamico
      CREATE VIEW vw_users_masked AS
      SELECT
        id,
        CASE
          WHEN current_user_role() IN ('admin', 'compliance')
          THEN decrypt_pii(cpf_encrypted)
          ELSE '***.***.XXX-XX'
        END as cpf,
        CASE
          WHEN current_user_role() IN ('admin', 'compliance', 'support_l2')
          THEN decrypt_pii(name_encrypted)
          ELSE split_part(decrypt_pii(name_encrypted), ' ', 1) || ' ***'
        END as name,
        email,  -- Sempre visivel
        created_at
      FROM users;
      ```

  estatico:
    descricao: Dados anonimizados para ambientes nao-prod
    ferramenta: Custom script + Faker

    regras:
      cpf: Gerar CPF valido aleatorio
      nome: Gerar nome ficticio
      email: usuario_HASH@test.local
      telefone: +55 11 99999-XXXX
      endereco: Endereco ficticio
      transacoes: Manter valores, anonimizar merchant

    processo:
      1. Dump sanitizado do banco producao
      2. Aplicar transformacoes de masking
      3. Validar que nenhum PII real permanece
      4. Carregar em ambiente staging/dev

    frequencia: Semanal (refresh de staging)

  logs:
    regras:
      - Nunca logar PII em plain text
      - Usar placeholders: "User {user_id} updated profile"
      - Mascarar em caso de erro que inclui dados
    ferramenta: Middleware de logging + regex sanitization
```

### 8.4 Backup & Disaster Recovery

```yaml
Backup_Strategy:

  database_postgresql:
    tipo: Continuous backup (PITR)
    retencao: 30 dias point-in-time
    frequencia: Continuous WAL archiving + daily snapshots
    localizacao:
      primary: Same region (RDS automated)
      secondary: Cross-region (outro datacenter)
    criptografia: AES-256 (chave separada)
    teste_restore: Mensal

  data_lake:
    tipo: Versionamento S3 + replicacao
    retencao: 90 dias de versoes
    replicacao: Cross-region replication
    criptografia: SSE-KMS

  configuracoes:
    tipo: Infrastructure as Code (Terraform)
    versionamento: Git
    backup: Automatico no repositorio

  secrets:
    tipo: Vault snapshots
    frequencia: Diaria
    retencao: 30 dias
    teste: Mensal

Disaster_Recovery:

  rpo: 1 hora (maximo de dados perdidos)
  rto: 4 horas (tempo para restaurar)

  cenarios:

    falha_zona:
      descricao: AZ indisponivel
      estrategia: Multi-AZ automatico
      rto: Minutos (automatico)

    falha_regiao:
      descricao: Regiao AWS/Azure indisponivel
      estrategia: Failover para regiao secundaria
      rto: 2-4 horas
      processo:
        1. Declarar disaster
        2. Promover replica secundaria
        3. Atualizar DNS
        4. Validar integridade
        5. Comunicar usuarios

    corrupcao_dados:
      descricao: Dados corrompidos ou deletados
      estrategia: Point-in-time recovery
      rto: 1-4 horas dependendo do volume

    ransomware:
      descricao: Sistema comprometido
      estrategia: Restore de backup limpo
      rto: 4-8 horas
      requisitos: Backups isolados e imutaveis

  testes:
    frequencia: Trimestral
    tipos:
      - Restore de backup
      - Failover regional
      - Recuperacao de tabela especifica
    documentacao: Runbook atualizado
```

---

## 9. Data Stack Recomendado

### 9.1 Architecture Decision Records

```yaml
ADR_Summary:

  ADR-001_Database:
    decisao: PostgreSQL (AWS RDS)
    alternativas: [MySQL, CockroachDB, Aurora]
    justificativa:
      - Maturidade e estabilidade
      - Forte suporte a JSON (JSONB)
      - Extensoes (pgcrypto, PostGIS)
      - Custo-beneficio
      - Familiaridade da equipe
    trade-offs:
      - Escala horizontal limitada (mitigado com read replicas)

  ADR-002_Cache:
    decisao: Redis (ElastiCache)
    alternativas: [Memcached, DynamoDB DAX]
    justificativa:
      - Estruturas de dados ricas
      - Pub/Sub para real-time
      - Persistencia opcional
      - Session storage

  ADR-003_Search:
    decisao: Elasticsearch (OpenSearch)
    alternativas: [Algolia, PostgreSQL FTS]
    justificativa:
      - Full-text search
      - Log aggregation
      - Near real-time
      - Escalabilidade

  ADR-004_Streaming:
    decisao: Apache Kafka (MSK)
    alternativas: [Kinesis, RabbitMQ, Pulsar]
    justificativa:
      - Durabilidade (replicacao)
      - Alto throughput
      - Ecossistema (Connect, Streams)
      - Industria standard
    trade-offs:
      - Complexidade operacional (mitigado com MSK)

  ADR-005_Data_Lake:
    decisao: S3 + Delta Lake
    alternativas: [Iceberg, Hudi, plain Parquet]
    justificativa:
      - ACID transactions
      - Time travel (auditoria)
      - Schema evolution
      - Integracao Spark
      - Open source

  ADR-006_Data_Warehouse:
    decisao: BigQuery
    alternativas: [Snowflake, Redshift, Databricks SQL]
    justificativa:
      - Serverless (sem gerenciamento)
      - Preco por query (custo variavel)
      - Integracao GCP
      - Performance excelente
    trade-offs:
      - Vendor lock-in (mitigado com camada de abstracao)

  ADR-007_Orchestration:
    decisao: Apache Airflow (MWAA/Cloud Composer)
    alternativas: [Dagster, Prefect, Step Functions]
    justificativa:
      - Maturidade
      - Grande comunidade
      - Extensibilidade
      - Managed options disponiveis
    trade-offs:
      - UI datada (aceito)

  ADR-008_BI:
    decisao: Metabase (start) -> Looker (scale)
    alternativas: [Tableau, Superset, Mode]
    justificativa:
      - Metabase: Open source, rapido setup, custo zero
      - Looker: Governanca, semantic layer, embedding
    migracao: Quando ARR > $500K
```

### 9.2 Complete Stack Diagram

```
+-----------------------------------------------------------------------------------+
|                         DATA STACK COMPLETO                                       |
+-----------------------------------------------------------------------------------+
|                                                                                   |
|  LAYER              TECNOLOGIA                   MANAGED SERVICE                  |
|  ---------------    -------------------------    --------------------------       |
|                                                                                   |
|  SOURCES            Mobile App                   -                                |
|                     Web App                      -                                |
|                     BaaS APIs (Dock/Matera)      -                                |
|                                                                                   |
|  INGESTION          Debezium (CDC)               -                                |
|                     Kafka Connect                MSK Connect                      |
|                     Airbyte (APIs)               Airbyte Cloud                    |
|                                                                                   |
|  MESSAGE QUEUE      Apache Kafka                 AWS MSK                          |
|                                                                                   |
|  STREAM PROCESS     Apache Flink                 Kinesis Data Analytics           |
|                     Kafka Streams                -                                |
|                                                                                   |
|  BATCH PROCESS      Apache Spark                 EMR / Databricks                 |
|                     dbt                          dbt Cloud                        |
|                                                                                   |
|  STORAGE            PostgreSQL                   AWS RDS                          |
|                     Redis                        ElastiCache                      |
|                     Elasticsearch                OpenSearch Service               |
|                     S3 + Delta Lake              S3                               |
|                                                                                   |
|  DATA WAREHOUSE     BigQuery                     BigQuery (GCP)                   |
|                                                                                   |
|  ORCHESTRATION      Apache Airflow               MWAA / Cloud Composer            |
|                                                                                   |
|  QUALITY            Great Expectations           -                                |
|                     dbt tests                    -                                |
|                                                                                   |
|  CATALOG            DataHub / OpenMetadata       -                                |
|                                                                                   |
|  ML PLATFORM        MLflow                       -                                |
|                     Feast (Feature Store)        -                                |
|                     SageMaker                    SageMaker                        |
|                                                                                   |
|  BI & ANALYTICS     Metabase                     Metabase Cloud                   |
|                     Looker (future)              Looker (GCP)                     |
|                                                                                   |
|  MONITORING         Prometheus + Grafana         -                                |
|                     Datadog                      Datadog                          |
|                                                                                   |
|  SECURITY           HashiCorp Vault              -                                |
|                     AWS KMS                      KMS                              |
|                                                                                   |
+-----------------------------------------------------------------------------------+
```

### 9.3 Cost Estimation

```yaml
Cost_Estimate_Monthly:

  # Ano 1: 50K familias, 200K tx/dia
  year_1:
    database:
      rds_postgresql: $800  # db.r5.large multi-az
      elasticache_redis: $300
      opensearch: $400
    streaming:
      msk_kafka: $600  # 3 brokers m5.large
    processing:
      emr_spark: $500  # On-demand, algumas horas/dia
      lambda: $100
    storage:
      s3: $200  # ~2TB
      ebs: $100
    data_warehouse:
      bigquery: $300  # Query-based
    orchestration:
      mwaa_airflow: $350  # Smallest environment
    bi:
      metabase: $0  # Self-hosted ou $85 cloud
    monitoring:
      datadog: $500
    total_year_1: ~$4,200/mes ($50K/ano)

  # Ano 2: 200K familias, 800K tx/dia
  year_2:
    database: $2,500
    streaming: $1,500
    processing: $2,000
    storage: $800
    data_warehouse: $1,000
    orchestration: $600
    bi: $500  # Metabase cloud
    monitoring: $1,000
    total_year_2: ~$10,000/mes ($120K/ano)

  # Ano 3: 500K familias, 2M tx/dia
  year_3:
    database: $5,000
    streaming: $3,000
    processing: $5,000
    storage: $2,000
    data_warehouse: $3,000
    orchestration: $1,000
    bi: $2,000  # Looker
    monitoring: $2,000
    total_year_3: ~$23,000/mes ($275K/ano)

  otimizacoes:
    - Reserved instances: -30% em compute
    - Spot instances para Spark: -60%
    - BigQuery flat-rate se query volume alto
    - Tiered storage (S3 Glacier)
    - Right-sizing continuo
```

---

## 10. Data Team Structure

### 10.1 Team Evolution

```
+-----------------------------------------------------------------------------------+
|                           DATA TEAM EVOLUTION                                     |
+-----------------------------------------------------------------------------------+

FASE 1: MVP (0-50K familias)
+---------------------------+
| 1x Data Engineer (Senior) |  <- Contratacao PRIORITARIA
|   - Pipelines             |
|   - Infraestrutura        |
|   - Quality               |
+---------------------------+
| 1x Backend (Data focus)   |  <- Shared com produto
|   - Schema design         |
|   - APIs de dados         |
+---------------------------+

FASE 2: Growth (50K-200K familias)
+---------------------------+---------------------------+
| Data Engineering          | Analytics                 |
+---------------------------+---------------------------+
| 2x Data Engineer          | 1x Analytics Engineer     |
|   - Pipelines             |   - Dashboards            |
|   - Platform              |   - Self-service          |
|                           |   - Ad-hoc analysis       |
| 1x Data Engineer (Junior) |                           |
|   - Quality               | 1x Data Analyst           |
|   - Monitoring            |   - Business metrics      |
|                           |   - Reports               |
+---------------------------+---------------------------+

FASE 3: Scale (200K-500K familias)
+---------------------------+---------------------------+---------------------------+
| Data Platform             | Analytics                 | Data Science              |
+---------------------------+---------------------------+---------------------------+
| 1x Data Platform Lead     | 1x Analytics Lead         | 1x ML Engineer            |
|   - Architecture          |   - Strategy              |   - Models                |
|   - Standards             |   - Governance            |   - MLOps                 |
|                           |                           |                           |
| 2x Data Engineer (Senior) | 2x Analytics Engineer     | 1x Data Scientist         |
|   - Core pipelines        |   - Dashboards            |   - Fraud/Risk            |
|   - Real-time             |   - Semantic layer        |   - Experimentation       |
|                           |                           |                           |
| 2x Data Engineer          | 2x Data Analyst           |                           |
|   - Feature pipelines     |   - Domain experts        |                           |
|   - Quality               |   - Ad-hoc                |                           |
+---------------------------+---------------------------+---------------------------+
| TOTAL: ~11 pessoas                                                                |
+-----------------------------------------------------------------------------------+
```

### 10.2 Role Descriptions

```yaml
Roles:

  data_engineer_senior:
    responsabilidades:
      - Projetar e implementar pipelines de dados
      - Definir arquitetura de Data Lake/Warehouse
      - Garantir qualidade e governanca de dados
      - Mentoria de juniors
    requisitos:
      - 5+ anos de experiencia
      - Python, SQL, Spark
      - Kafka, Airflow
      - AWS/GCP
      - Modelagem dimensional
    salario_faixa: R$ 18-25K

  data_engineer:
    responsabilidades:
      - Desenvolver e manter pipelines
      - Implementar quality checks
      - Monitorar e otimizar jobs
    requisitos:
      - 2-4 anos de experiencia
      - Python, SQL
      - ETL/ELT tools
      - Cloud basics
    salario_faixa: R$ 12-18K

  analytics_engineer:
    responsabilidades:
      - Modelar dados para consumo
      - Criar e manter dashboards
      - Definir metricas e KPIs
      - Habilitar self-service
    requisitos:
      - 3+ anos de experiencia
      - SQL avancado
      - dbt
      - BI tools (Metabase, Looker)
      - Comunicacao com business
    salario_faixa: R$ 14-20K

  data_analyst:
    responsabilidades:
      - Analises ad-hoc
      - Reports para stakeholders
      - Identificar insights
      - Suporte a decisoes
    requisitos:
      - 2+ anos de experiencia
      - SQL
      - Excel/Sheets avancado
      - Visualizacao de dados
      - Conhecimento do negocio
    salario_faixa: R$ 8-14K

  ml_engineer:
    responsabilidades:
      - Desenvolver modelos de ML
      - Implementar MLOps
      - Feature engineering
      - Model serving
    requisitos:
      - 3+ anos de experiencia
      - Python, ML frameworks
      - MLflow, Feature stores
      - Production ML systems
    salario_faixa: R$ 18-28K

  data_scientist:
    responsabilidades:
      - Modelagem estatistica
      - Experimentacao (A/B tests)
      - Analise exploratoria
      - Comunicar resultados
    requisitos:
      - 3+ anos de experiencia
      - Python, R
      - Estatistica
      - ML basics
      - Storytelling com dados
    salario_faixa: R$ 15-22K
```

### 10.3 Hiring Priorities

```yaml
Hiring_Roadmap:

  quarter_1:
    priority: P0
    role: Senior Data Engineer
    justificativa: |
      Fundacao de toda infraestrutura de dados.
      Precisa ser senior para tomar decisoes arquiteturais corretas
      desde o inicio. Essa pessoa vai definir padroes para o time futuro.
    perfil_ideal:
      - Experiencia em fintech/pagamentos
      - Hands-on em Kafka, Spark, Airflow
      - Mentalidade de compliance/seguranca

  quarter_2:
    priority: P1
    role: Analytics Engineer
    justificativa: |
      Com a infraestrutura basica pronta, precisamos habilitar
      o time de produto/negocio a consumir dados. Self-service
      e dashboards sao criticos para tomada de decisao.

  quarter_3:
    priority: P1
    role: Data Engineer (2nd)
    justificativa: |
      Escalar a capacidade de engenharia. Senior pode focar em
      arquitetura enquanto segundo DE implementa pipelines.

  quarter_4:
    priority: P2
    roles: [Data Analyst, Data Engineer Junior]
    justificativa: |
      Suporte ao time de analytics e reducao de carga do time core.

  year_2:
    priority: P1
    roles: [ML Engineer, 3rd Data Engineer, 2nd Analytics Engineer]
    justificativa: |
      ML para fraude/churn se torna critico com escala.
      Time de engenharia precisa escalar com volume.
```

### 10.4 Team Rituals

```yaml
Team_Rituals:

  daily:
    - name: Data Standup
      duracao: 15 min
      participantes: Data team
      agenda:
        - Pipeline status
        - Blockers
        - Prioridades do dia

  weekly:
    - name: Data Review
      duracao: 1 hora
      participantes: Data + Product + Engineering leads
      agenda:
        - Metricas da semana
        - Qualidade de dados
        - Roadmap update

    - name: Office Hours
      duracao: 2 horas
      participantes: Data team disponivel
      objetivo: Suporte a outros times (queries, dashboards)

  monthly:
    - name: Data Governance Council
      duracao: 2 horas
      participantes: Data Lead + Compliance + Security + Product
      agenda:
        - Review de politicas
        - Novos casos de uso
        - Compliance updates

    - name: Architecture Review
      duracao: 2 horas
      participantes: Data Engineers + Tech Lead
      agenda:
        - Technical debt
        - Melhorias de arquitetura
        - Otimizacoes de custo

  quarterly:
    - name: Data Strategy Review
      duracao: 4 horas
      participantes: Data Lead + C-Level
      agenda:
        - OKRs do trimestre
        - Roadmap
        - Budget
        - Team health
```

---

## Anexos

### A. Glossario

| Termo | Definicao |
|-------|-----------|
| **CDC** | Change Data Capture - captura de mudancas incrementais |
| **DAG** | Directed Acyclic Graph - grafo de dependencias de tarefas |
| **Data Lake** | Repositorio centralizado de dados brutos |
| **Data Warehouse** | Banco otimizado para analytics |
| **dbt** | Data Build Tool - transformacoes SQL |
| **Delta Lake** | Formato de storage com ACID transactions |
| **ETL** | Extract, Transform, Load |
| **ELT** | Extract, Load, Transform |
| **Feature Store** | Repositorio de features para ML |
| **Lakehouse** | Arquitetura que combina Lake + Warehouse |
| **OLAP** | Online Analytical Processing |
| **OLTP** | Online Transaction Processing |
| **PII** | Personally Identifiable Information |
| **RBAC** | Role-Based Access Control |
| **RPO** | Recovery Point Objective |
| **RTO** | Recovery Time Objective |

### B. Referencias

- [Delta Lake Documentation](https://docs.delta.io/)
- [dbt Best Practices](https://docs.getdbt.com/guides/best-practices)
- [Feast Feature Store](https://feast.dev/)
- [Great Expectations](https://greatexpectations.io/)
- [Airflow Best Practices](https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html)
- [LGPD - Lei 13.709/2018](http://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm)
- [Resolucoes Bacen](https://www.bcb.gov.br/estabilidadefinanceira/)

### C. Controle de Versao

| Versao | Data | Autor | Alteracoes |
|--------|------|-------|------------|
| 1.0 | Jan 2026 | Data Engineering | Versao inicial |

---

**Aprovacoes:**

| Papel | Nome | Data | Assinatura |
|-------|------|------|------------|
| CTO | _____________ | ___/___/___ | _____________ |
| Head of Data | _____________ | ___/___/___ | _____________ |
| Head of Security | _____________ | ___/___/___ | _____________ |
| Head of Compliance | _____________ | ___/___/___ | _____________ |
