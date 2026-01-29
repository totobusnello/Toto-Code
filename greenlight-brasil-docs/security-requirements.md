# Requisitos de Seguranca - Fintech de Educacao Financeira Familiar

> Documento de requisitos de seguranca para aplicativo mobile de educacao financeira para pais e filhos menores de idade no Brasil.

**Versao:** 1.0
**Data:** Janeiro 2026
**Classificacao:** Confidencial
**Responsavel:** Equipe de Seguranca da Informacao

---

## Sumario Executivo

Este documento define os requisitos de seguranca para uma fintech brasileira de educacao financeira familiar que processa dados sensiveis de menores de idade. O sistema deve estar em conformidade com:

- **LGPD** (Lei Geral de Protecao de Dados) - com atencao especial ao Art. 14 sobre dados de criancas
- **PCI-DSS** (Payment Card Industry Data Security Standard) - para processamento de cartoes
- **Resolucoes do Bacen** - para instituicoes de pagamento
- **Circular 3.978/2020** - PLD/FT (Prevencao a Lavagem de Dinheiro)

---

## 1. Threat Modeling

### 1.1 Metodologia

Utilizamos **STRIDE** (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) combinado com **DREAD** para priorizacao de riscos.

### 1.2 Ativos Criticos

| Ativo | Classificacao | Impacto se Comprometido |
|-------|---------------|-------------------------|
| Dados de menores (CPF, nome, foto) | Critico | Danos irreparaveis, multas LGPD |
| Credenciais bancarias dos pais | Critico | Fraude financeira, perda de confianca |
| Dados de transacoes | Alto | Fraude, lavagem de dinheiro |
| Tokens de autenticacao | Alto | Account takeover |
| Chaves de criptografia | Critico | Exposicao total de dados |
| Dados de cartao (PAN) | Critico | Fraude, multas PCI |

### 1.3 Principais Ameacas Identificadas

#### T01 - Account Takeover (ATO)
```
Vetor: Credential stuffing, phishing, SIM swap
Alvo: Contas de pais (acesso a dados dos filhos)
Impacto: Critico
Probabilidade: Alta
Mitigacao: MFA obrigatorio, device binding, velocity checks
```

#### T02 - Fraude de Identidade no Onboarding
```
Vetor: Documentos falsos, deepfakes, identidade roubada
Alvo: Processo de KYC
Impacto: Alto
Probabilidade: Media
Mitigacao: Liveness detection, validacao CPF, face match com documento
```

#### T03 - Vazamento de Dados de Menores
```
Vetor: SQL injection, IDOR, insider threat, backup exposto
Alvo: Base de dados de menores
Impacto: Critico (multas LGPD ate 2% faturamento)
Probabilidade: Media
Mitigacao: Criptografia, tokenizacao, access logging, DLP
```

#### T04 - Fraude em Transacoes
```
Vetor: Device emulation, transacoes nao autorizadas, replay attack
Alvo: Sistema de pagamentos/PIX
Impacto: Alto
Probabilidade: Alta
Mitigacao: Device fingerprint, velocity rules, confirmacao parental
```

#### T05 - Ataque a API
```
Vetor: API abuse, DDoS, broken auth, injection
Alvo: APIs de backend
Impacto: Alto
Probabilidade: Alta
Mitigacao: WAF, rate limiting, API gateway, input validation
```

#### T06 - Insider Threat
```
Vetor: Funcionario mal-intencionado, engenharia social
Alvo: Dados sensiveis, sistemas internos
Impacto: Critico
Probabilidade: Baixa
Mitigacao: Least privilege, audit logs, background check, DLP
```

#### T07 - Malware no Dispositivo
```
Vetor: App malicioso, overlay attack, keylogger
Alvo: Credenciais do usuario, dados no dispositivo
Impacto: Alto
Probabilidade: Media
Mitigacao: Root/jailbreak detection, secure keyboard, app attestation
```

#### T08 - Man-in-the-Middle (MitM)
```
Vetor: WiFi malicioso, certificate pinning bypass
Alvo: Comunicacao app-servidor
Impacto: Alto
Probabilidade: Media
Mitigacao: Certificate pinning, TLS 1.3, mutual TLS para APIs criticas
```

### 1.4 Matriz de Riscos

| Ameaca | Probabilidade | Impacto | Score | Prioridade |
|--------|--------------|---------|-------|------------|
| T01 - Account Takeover | Alta | Critico | 25 | P0 |
| T04 - Fraude Transacional | Alta | Alto | 20 | P0 |
| T03 - Vazamento Dados Menores | Media | Critico | 20 | P0 |
| T05 - Ataque a API | Alta | Alto | 20 | P1 |
| T02 - Fraude Onboarding | Media | Alto | 15 | P1 |
| T07 - Malware Dispositivo | Media | Alto | 15 | P1 |
| T08 - MitM | Media | Alto | 15 | P2 |
| T06 - Insider Threat | Baixa | Critico | 12 | P2 |

---

## 2. Requisitos de Autenticacao

### 2.1 Arquitetura de Autenticacao

```
+------------------+     +------------------+     +------------------+
|   App Mobile     |---->|   API Gateway    |---->|   Auth Service   |
|  (iOS/Android)   |     |   (Rate Limit)   |     |   (OAuth 2.0)    |
+------------------+     +------------------+     +------------------+
        |                                                  |
        v                                                  v
+------------------+                              +------------------+
| Device Security  |                              |   Identity       |
| - Biometrics     |                              |   Provider       |
| - PIN/Password   |                              |   - MFA          |
| - Device Binding |                              |   - Risk Engine  |
+------------------+                              +------------------+
```

### 2.2 Requisitos por Perfil de Usuario

#### 2.2.1 Pais/Responsaveis (Adultos)

| Requisito | Especificacao | Obrigatorio |
|-----------|---------------|-------------|
| **Cadastro** | Email + Senha forte (min 12 chars, complexidade) | Sim |
| **MFA** | TOTP ou SMS (fallback) obrigatorio | Sim |
| **Biometria** | Face ID / Touch ID para acesso rapido | Opcional |
| **Device Binding** | Maximo 3 dispositivos ativos | Sim |
| **Sessao** | Timeout 15 min inatividade, max 24h | Sim |
| **Reautenticacao** | Operacoes sensiveis (transferencia, config) | Sim |

