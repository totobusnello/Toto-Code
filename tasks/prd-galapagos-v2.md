# PRD: GalapagosApp v2 - Remote Backend & Security Upgrade

## Overview

Evolução do GalapagosApp de um app local para uma solução completa com backend remoto, segurança robusta e deploy para iPhone. O app extrai dados de portfólio do portal Galápagos Capital e os exibe em um dashboard nativo.

**Arquitetura Atual:**
- React Native/Expo SDK 54
- WebView com JavaScript injection para extrair dados
- Cache local (AsyncStorage + SecureStore)
- Backend: PocketBase (configurado) + Supabase (configurado)
- Testes: Playwright configurado

**Arquitetura Alvo:**
- Backend: PocketBase hospedado no Railway.com
- Segurança: Criptografia AES-256, HTTPS only, session timeout
- Deploy: TestFlight para iPhone
- Sync: Realtime entre dispositivos

---

## Goals

1. **Backend Remoto Funcional** - PocketBase rodando no Railway, acessível de qualquer lugar
2. **Segurança de Produção** - Eliminar todas as vulnerabilidades críticas identificadas
3. **Deploy iOS** - App funcionando no iPhone via TestFlight
4. **Experiência Premium** - UI/UX aprimorada com gráficos, notificações e offline-first

## Non-Goals

- Versão Android (foco no iPhone por enquanto)
- Múltiplas contas/empresas (single-tenant)
- Login OAuth (apenas email/senha)
- Criptografia end-to-end complexa (usar TLS + criptografia local)

---

## User Stories

### FASE 1: INFRAESTRUTURA (Backend Remoto)

#### US-001: Deploy PocketBase no Railway

**Description:** Como usuário, quero que meus dados sejam salvos na nuvem para acessar de qualquer dispositivo.

**Acceptance Criteria:**
- [ ] PocketBase rodando no Railway.com
- [ ] URL pública HTTPS configurada
- [ ] Collections criadas: users, portfolios, historical
- [ ] Regras de acesso (RLS) configuradas
- [ ] Health check endpoint funcionando
- [ ] App conectando ao backend remoto

**Technical Approach:**
```bash
# Railway CLI
railway login
railway init
railway link

# Dockerfile para PocketBase
FROM alpine:latest
RUN apk add --no-cache unzip ca-certificates
ADD https://github.com/pocketbase/pocketbase/releases/download/v0.22.0/pocketbase_0.22.0_linux_amd64.zip /tmp/
RUN unzip /tmp/pocketbase_0.22.0_linux_amd64.zip -d /pb/
EXPOSE 8080
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
```

**Files to modify:**
- `src/config/pocketbase.js` - URL do Railway
- Criar `railway.toml` na raiz
- Criar `Dockerfile` para deploy

---

#### US-002: Configurar Collections no PocketBase

**Description:** Como desenvolvedor, preciso das collections corretas no PocketBase para o app funcionar.

**Acceptance Criteria:**
- [ ] Collection `users` com campos: email, name, avatar
- [ ] Collection `portfolios` com campos: user (relation), data (json), updated_at
- [ ] Collection `historical` com campos: user (relation), date, total_patrimonio, renda_fixa, renda_variavel, outras_classes
- [ ] Rules configuradas: usuário só acessa seus próprios dados
- [ ] Índices criados para performance

**Schema PocketBase:**
```javascript
// users (auth collection - já existe por padrão)

// portfolios
{
  "name": "portfolios",
  "type": "base",
  "schema": [
    { "name": "user", "type": "relation", "options": { "collectionId": "users", "maxSelect": 1 } },
    { "name": "data", "type": "json" },
    { "name": "updated_at", "type": "date" }
  ],
  "listRule": "@request.auth.id = user",
  "viewRule": "@request.auth.id = user",
  "createRule": "@request.auth.id != ''",
  "updateRule": "@request.auth.id = user",
  "deleteRule": "@request.auth.id = user"
}

// historical
{
  "name": "historical",
  "type": "base",
  "schema": [
    { "name": "user", "type": "relation", "options": { "collectionId": "users" } },
    { "name": "date", "type": "date" },
    { "name": "total_patrimonio", "type": "number" },
    { "name": "renda_fixa", "type": "number" },
    { "name": "renda_variavel", "type": "number" },
    { "name": "outras_classes", "type": "number" }
  ],
  "listRule": "@request.auth.id = user",
  "viewRule": "@request.auth.id = user",
  "createRule": "@request.auth.id != ''",
  "updateRule": null,
  "deleteRule": "@request.auth.id = user",
  "indexes": ["CREATE UNIQUE INDEX idx_user_date ON historical(user, date)"]
}
```

---

#### US-003: Atualizar Config do App para Railway

**Description:** Como desenvolvedor, preciso que o app aponte para o backend no Railway.

