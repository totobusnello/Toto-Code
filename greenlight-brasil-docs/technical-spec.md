# Especificacao Tecnica - Fintech de Educacao Financeira Familiar

> **Documento Tecnico** | Versao 1.0 | Janeiro 2026
>
> **Projeto**: Greenlight Brasil - Plataforma de educacao financeira para familias
> **Classificacao**: Confidencial

---

## Indice

1. [Visao Geral da Arquitetura](#1-visao-geral-da-arquitetura)
2. [Stack Tecnologico](#2-stack-tecnologico)
3. [Arquitetura de Microservices](#3-arquitetura-de-microservices)
4. [Modelo de Dados](#4-modelo-de-dados)
5. [APIs Principais](#5-apis-principais)
6. [Integracoes Externas](#6-integracoes-externas)
7. [Requisitos de Seguranca](#7-requisitos-de-seguranca)
8. [Infraestrutura Cloud](#8-infraestrutura-cloud)
9. [DevOps e CI/CD](#9-devops-e-cicd)
10. [Observabilidade](#10-observabilidade)

---

## 1. Visao Geral da Arquitetura

### 1.1 Diagrama de Alto Nivel

```
                                    CLIENTES
                                       |
            +----------+----------+----+----+----------+
            |          |          |         |          |
         iOS App   Android    Web App   Admin     Partner
        (React    (React     (Next.js)  Panel      APIs
        Native)   Native)
            |          |          |         |          |
            +----------+----------+---------+----------+
                                  |
                           +------v------+
                           |   AWS CDN   |
                           | CloudFront  |
                           +------+------+
                                  |
                           +------v------+
                           |    WAF      |
                           |  AWS WAF    |
                           +------+------+
                                  |
                           +------v------+
                           | API Gateway |
                           |   Kong/AWS  |
                           +------+------+
                                  |
        +------------+------------+------------+------------+
        |            |            |            |            |
   +----v----+  +----v----+  +----v----+  +----v----+  +----v----+
   |  Auth   |  |  User   |  | Account |  | Payment |  |  Card   |
   | Service |  | Service |  | Service |  | Service |  | Service |
   +---------+  +---------+  +---------+  +---------+  +---------+
        |            |            |            |            |
        +------------+------------+------------+------------+
                                  |
                    +-------------+-------------+
                    |             |             |
              +-----v-----+ +-----v-----+ +-----v-----+
              | PostgreSQL| |   Redis   | |    S3     |
              |  (RDS)    | | (Elastic  | | (Storage) |
              |           | |  Cache)   | |           |
              +-----------+ +-----------+ +-----------+
```

### 1.2 Principios Arquiteturais

| Principio | Descricao | Implementacao |
|-----------|-----------|---------------|
| **Microservices** | Servicos independentes e desacoplados | Domain-Driven Design |
| **Event-Driven** | Comunicacao assincrona entre servicos | Apache Kafka / AWS SQS |
| **API-First** | Contratos definidos antes da implementacao | OpenAPI 3.0 |
| **Security by Design** | Seguranca em todas as camadas | Zero Trust |
| **Cloud-Native** | Construido para cloud | Kubernetes/EKS |
| **12-Factor App** | Boas praticas de desenvolvimento | Configuracao via ambiente |

### 1.3 Requisitos Nao-Funcionais

| Requisito | Target | Justificativa |
|-----------|--------|---------------|
| **Disponibilidade** | 99.95% | SLA financeiro |
| **Latencia P99** | < 200ms | UX mobile |
| **Throughput** | 10,000 TPS | Pico de transacoes |
| **RPO** | 1 minuto | Perda maxima de dados |
| **RTO** | 15 minutos | Tempo de recuperacao |
| **Retencao de Logs** | 5 anos | Compliance Bacen |

---

## 2. Stack Tecnologico

### 2.1 Camada de Aplicacao

```yaml
Mobile:
  framework: React Native 0.73+
  state_management: Zustand + React Query
  navigation: React Navigation 6
  ui_components:
    - React Native Paper
    - Custom Design System
  seguranca:
    - Certificate Pinning
    - Root/Jailbreak Detection
    - Secure Storage (Keychain/Keystore)
    - Biometrics (Face ID/Touch ID)
  analytics:
    - Firebase Analytics
    - Mixpanel
  crash_reporting: Sentry

Web (Admin/Landing):
  framework: Next.js 14 (App Router)
  styling: Tailwind CSS + Shadcn/ui
  state: Zustand + TanStack Query
  forms: React Hook Form + Zod
  charts: Recharts

Backend:
  framework: NestJS 10
  language: TypeScript 5.3
  runtime: Node.js 20 LTS
  orm: Prisma 5
  validation: class-validator + class-transformer
  documentation: Swagger/OpenAPI 3.0
```

### 2.2 Camada de Dados

```yaml
Primary Database:
  engine: PostgreSQL 16
  hosting: AWS RDS Multi-AZ
  extensions:
    - pgcrypto (criptografia)
    - pg_stat_statements (monitoring)
    - timescaledb (time-series para analytics)
  features:
    - Read Replicas (2x)
    - Automated Backups (30 dias)
    - Point-in-Time Recovery
    - Encryption at Rest (AES-256)

Cache Layer:
  engine: Redis 7 (Cluster Mode)
  hosting: AWS ElastiCache
  use_cases:
    - Session storage
    - Rate limiting
    - Feature flags
    - Leaderboards (gamificacao)
    - Pub/Sub (real-time notifications)

Document Store:
  engine: MongoDB 7
  hosting: MongoDB Atlas (opcional)
  use_cases:
    - Audit logs
    - Event sourcing
    - Analytics raw data

Object Storage:
  service: AWS S3
  use_cases:
    - KYC documents
    - Profile photos
    - Statements (PDF)
    - Backups
  encryption: SSE-KMS
  lifecycle:
    - 30 dias: Standard
    - 90 dias: Intelligent-Tiering
    - 1 ano: Glacier
    - 5 anos: Glacier Deep Archive
```

### 2.3 Messaging e Eventos

```yaml
Message Broker:
  primary: Apache Kafka (MSK)
  alternative: AWS SQS + SNS

  topics:
    - transactions.created
    - transactions.completed
    - transactions.failed
    - accounts.created
    - accounts.updated
    - buckets.allocated
    - notifications.send
    - fraud.alert
    - kyc.completed
    - kyc.failed

  retention: 7 dias (producao)
  partitions: 6 por topic (escalavel)
  replication_factor: 3

Real-time:
  websockets: Socket.io (Redis Adapter)
  use_cases:
    - Balance updates
    - Transaction notifications
    - Parent approvals
```

### 2.4 Infraestrutura

```yaml
Container Orchestration:
  platform: Kubernetes (AWS EKS)
  version: 1.28+
  node_groups:
    - name: general
      instance_type: m6i.large
      min: 3
      max: 10
    - name: compute
      instance_type: c6i.xlarge
      min: 2
      max: 8

Service Mesh:
  provider: AWS App Mesh / Istio
  features:
    - mTLS between services
    - Traffic management
    - Observability

API Gateway:
  provider: Kong / AWS API Gateway
  features:
    - Rate limiting
    - Authentication
    - Request/Response transformation
    - Logging
```

---

## 3. Arquitetura de Microservices

### 3.1 Mapa de Servicos

```
+------------------------------------------------------------------+
|                        DOMAIN SERVICES                            |
+------------------------------------------------------------------+
|                                                                  |
|  +---------------+  +---------------+  +---------------+         |
|  | AUTH-SERVICE  |  | USER-SERVICE  |  | FAMILY-SERVICE|         |
|  |---------------|  |---------------|  |---------------|         |
|  | - Login/JWT   |  | - Profiles    |  | - Family mgmt |         |
|  | - MFA         |  | - KYC         |  | - Invites     |         |
|  | - OAuth       |  | - Preferences |  | - Permissions |         |
|  | - Sessions    |  | - Devices     |  | - Linking     |         |
|  +---------------+  +---------------+  +---------------+         |
|                                                                  |
|  +---------------+  +---------------+  +---------------+         |
|  |ACCOUNT-SERVICE|  | BUCKET-SERVICE|  |ALLOWANCE-SVC  |         |
|  |---------------|  |---------------|  |---------------|         |
|  | - Account mgmt|  | - 4 Buckets   |  | - Scheduling  |         |
|  | - Balance     |  | - Allocation  |  | - Recurrence  |         |
|  | - Statements  |  | - Transfers   |  | - Auto-divide |         |
|  | - Limits      |  | - Goals/Metas |  | - History     |         |
|  +---------------+  +---------------+  +---------------+         |
|                                                                  |
|  +---------------+  +---------------+  +---------------+         |
|  |PAYMENT-SERVICE|  | CARD-SERVICE  |  | PIX-SERVICE   |         |
|  |---------------|  |---------------|  |---------------|         |
|  | - Processing  |  | - Virtual     |  | - Keys        |         |
|  | - Settlement  |  | - Physical    |  | - QR Code     |         |
|  | - Refunds     |  | - Controls    |  | - Transfers   |         |
|  | - Chargebacks |  | - Tokenization|  | - Limits      |         |
|  +---------------+  +---------------+  +---------------+         |
|                                                                  |
|  +---------------+  +---------------+  +---------------+         |
|  | CHORES-SERVICE|  |INVEST-SERVICE |  | DONATE-SERVICE|         |
|  |---------------|  |---------------|  |---------------|         |
|  | - Tasks       |  | - Products    |  | - Institutions|         |
|  | - Rewards     |  | - Portfolio   |  | - Donations   |         |
|  | - Approval    |  | - Performance |  | - Receipts    |         |
|  | - Completion  |  | - Redemption  |  | - History     |         |
|  +---------------+  +---------------+  +---------------+         |
|                                                                  |
+------------------------------------------------------------------+
|                     PLATFORM SERVICES                             |
+------------------------------------------------------------------+
|                                                                  |
|  +---------------+  +---------------+  +---------------+         |
|  |NOTIFICATION-SV|  | FRAUD-SERVICE |  | AUDIT-SERVICE |         |
|  |---------------|  |---------------|  |---------------|         |
|  | - Push        |  | - Rules engine|  | - Event log   |         |
|  | - Email       |  | - ML scoring  |  | - Compliance  |         |
|  | - SMS         |  | - Velocity    |  | - Reports     |         |
|  | - In-app      |  | - Alerts      |  | - Retention   |         |
|  +---------------+  +---------------+  +---------------+         |
|                                                                  |
|  +---------------+  +---------------+  +---------------+         |
|  |GAMIFICATION-SV|  |EDUCATION-SVC  |  | REPORT-SERVICE|         |
|  |---------------|  |---------------|  |---------------|         |
|  | - Points      |  | - Content     |  | - Statements  |         |
|  | - Badges      |  | - Quizzes     |  | - Analytics   |         |
|  | - Leaderboard |  | - Progress    |  | - Regulatory  |         |
|  | - Challenges  |  | - Certificates|  | - Exports     |         |
|  +---------------+  +---------------+  +---------------+         |
|                                                                  |
+------------------------------------------------------------------+
```

### 3.2 Detalhamento dos Servicos Core

#### AUTH-SERVICE

```yaml
responsabilidades:
  - Autenticacao de usuarios (pais e filhos)
  - Gerenciamento de sessoes JWT
  - MFA (TOTP, SMS, Push)
  - OAuth 2.0 / OIDC
  - Device binding e trust
  - Rate limiting de login

endpoints:
  - POST /auth/register
  - POST /auth/login
  - POST /auth/logout
  - POST /auth/refresh
  - POST /auth/mfa/setup
  - POST /auth/mfa/verify
  - POST /auth/password/reset
  - POST /auth/device/register
  - DELETE /auth/device/{id}

dependencias:
  - Redis (sessions, rate limiting)
  - PostgreSQL (users, devices)
  - Notification Service (OTP)

eventos_publicados:
  - user.registered
  - user.logged_in
  - user.logged_out
  - mfa.enabled
  - device.registered
  - suspicious_login.detected
```

#### ACCOUNT-SERVICE

```yaml
responsabilidades:
  - Gerenciamento de contas (pai e filho)
  - Saldos e limites
  - Extratos e historico
  - Reconciliacao com BaaS

endpoints:
  - POST /accounts
  - GET /accounts/{id}
  - GET /accounts/{id}/balance
  - GET /accounts/{id}/statement
  - PATCH /accounts/{id}/limits
  - POST /accounts/{id}/block
  - POST /accounts/{id}/unblock

dependencias:
  - PostgreSQL (accounts, balances)
  - Redis (cache de saldo)
  - BaaS Provider (Dock/Matera)
  - Bucket Service

eventos_publicados:
  - account.created
  - account.updated
  - account.blocked
  - balance.updated
  - limit.changed
```

#### BUCKET-SERVICE (Core do Sistema de 4 Baldes)

```yaml
responsabilidades:
  - Gerenciamento dos 4 baldes (Gastar/Guardar/Doar/Investir)
  - Alocacao automatica de mesada
  - Transferencias entre baldes
  - Metas de poupanca
  - Calculo de "juros parentais"

endpoints:
  - GET /buckets/account/{accountId}
  - GET /buckets/{bucketId}
  - PATCH /buckets/{bucketId}/allocation
  - POST /buckets/transfer
  - POST /buckets/goals
  - GET /buckets/goals/{goalId}
  - PATCH /buckets/goals/{goalId}
  - DELETE /buckets/goals/{goalId}
  - POST /buckets/goals/{goalId}/contribute

dependencias:
  - PostgreSQL (buckets, goals, allocations)
  - Redis (cache)
  - Account Service
  - Notification Service

eventos_publicados:
  - bucket.allocated
  - bucket.transferred
  - goal.created
  - goal.updated
  - goal.completed
  - parent_interest.paid
```

#### PAYMENT-SERVICE

```yaml
responsabilidades:
  - Processamento de transacoes
  - Integracao com bandeiras
  - Settlement e clearing
  - Chargebacks e disputas
  - Refunds

endpoints:
  - POST /payments/authorize
  - POST /payments/capture
  - POST /payments/void
  - POST /payments/refund
  - GET /payments/{id}
  - GET /payments/account/{accountId}
  - POST /payments/chargeback

dependencias:
  - PostgreSQL (transactions)
  - Kafka (events)
  - BaaS Provider
  - Fraud Service
  - Account Service
  - Bucket Service

eventos_publicados:
  - payment.authorized
  - payment.captured
  - payment.declined
  - payment.refunded
  - chargeback.initiated
  - chargeback.resolved
```

#### PIX-SERVICE

```yaml
responsabilidades:
  - Gerenciamento de chaves PIX
  - Envio e recebimento PIX
  - QR Code (estatico e dinamico)
  - Limites e horarios
  - Integracao com SPI (via BaaS)

endpoints:
  - POST /pix/keys
  - GET /pix/keys/account/{accountId}
  - DELETE /pix/keys/{keyId}
  - POST /pix/transfer
  - POST /pix/qrcode/generate
  - POST /pix/qrcode/decode
  - GET /pix/transfer/{id}
  - GET /pix/transfer/account/{accountId}

dependencias:
  - PostgreSQL (keys, transfers)
  - BaaS Provider (DICT integration)
  - Account Service
  - Bucket Service
  - Fraud Service
  - Notification Service

eventos_publicados:
  - pix.key_registered
  - pix.key_deleted
  - pix.transfer_initiated
  - pix.transfer_completed
  - pix.transfer_failed
  - pix.received
```

### 3.3 Comunicacao entre Servicos

```
+------------------------------------------------------------------+
|                    COMUNICACAO SINCRONA                           |
+------------------------------------------------------------------+
|                                                                  |
|   Service A ----[REST/gRPC]----> Service B                       |
|                                                                  |
|   Casos de uso:                                                  |
|   - Consulta de saldo (Account Service)                          |
|   - Validacao de limites (Payment -> Account)                    |
|   - Verificacao de fraude (Payment -> Fraud)                     |
|                                                                  |
|   Patterns:                                                      |
|   - Circuit Breaker (Resilience4j)                               |
|   - Retry with Exponential Backoff                               |
|   - Timeout: 5s (default), 30s (max)                             |
|                                                                  |
+------------------------------------------------------------------+
|                    COMUNICACAO ASSINCRONA                         |
+------------------------------------------------------------------+
|                                                                  |
|   Service A ----[Kafka]----> Service B, C, D                     |
|                                                                  |
|   Casos de uso:                                                  |
|   - Notificacoes (Payment -> Notification)                       |
|   - Atualizacao de saldo (Payment -> Account)                    |
|   - Audit logging (All -> Audit)                                 |
|   - Analytics (All -> Analytics)                                 |
|                                                                  |
|   Garantias:                                                     |
|   - At-least-once delivery                                       |
|   - Idempotency via event ID                                     |
|   - Dead Letter Queue para falhas                                |
|                                                                  |
+------------------------------------------------------------------+
```

### 3.4 Saga Pattern (Transacoes Distribuidas)

```
+------------------------------------------------------------------+
|              SAGA: ENVIO DE PIX COM ALOCACAO DE BALDE            |
+------------------------------------------------------------------+
|                                                                  |
|  1. [PIX-SERVICE] Recebe requisicao de PIX                       |
|        |                                                         |
|        v                                                         |
|  2. [FRAUD-SERVICE] Valida regras de fraude                      |
|        |                                                         |
|        v (aprovado)                                              |
|  3. [BUCKET-SERVICE] Reserva saldo do balde GASTAR               |
|        |                                                         |
|        v (saldo OK)                                              |
|  4. [ACCOUNT-SERVICE] Debita saldo da conta                      |
|        |                                                         |
|        v (debito OK)                                             |
|  5. [BAAS-PROVIDER] Executa PIX no SPI                           |
|        |                                                         |
|        +---> SUCESSO: Confirma transacao                         |
|        |                                                         |
|        +---> FALHA: Inicia compensacao                           |
|                  |                                               |
|                  v                                               |
|              4'. [ACCOUNT-SERVICE] Estorna debito                |
|                  |                                               |
|                  v                                               |
|              3'. [BUCKET-SERVICE] Libera reserva                 |
|                  |                                               |
|                  v                                               |
|              NOTIFICA usuario sobre falha                        |
|                                                                  |
+------------------------------------------------------------------+
```

---

## 4. Modelo de Dados

### 4.1 Diagrama ER (Entidades Principais)

```
+------------------------------------------------------------------+
|                        MODELO DE DADOS                            |
+------------------------------------------------------------------+

                          +-------------+
                          |   FAMILY    |
                          |-------------|
                          | id (PK)     |
                          | name        |
                          | plan_type   |
                          | created_at  |
                          +------+------+
                                 |
                                 | 1:N
                                 v
+-------------+           +-------------+           +-------------+
|   DEVICE    |           |    USER     |           |   ADDRESS   |
|-------------|           |-------------|           |-------------|
| id (PK)     |     N:1   | id (PK)     |   1:N     | id (PK)     |
| user_id(FK) |<--------->| family_id   |<--------->| user_id(FK) |
| fingerprint |           | type        |           | street      |
| platform    |           | cpf_hash    |           | city        |
| trust_level |           | email       |           | state       |
| last_used   |           | phone       |           | zipcode     |
+-------------+           | birth_date  |           +-------------+
                          | role        |
                          | kyc_status  |
                          +------+------+
                                 |
                    +------------+------------+
                    |                         |
                    | 1:1                     | 1:N
                    v                         v
             +-------------+           +-------------+
             |   ACCOUNT   |           |  KYC_DATA   |
             |-------------|           |-------------|
             | id (PK)     |           | id (PK)     |
             | user_id(FK) |           | user_id(FK) |
             | baas_id     |           | doc_type    |
             | status      |           | doc_url     |
             | type        |           | selfie_url  |
             | created_at  |           | status      |
             +------+------+           | verified_at |
                    |                  +-------------+
                    |
       +------------+------------+------------+
       |            |            |            |
       | 1:N        | 1:4        | 1:N        | 1:N
       v            v            v            v
+-------------+ +-------------+ +-------------+ +-------------+
| TRANSACTION | |   BUCKET    | |  PIX_KEY    | |    CARD     |
|-------------| |-------------| |-------------| |-------------|
| id (PK)     | | id (PK)     | | id (PK)     | | id (PK)     |
| account_id  | | account_id  | | account_id  | | account_id  |
| type        | | type        | | key_type    | | type        |
| amount      | | balance     | | key_value   | | last_4      |
| bucket_id   | | allocation  | | status      | | token       |
| status      | | created_at  | | created_at  | | status      |
| created_at  | +------+------+ +-------------+ | limits      |
+-------------+        |                        +-------------+
                       |
          +------------+------------+
          |                         |
          | 1:N                     | (GUARDAR bucket only)
          v                         v
   +-------------+           +-------------+
   |BUCKET_TRANS |           |    GOAL     |
   |-------------|           |-------------|
   | id (PK)     |           | id (PK)     |
   | from_bucket |           | bucket_id   |
   | to_bucket   |           | name        |
   | amount      |           | target      |
   | reason      |           | current     |
   | approved_by |           | image_url   |
   | created_at  |           | deadline    |
   +-------------+           | status      |
                             +-------------+
```

### 4.2 Schema Detalhado (PostgreSQL)

```sql
-- =====================================================
-- SCHEMA: core
-- =====================================================

CREATE SCHEMA IF NOT EXISTS core;

-- Families
CREATE TABLE core.families (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    plan_type VARCHAR(20) NOT NULL DEFAULT 'FREE',
    plan_expires_at TIMESTAMP,
    max_children SMALLINT NOT NULL DEFAULT 5,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP
);

-- Users (Parents and Children)
CREATE TABLE core.users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    family_id UUID REFERENCES core.families(id),
    type VARCHAR(10) NOT NULL CHECK (type IN ('PARENT', 'CHILD')),
    role VARCHAR(20) NOT NULL DEFAULT 'MEMBER',

    -- PII (Encrypted)
    cpf_encrypted BYTEA NOT NULL,
    cpf_hash VARCHAR(64) NOT NULL UNIQUE,
    name_encrypted BYTEA NOT NULL,
    email VARCHAR(255),
    phone_encrypted BYTEA,
    birth_date DATE NOT NULL,

    -- Auth
    password_hash VARCHAR(255),
    pin_hash VARCHAR(255),
    mfa_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    mfa_secret_encrypted BYTEA,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING_KYC',
    kyc_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    kyc_verified_at TIMESTAMP,

    -- Metadata
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMP,

    CONSTRAINT email_required_for_parent CHECK (
        type = 'CHILD' OR email IS NOT NULL
    )
);

CREATE INDEX idx_users_cpf_hash ON core.users(cpf_hash);
CREATE INDEX idx_users_email ON core.users(email) WHERE email IS NOT NULL;
CREATE INDEX idx_users_family ON core.users(family_id);

-- =====================================================
-- SCHEMA: accounts
-- =====================================================

CREATE SCHEMA IF NOT EXISTS accounts;

-- Accounts
CREATE TABLE accounts.accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES core.users(id),

    -- BaaS Integration
    baas_provider VARCHAR(20) NOT NULL,
    baas_account_id VARCHAR(100) NOT NULL,
    baas_branch VARCHAR(10),
    baas_number VARCHAR(20),

    -- Status
    type VARCHAR(20) NOT NULL DEFAULT 'PREPAID',
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

    -- Limits
    daily_pix_limit DECIMAL(10,2) NOT NULL DEFAULT 1000.00,
    daily_card_limit DECIMAL(10,2) NOT NULL DEFAULT 500.00,
    monthly_limit DECIMAL(10,2) NOT NULL DEFAULT 5000.00,

    -- Metadata
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    UNIQUE(baas_provider, baas_account_id)
);

-- Buckets (4 Baldes)
CREATE TABLE accounts.buckets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES accounts.accounts(id),

    type VARCHAR(10) NOT NULL CHECK (type IN ('SPEND', 'SAVE', 'GIVE', 'INVEST')),
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    allocation_percent SMALLINT NOT NULL DEFAULT 25,

    -- Status
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- Metadata
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    UNIQUE(account_id, type),
    CONSTRAINT valid_allocation CHECK (allocation_percent >= 0 AND allocation_percent <= 100),
    CONSTRAINT positive_balance CHECK (balance >= 0)
);

-- Goals (Metas do balde SAVE)
CREATE TABLE accounts.goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bucket_id UUID NOT NULL REFERENCES accounts.buckets(id),

    name VARCHAR(100) NOT NULL,
    description TEXT,
    target_amount DECIMAL(10,2) NOT NULL,
    current_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    image_url VARCHAR(500),

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    deadline DATE,
    completed_at TIMESTAMP,

    -- Metadata
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT positive_amounts CHECK (
        target_amount > 0 AND current_amount >= 0
    )
);

-- =====================================================
-- SCHEMA: transactions
-- =====================================================

CREATE SCHEMA IF NOT EXISTS transactions;

-- Transactions
CREATE TABLE transactions.transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES accounts.accounts(id),
    bucket_id UUID REFERENCES accounts.buckets(id),

    -- Transaction Info
    type VARCHAR(30) NOT NULL,
    direction VARCHAR(10) NOT NULL CHECK (direction IN ('IN', 'OUT')),
    amount DECIMAL(12,2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'BRL',

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',

    -- External References
    external_id VARCHAR(100),
    baas_transaction_id VARCHAR(100),

    -- Counterparty
    counterparty_name VARCHAR(200),
    counterparty_document VARCHAR(20),
    counterparty_bank VARCHAR(10),
    counterparty_account VARCHAR(30),

    -- Metadata
    description VARCHAR(500),
    category VARCHAR(50),
    merchant_name VARCHAR(200),
    merchant_mcc VARCHAR(4),

    -- Timestamps
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    processed_at TIMESTAMP,
    settled_at TIMESTAMP,

    -- Idempotency
    idempotency_key VARCHAR(100) UNIQUE
);

CREATE INDEX idx_transactions_account ON transactions.transactions(account_id);
CREATE INDEX idx_transactions_created ON transactions.transactions(created_at DESC);
CREATE INDEX idx_transactions_status ON transactions.transactions(status);

-- Bucket Transfers
CREATE TABLE transactions.bucket_transfers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    from_bucket_id UUID NOT NULL REFERENCES accounts.buckets(id),
    to_bucket_id UUID NOT NULL REFERENCES accounts.buckets(id),

    amount DECIMAL(10,2) NOT NULL,
    reason VARCHAR(200),

    -- Approval (if required)
    requires_approval BOOLEAN NOT NULL DEFAULT FALSE,
    approved_by UUID REFERENCES core.users(id),
    approved_at TIMESTAMP,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',

    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =====================================================
-- SCHEMA: payments
-- =====================================================

CREATE SCHEMA IF NOT EXISTS payments;

-- PIX Keys
CREATE TABLE payments.pix_keys (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES accounts.accounts(id),

    key_type VARCHAR(10) NOT NULL CHECK (key_type IN ('CPF', 'PHONE', 'EMAIL', 'EVP')),
    key_value VARCHAR(100) NOT NULL,
    key_value_hash VARCHAR(64) NOT NULL,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

    -- BaaS
    baas_key_id VARCHAR(100),

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),

    UNIQUE(key_value_hash)
);

-- Cards
CREATE TABLE payments.cards (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID NOT NULL REFERENCES accounts.accounts(id),

    type VARCHAR(10) NOT NULL CHECK (type IN ('VIRTUAL', 'PHYSICAL')),
    brand VARCHAR(20) NOT NULL DEFAULT 'MASTERCARD',

    -- Card Data (tokenizado no BaaS)
    last_4 VARCHAR(4) NOT NULL,
    token VARCHAR(200) NOT NULL,
    baas_card_id VARCHAR(100) NOT NULL,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',

    -- Limits
    per_transaction_limit DECIMAL(10,2),
    daily_limit DECIMAL(10,2),
    monthly_limit DECIMAL(10,2),

    -- Controls
    blocked_categories TEXT[], -- MCCs bloqueados
    allowed_merchants TEXT[],  -- Merchants permitidos

    -- Physical Card
    tracking_code VARCHAR(50),
    delivered_at TIMESTAMP,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =====================================================
-- SCHEMA: allowance
-- =====================================================

CREATE SCHEMA IF NOT EXISTS allowance;

-- Allowance Rules (Mesada)
CREATE TABLE allowance.rules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parent_id UUID NOT NULL REFERENCES core.users(id),
    child_id UUID NOT NULL REFERENCES core.users(id),

    amount DECIMAL(10,2) NOT NULL,
    frequency VARCHAR(20) NOT NULL CHECK (frequency IN ('DAILY', 'WEEKLY', 'BIWEEKLY', 'MONTHLY')),

    -- Scheduling
    day_of_week SMALLINT, -- 0-6 for weekly
    day_of_month SMALLINT, -- 1-28 for monthly
    next_payment DATE NOT NULL,

    -- Bucket Distribution
    spend_percent SMALLINT NOT NULL DEFAULT 50,
    save_percent SMALLINT NOT NULL DEFAULT 30,
    give_percent SMALLINT NOT NULL DEFAULT 10,
    invest_percent SMALLINT NOT NULL DEFAULT 10,

    -- Status
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT valid_distribution CHECK (
        spend_percent + save_percent + give_percent + invest_percent = 100
    )
);

-- Chores (Tarefas)
CREATE TABLE allowance.chores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    family_id UUID NOT NULL REFERENCES core.families(id),
    assigned_to UUID REFERENCES core.users(id),
    created_by UUID NOT NULL REFERENCES core.users(id),

    title VARCHAR(100) NOT NULL,
    description TEXT,
    reward_amount DECIMAL(8,2) NOT NULL,

    -- Scheduling
    frequency VARCHAR(20) NOT NULL DEFAULT 'ONCE',
    due_date DATE,

    -- Status
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    completed_at TIMESTAMP,
    approved_at TIMESTAMP,
    paid_at TIMESTAMP,

    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =====================================================
-- SCHEMA: audit
-- =====================================================

CREATE SCHEMA IF NOT EXISTS audit;

-- Audit Log
CREATE TABLE audit.events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Actor
    user_id UUID,
    device_id UUID,
    ip_address INET,
    user_agent TEXT,

    -- Event
    event_type VARCHAR(50) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    resource_id UUID,

    -- Data
    old_data JSONB,
    new_data JSONB,
    metadata JSONB,

    -- Timestamp
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Particionar por mes para performance
CREATE INDEX idx_audit_events_created ON audit.events(created_at DESC);
CREATE INDEX idx_audit_events_user ON audit.events(user_id);
CREATE INDEX idx_audit_events_type ON audit.events(event_type);
```

### 4.3 Indices e Otimizacoes

```sql
-- Indices compostos para queries frequentes
CREATE INDEX idx_transactions_account_date
ON transactions.transactions(account_id, created_at DESC);

CREATE INDEX idx_transactions_bucket_status
ON transactions.transactions(bucket_id, status)
WHERE bucket_id IS NOT NULL;

-- Indice para busca de metas ativas
CREATE INDEX idx_goals_active
ON accounts.goals(bucket_id, status)
WHERE status = 'ACTIVE';

-- Indice para mesadas pendentes
CREATE INDEX idx_allowance_pending
ON allowance.rules(next_payment)
WHERE is_active = TRUE;

-- Particao de transactions por mes
-- (para tabelas com alto volume)
```

---

## 5. APIs Principais

### 5.1 Padrao de Resposta

```json
{
  "success": true,
  "data": { },
  "meta": {
    "request_id": "uuid",
    "timestamp": "2026-01-29T10:00:00Z"
  },
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 100,
    "total_pages": 5
  },
  "error": null
}
```

```json
{
  "success": false,
  "data": null,
  "meta": {
    "request_id": "uuid",
    "timestamp": "2026-01-29T10:00:00Z"
  },
  "error": {
    "code": "INSUFFICIENT_BALANCE",
    "message": "Saldo insuficiente no balde Gastar",
    "details": {
      "available": 50.00,
      "requested": 100.00
    }
  }
}
```

### 5.2 Endpoints Core

#### Authentication API

```yaml
POST /v1/auth/register:
  description: Cadastro de novo usuario (pai)
  body:
    email: string (required)
    password: string (required, min 12 chars)
    cpf: string (required, 11 digits)
    name: string (required)
    phone: string (required)
    birth_date: date (required)
  response:
    user_id: uuid
    verification_required: boolean
  rate_limit: 5/minute

POST /v1/auth/login:
  description: Login com email/senha ou CPF/senha
  body:
    identifier: string (email or cpf)
    password: string
    device_info:
      device_id: string
      platform: string
      os_version: string
  response:
    access_token: string (JWT, 15min)
    refresh_token: string (opaque, 7 days)
    mfa_required: boolean
    mfa_methods: array
  rate_limit: 10/minute per IP

POST /v1/auth/mfa/verify:
  description: Verificacao de MFA
  body:
    mfa_token: string
    code: string
    method: enum [totp, sms, push]
  response:
    access_token: string
    refresh_token: string

POST /v1/auth/child/login:
  description: Login do filho (PIN)
  body:
    account_id: uuid
    pin: string (6 digits)
    device_info: object
  response:
    access_token: string
    refresh_token: string
  rate_limit: 5/minute
```

#### Family API

```yaml
POST /v1/family/children:
  description: Adicionar filho a familia
  auth: Parent JWT
  body:
    name: string
    cpf: string
    birth_date: date
    initial_pin: string (6 digits)
    bucket_allocation:
      spend: number (0-100)
      save: number (0-100)
      give: number (0-100)
      invest: number (0-100)
  response:
    child_id: uuid
    account_id: uuid
    requires_kyc: boolean

GET /v1/family/children:
  description: Listar filhos da familia
  auth: Parent JWT
  response:
    children: array
      - id: uuid
        name: string
        age: number
        account:
          balance: number
          buckets: object
        last_activity: datetime

PATCH /v1/family/children/{childId}/controls:
  description: Atualizar controles parentais
  auth: Parent JWT
  body:
    spending_limit_daily: number
    allowed_categories: array
    blocked_categories: array
    pix_contacts_only: boolean
    night_limit_enabled: boolean
    night_limit_percent: number
```

#### Buckets API

```yaml
GET /v1/buckets:
  description: Listar baldes do usuario
  auth: JWT
  response:
    buckets:
      - type: SPEND
        balance: 150.00
        allocation_percent: 50
      - type: SAVE
        balance: 230.00
        allocation_percent: 30
        goals:
          - name: "PlayStation 5"
            target: 3500.00
            current: 230.00
            progress: 6.5
      - type: GIVE
        balance: 45.00
        allocation_percent: 10
      - type: INVEST
        balance: 120.00
        allocation_percent: 10
        portfolio_value: 125.50

POST /v1/buckets/transfer:
  description: Transferir entre baldes
  auth: JWT (child needs parent approval)
  body:
    from_bucket: enum [SPEND, SAVE, GIVE, INVEST]
    to_bucket: enum [SPEND, SAVE, GIVE, INVEST]
    amount: number
    reason: string (optional)
  response:
    transfer_id: uuid
    status: enum [COMPLETED, PENDING_APPROVAL]
    new_balances: object

PATCH /v1/buckets/allocation:
  description: Alterar distribuicao de mesada
  auth: Parent JWT
  body:
    child_id: uuid
    allocation:
      spend: number
      save: number
      give: number
      invest: number
  response:
    success: boolean

POST /v1/buckets/goals:
  description: Criar meta de poupanca
  auth: JWT
  body:
    name: string
    target_amount: number
    image_url: string (optional)
    deadline: date (optional)
  response:
    goal_id: uuid
    bucket_id: uuid
```

#### Payments API

```yaml
POST /v1/pix/transfer:
  description: Enviar PIX
  auth: JWT
  body:
    key_type: enum [CPF, PHONE, EMAIL, EVP]
    key_value: string
    amount: number
    description: string (optional)
  validation:
    - Saldo suficiente no balde GASTAR
    - Dentro dos limites diarios
    - Destinatario aprovado (para menores)
    - Verificacao antifraude
  response:
    transfer_id: uuid
    status: enum [PROCESSING, COMPLETED, FAILED]
    end_to_end_id: string
    receipt_url: string

GET /v1/pix/transfer/{id}:
  description: Status de transferencia PIX
  auth: JWT
  response:
    id: uuid
    status: string
    amount: number
    counterparty:
      name: string
      document_masked: string
    timestamps:
      created_at: datetime
      completed_at: datetime

POST /v1/cards/virtual:
  description: Criar cartao virtual
  auth: JWT
  response:
    card_id: uuid
    card_data:
      number_masked: string
      expiry: string
      cvv_token: string (para exibicao unica)

PATCH /v1/cards/{cardId}/controls:
  description: Atualizar controles do cartao
  auth: Parent JWT
  body:
    per_transaction_limit: number
    daily_limit: number
    blocked_categories: array (MCCs)
    is_active: boolean
```

#### Allowance API

```yaml
POST /v1/allowance/rules:
  description: Configurar mesada automatica
  auth: Parent JWT
  body:
    child_id: uuid
    amount: number
    frequency: enum [DAILY, WEEKLY, BIWEEKLY, MONTHLY]
    day_of_week: number (0-6, for weekly)
    day_of_month: number (1-28, for monthly)
    distribution:
      spend_percent: number
      save_percent: number
      give_percent: number
      invest_percent: number
  response:
    rule_id: uuid
    next_payment: date

POST /v1/allowance/send:
  description: Enviar mesada avulsa
  auth: Parent JWT
  body:
    child_id: uuid
    amount: number
    message: string (optional)
  response:
    transfer_id: uuid
    distribution:
      spend: number
      save: number
      give: number
      invest: number

POST /v1/chores:
  description: Criar tarefa
  auth: Parent JWT
  body:
    title: string
    description: string (optional)
    reward_amount: number
    assigned_to: uuid (child_id)
    due_date: date (optional)
    frequency: enum [ONCE, DAILY, WEEKLY]
  response:
    chore_id: uuid

POST /v1/chores/{choreId}/complete:
  description: Filho marca tarefa como concluida
  auth: Child JWT
  body:
    proof_image_url: string (optional)
  response:
    status: PENDING_APPROVAL

POST /v1/chores/{choreId}/approve:
  description: Pai aprova e paga tarefa
  auth: Parent JWT
  body:
    approved: boolean
    feedback: string (optional)
  response:
    status: enum [PAID, REJECTED]
    transfer_id: uuid (if paid)
```

### 5.3 OpenAPI Spec (Exemplo)

```yaml
openapi: 3.0.3
info:
  title: Greenlight Brasil API
  version: 1.0.0
  description: API para plataforma de educacao financeira familiar

servers:
  - url: https://api.greenlight.com.br/v1
    description: Production
  - url: https://api.staging.greenlight.com.br/v1
    description: Staging

security:
  - BearerAuth: []

paths:
  /buckets:
    get:
      summary: Listar baldes do usuario
      tags: [Buckets]
      responses:
        '200':
          description: Lista de baldes
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BucketsResponse'
        '401':
          $ref: '#/components/responses/Unauthorized'

components:
  securitySchemes:
    BearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    BucketsResponse:
      type: object
      properties:
        success:
          type: boolean
        data:
          type: object
          properties:
            buckets:
              type: array
              items:
                $ref: '#/components/schemas/Bucket'

    Bucket:
      type: object
      properties:
        id:
          type: string
          format: uuid
        type:
          type: string
          enum: [SPEND, SAVE, GIVE, INVEST]
        balance:
          type: number
          format: decimal
        allocation_percent:
          type: integer
          minimum: 0
          maximum: 100

  responses:
    Unauthorized:
      description: Token invalido ou expirado
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
```

---

## 6. Integracoes Externas

### 6.1 Arquitetura de Integracoes

```
+------------------------------------------------------------------+
|                    INTEGRACOES EXTERNAS                           |
+------------------------------------------------------------------+
|                                                                  |
|  +-------------------+         +-------------------+             |
|  |   BaaS Provider   |         |   KYC Provider    |             |
|  | (Dock/Pismo/      |         | (idwall/Unico/    |             |
|  |  Matera)          |         |  Serpro)          |             |
|  +--------+----------+         +--------+----------+             |
|           |                             |                        |
|           v                             v                        |
|  +------------------------------------------------------------------+
|  |                    INTEGRATION LAYER                             |
|  |  +------------+  +------------+  +------------+  +------------+  |
|  |  | BaaS       |  | KYC        |  | Fraud      |  | Notify     |  |
|  |  | Adapter    |  | Adapter    |  | Adapter    |  | Adapter    |  |
|  |  +------------+  +------------+  +------------+  +------------+  |
|  +------------------------------------------------------------------+
|           |                             |                        |
|           v                             v                        |
|  +-------------------+         +-------------------+             |
|  |   Anti-Fraud      |         |   Notification    |             |
|  | (Shield/Incognia/ |         | (Firebase/SNS/    |             |
|  |  Clearsale)       |         |  Twilio)          |             |
|  +-------------------+         +-------------------+             |
|                                                                  |
+------------------------------------------------------------------+
```

### 6.2 BaaS (Banking as a Service)

```yaml
Provider_Principal: Dock
Provider_Backup: Matera

Dock_Integration:
  base_url: https://api.dock.tech
  auth: OAuth 2.0 (client_credentials)

  services:
    accounts:
      - Abertura de conta digital
      - Consulta de saldo
      - Bloqueio/desbloqueio
      - Encerramento

    cards:
      - Emissao de cartao virtual
      - Emissao de cartao fisico
      - Tokenizacao
      - Gestao de limites
      - Bloqueio/desbloqueio

    pix:
      - Registro de chaves (DICT)
      - Envio/recebimento
      - QR Code
      - Devolucao

    transfers:
      - TED
      - Transferencia interna

    statements:
      - Extrato
      - Comprovantes

  webhooks:
    - account.status_changed
    - card.transaction_authorized
    - card.transaction_settled
    - pix.transfer_completed
    - pix.transfer_received

  sla:
    availability: 99.9%
    latency_p99: 500ms

  error_handling:
    retry_policy:
      max_attempts: 3
      backoff: exponential
      initial_delay: 1s

    circuit_breaker:
      failure_threshold: 5
      timeout: 30s
      half_open_after: 60s
```

### 6.3 KYC (Know Your Customer)

```yaml
Provider_Principal: idwall
Provider_Secundario: Serpro (validacao CPF)

idwall_Integration:
  services:
    document_ocr:
      - RG
      - CNH
      - Certidao de nascimento (menores)

    face_match:
      - Comparacao selfie x documento
      - Liveness detection

    background_check:
      - PEP (Pessoa Exposta Politicamente)
      - Watchlists
      - Processos judiciais

    fraud_signals:
      - Device fingerprint
      - Comportamento anomalo

  flow_parent:
    1. Validacao CPF (Serpro)
    2. OCR documento (RG/CNH)
    3. Selfie + Liveness
    4. Face match
    5. Background check
    6. Decisao (auto/manual)

  flow_child:
    1. Validacao CPF (Serpro)
    2. OCR certidao ou RG (se >12 anos)
    3. Vinculo com responsavel (CPF pai)
    4. Decisao

  sla:
    ocr: 10s
    face_match: 15s
    background: 30s
    total: 60s

Serpro_Integration:
  base_url: https://gateway.apiserpro.serpro.gov.br
  services:
    - Validacao de CPF
    - Consulta de dados cadastrais
    - Situacao cadastral
```

### 6.4 Antifraude

```yaml
Provider_Principal: Shield (device intelligence)
Provider_Secundario: Incognia (location behavior)
Provider_Adicional: Internal rules engine

Shield_Integration:
  services:
    device_fingerprint:
      - Device ID persistente
      - Hardware attributes
      - Software attributes
      - Network info

    risk_signals:
      - Emulador detectado
      - Root/Jailbreak
      - App tampering
      - Hooking frameworks
      - VPN/Proxy
      - Modo debugger

    risk_score:
      range: 0-100
      thresholds:
        low: 0-30
        medium: 31-60
        high: 61-80
        critical: 81-100

Incognia_Integration:
  services:
    location_behavior:
      - Home location
      - Work location
      - Travel patterns

    risk_assessment:
      - Location spoofing
      - Impossible travel
      - Device/location mismatch

Internal_Rules_Engine:
  rules:
    velocity:
      - Max 5 PIX/hora (menor)
      - Max R$1000/dia (menor)
      - Max 3 novos destinatarios/dia

    patterns:
      - Transacao fora do horario normal
      - Valor atipico
      - Destinatario de risco

    blocklist:
      - CPFs fraudulentos
      - Devices comprometidos
      - IPs suspeitos

  actions:
    - ALLOW
    - CHALLENGE (step-up auth)
    - BLOCK
    - ALERT (notifica pai)
    - REVIEW (fila manual)
```

### 6.5 Notificacoes

```yaml
Push_Notifications:
  provider: Firebase Cloud Messaging (FCM)
  fallback: AWS SNS

  types:
    transactional:
      - Transacao realizada
      - Transacao recebida
      - Meta atingida
      - Mesada creditada
      - Tarefa aprovada

    alerts:
      - Transacao bloqueada
      - Login novo dispositivo
      - Limite proximo

    marketing:
      - Novos recursos
      - Dicas financeiras
      - Desafios

Email:
  provider: AWS SES
  templates: SendGrid Dynamic Templates

  types:
    - Confirmacao de cadastro
    - Reset de senha
    - Extrato mensal
    - Alertas de seguranca

SMS:
  provider: Twilio
  fallback: AWS SNS

  types:
    - OTP para MFA
    - Alertas criticos
    - Confirmacao de transacoes altas
```

### 6.6 Investimentos

```yaml
Provider: BaaS (Dock) + Parceiro de Investimentos

Produtos_MVP:
  - CDB DI (parceiro bancario)
  - Tesouro Direto (via STN)

Fluxo_Investimento:
  1. Filho solicita investimento
  2. Pai recebe notificacao
  3. Pai aprova com MFA
  4. Sistema debita balde INVEST
  5. Ordem enviada ao parceiro
  6. Confirmacao recebida
  7. Posicao atualizada

Custodia:
  - Ativos em nome do menor
  - Representado pelo responsavel legal
  - Resgate requer aprovacao parental

Tributacao:
  - Calculo automatico de IR
  - DARF gerado para resgates
  - Informe de rendimentos anual
```

---

## 7. Requisitos de Seguranca

### 7.1 Arquitetura de Seguranca

```
+------------------------------------------------------------------+
|                    SECURITY ARCHITECTURE                          |
+------------------------------------------------------------------+
|                                                                  |
|  PERIMETER                                                       |
|  +------------------------------------------------------------+  |
|  | WAF (AWS WAF) | DDoS Protection (Shield) | CDN (CloudFront)|  |
|  +------------------------------------------------------------+  |
|                              |                                   |
|  NETWORK                     v                                   |
|  +------------------------------------------------------------+  |
|  | VPC | Private Subnets | Security Groups | NACLs | VPN      |  |
|  +------------------------------------------------------------+  |
|                              |                                   |
|  APPLICATION                 v                                   |
|  +------------------------------------------------------------+  |
|  | API Gateway | mTLS | JWT Auth | RBAC | Input Validation    |  |
|  +------------------------------------------------------------+  |
|                              |                                   |
|  DATA                        v                                   |
|  +------------------------------------------------------------+  |
|  | Encryption at Rest | Encryption in Transit | Tokenization  |  |
|  | KMS | HSM | Field-level Encryption | Data Masking          |  |
|  +------------------------------------------------------------+  |
|                              |                                   |
|  MONITORING                  v                                   |
|  +------------------------------------------------------------+  |
|  | SIEM | Audit Logs | Threat Detection | Incident Response   |  |
|  +------------------------------------------------------------+  |
|                                                                  |
+------------------------------------------------------------------+
```

### 7.2 Autenticacao e Autorizacao

```yaml
Authentication:
  parents:
    primary: Email + Senha (12+ chars)
    mfa: Obrigatorio (TOTP ou SMS)
    biometrics: Opcional (Face ID/Touch ID)
    session: 15min inatividade, 24h max

  children:
    primary: PIN (6 digitos)
    biometrics: Opcional
    session: 5min inatividade, 4h max
    restrictions: Nao pode alterar seguranca

Authorization:
  model: RBAC + ABAC

  roles:
    PARENT_ADMIN:
      - Gerenciar familia
      - Aprovar transacoes
      - Definir limites
      - Ver tudo

    PARENT_MEMBER:
      - Ver filhos
      - Aprovar transacoes
      - Enviar mesada

    CHILD:
      - Ver propria conta
      - Transacionar (com limites)
      - Criar metas
      - Completar tarefas

  policies:
    - Pai so ve filhos da propria familia
    - Filho so ve propria conta
    - Transacoes acima de limite requerem aprovacao
    - Alteracoes de seguranca requerem MFA
```

### 7.3 Criptografia

```yaml
At_Rest:
  database:
    engine: AES-256-GCM
    key_management: AWS KMS
    rotation: Automatica (90 dias)

  storage:
    engine: AES-256 (SSE-KMS)
    documents: Criptografia adicional por cliente

  field_level:
    cpf: AES-256 + hash para busca
    name: AES-256
    phone: AES-256
    card_data: Tokenizado no BaaS

In_Transit:
  external: TLS 1.3
  internal: mTLS entre servicos

  certificate_pinning:
    enabled: true
    backup_pins: 2

Key_Management:
  provider: AWS KMS
  hsm: CloudHSM (para chaves criticas)

  key_hierarchy:
    master_key: HSM (nunca exportada)
    data_encryption_keys: KMS
    rotation: Automatica
```

### 7.4 Protecao de Dados (LGPD)

```yaml
Data_Classification:
  critico:
    - CPF, RG
    - Biometria facial
    - Dados de cartao

  sensivel:
    - Nome, endereco
    - Telefone, email
    - Transacoes

  interno:
    - Logs de sistema
    - Metricas

  publico:
    - Termos de uso
    - Politicas

Minimization:
  - Coletar apenas dados necessarios
  - Anonimizar para analytics
  - Pseudonimizar para desenvolvimento

Retention:
  cadastrais: Vida da conta + 5 anos
  transacoes: 10 anos (Bacen)
  logs_seguranca: 5 anos
  marketing: Ate revogacao

Rights_Management:
  acesso: Exportar dados via app
  correcao: Formulario in-app
  exclusao: Processo com verificacao
  portabilidade: JSON padronizado
```

### 7.5 PCI-DSS Compliance

```yaml
Scope_Reduction:
  strategy: Tokenizacao total

  card_data:
    - Nunca armazenado localmente
    - Enviado direto ao tokenizador (BaaS)
    - Backend recebe apenas token
    - CVV nunca persistido

Controls:
  network:
    - Segmentacao PCI
    - Firewall dedicado
    - IDS/IPS

  access:
    - MFA para admins
    - Least privilege
    - Logs de acesso

  monitoring:
    - File integrity
    - Log review diario
    - Alertas automaticos

  testing:
    - Pentest anual
    - Scan ASV trimestral
    - Vulnerability scan semanal

Certification:
  level: SAQ A-EP (escopo reduzido)
  auditor: QSA certificado
  renovacao: Anual
```

---

## 8. Infraestrutura Cloud

### 8.1 Arquitetura AWS

```
+------------------------------------------------------------------+
|                         AWS ARCHITECTURE                          |
+------------------------------------------------------------------+
|                                                                  |
|  REGION: sa-east-1 (Sao Paulo)                                   |
|  +------------------------------------------------------------+  |
|  |                                                            |  |
|  |  +------------------+                                      |  |
|  |  |   Route 53       |  DNS + Health Checks                 |  |
|  |  +--------+---------+                                      |  |
|  |           |                                                |  |
|  |  +--------v---------+                                      |  |
|  |  |   CloudFront     |  CDN + WAF + Shield                  |  |
|  |  +--------+---------+                                      |  |
|  |           |                                                |  |
|  |  +--------v---------+                                      |  |
|  |  |   ALB (Public)   |  Application Load Balancer           |  |
|  |  +--------+---------+                                      |  |
|  |           |                                                |  |
|  |  +--------v--------------------------------------------------+
|  |  |  VPC: 10.0.0.0/16                                        |
|  |  |  +---------------------------------------------------+   |
|  |  |  |  Public Subnets (10.0.1.0/24, 10.0.2.0/24)       |   |
|  |  |  |  +-------------+  +-------------+  +-------------+|   |
|  |  |  |  | NAT GW AZ-a |  | NAT GW AZ-b |  | Bastion     ||   |
|  |  |  |  +-------------+  +-------------+  +-------------+|   |
|  |  |  +---------------------------------------------------+   |
|  |  |                          |                               |
|  |  |  +---------------------------------------------------+   |
|  |  |  |  Private Subnets (10.0.10.0/24, 10.0.20.0/24)    |   |
|  |  |  |  +---------------------------------------------+ |   |
|  |  |  |  |            EKS Cluster                      | |   |
|  |  |  |  |  +-------+  +-------+  +-------+  +-------+ | |   |
|  |  |  |  |  | Auth  |  | User  |  |Account|  |Payment| | |   |
|  |  |  |  |  +-------+  +-------+  +-------+  +-------+ | |   |
|  |  |  |  |  +-------+  +-------+  +-------+  +-------+ | |   |
|  |  |  |  |  |Bucket |  | PIX   |  | Card  |  |Notify | | |   |
|  |  |  |  |  +-------+  +-------+  +-------+  +-------+ | |   |
|  |  |  |  +---------------------------------------------+ |   |
|  |  |  +---------------------------------------------------+   |
|  |  |                          |                               |
|  |  |  +---------------------------------------------------+   |
|  |  |  |  Data Subnets (10.0.100.0/24, 10.0.200.0/24)     |   |
|  |  |  |  +-----------+  +-----------+  +-----------+     |   |
|  |  |  |  | RDS       |  | ElastiCache|  | MSK      |     |   |
|  |  |  |  | (Primary) |  | (Redis)   |  | (Kafka)  |     |   |
|  |  |  |  +-----------+  +-----------+  +-----------+     |   |
|  |  |  |  +-----------+                                   |   |
|  |  |  |  | RDS       |                                   |   |
|  |  |  |  | (Replica) |                                   |   |
|  |  |  |  +-----------+                                   |   |
|  |  |  +---------------------------------------------------+   |
|  |  +----------------------------------------------------------+
|  |                                                            |  |
|  +------------------------------------------------------------+  |
|                                                                  |
|  DR REGION: us-east-1 (Virginia) - Cross-region replication     |
|                                                                  |
+------------------------------------------------------------------+
```

### 8.2 Servicos AWS

```yaml
Compute:
  eks:
    version: 1.28
    node_groups:
      general:
        instance_type: m6i.large
        min: 3
        max: 10
        disk: 100GB gp3
      compute:
        instance_type: c6i.xlarge
        min: 2
        max: 8

Database:
  rds:
    engine: PostgreSQL 16
    instance: db.r6g.xlarge
    storage: 500GB gp3
    multi_az: true
    read_replicas: 2
    backup_retention: 30 days
    encryption: AES-256 (KMS)

  elasticache:
    engine: Redis 7
    node_type: cache.r6g.large
    num_nodes: 3 (cluster mode)
    encryption: in-transit + at-rest

Messaging:
  msk:
    version: 3.5.1
    brokers: 3
    instance: kafka.m5.large
    storage: 500GB per broker
    retention: 7 days

Storage:
  s3:
    buckets:
      - greenlight-documents-prod
      - greenlight-backups-prod
      - greenlight-logs-prod
    versioning: enabled
    lifecycle:
      intelligent_tiering: 30 days
      glacier: 90 days

Networking:
  vpc:
    cidr: 10.0.0.0/16
    azs: 2 (sa-east-1a, sa-east-1b)

  cloudfront:
    origins:
      - ALB (API)
      - S3 (static)
    waf: enabled
    shield: standard (upgrade to advanced)

Security:
  kms:
    keys:
      - database-key
      - storage-key
      - secrets-key
    rotation: automatic (yearly)

  secrets_manager:
    - database credentials
    - api keys
    - certificates

  waf:
    rules:
      - AWS Managed Rules
      - SQL Injection
      - XSS
      - Rate limiting
```

### 8.3 Estimativa de Custos

```yaml
Monthly_Estimate_USD:
  compute:
    eks_nodes: $800  # 5 nodes average
    fargate: $200    # batch jobs

  database:
    rds_primary: $500
    rds_replicas: $600
    elasticache: $400

  messaging:
    msk: $500
    sqs_sns: $50

  storage:
    s3: $100
    ebs: $150

  networking:
    nat_gateway: $200
    data_transfer: $300
    cloudfront: $100

  security:
    waf: $50
    kms: $30
    secrets_manager: $20

  monitoring:
    cloudwatch: $100
    x-ray: $50

  total_base: ~$4,100/month

  scaling_factors:
    100k_users: 1x ($4,100)
    500k_users: 2.5x ($10,250)
    1M_users: 4x ($16,400)
```

---

## 9. DevOps e CI/CD

### 9.1 Pipeline de CI/CD

```
+------------------------------------------------------------------+
|                      CI/CD PIPELINE                               |
+------------------------------------------------------------------+
|                                                                  |
|  DEVELOPER                                                       |
|  +--------+                                                      |
|  | Commit |                                                      |
|  +---+----+                                                      |
|      |                                                           |
|      v                                                           |
|  +------------------------------------------------------------------+
|  |  CONTINUOUS INTEGRATION (GitHub Actions)                        |
|  |  +----------+  +----------+  +----------+  +----------+        |
|  |  | Lint     |  | Unit     |  | Security |  | Build    |        |
|  |  | (ESLint) |  | Tests    |  | Scan     |  | Docker   |        |
|  |  +----------+  +----------+  +----------+  +----------+        |
|  |       |             |             |             |              |
|  |       +-------------+-------------+-------------+              |
|  |                          |                                     |
|  |                    +-----v-----+                               |
|  |                    | Push to   |                               |
|  |                    | ECR       |                               |
|  |                    +-----------+                               |
|  +------------------------------------------------------------------+
|                              |                                   |
|                              v                                   |
|  +------------------------------------------------------------------+
|  |  CONTINUOUS DEPLOYMENT (ArgoCD)                                 |
|  |                                                                 |
|  |  DEV         STAGING       PRODUCTION                          |
|  |  +------+    +------+      +------+                            |
|  |  | Auto |    | Auto |      | Manual|                           |
|  |  |Deploy|--->|Deploy|----->|Approve|                           |
|  |  +------+    +------+      +------+                            |
|  |     |           |              |                               |
|  |     v           v              v                               |
|  |  +------+    +------+      +------+                            |
|  |  | E2E  |    | E2E  |      |Canary |                           |
|  |  |Tests |    |Tests |      |Deploy |                           |
|  |  +------+    +------+      +------+                            |
|  |                               |                                |
|  |                               v                                |
|  |                            +------+                            |
|  |                            |100%  |                            |
|  |                            |Rollout                            |
|  |                            +------+                            |
|  +------------------------------------------------------------------+
|                                                                  |
+------------------------------------------------------------------+
```

### 9.2 GitHub Actions Workflow

```yaml
# .github/workflows/ci-cd.yml

name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  AWS_REGION: sa-east-1
  ECR_REPOSITORY: greenlight-api
  EKS_CLUSTER: greenlight-prod

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_PASSWORD: test
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
      redis:
        image: redis:7
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
      - run: npm ci
      - run: npm run test:cov
      - uses: codecov/codecov-action@v3

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Snyk
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      - name: Run Trivy
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          severity: 'CRITICAL,HIGH'

  build:
    needs: [lint, test, security]
    runs-on: ubuntu-latest
    outputs:
      image_tag: ${{ steps.meta.outputs.tags }}
    steps:
      - uses: actions/checkout@v4

      - name: Configure AWS
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Login to ECR
        uses: aws-actions/amazon-ecr-login@v2

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          push: true
          tags: |
            ${{ env.ECR_REPOSITORY }}:${{ github.sha }}
            ${{ env.ECR_REPOSITORY }}:latest

  deploy-dev:
    if: github.ref == 'refs/heads/develop'
    needs: build
    runs-on: ubuntu-latest
    environment: development
    steps:
      - name: Deploy to Dev
        run: |
          # ArgoCD sync
          argocd app sync greenlight-dev --revision ${{ github.sha }}

  deploy-staging:
    if: github.ref == 'refs/heads/main'
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - name: Deploy to Staging
        run: |
          argocd app sync greenlight-staging --revision ${{ github.sha }}

      - name: Run E2E Tests
        run: |
          npm run test:e2e -- --env=staging

  deploy-prod:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Canary Deploy
        run: |
          argocd app set greenlight-prod \
            --parameter image.tag=${{ github.sha }}
          argocd app sync greenlight-prod \
            --strategy=canary --canary-percent=10

      - name: Monitor Canary
        run: |
          sleep 300  # 5 min
          # Check error rates, latency
          ./scripts/check-canary-health.sh

      - name: Full Rollout
        run: |
          argocd app sync greenlight-prod \
            --strategy=canary --canary-percent=100
```

### 9.3 Infrastructure as Code (Terraform)

```hcl
# terraform/main.tf

terraform {
  required_version = ">= 1.6"

  backend "s3" {
    bucket         = "greenlight-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "greenlight"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "greenlight-${var.environment}"
  cidr = "10.0.0.0/16"

  azs             = ["sa-east-1a", "sa-east-1b"]
  private_subnets = ["10.0.10.0/24", "10.0.20.0/24"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = var.environment != "prod"

  enable_dns_hostnames = true
  enable_dns_support   = true
}

# EKS Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "greenlight-${var.environment}"
  cluster_version = "1.28"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    general = {
      instance_types = ["m6i.large"]
      min_size       = 3
      max_size       = 10
      desired_size   = 3
    }
  }

  cluster_encryption_config = {
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }
}

# RDS PostgreSQL
module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "greenlight-${var.environment}"

  engine               = "postgres"
  engine_version       = "16"
  family               = "postgres16"
  major_engine_version = "16"
  instance_class       = var.environment == "prod" ? "db.r6g.xlarge" : "db.t3.medium"

  allocated_storage     = 100
  max_allocated_storage = 500
  storage_encrypted     = true
  kms_key_id           = aws_kms_key.rds.arn

  multi_az = var.environment == "prod"

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  backup_retention_period = 30
  deletion_protection     = true
}

# ElastiCache Redis
module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  cluster_id         = "greenlight-${var.environment}"
  engine             = "redis"
  engine_version     = "7.0"
  node_type          = "cache.r6g.large"
  num_cache_nodes    = 3

  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [aws_security_group.redis.id]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
}
```

---

## 10. Observabilidade

### 10.1 Stack de Observabilidade

```
+------------------------------------------------------------------+
|                    OBSERVABILITY STACK                            |
+------------------------------------------------------------------+
|                                                                  |
|  METRICS                                                         |
|  +------------------------------------------------------------+  |
|  |  Prometheus  -->  Grafana                                  |  |
|  |  - Application metrics                                     |  |
|  |  - Infrastructure metrics                                  |  |
|  |  - Custom business metrics                                 |  |
|  +------------------------------------------------------------+  |
|                                                                  |
|  LOGGING                                                         |
|  +------------------------------------------------------------+  |
|  |  Fluentd  -->  OpenSearch  -->  Kibana                     |  |
|  |  - Application logs                                        |  |
|  |  - Access logs                                             |  |
|  |  - Audit logs                                              |  |
|  +------------------------------------------------------------+  |
|                                                                  |
|  TRACING                                                         |
|  +------------------------------------------------------------+  |
|  |  OpenTelemetry  -->  Jaeger / AWS X-Ray                    |  |
|  |  - Distributed tracing                                     |  |
|  |  - Service dependencies                                    |  |
|  |  - Latency analysis                                        |  |
|  +------------------------------------------------------------+  |
|                                                                  |
|  ALERTING                                                        |
|  +------------------------------------------------------------+  |
|  |  AlertManager  -->  PagerDuty / Slack / SMS                |  |
|  |  - SLA monitoring                                          |  |
|  |  - Error rate alerts                                       |  |
|  |  - Business alerts                                         |  |
|  +------------------------------------------------------------+  |
|                                                                  |
+------------------------------------------------------------------+
```

### 10.2 Metricas Principais

```yaml
SLIs_SLOs:
  availability:
    sli: Uptime do servico
    slo: 99.95%
    measurement: (1 - error_requests/total_requests) * 100

  latency:
    sli: Tempo de resposta P99
    slo: < 200ms
    measurement: histogram_quantile(0.99, http_request_duration_seconds)

  throughput:
    sli: Requests por segundo
    slo: > 1000 RPS sustained
    measurement: rate(http_requests_total[5m])

Business_Metrics:
  transactions:
    - pix_transfers_total
    - pix_transfers_amount_total
    - card_transactions_total
    - card_transactions_amount_total

  users:
    - registrations_total
    - active_users_daily
    - active_users_monthly
    - churn_rate

  engagement:
    - app_opens_total
    - goals_created_total
    - goals_completed_total
    - chores_completed_total

  buckets:
    - bucket_balance_by_type
    - bucket_transfers_total
    - allocation_distribution

Application_Metrics:
  http:
    - http_requests_total{method, endpoint, status}
    - http_request_duration_seconds{method, endpoint}
    - http_request_size_bytes
    - http_response_size_bytes

  database:
    - db_query_duration_seconds
    - db_connections_active
    - db_connections_idle

  cache:
    - cache_hits_total
    - cache_misses_total
    - cache_latency_seconds

  queue:
    - queue_messages_total
    - queue_processing_duration
    - queue_dead_letter_total
```

### 10.3 Dashboards

```yaml
Executive_Dashboard:
  metrics:
    - Total de usuarios
    - Usuarios ativos (DAU/MAU)
    - Volume transacionado
    - Receita (estimada)
  refresh: 1 hora

Operations_Dashboard:
  metrics:
    - Availability (%)
    - Latency P50/P95/P99
    - Error rate
    - Throughput (RPS)
    - Active alerts
  refresh: 10 segundos

Service_Dashboard:
  per_service:
    - Request rate
    - Error rate
    - Latency distribution
    - Dependencies health
    - Pod/container metrics
  refresh: 30 segundos

Database_Dashboard:
  metrics:
    - Connections (active/idle)
    - Query performance
    - Replication lag
    - Disk usage
    - Cache hit ratio
  refresh: 1 minuto

Security_Dashboard:
  metrics:
    - Failed login attempts
    - Blocked requests (WAF)
    - Fraud alerts
    - Suspicious activities
  refresh: 1 minuto
```

### 10.4 Alertas

```yaml
Critical_Alerts:
  - name: HighErrorRate
    condition: error_rate > 1%
    duration: 5m
    action: PagerDuty (P0)

  - name: ServiceDown
    condition: up == 0
    duration: 1m
    action: PagerDuty (P0)

  - name: DatabaseReplicationLag
    condition: lag > 30s
    duration: 5m
    action: PagerDuty (P1)

  - name: FraudSpikeDetected
    condition: fraud_alerts > 10/min
    duration: 2m
    action: PagerDuty (P0) + Security Team

Warning_Alerts:
  - name: HighLatency
    condition: p99_latency > 500ms
    duration: 10m
    action: Slack

  - name: HighCPUUsage
    condition: cpu > 80%
    duration: 15m
    action: Slack

  - name: LowDiskSpace
    condition: disk_free < 20%
    duration: 30m
    action: Slack

  - name: CacheHitRateLow
    condition: cache_hit_rate < 80%
    duration: 15m
    action: Slack

Business_Alerts:
  - name: HighChargebackRate
    condition: chargebacks/transactions > 0.5%
    duration: 1h
    action: Email to Finance

  - name: KYCBacklog
    condition: pending_kyc > 1000
    duration: 30m
    action: Slack to Operations

  - name: PIXFailureSpike
    condition: pix_failures > 5%
    duration: 5m
    action: PagerDuty (P1)
```

### 10.5 Runbooks

```yaml
Runbook_ServiceDown:
  trigger: ServiceDown alert
  steps:
    1. Verificar status do pod (kubectl get pods)
    2. Verificar logs do pod (kubectl logs)
    3. Verificar recursos (CPU/Memory)
    4. Verificar dependencias (DB, Redis, Kafka)
    5. Se necessario, restart do pod
    6. Se persistir, rollback para versao anterior
    7. Notificar time de desenvolvimento

Runbook_HighErrorRate:
  trigger: HighErrorRate alert
  steps:
    1. Identificar endpoint com erro (Grafana)
    2. Verificar logs de erro (OpenSearch)
    3. Verificar traces (Jaeger)
    4. Identificar causa raiz
    5. Aplicar hotfix ou rollback
    6. Documentar incidente

Runbook_DatabaseIssue:
  trigger: Database alerts
  steps:
    1. Verificar conexoes ativas
    2. Identificar queries lentas
    3. Verificar locks
    4. Verificar replication lag
    5. Se necessario, failover para replica
    6. Contatar DBA de plantao
```

---

## Anexos

### A. Glossario Tecnico

| Termo | Definicao |
|-------|-----------|
| **BaaS** | Banking as a Service - Infraestrutura bancaria via API |
| **DICT** | Diretorio de Identificadores de Contas Transacionais (PIX) |
| **HSM** | Hardware Security Module |
| **KYC** | Know Your Customer |
| **MCC** | Merchant Category Code |
| **PAN** | Primary Account Number |
| **SPI** | Sistema de Pagamentos Instantaneos |

### B. Referencias

- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [12-Factor App](https://12factor.net/)
- [OWASP Security Guidelines](https://owasp.org/)
- [PCI DSS v4.0](https://www.pcisecuritystandards.org/)
- [Bacen - Resolucoes](https://www.bcb.gov.br/)

### C. Controle de Versao

| Versao | Data | Autor | Alteracoes |
|--------|------|-------|------------|
| 1.0 | Jan 2026 | Tech Team | Versao inicial |

---

**Aprovacoes:**

| Papel | Nome | Data | Assinatura |
|-------|------|------|------------|
| CTO | _____________ | ___/___/___ | _____________ |
| Tech Lead | _____________ | ___/___/___ | _____________ |
| Security | _____________ | ___/___/___ | _____________ |
| Arquiteto | _____________ | ___/___/___ | _____________ |