**Politica de Senha para Pais:**
```
- Minimo 12 caracteres
- Pelo menos 1 maiuscula, 1 minuscula, 1 numero, 1 especial
- Nao pode conter nome, email ou data de nascimento
- Nao pode estar em lista de senhas vazadas (HaveIBeenPwned)
- Expiracao: 180 dias (com aviso 30 dias antes)
- Historico: ultimas 12 senhas nao podem ser reutilizadas
```

#### 2.2.2 Filhos (Menores de Idade)

| Requisito | Especificacao | Obrigatorio |
|-----------|---------------|-------------|
| **Cadastro** | Vinculado a conta do pai (sem email proprio) | Sim |
| **PIN** | 6 digitos para acesso ao app | Sim |
| **Biometria** | Face ID / Touch ID (se disponivel) | Opcional |
| **Device Binding** | Maximo 1 dispositivo por filho | Sim |
| **Sessao** | Timeout 5 min inatividade, max 4h | Sim |
| **Restricoes** | Nao pode alterar configs de seguranca | Sim |

**Politica de PIN para Filhos:**
```
- Exatamente 6 digitos
- Nao pode ser sequencial (123456, 654321)
- Nao pode ser repetido (111111, 222222)
- Nao pode ser data de nascimento
- Bloqueio apos 5 tentativas incorretas
- Reset apenas pelo pai/responsavel
```

### 2.3 Multi-Factor Authentication (MFA)

#### Metodos Suportados (ordem de preferencia):
1. **TOTP (Authenticator App)** - Recomendado
2. **Push Notification** - App proprio
3. **SMS OTP** - Fallback (risco de SIM swap)
4. **Email OTP** - Apenas para recuperacao

#### Step-Up Authentication (Operacoes Sensiveis):
```
Operacao                          | Autenticacao Adicional
----------------------------------|-------------------------
Transferencia > R$ 500            | Biometria + PIN
Novo destinatario PIX             | MFA + Confirmacao email
Alteracao de limites              | MFA + PIN
Adicionar novo dispositivo        | MFA + Email + PIN
Alteracao dados cadastrais        | MFA + Documento (foto)
Exclusao de conta                 | MFA + PIN + Confirmacao 48h
```

### 2.4 Device Binding e Confianca

```yaml
Device Trust Levels:
  trusted:
    - Dispositivo registrado > 30 dias
    - Sem mudanca de SIM
    - Sem root/jailbreak
    - Biometria habilitada
    - Limite: 100% das funcionalidades

  verified:
    - Dispositivo registrado < 30 dias
    - Passou por verificacao inicial
    - Limite: 80% (transferencias com step-up)

  new:
    - Primeiro acesso
    - Requer MFA para todas operacoes
    - Limite: 50% (apenas consultas, transferencias bloqueadas 24h)

  suspicious:
    - Root/jailbreak detectado
    - Emulador detectado
    - VPN/Proxy detectado
    - Limite: Bloqueado, contatar suporte
```

### 2.5 Recuperacao de Conta

```
Fluxo de Recuperacao (Pais):
1. Solicitar reset via email cadastrado
2. Verificacao de identidade (selfie + documento)
3. Confirmacao via SMS para celular cadastrado
4. Novo dispositivo requer cooldown de 24h
5. Notificacao em todos canais (email, SMS, push)

Fluxo de Recuperacao (Filhos):
1. Pai solicita reset na propria conta
2. Pai confirma com sua biometria/MFA
3. Novo PIN definido para o filho
4. Filho recebe notificacao no dispositivo
```

---

## 3. Protecao de Dados

### 3.1 Classificacao de Dados

| Categoria | Exemplos | Criptografia | Retencao |
|-----------|----------|--------------|----------|
| **PII Critico** | CPF, RG, biometria facial | AES-256 + HSM | Vida da conta + 5 anos |
| **PII Sensivel** | Nome, endereco, telefone | AES-256 | Vida da conta + 5 anos |
| **Financeiro** | Saldo, transacoes | AES-256 | 10 anos (Bacen) |
| **Cartao (PCI)** | PAN, CVV, validade | Tokenizacao | Nao armazenar CVV |
| **Autenticacao** | Senhas, PINs | Argon2id | Vida da conta |
| **Logs** | Access logs, audit trail | AES-256 | 5 anos |

### 3.2 Criptografia

#### 3.2.1 Em Transito (TLS)
```yaml
Requisitos TLS:
  versao_minima: TLS 1.3
  cipher_suites:
    - TLS_AES_256_GCM_SHA384
    - TLS_CHACHA20_POLY1305_SHA256
  certificate_pinning: obrigatorio
  hsts: max-age=31536000; includeSubDomains; preload

Mutual TLS (mTLS):
  apis_internas: obrigatorio
  parceiro_baas: obrigatorio
  webhook_callbacks: obrigatorio
```

#### 3.2.2 Em Repouso (Encryption at Rest)
```yaml
Database:
  tipo: PostgreSQL com pgcrypto
  algoritmo: AES-256-GCM
  chaves: Gerenciadas por AWS KMS / Azure Key Vault
  rotacao: Automatica a cada 90 dias

Storage:
  tipo: S3 / Azure Blob
  algoritmo: AES-256 (SSE-KMS)
  documentos_kyc: Criptografia adicional por cliente

Backups:
  algoritmo: AES-256
  chave: Separada da chave de producao
  teste_restore: Mensal
```

#### 3.2.3 Criptografia de Campos Sensiveis
```sql
-- Exemplo: Campo CPF criptografado
CREATE TABLE usuarios (
    id UUID PRIMARY KEY,
    cpf_encrypted BYTEA NOT NULL,  -- AES-256-GCM
    cpf_hash VARCHAR(64) NOT NULL, -- SHA-256 para busca
    nome_encrypted BYTEA NOT NULL,
    email VARCHAR(255) NOT NULL,   -- Indexado para login
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indice para busca por CPF (hash)
CREATE INDEX idx_cpf_hash ON usuarios(cpf_hash);
```

### 3.3 Tokenizacao

#### 3.3.1 Dados de Cartao (PCI-DSS)
```yaml
Tokenizacao_Cartao:
  provedor: Parceiro BaaS (Dock/Matera)
  formato_token: "tok_" + UUID
  dados_armazenados_local: Nenhum (apenas token)

  fluxo:
    1. Usuario insere dados do cartao
    2. Dados enviados diretamente ao tokenizador (client-side)
    3. Token retornado ao backend
    4. Backend armazena apenas token
    5. Transacoes usam token
```