**Acceptance Criteria:**
- [ ] Variável de ambiente POCKETBASE_URL configurada
- [ ] Fallback para localhost em desenvolvimento
- [ ] Detecção automática de ambiente (dev/prod)
- [ ] Retry automático em caso de falha de conexão

**Files to modify:**
- `src/config/pocketbase.js`
- `app.json` (expo extra config)

---

### FASE 2: SEGURANÇA

#### US-004: Upgrade Criptografia para AES-256

**Description:** Como usuário, quero que meus dados financeiros sejam criptografados com algoritmo seguro.

**Acceptance Criteria:**
- [ ] Substituir XOR por AES-256-GCM
- [ ] Chave derivada de senha do usuário (PBKDF2)
- [ ] IV único por operação
- [ ] Dados em cache sempre criptografados
- [ ] Testes de criptografia/descriptografia

**Technical Approach:**
```javascript
// Usar expo-crypto para AES
import * as Crypto from 'expo-crypto';

// Derivar chave da senha
async function deriveKey(password, salt) {
  // PBKDF2 não disponível diretamente, usar SHA-256 iterativo
  let key = password + salt;
  for (let i = 0; i < 10000; i++) {
    key = await Crypto.digestStringAsync(Crypto.CryptoDigestAlgorithm.SHA256, key);
  }
  return key;
}
```

**Files to modify:**
- `src/services/SecurityService.js`

---

#### US-005: Implementar Session Timeout

**Description:** Como usuário, quero que o app faça logout automático após inatividade para proteger meus dados.

**Acceptance Criteria:**
- [ ] Timeout de 5 minutos de inatividade
- [ ] Timer resetado em qualquer interação
- [ ] Aviso 30 segundos antes do logout
- [ ] Opção de "manter conectado" por 24h
- [ ] Logout limpa cache criptografado

**Files to modify:**
- `App.js` - adicionar listener de atividade
- `src/services/SessionService.js` - novo arquivo

---

#### US-006: Remover Console.logs de Produção

**Description:** Como desenvolvedor, preciso garantir que dados sensíveis não vazem nos logs.

**Acceptance Criteria:**
- [ ] Todos os console.log condicionais com __DEV__
- [ ] Nenhum dado financeiro logado mesmo em dev
- [ ] Logger centralizado com níveis (debug, info, warn, error)
- [ ] Build de produção sem logs

**Files to modify:**
- Todos os arquivos em `src/services/`
- `src/utils/InjectionScript.js`
- Criar `src/utils/Logger.js`

---

#### US-007: Hardening WebView

**Description:** Como usuário, quero que a WebView seja segura contra ataques.

**Acceptance Criteria:**
- [ ] Whitelist de domínios estrita
- [ ] Bloquear navegação para URLs não permitidas
- [ ] Desabilitar JavaScript em páginas externas (exceto Galápagos)
- [ ] Limpar cookies ao logout
- [ ] Timeout de sessão WebView

**Files to modify:**
- `App.js` - props da WebView
- `src/services/SecurityService.js` - validação de URL

---

### FASE 3: BUILD iOS

#### US-008: Configurar EAS Build para iOS

**Description:** Como desenvolvedor, preciso configurar o build para gerar o app iOS.

**Acceptance Criteria:**
- [ ] `eas.json` configurado para iOS
- [ ] Apple Developer account vinculada
- [ ] Provisioning profile configurado
- [ ] Build passando sem erros
- [ ] Arquivo .ipa gerado

**Files to modify:**
- `eas.json`
- `app.json` (iOS config)

---

#### US-009: Configurar TestFlight

**Description:** Como usuário, quero instalar o app no meu iPhone via TestFlight.

**Acceptance Criteria:**
- [ ] App submetido ao TestFlight
- [ ] Build disponível para instalação
- [ ] Convite enviado para tester
- [ ] App funcionando no iPhone real

**Commands:**
```bash
eas build --platform ios --profile production
eas submit --platform ios
```

---

#### US-010: Adaptar UI para iPhone

**Description:** Como usuário iPhone, quero que o app tenha boa aparência no meu dispositivo.

**Acceptance Criteria:**
- [ ] Safe areas configuradas corretamente
- [ ] Notch/Dynamic Island respeitados
- [ ] Keyboard avoiding view
- [ ] Haptic feedback em ações importantes
- [ ] App icon e splash screen configurados

**Files to modify:**
- `App.js`
- `src/components/DashboardScreen.js`
- `app.json` - assets iOS

---

### FASE 4: MELHORIAS UX

#### US-011: Gráfico de Evolução Patrimonial

**Description:** Como usuário, quero ver um gráfico da evolução do meu patrimônio ao longo do tempo.

**Acceptance Criteria:**
- [ ] Gráfico de linha com histórico
- [ ] Período selecionável: 7d, 30d, 90d, 1y
- [ ] Tooltip com valor exato ao tocar
- [ ] Cores indicando ganho/perda
- [ ] Loading state enquanto carrega

