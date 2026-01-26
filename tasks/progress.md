# Progress Log: GalapagosApp v2

Branch: `feature/galapagos-v2-upgrade`
Started: 2026-01-26
Target Repo: totobusnello/GalapagosApp

---

## Análise Inicial - 2026-01-26

### Codebase Discovery

**Stack Detectado:**
- React Native 0.81.5
- Expo SDK 54
- PocketBase (configurado mas não deployado)
- Supabase (configurado como alternativa)
- Playwright para testes

**Arquivos Principais:**
- `App.js` - Orquestrador WebView/Dashboard
- `src/components/DashboardScreen.js` - UI principal
- `src/services/PocketbaseService.js` - Backend (já implementado)
- `src/services/SecurityService.js` - Segurança (parcial)
- `src/utils/InjectionScript.js` - Extração de dados

**Estado Atual:**
- ✅ Estrutura de serviços bem organizada
- ✅ PocketbaseService completo com auth, CRUD, sync
- ✅ SecurityService com hash, criptografia (XOR), whitelist
- ⚠️ Criptografia usa XOR (fraco) - precisa AES
- ⚠️ Alguns console.log sem __DEV__
- ⚠️ Backend não deployado (apenas local)
- ❌ Build iOS não testado

**Dependências Úteis Já Instaladas:**
- `expo-crypto` - Para criptografia
- `expo-secure-store` - Storage seguro
- `expo-local-authentication` - Biometria
- `expo-notifications` - Push notifications
- `react-native-chart-kit` - Gráficos
- `pocketbase` - SDK do backend

### Plano de Implementação

1. **Fase 1 (Infraestrutura)**: US-001 → US-003
   - Deploy PocketBase no Railway
   - Configurar collections
   - Conectar app ao backend remoto

2. **Fase 2 (Segurança)**: US-004 → US-007
   - Upgrade criptografia para AES
   - Session timeout
   - Hardening WebView

3. **Fase 3 (iOS Build)**: US-008 → US-010
   - Configurar EAS Build
   - Submeter TestFlight
   - Ajustes de UI

4. **Fase 4 (UX)**: US-011 → US-014
   - Gráficos de evolução
   - Push notifications
   - Offline-first
   - Biometria

---

## Próxima Ação

Iniciar **US-001: Deploy PocketBase no Railway**

Pré-requisitos:
1. Conta no Railway.com
2. Railway CLI instalado
3. Dockerfile configurado

---