#### 3.3.2 Dados Sensiveis (Internos)
```yaml
Tokenizacao_Interna:
  cpf: "cpf_" + hash_truncado(8) + UUID
  telefone: "tel_" + UUID

  vault:
    tipo: HashiCorp Vault
    path: secret/data/pii/{user_id}
    acesso: Apenas servicos autorizados
    audit: 100% das operacoes logadas
```

### 3.4 Mascaramento de Dados

```yaml
Regras_Mascaramento:
  cpf:
    exibicao: "***.***.XXX-XX"  # Ultimos 5 digitos
    logs: "***.***.***-**"      # Totalmente mascarado

  cartao:
    exibicao: "**** **** **** 1234"  # Ultimos 4 digitos
    logs: "**** **** **** ****"

  telefone:
    exibicao: "(**) ****-1234"
    logs: "(XX) XXXXX-XXXX"

  email:
    exibicao: "j***@g***.com"
    logs: "***@***.***"

  nome_filho:
    para_terceiros: Apenas primeiro nome
    em_notificacoes: Nome completo (para o pai)
```

### 3.5 Data Loss Prevention (DLP)

```yaml
Regras_DLP:
  deteccao:
    - Padrao CPF em logs/mensagens
    - Padrao cartao de credito
    - Padrao telefone brasileiro
    - Nomes de menores em contexto nao autorizado

  acoes:
    alerta: Notificar equipe de seguranca
    bloquear: Impedir envio/gravacao
    mascarar: Substituir por tokens

  canais_monitorados:
    - Logs de aplicacao
    - Mensagens Slack/Teams
    - Emails corporativos
    - Exports de banco de dados
    - Chamadas de API externas
```

---

## 4. Seguranca de API

### 4.1 Arquitetura de API

```
                    +----------------+
                    |    WAF/DDoS    |
                    | (Cloudflare/   |
                    |  AWS Shield)   |
                    +-------+--------+
                            |
                    +-------v--------+
                    |  API Gateway   |
                    | - Rate Limit   |
                    | - Auth Check   |
                    | - Request Val  |
                    +-------+--------+
                            |
        +-------------------+-------------------+
        |                   |                   |
+-------v-------+   +-------v-------+   +-------v-------+
|  Auth Service |   |  User Service |   | Payment Svc   |
|  (OAuth 2.0)  |   |  (Profile)    |   |  (Transacoes) |
+---------------+   +---------------+   +---------------+
```

### 4.2 Autenticacao de API

```yaml
OAuth2_Config:
  grant_types:
    - authorization_code (web)
    - device_code (mobile)

  access_token:
    tipo: JWT (RS256)
    expiracao: 15 minutos
    claims:
      - sub: user_id
      - scope: [read, write, transfer]
      - device_id: dispositivo
      - risk_score: nivel de risco

  refresh_token:
    tipo: Opaque (armazenado em Redis)
    expiracao: 7 dias
    rotacao: A cada uso
    revogacao: Imediata se comprometido
```

### 4.3 Rate Limiting

```yaml
Rate_Limits:
  global:
    requests_por_segundo: 10000

  por_ip:
    requests_por_minuto: 100
    burst: 20

  por_usuario:
    requests_por_minuto: 60
    burst: 10

  por_endpoint:
    /auth/login:
      requests_por_minuto: 5
      lockout_apos: 10 tentativas
      lockout_duracao: 15 minutos

    /auth/mfa:
      requests_por_minuto: 3
      lockout_apos: 5 tentativas

    /pix/transfer:
      requests_por_minuto: 10
      por_usuario: true

    /user/export-data:
      requests_por_dia: 3
      cooldown: 1 hora
```

### 4.4 Web Application Firewall (WAF)

```yaml
WAF_Rules:
  owasp_core_ruleset: habilitado

  regras_customizadas:
    - nome: "Block SQL Injection"
      padrao: "(?i)(union|select|insert|update|delete|drop|truncate)"
      acao: block

    - nome: "Block XSS"
      padrao: "<script|javascript:|on\\w+="
      acao: block

    - nome: "Block Path Traversal"
      padrao: "\\.\\./|\\.\\.%2f"
      acao: block

    - nome: "Rate Limit por Device ID"
      condicao: "header:X-Device-ID ausente"
      acao: challenge

    - nome: "Geo Block"
      paises_bloqueados: [RU, CN, KP, IR]
      excecao: VPN corporativa

  bot_protection:
    modo: challenge
    bots_permitidos: [googlebot, bingbot]
    fingerprinting: habilitado
```

### 4.5 Validacao de Input

```yaml
Validacao_Padrao:
  todos_endpoints:
    - Content-Type deve ser application/json
    - Tamanho maximo body: 1MB
    - Caracteres permitidos: UTF-8
    - Sanitizacao HTML/JS em strings

  campos_especificos:
    cpf:
      formato: "\\d{11}"
      validacao: Algoritmo modulo 11

    email:
      formato: RFC 5322
      dominio: Verificar MX record

    telefone:
      formato: "+55\\d{10,11}"

    valor_transacao:
      tipo: decimal(10,2)
      minimo: 0.01
      maximo: 50000.00

    pix_chave:
      tipos: [cpf, cnpj, email, telefone, evp]
      validacao: Por tipo
```

### 4.6 Seguranca de Headers

```yaml
Security_Headers:
  Content-Security-Policy: "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; connect-src 'self' https://api.greenlight.com.br; frame-ancestors 'none'"

  X-Content-Type-Options: "nosniff"
  X-Frame-Options: "DENY"
  X-XSS-Protection: "1; mode=block"
  Referrer-Policy: "strict-origin-when-cross-origin"
  Permissions-Policy: "geolocation=(), microphone=(), camera=(self)"

  Cache-Control: "no-store, no-cache, must-revalidate"
  Pragma: "no-cache"
```

### 4.7 API Versioning e Deprecation

```yaml
Versionamento:
  estrategia: URL path (/v1/, /v2/)

  deprecation:
    aviso: 6 meses antes
    header: "Deprecation: true"
    header: "Sunset: <data>"
    documentacao: Link para nova versao

  suporte_minimo: 2 versoes anteriores
```

---

## 5. Protecao Contra Fraude

### 5.1 Device Fingerprinting