**Files to modify:**
- `src/components/DashboardScreen.js`
- Ou criar `src/components/PortfolioChart.js`

---

#### US-012: Push Notifications Funcionais

**Description:** Como usuário, quero receber notificações quando meu portfólio mudar significativamente.

**Acceptance Criteria:**
- [ ] Permissão solicitada no primeiro uso
- [ ] Notificação quando variação > 1%
- [ ] Resumo diário às 7h (opcional)
- [ ] Configuração on/off no app
- [ ] Deep link para dashboard

**Files to modify:**
- `src/services/PushNotificationService.js`
- `App.js` - registrar notificações

---

#### US-013: Offline-First com Sync

**Description:** Como usuário, quero usar o app mesmo sem internet e sincronizar depois.

**Acceptance Criteria:**
- [ ] App funciona 100% offline com cache
- [ ] Indicador de status online/offline
- [ ] Queue de operações pendentes
- [ ] Sync automático quando reconectar
- [ ] Resolução de conflitos (last-write-wins)

**Files to modify:**
- `src/services/CacheService.js`
- `src/services/SyncService.js` - novo arquivo

---

#### US-014: Biometria para Acesso

**Description:** Como usuário, quero usar Face ID/Touch ID para abrir o app.

**Acceptance Criteria:**
- [ ] Solicitar biometria ao abrir (se configurado)
- [ ] Fallback para PIN/senha
- [ ] Opção de desabilitar
- [ ] Não mostrar valores se não autenticado
- [ ] Timeout de biometria

**Files to modify:**
- `App.js`
- `src/services/AuthService.js`

---

## Technical Approach

### Arquitetura de Deploy

```
┌─────────────────┐     HTTPS      ┌─────────────────┐
│   iPhone App    │ ◄────────────► │    Railway      │
│  (React Native) │                │  (PocketBase)   │
└─────────────────┘                └─────────────────┘
        │                                   │
        │ Cache                             │ SQLite
        ▼                                   ▼
┌─────────────────┐                ┌─────────────────┐
│  SecureStore    │                │   Persistent    │
│  (Encrypted)    │                │    Volume       │
└─────────────────┘                └─────────────────┘
```

### Stack Final

| Componente | Tecnologia |
|------------|------------|
| Frontend | React Native + Expo SDK 54 |
| Backend | PocketBase 0.22+ |
| Hosting | Railway.com |
| Auth | PocketBase Auth |
| Database | SQLite (PocketBase) |
| Storage | Railway Persistent Volume |
| Cache | AsyncStorage + SecureStore (encrypted) |
| Push | Expo Notifications |
| Build | EAS Build |
| Distribution | TestFlight |

### Variáveis de Ambiente

```bash
# .env.production
POCKETBASE_URL=https://galapagos-api.up.railway.app

# .env.development
POCKETBASE_URL=http://localhost:8090
```

---

## Success Metrics

1. **Backend** - PocketBase respondendo em < 200ms
2. **Segurança** - Zero vulnerabilidades críticas
3. **iOS** - App instalado e funcionando no iPhone
4. **Sync** - Dados sincronizados em < 5s
5. **UX** - Gráficos carregando em < 1s

---

## Ordem de Implementação

| # | Story | Prioridade | Dependências |
|---|-------|------------|--------------|
| 1 | US-001 | P0 | - |
| 2 | US-002 | P0 | US-001 |
| 3 | US-003 | P0 | US-002 |
| 4 | US-004 | P1 | - |
| 5 | US-005 | P1 | - |
| 6 | US-006 | P1 | - |
| 7 | US-007 | P1 | - |
| 8 | US-008 | P0 | US-003 |
| 9 | US-009 | P0 | US-008 |
| 10 | US-010 | P1 | US-009 |
| 11 | US-011 | P2 | US-003 |
| 12 | US-012 | P2 | US-009 |
| 13 | US-013 | P2 | US-003 |
| 14 | US-014 | P2 | US-005 |

---

## Estimativa de Arquivos

| Fase | Arquivos Novos | Arquivos Modificados |
|------|----------------|---------------------|
| Infraestrutura | 3 | 2 |
| Segurança | 2 | 5 |
| iOS Build | 0 | 2 |
| UX | 2 | 3 |
| **Total** | **7** | **12** |

---

## Próximos Passos

1. **Aprovar este PRD** - Revisar e ajustar se necessário
2. **Criar conta Railway** - Se ainda não tem
3. **Apple Developer** - Verificar se a conta está ativa
4. **Iniciar US-001** - Deploy do PocketBase

Reply with:
- "approved" - Converter para prd.json e começar implementação
- "edit [story]" - Modificar uma story específica
- "add [story]" - Adicionar nova story
- "questions" - Perguntar sobre a abordagem