```yaml
Device_Fingerprint:
  coletado_no_app:
    - Device ID (IDFV iOS, Android ID)
    - Modelo do dispositivo
    - Versao do SO
    - Idioma/Timezone
    - Screen resolution
    - Carrier/WiFi info
    - Installed apps (lista limitada)
    - Battery level pattern

  coletado_no_backend:
    - IP address
    - Geolocalizacao (IP-based)
    - User-Agent
    - TLS fingerprint

  sinais_de_risco:
    - Emulador detectado: +80 risk score
    - Root/Jailbreak: +70 risk score
    - VPN/Proxy: +30 risk score
    - Device ID novo: +20 risk score
    - Geolocalizacao inconsistente: +40 risk score
    - Horario incomum: +15 risk score
```

### 5.2 Velocity Checks

```yaml
Velocity_Rules:
  transacoes:
    - regra: "Mais de 5 PIX em 1 hora"
      acao: Bloquear + Notificar pai

    - regra: "Valor total > R$ 1000 em 24h (menor)"
      acao: Bloquear + Requerer aprovacao

    - regra: "Primeiro PIX para novo destinatario > R$ 200"
      acao: Step-up auth + Delay 30min

    - regra: "Transacao fora do horario permitido"
      acao: Bloquear

  login:
    - regra: "Login de novo dispositivo"
      acao: MFA + Notificacao

    - regra: "Login de nova localizacao (> 500km)"
      acao: MFA + Verificacao adicional

    - regra: "3 falhas de login em 5 minutos"
      acao: Lockout 15 min + Notificacao

  cadastro:
    - regra: "Mesmo CPF em multiplas contas"
      acao: Bloquear + Investigar

    - regra: "Mesmo device em multiplas contas"
      acao: Flag para revisao manual
```

### 5.3 Behavioral Analytics

```yaml
Behavioral_Baseline:
  metricas:
    - Horarios tipicos de acesso
    - Valores tipicos de transacao
    - Destinatarios frequentes
    - Tempo medio de sessao
    - Velocidade de digitacao (PIN)

  anomalias:
    - Desvio > 2 sigma do padrao: Alerta
    - Desvio > 3 sigma: Bloquear + Verificar

  machine_learning:
    modelo: Isolation Forest / Autoencoder
    features: 50+ signals
    retreino: Semanal
    threshold: Ajustado por segmento
```

### 5.4 Regras Anti-Fraude Especificas

```yaml
Regras_Menores:
  pix:
    - Menor nao pode enviar PIX para desconhecidos
    - Lista de contatos aprovados pelo pai
    - Limite noturno (22h-6h): 50% do diurno
    - Bloqueio automatico se 3 transacoes recusadas

  cartao:
    - Categorias bloqueadas: Jogos azar, adulto, armas
    - Merchant whitelist opcional
    - Notificacao em tempo real ao pai
    - Limite por transacao: Definido pelo pai

  recarga:
    - Origem apenas de conta do pai
    - PIX de terceiros: Apenas com aprovacao
    - Limite mensal de recarga: Configuravel

Regras_Pais:
  transferencias:
    - Novo destinatario: Cooldown 30 min
    - Valor alto (> R$ 5000): Delay 4h + MFA
    - Horario incomum: Step-up auth

  alteracoes:
    - Mudanca de telefone: Cooldown 24h
    - Mudanca de email: MFA + Confirmacao antigo email
    - Aumento de limites: Delay 48h
```

### 5.5 Integracao com Servicos Anti-Fraude

```yaml
Integracoes:
  bureau_credito:
    - Serasa Experian (score e alertas)
    - Boa Vista (SCPC)

  verificacao_identidade:
    - Serpro (validacao CPF)
    - Denatran (validacao CNH)
    - idwall / unico (liveness + face match)

  listas_negativas:
    - Lista interna de fraudadores
    - Lista compartilhada do setor
    - Bacen (CCF - Cadastro de Cheques sem Fundo)

  device_intelligence:
    - Incognia (localizacao comportamental)
    - SHIELD (device fingerprint)
```

---

## 6. LGPD para Menores

### 6.1 Requisitos Legais (Art. 14 LGPD)

```
Art. 14 - Tratamento de dados de criancas e adolescentes:
- Deve ser realizado em seu MELHOR INTERESSE
- Requer CONSENTIMENTO ESPECIFICO de pelo menos um dos pais/responsavel
- Informacoes sobre o tratamento devem ser fornecidas de maneira SIMPLES, CLARA e ACESSIVEL
```

### 6.2 Consentimento Parental

```yaml
Fluxo_Consentimento:
  1_cadastro_pai:
    - Pai cria conta propria primeiro
    - Aceita termos de uso gerais
    - Verifica identidade (KYC)

  2_adicao_filho:
    - Pai inicia cadastro do filho
    - Apresenta termos especificos para menores
    - Linguagem simplificada e clara
    - Destaque para:
      - Quais dados serao coletados
      - Por que sao necessarios
      - Com quem serao compartilhados
      - Por quanto tempo serao armazenados
      - Direitos do menor/responsavel

  3_confirmacao:
    - Aceite explicito (checkbox + assinatura digital)
    - Confirmacao via MFA
    - Registro com timestamp e IP
    - Copia enviada por email

  4_renovacao:
    - Consentimento renovado anualmente
    - Notificacao 30 dias antes
    - Novo aceite se houver mudancas materiais
```

### 6.3 Termos Simplificados para Menores

```markdown
## O que voce precisa saber (versao para menores)

### Quais informacoes guardamos?
- Seu nome e sobrenome
- Sua foto (para ter certeza que e voce)
- Seu CPF (documento do governo)
- Suas compras e mesada

### Por que guardamos?
- Para voce usar o app e seu cartao
- Para seus pais verem como voce gasta
- Para manter seu dinheiro seguro

### Quem mais pode ver?
- Seus pais sempre podem ver tudo
- A empresa do cartao ve quando voce compra algo
- Ninguem mais ve suas informacoes

### Seus direitos
- Voce pode pedir para ver tudo que guardamos
- Voce pode pedir para apagar (com seus pais)
- Se algo estiver errado, pode pedir para corrigir
```

### 6.4 Direitos dos Titulares (Menores)

| Direito | Solicitante | Prazo | Processo |
|---------|-------------|-------|----------|
| **Acesso** | Pai ou menor (>12 anos) | 15 dias | Exportar JSON/PDF via app |
| **Correcao** | Pai | 15 dias | Formulario no app |
| **Exclusao** | Pai | 15 dias | Solicitacao + confirmacao |
| **Portabilidade** | Pai | 15 dias | Exportar formato interoperavel |
| **Revogacao** | Pai | Imediato | Encerramento da conta do filho |
| **Oposicao** | Pai | 15 dias | Avaliar caso a caso |

### 6.5 Retencao e Exclusao de Dados

```yaml
Politica_Retencao:
  dados_cadastrais:
    retencao: Vida da conta + 5 anos
    base_legal: Obrigacao legal (Bacen, Receita)

  transacoes:
    retencao: 10 anos
    base_legal: Obrigacao legal (Bacen, contabil)

  documentos_kyc:
    retencao: 5 anos apos encerramento
    base_legal: PLD/FT

  logs_acesso:
    retencao: 5 anos
    base_legal: Seguranca e auditoria

  dados_marketing:
    retencao: Ate revogacao
    base_legal: Consentimento

Exclusao:
  processo:
    1. Solicitacao pelo pai
    2. Verificacao de identidade
    3. Verificacao de pendencias financeiras
    4. Anonimizacao de dados nao obrigatorios
    5. Retencao de dados obrigatorios (marcados)
    6. Confirmacao ao solicitante

  timeline:
    - Dados de marketing: Imediato
    - Dados cadastrais nao essenciais: 30 dias
    - Dados com retencao legal: Apos prazo legal
```

### 6.6 Relatorio de Impacto (RIPD)

```yaml
RIPD_Obrigatorio:
  escopo:
    - Tratamento de dados de menores
    - Dados financeiros
    - Dados biometricos (facial)

  conteudo:
    1. Descricao das operacoes de tratamento
    2. Finalidade e base legal
    3. Necessidade e proporcionalidade
    4. Riscos aos titulares
    5. Medidas de mitigacao
    6. Opiniao do DPO

  atualizacao: Anual ou quando houver mudancas

  disponibilidade: ANPD pode solicitar a qualquer momento
```

### 6.7 Incidentes Envolvendo Menores

```yaml
Protocolo_Incidente_Menor:
  classificacao: CRITICO (automatico)

  notificacao:
    - Pai/Responsavel: Imediato (< 1 hora)
    - DPO: Imediato
    - ANPD: Ate 2 dias uteis (se houver risco)
    - Conselho Tutelar: Se houver risco a crianca

  comunicacao_pai:
    - Canal: Push + Email + SMS
    - Conteudo:
      - O que aconteceu (linguagem clara)
      - Quais dados foram afetados
      - O que estamos fazendo
      - O que o pai deve fazer
      - Contato do DPO

  medidas_imediatas:
    - Suspender acesso do menor
    - Reset de credenciais
    - Monitoramento intensivo 30 dias
    - Oferecer protecao de credito (pais)
```

---

## 7. PCI-DSS Compliance Checklist

### 7.1 Escopo PCI

```yaml
Ambiente_PCI:
  em_escopo:
    - Checkout (entrada de dados de cartao)
    - API de tokenizacao
    - Comunicacao com processador
    - Logs de transacao (tokenizados)

  fora_escopo:
    - Backend principal (usa apenas tokens)
    - Mobile app (dados enviados direto ao tokenizador)
    - Banco de dados (nao armazena PAN)

  estrategia: SAQ A-EP (menor escopo possivel)
```

### 7.2 Checklist por Requisito

#### Requisito 1: Firewall e Segmentacao
- [ ] Firewall configurado entre DMZ e rede interna
- [ ] Segmentacao de rede PCI isolada
- [ ] Regras documentadas e revisadas trimestralmente
- [ ] Diagrama de rede atualizado

#### Requisito 2: Remover Defaults
- [ ] Senhas padrao alteradas em todos sistemas
- [ ] Servicos desnecessarios desabilitados
- [ ] Hardening baseado em CIS Benchmarks
- [ ] Inventario de sistemas atualizado

#### Requisito 3: Proteger Dados Armazenados
- [ ] PAN nao armazenado (tokenizado)
- [ ] CVV nunca armazenado
- [ ] Dados de autenticacao nao retidos apos autorizacao
- [ ] Criptografia AES-256 para dados sensiveis
- [ ] Gerenciamento de chaves documentado

#### Requisito 4: Criptografia em Transito
- [ ] TLS 1.2+ para todas transmissoes
- [ ] Certificados validos e nao expirados
- [ ] Certificate pinning no mobile app
- [ ] Sem transmissao de PAN por email/chat

#### Requisito 5: Antimalware
- [ ] Antimalware em todos sistemas Windows
- [ ] Atualizacoes automaticas de definicoes
- [ ] Scans periodicos agendados
- [ ] Logs de malware revisados

#### Requisito 6: Sistemas Seguros
- [ ] SDLC documentado com seguranca
- [ ] Code review antes de producao
- [ ] Testes de seguranca (SAST/DAST)
- [ ] Patches aplicados em 30 dias (criticos em 7 dias)
- [ ] Separacao de ambientes (dev/test/prod)

#### Requisito 7: Restricao de Acesso
- [ ] Acesso baseado em need-to-know
- [ ] Matriz de acesso documentada
- [ ] Revisao trimestral de acessos
- [ ] Default deny implementado

#### Requisito 8: Identificacao e Autenticacao
- [ ] IDs unicos para todos usuarios
- [ ] MFA para acesso administrativo
- [ ] Senhas fortes (12+ caracteres)
- [ ] Lockout apos 6 tentativas
- [ ] Sessoes timeout apos 15 min

#### Requisito 9: Acesso Fisico
- [ ] Datacenter com controle de acesso
- [ ] Visitantes escoltados e logados
- [ ] Midia fisica destruida adequadamente
- [ ] Inventario de midias atualizado

#### Requisito 10: Logging e Monitoramento
- [ ] Logs de acesso a dados de cartao
- [ ] Logs centralizados (SIEM)
- [ ] Retencao de 1 ano (3 meses online)
- [ ] Revisao diaria de logs
- [ ] Alertas para eventos suspeitos
- [ ] Sincronizacao de tempo (NTP)

#### Requisito 11: Testes de Seguranca
- [ ] Scan de vulnerabilidades trimestral
- [ ] Pentest anual (externo e interno)
- [ ] IDS/IPS implementado
- [ ] File integrity monitoring
- [ ] Scan ASV trimestral

#### Requisito 12: Politicas
- [ ] Politica de seguranca documentada
- [ ] Revisao anual de politicas
- [ ] Treinamento de funcionarios
- [ ] Programa de conscientizacao
- [ ] Plano de resposta a incidentes

### 7.3 Timeline de Compliance

```
Mes 1-2: Gap assessment e planejamento
Mes 3-4: Implementacao de controles
Mes 5: Scan ASV e remediacoes
Mes 6: Pentest e remediacoes
Mes 7: Auditoria interna
Mes 8: SAQ A-EP ou audit QSA
Mes 9+: Manutencao continua
```

---

## 8. Incident Response Plan

### 8.1 Classificacao de Incidentes

| Severidade | Descricao | Exemplos | SLA Resposta |
|------------|-----------|----------|--------------|
| **P0 - Critico** | Impacto massivo, dados expostos | Vazamento dados menores, ransomware | 15 min |
| **P1 - Alto** | Servico indisponivel ou fraude ativa | DDoS, account takeover em massa | 30 min |
| **P2 - Medio** | Degradacao ou vulnerabilidade explorada | API abuse, vulnerabilidade critica | 2 horas |
| **P3 - Baixo** | Potencial risco, sem impacto atual | Vulnerabilidade descoberta, phishing | 24 horas |

### 8.2 Equipe de Resposta (CSIRT)

```yaml
CSIRT:
  lider_incidente:
    papel: Coordenacao geral
    contato: +55 11 XXXXX-XXXX
    backup: CTO

  analista_seguranca:
    papel: Investigacao tecnica
    contato: security@empresa.com.br

  comunicacao:
    papel: Comunicacao interna/externa
    contato: comms@empresa.com.br

  juridico:
    papel: Aspectos legais, LGPD
    contato: legal@empresa.com.br

  dpo:
    papel: Protecao de dados
    contato: dpo@empresa.com.br

  escalacao_executiva:
    - CEO: Para P0 e comunicacao publica
    - CTO: Para decisoes tecnicas criticas
    - CFO: Para impacto financeiro
```

### 8.3 Playbooks de Resposta

#### Playbook 1: Vazamento de Dados
```yaml
Vazamento_Dados:
  deteccao:
    - Alerta de DLP
    - Denuncia externa
    - Monitoramento dark web

  contencao_imediata:
    1. Identificar origem do vazamento
    2. Revogar acessos comprometidos
    3. Isolar sistemas afetados
    4. Preservar evidencias

  investigacao:
    1. Analisar logs de acesso
    2. Identificar dados afetados
    3. Identificar titulares afetados
    4. Determinar causa raiz

  erradicacao:
    1. Corrigir vulnerabilidade
    2. Resetar credenciais afetadas
    3. Atualizar controles

  notificacao:
    - Titulares afetados: Ate 72h
    - ANPD: Ate 2 dias uteis
    - Bacen: Se envolve dados financeiros
    - Policia: Se crime identificado

  recuperacao:
    1. Restaurar servicos
    2. Monitoramento intensivo
    3. Verificar integridade

  licoes_aprendidas:
    - Reuniao post-mortem em 7 dias
    - Documentar timeline
    - Atualizar controles
    - Treinar equipe
```

#### Playbook 2: Ransomware
```yaml
Ransomware:
  deteccao:
    - Alerta de antimalware
    - Arquivos criptografados
    - Nota de resgate

  contencao_imediata:
    1. DESCONECTAR sistemas afetados da rede
    2. NAO DESLIGAR (preservar memoria)
    3. Isolar backup (verificar se nao afetado)
    4. Ativar plano de continuidade

  decisao_pagamento:
    - Politica: NAO PAGAR
    - Consultar juridico e autoridades

  recuperacao:
    1. Identificar variante do ransomware
    2. Verificar se ha decryptor disponivel
    3. Restaurar de backup limpo
    4. Reconstruir sistemas se necessario

  comunicacao:
    - Usuarios: "Manutencao de emergencia"
    - Autoridades: Policia Federal (crimes ciberneticos)
```

#### Playbook 3: Account Takeover
```yaml
Account_Takeover:
  deteccao:
    - Alerta de velocity
    - Denuncia do usuario
    - Transacao suspeita

  contencao_imediata:
    1. Bloquear conta afetada
    2. Reverter transacoes fraudulentas
    3. Revogar todas sessoes

  investigacao:
    1. Analisar metodo de comprometimento
    2. Verificar outras contas do mesmo padrao
    3. Identificar device/IP do atacante

  remediacoes:
    1. Contatar usuario legitimo
    2. Reset de credenciais
    3. Reativar com verificacao reforçada
    4. Bloquear device/IP malicioso

  prevencao:
    - Adicionar indicadores a blacklist
    - Ajustar regras de deteccao
```

### 8.4 Comunicacao de Crise

```yaml
Templates_Comunicacao:

  notificacao_usuario:
    assunto: "Aviso de Seguranca - [Empresa]"
    conteudo: |
      Prezado(a) [Nome],

      Identificamos uma atividade incomum em sua conta em [data].

      O que aconteceu:
      [Descricao simples e clara]

      O que fizemos:
      [Acoes tomadas]

      O que voce deve fazer:
      1. [Acao 1]
      2. [Acao 2]

      Se voce nao reconhece esta atividade, entre em contato
      imediatamente: [telefone/email]

      Atenciosamente,
      Equipe de Seguranca

  notificacao_imprensa:
    - Apenas apos aprovacao do CEO
    - Preparar Q&A
    - Designar porta-voz unico

  notificacao_anpd:
    - Formulario oficial da ANPD
    - Prazo: 2 dias uteis
    - Conteudo: Natureza, titulares afetados, medidas
```

### 8.5 Testes do Plano

```yaml
Testes_IRP:
  tabletop_exercise:
    frequencia: Trimestral
    participantes: CSIRT + executivos
    cenarios:
      - Vazamento de dados de menores
      - Ransomware
      - Insider threat

  simulacao_tecnica:
    frequencia: Semestral
    tipo: Red team exercise
    escopo: Ambiente de staging

  teste_comunicacao:
    frequencia: Trimestral
    tipo: Ativacao da arvore de chamadas

  revisao_plano:
    frequencia: Anual
    gatilho: Apos incidente real ou mudanca significativa
```

---

## 9. Penetration Testing Requirements

### 9.1 Escopo de Testes

```yaml
Escopo_Pentest:
  aplicacao_mobile:
    - iOS app
    - Android app
    - Armazenamento local
    - Comunicacao de rede
    - Certificate pinning bypass
    - Root/jailbreak bypass
    - Reverse engineering

  api_backend:
    - Autenticacao e autorizacao
    - Injection (SQL, NoSQL, Command)
    - IDOR e broken access control
    - Business logic flaws
    - Rate limiting bypass
    - API abuse scenarios

  infraestrutura:
    - Scan de vulnerabilidades externo
    - Pentest de perimetro
    - Cloud configuration review
    - Kubernetes security

  social_engineering:
    - Phishing simulation (funcionarios)
    - Vishing (telefone)
    - Pretexting
```

### 9.2 Tipos de Teste

| Tipo | Frequencia | Executor | Foco |
|------|------------|----------|------|
| **Scan Automatizado** | Semanal | Interno (DAST) | Vulnerabilidades conhecidas |
| **Pentest Web/API** | Trimestral | Externo | OWASP Top 10, logica |
| **Pentest Mobile** | Semestral | Externo | OWASP Mobile Top 10 |
| **Pentest Infra** | Anual | Externo | Perimetro, cloud |
| **Red Team** | Anual | Externo | Cenario completo de ataque |
| **Social Engineering** | Semestral | Externo | Fator humano |

### 9.3 Metodologias

```yaml
Metodologias_Requeridas:
  web_api:
    - OWASP Testing Guide v4.2
    - OWASP API Security Top 10
    - PTES (Penetration Testing Execution Standard)

  mobile:
    - OWASP Mobile Security Testing Guide (MSTG)
    - OWASP Mobile Top 10

  infraestrutura:
    - NIST SP 800-115
    - PTES
    - CIS Controls assessment

  cloud:
    - CSA Cloud Controls Matrix
    - AWS/Azure/GCP Well-Architected Framework
```

### 9.4 Requisitos do Fornecedor

```yaml
Requisitos_Fornecedor:
  certificacoes:
    obrigatorias:
      - OSCP ou OSCE
      - CEH ou similar
    desejaveis:
      - OSWE (web)
      - OSMR (mobile)
      - AWS Security Specialty

  experiencia:
    - Minimo 5 anos em pentest
    - Experiencia em fintech/bancos
    - Referencias verificaveis

  seguros:
    - Seguro de responsabilidade civil
    - Acordo de confidencialidade (NDA)

  entregaveis:
    - Relatorio executivo
    - Relatorio tecnico detalhado
    - Evidencias (screenshots, PoC)
    - Lista de vulnerabilidades com CVSS
    - Recomendacoes de correcao
    - Reteste apos correcoes
```

### 9.5 Regras de Engajamento

```yaml
Rules_of_Engagement:
  autorizacao:
    - Carta de autorizacao assinada pelo CEO/CTO
    - Lista de IPs/dominios em escopo
    - Lista de IPs/dominios fora de escopo
    - Contatos de emergencia

  restricoes:
    - Nao realizar DoS/DDoS
    - Nao exfiltrar dados reais de clientes
    - Nao modificar dados de producao
    - Nao testar em horario de pico (9h-18h)
    - Parar imediatamente se solicitado

  comunicacao:
    - Canal seguro para achados criticos
    - Report imediato de vulnerabilidade critica
    - Daily standup durante teste
    - Debrief ao final

  ambiente:
    - Preferencia: Ambiente de staging
    - Producao: Apenas com autorizacao especial
    - Dados: Usar dados sinteticos quando possivel
```

### 9.6 Processo de Remediacoes

```yaml
Processo_Remediacoes:
  classificacao_cvss:
    critico (9.0-10.0): Correcao em 7 dias
    alto (7.0-8.9): Correcao em 30 dias
    medio (4.0-6.9): Correcao em 90 dias
    baixo (0.1-3.9): Correcao em 180 dias

  workflow:
    1. Receber relatorio de pentest
    2. Triagem e validacao dos achados
    3. Criar tickets para cada vulnerabilidade
    4. Priorizar com base em CVSS e contexto
    5. Desenvolver e testar correcoes
    6. Deploy das correcoes
    7. Solicitar reteste
    8. Fechar vulnerabilidade apos confirmacao

  excecoes:
    - Justificativa por escrito
    - Aprovacao do CISO
    - Controles compensatorios documentados
    - Revisao trimestral
```

---

## 10. Security Monitoring e Alertas

### 10.1 Arquitetura de Monitoramento

```
+------------------+     +------------------+     +------------------+
|   Aplicacoes     |---->|   Log Shipper    |---->|      SIEM        |
|   (Apps, APIs)   |     |   (Fluentd)      |     |   (Splunk/ELK)   |
+------------------+     +------------------+     +--------+---------+
                                                          |
+------------------+     +------------------+              |
| Infrastructure   |---->|   Metrics        |              |
| (Cloud, K8s)     |     |   (Prometheus)   |              |
+------------------+     +--------+---------+              |
                                  |                       |
                         +--------v---------+    +--------v---------+
                         |   Grafana        |    |   Alert Manager  |
                         |   (Dashboards)   |    |   (PagerDuty)    |
                         +------------------+    +------------------+
```

### 10.2 Fontes de Log

```yaml
Fontes_Log:
  aplicacao:
    - Logs de acesso (quem, quando, o que)
    - Logs de erro
    - Logs de transacao
    - Logs de autenticacao

  infraestrutura:
    - Logs de firewall/WAF
    - Logs de VPC Flow
    - Logs de DNS
    - Logs de load balancer

  seguranca:
    - Logs de IDS/IPS
    - Logs de antimalware
    - Logs de DLP
    - Logs de CASB

  cloud:
    - AWS CloudTrail
    - Azure Activity Log
    - GCP Audit Log

  kubernetes:
    - API Server audit logs
    - Pod logs
    - Network policy logs
```

### 10.3 Alertas de Seguranca

#### Categoria: Autenticacao

| Alerta | Condicao | Severidade | Acao |
|--------|----------|------------|------|
| Brute Force | >10 falhas login/5min mesmo IP | Alto | Bloquear IP, notificar SOC |
| Credential Stuffing | >100 falhas login/hora diferentes users | Critico | Ativar CAPTCHA, investigar |
| MFA Bypass Attempt | MFA falho apos login sucesso | Alto | Bloquear sessao, notificar usuario |
| Impossible Travel | Login de 2 locais >500km em <1h | Medio | Step-up auth, notificar |
| New Device Login | Login de device nao reconhecido | Baixo | Notificar usuario |

#### Categoria: Transacoes

| Alerta | Condicao | Severidade | Acao |
|--------|----------|------------|------|
| High Value Transfer | Transferencia >R$5000 | Medio | Notificar, delay 30min |
| Unusual Time | Transacao 2h-6h | Baixo | Log para analise |
| New Recipient High Value | Novo destinatario >R$1000 | Alto | Bloquear, requerer aprovacao |
| Velocity Exceeded | >5 transacoes/hora (menor) | Alto | Bloquear, notificar pai |
| Blocked Category | Transacao em categoria bloqueada | Medio | Bloquear, notificar pai |

#### Categoria: Sistema

| Alerta | Condicao | Severidade | Acao |
|--------|----------|------------|------|
| DDoS Detected | Traffic >10x baseline | Critico | Ativar mitigacao, escalar |
| SQL Injection | Pattern detectado no WAF | Alto | Bloquear, investigar |
| Data Exfiltration | Download >1GB por usuario | Alto | Bloquear, investigar |
| Privilege Escalation | Usuario ganhou admin | Critico | Revogar, investigar |
| Config Change | Mudanca em security group | Medio | Revisar, aprovar |

#### Categoria: Compliance

| Alerta | Condicao | Severidade | Acao |
|--------|----------|------------|------|
| PII Access | Acesso a dados de menor por funcionario | Medio | Log, revisar semanalmente |
| Mass Data Export | Export de >1000 registros | Alto | Bloquear, investigar |
| Unencrypted Data | Dados sensiveis sem criptografia | Critico | Corrigir imediatamente |
| Retention Exceeded | Dados alem do prazo de retencao | Medio | Iniciar processo de exclusao |

### 10.4 Dashboards de Seguranca

```yaml
Dashboards:
  executive_summary:
    - Security score geral
    - Incidentes por severidade (ultimos 30 dias)
    - Vulnerabilidades abertas (por criticidade)
    - Compliance status
    - Tendencias de ameacas

  operacional:
    - Eventos de seguranca em tempo real
    - Top 10 IPs bloqueados
    - Taxa de falhas de autenticacao
    - Transacoes suspeitas
    - Alertas ativos

  fraude:
    - Transacoes bloqueadas por fraude
    - Chargebacks
    - Account takeover attempts
    - Device risk scores
    - Geographic anomalies

  compliance:
    - Status de controles PCI
    - Requisicoes LGPD (SAR)
    - Usuarios com acesso privilegiado
    - Rotacao de credenciais
    - Patches pendentes
```

### 10.5 Metricas de Seguranca (KPIs)

```yaml
KPIs_Seguranca:
  deteccao:
    - MTTD (Mean Time to Detect): Target <1h
    - Taxa de falsos positivos: Target <10%
    - Cobertura de logs: Target 100%

  resposta:
    - MTTR (Mean Time to Respond): Target <4h (P0/P1)
    - MTTC (Mean Time to Contain): Target <1h (P0)
    - Incidentes resolvidos em SLA: Target >95%

  vulnerabilidades:
    - Vulnerabilidades criticas abertas: Target 0
    - Tempo medio de correcao (critico): Target <7 dias
    - % de sistemas patcheados: Target >95%

  compliance:
    - Controles PCI em conformidade: Target 100%
    - Requisicoes LGPD atendidas em SLA: Target 100%
    - Treinamentos de seguranca completos: Target >95%

  fraude:
    - Taxa de fraude: Target <0.1%
    - Chargebacks: Target <0.5%
    - Account takeover: Target <0.01%
```

### 10.6 Retencao de Logs

| Tipo de Log | Retencao Online | Retencao Arquivo | Base Legal |
|-------------|-----------------|------------------|------------|
| Logs de seguranca | 90 dias | 5 anos | PCI-DSS, LGPD |
| Logs de transacao | 1 ano | 10 anos | Bacen |
| Logs de acesso | 90 dias | 5 anos | LGPD |
| Logs de auditoria | 1 ano | 7 anos | Compliance |
| Logs de aplicacao | 30 dias | 1 ano | Operacional |

### 10.7 Integracao e Automacao

```yaml
Integracoes_SOAR:
  playbooks_automaticos:
    - Bloquear IP apos threshold de falhas
    - Revogar sessoes em account takeover
    - Criar ticket para vulnerabilidade critica
    - Notificar on-call para P0/P1
    - Coletar evidencias automaticamente

  enrichment:
    - VirusTotal (hashes, URLs)
    - AbuseIPDB (reputacao IP)
    - Shodan (info de dispositivo)
    - Have I Been Pwned (credenciais vazadas)

  orquestracao:
    - PagerDuty (alertas)
    - Slack (notificacoes)
    - Jira (tickets)
    - Confluence (documentacao)
```

---

## Anexos

### A. Glossario

| Termo | Definicao |
|-------|-----------|
| **ATO** | Account Takeover - tomada de conta por atacante |
| **CVSS** | Common Vulnerability Scoring System |
| **DLP** | Data Loss Prevention |
| **HSM** | Hardware Security Module |
| **IDOR** | Insecure Direct Object Reference |
| **KYC** | Know Your Customer |
| **MTTD** | Mean Time to Detect |
| **MTTR** | Mean Time to Respond |
| **PAN** | Primary Account Number (numero do cartao) |
| **RIPD** | Relatorio de Impacto a Protecao de Dados |
| **SAQ** | Self-Assessment Questionnaire (PCI) |
| **SIEM** | Security Information and Event Management |
| **SOAR** | Security Orchestration, Automation and Response |
| **TOTP** | Time-based One-Time Password |

### B. Referencias

- [LGPD - Lei 13.709/2018](http://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm)
- [PCI-DSS v4.0](https://www.pcisecuritystandards.org/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Mobile Top 10](https://owasp.org/www-project-mobile-top-10/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [CIS Controls](https://www.cisecurity.org/controls/)
- [Bacen - Resolucao 4.658](https://www.bcb.gov.br/estabilidadefinanceira/exibenormativo?tipo=Resolu%C3%A7%C3%A3o&numero=4658)

### C. Controle de Versao

| Versao | Data | Autor | Alteracoes |
|--------|------|-------|------------|
| 1.0 | Jan 2026 | Security Team | Versao inicial |

---

**Aprovacoes:**

| Papel | Nome | Data | Assinatura |
|-------|------|------|------------|
| CISO | _____________ | ___/___/___ | _____________ |
| DPO | _____________ | ___/___/___ | _____________ |
| CTO | _____________ | ___/___/___ | _____________ |
| CEO | _____________ | ___/___/___ | _____________ |
