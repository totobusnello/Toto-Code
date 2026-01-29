# Arquitetura Mobile - Greenlight Brasil

> **Documento de Planejamento Tecnico** | Versao 1.0 | Janeiro 2026
>
> **Projeto**: Apps Mobile de Educacao Financeira Familiar
> **Stack**: React Native 0.76+
> **Autor**: Mobile Developer Agent

---

## Indice

1. [Arquitetura Geral](#1-arquitetura-geral-monorepo-vs-multi-repo)
2. [Estrutura de Pastas](#2-estrutura-de-pastas)
3. [State Management](#3-state-management)
4. [Navegacao](#4-navegacao)
5. [Design System](#5-design-system)
6. [Autenticacao e Seguranca](#6-autenticacao-e-seguranca)
7. [Offline-First Strategy](#7-offline-first-strategy)
8. [Push Notifications](#8-push-notifications)
9. [Deep Linking](#9-deep-linking)
10. [Performance](#10-performance)
11. [Testing Strategy](#11-testing-strategy)
12. [CI/CD Mobile](#12-cicd-mobile)
13. [Feature Flags](#13-feature-flags)
14. [Analytics e Tracking](#14-analytics-e-tracking)
15. [Acessibilidade](#15-acessibilidade)

---

## 1. Arquitetura Geral (Monorepo vs Multi-repo)

### Decisao: MONOREPO com Turborepo

```
+------------------------------------------------------------------+
|                         MONOREPO STRUCTURE                        |
+------------------------------------------------------------------+
|                                                                    |
|  greenlight-brasil/                                               |
|  |                                                                 |
|  +-- apps/                                                         |
|  |   +-- parent-app/     # App do Pai (React Native)             |
|  |   +-- child-app/      # App do Filho (React Native)           |
|  |   +-- web/            # Landing Page (Next.js)                 |
|  |   +-- admin/          # Painel Admin (Next.js)                 |
|  |                                                                 |
|  +-- packages/                                                     |
|  |   +-- ui/             # Componentes compartilhados             |
|  |   +-- core/           # Logica de negocio compartilhada        |
|  |   +-- api-client/     # Cliente API tipado                     |
|  |   +-- config/         # Configuracoes (ESLint, TS, etc)        |
|  |   +-- utils/          # Utilitarios compartilhados             |
|  |   +-- types/          # Tipos TypeScript compartilhados        |
|  |                                                                 |
|  +-- backend/            # API NestJS (mesmo repo)                |
|  +-- turbo.json          # Configuracao Turborepo                 |
|  +-- package.json        # Workspaces root                        |
|                                                                    |
+------------------------------------------------------------------+
```

### Justificativa da Decisao

| Criterio | Monorepo | Multi-repo |
|----------|----------|------------|
| **Code sharing** | Excelente (packages compartilhados) | Complexo (npm packages) |
| **Consistencia de tipos** | Automatica | Requer publicacao |
| **Atomic commits** | Sim (features afetam ambos apps) | Nao |
| **CI/CD** | Unificado com cache | Separado por repo |
| **Onboarding** | Um clone | Multiplos clones |
| **Complexidade inicial** | Media | Baixa |

**Decisao**: Monorepo com **Turborepo** porque:
1. Apps Pai e Filho compartilham 70-80% da logica (API, tipos, utils)
2. Sistema de 4 Baldes e precisa ser identico em ambos apps
3. Atualizacoes de seguranca precisam ser atomicas
4. Time pequeno inicial (< 10 devs)

### Configuracao Turborepo

```json
// turbo.json
{
  "$schema": "https://turbo.build/schema.json",
  "globalDependencies": ["**/.env.*local"],
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "android/app/build/**", "ios/build/**"]
    },
    "test": {
      "dependsOn": ["build"],
      "inputs": ["src/**/*.tsx", "src/**/*.ts", "test/**/*.ts"]
    },
    "lint": {},
    "type-check": {
      "dependsOn": ["^build"]
    }
  }
}
```

---

## 2. Estrutura de Pastas

### Estrutura do App (Parent e Child)

```
apps/parent-app/                        apps/child-app/
|                                       |
+-- src/                                +-- src/
|   +-- app/                            |   +-- app/
|   |   +-- (auth)/                     |   |   +-- (auth)/
|   |   |   +-- login/                  |   |   |   +-- pin-login/
|   |   |   +-- register/               |   |   |   +-- biometric/
|   |   |   +-- forgot-password/        |   |   |
|   |   |                               |   |   +-- (main)/
|   |   +-- (main)/                     |   |   |   +-- home/           # 4 Baldes
|   |   |   +-- home/                   |   |   |   +-- spend/          # Balde Gastar
|   |   |   +-- children/               |   |   |   +-- save/           # Balde Guardar
|   |   |   +-- transfer/               |   |   |   +-- give/           # Balde Doar
|   |   |   +-- reports/                |   |   |   +-- invest/         # Balde Investir
|   |   |   +-- education/              |   |   |   +-- tasks/
|   |   |   +-- settings/               |   |   |   +-- learn/
|   |   |                               |   |   |   +-- settings/
|   |   +-- _layout.tsx                 |   |   |
|   |                                   |   |   +-- _layout.tsx
|   +-- components/                     |   |
|   |   +-- children/                   |   +-- components/
|   |   +-- transactions/               |   |   +-- buckets/            # UI dos Baldes
|   |   +-- cards/                      |   |   +-- goals/
|   |   +-- tasks/                      |   |   +-- transactions/
|   |                                   |   |   +-- card/
|   +-- hooks/                          |   |
|   |   +-- useChildData.ts             |   +-- hooks/
|   |   +-- useParentalControls.ts      |   |   +-- useBuckets.ts
|   |                                   |   |   +-- useGoals.ts
|   +-- services/                       |   |
|   |   +-- children.service.ts         |   +-- services/
|   |   +-- controls.service.ts         |   |   +-- buckets.service.ts
|   |                                   |   |   +-- tasks.service.ts
|   +-- store/                          |   |
|   |   +-- slices/                     |   +-- store/
|   |   |   +-- childrenSlice.ts        |   |   +-- slices/
|   |   |   +-- controlsSlice.ts        |   |   |   +-- bucketsSlice.ts
|   |   +-- index.ts                    |   |   |   +-- goalsSlice.ts
|   |                                   |   |   +-- index.ts
|   +-- constants/                      |   |
|   +-- utils/                          |   +-- constants/
|   +-- types/                          |   +-- utils/
|                                       |   +-- types/
+-- android/                            |
+-- ios/                                +-- android/
+-- app.json                            +-- ios/
+-- metro.config.js                     +-- app.json
+-- package.json                        +-- metro.config.js
                                        +-- package.json
```

### Estrutura do Package UI Compartilhado

```
packages/ui/
|
+-- src/
|   +-- components/
|   |   +-- Button/
|   |   |   +-- Button.tsx
|   |   |   +-- Button.styles.ts
|   |   |   +-- Button.test.tsx
|   |   |   +-- index.ts
|   |   |
|   |   +-- Input/
|   |   +-- Card/
|   |   +-- Modal/
|   |   +-- Avatar/
|   |   +-- Badge/
|   |   +-- ProgressBar/
|   |   +-- TransactionItem/
|   |   +-- BucketCard/             # Card do sistema de baldes
|   |   +-- GoalCard/               # Card de meta
|   |   +-- AmountDisplay/          # Exibicao de valores monetarios
|   |
|   +-- primitives/
|   |   +-- Box/
|   |   +-- Text/
|   |   +-- Pressable/
|   |   +-- Stack/
|   |
|   +-- tokens/
|   |   +-- colors.ts
|   |   +-- typography.ts
|   |   +-- spacing.ts
|   |   +-- shadows.ts
|   |
|   +-- theme/
|   |   +-- ThemeProvider.tsx
|   |   +-- useTheme.ts
|   |   +-- parentTheme.ts          # Tema do app pai
|   |   +-- childTheme.ts           # Tema do app filho (mais colorido)
|   |
|   +-- index.ts
|
+-- package.json
```

### Estrutura do Package Core

```
packages/core/
|
+-- src/
|   +-- domain/
|   |   +-- entities/
|   |   |   +-- User.ts
|   |   |   +-- Child.ts
|   |   |   +-- Bucket.ts           # Entidade Balde
|   |   |   +-- Transaction.ts
|   |   |   +-- Goal.ts
|   |   |   +-- Task.ts
|   |   |
|   |   +-- value-objects/
|   |   |   +-- Money.ts
|   |   |   +-- CPF.ts
|   |   |   +-- PixKey.ts
|   |   |   +-- BucketAllocation.ts # Porcentagens dos baldes
|   |
|   +-- use-cases/
|   |   +-- auth/
|   |   |   +-- LoginUseCase.ts
|   |   |   +-- RegisterUseCase.ts
|   |   |
|   |   +-- buckets/
|   |   |   +-- DistributeToBucketsUseCase.ts
|   |   |   +-- TransferBetweenBucketsUseCase.ts
|   |   |   +-- GetBucketBalanceUseCase.ts
|   |   |
|   |   +-- transactions/
|   |   |   +-- SendPixUseCase.ts
|   |   |   +-- GetTransactionsUseCase.ts
|   |   |
|   |   +-- goals/
|   |   |   +-- CreateGoalUseCase.ts
|   |   |   +-- ContributeToGoalUseCase.ts
|   |
|   +-- repositories/
|   |   +-- IUserRepository.ts
|   |   +-- IBucketRepository.ts
|   |   +-- ITransactionRepository.ts
|   |
|   +-- services/
|   |   +-- IAuthService.ts
|   |   +-- IBiometricService.ts
|   |   +-- INotificationService.ts
|   |
|   +-- index.ts
|
+-- package.json
```

---

## 3. State Management

### Decisao: Zustand + React Query (TanStack Query)

```
+------------------------------------------------------------------+
|                    STATE MANAGEMENT ARCHITECTURE                  |
+------------------------------------------------------------------+
|                                                                    |
|  +------------------+     +------------------+                     |
|  |   ZUSTAND        |     |   REACT QUERY    |                    |
|  |   (Client State) |     |   (Server State) |                    |
|  +------------------+     +------------------+                     |
|  |                  |     |                  |                     |
|  | - Auth state     |     | - User data      |                    |
|  | - UI state       |     | - Transactions   |                    |
|  | - Navigation     |     | - Buckets        |                    |
|  | - Preferences    |     | - Goals          |                    |
|  | - Offline queue  |     | - Tasks          |                    |
|  |                  |     |                  |                     |
|  | Persist:         |     | Cache:           |                    |
|  | MMKV encrypted   |     | - staleTime      |                    |
|  |                  |     | - cacheTime      |                    |
|  |                  |     | - Offline persist|                    |
|  +------------------+     +------------------+                     |
|                                                                    |
+------------------------------------------------------------------+
```

### Justificativa

| Solucao | Pros | Contras | Veredicto |
|---------|------|---------|-----------|
| Redux Toolkit | Maduro, DevTools | Boilerplate, curva | Descartado |
| Zustand | Simples, leve, TS | Menos DevTools | **Escolhido** |
| Jotai | Atomico, simples | Menos patterns | Alternativa |
| MobX | Reativo | Curva, menos comum | Descartado |

**Decisao**:
- **Zustand** para estado local/cliente (auth, UI, preferences)
- **TanStack Query** para estado do servidor (dados da API)

### Implementacao Zustand

```typescript
// packages/core/src/store/authStore.ts
import { create } from 'zustand';
import { persist, createJSONStorage } from 'zustand/middleware';
import { MMKV } from 'react-native-mmkv';

const storage = new MMKV({ id: 'auth-storage', encryptionKey: 'key' });

interface AuthState {
  user: User | null;
  token: string | null;
  deviceId: string | null;
  biometricEnabled: boolean;

  // Actions
  setUser: (user: User) => void;
  setToken: (token: string) => void;
  logout: () => void;
  enableBiometric: () => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      token: null,
      deviceId: null,
      biometricEnabled: false,

      setUser: (user) => set({ user }),
      setToken: (token) => set({ token }),
      logout: () => set({ user: null, token: null }),
      enableBiometric: () => set({ biometricEnabled: true }),
    }),
    {
      name: 'auth-storage',
      storage: createJSONStorage(() => ({
        getItem: (name) => storage.getString(name) ?? null,
        setItem: (name, value) => storage.set(name, value),
        removeItem: (name) => storage.delete(name),
      })),
    }
  )
);
```

### Implementacao TanStack Query

```typescript
// packages/api-client/src/hooks/useBuckets.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { bucketsApi } from '../api/buckets';

export const bucketKeys = {
  all: ['buckets'] as const,
  byChild: (childId: string) => [...bucketKeys.all, childId] as const,
  detail: (childId: string, bucketType: BucketType) =>
    [...bucketKeys.byChild(childId), bucketType] as const,
};

export function useBuckets(childId: string) {
  return useQuery({
    queryKey: bucketKeys.byChild(childId),
    queryFn: () => bucketsApi.getBuckets(childId),
    staleTime: 30 * 1000, // 30 segundos
    cacheTime: 5 * 60 * 1000, // 5 minutos
  });
}

export function useTransferBetweenBuckets() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: bucketsApi.transferBetweenBuckets,
    onMutate: async (transfer) => {
      // Optimistic update
      await queryClient.cancelQueries(bucketKeys.byChild(transfer.childId));
      const previous = queryClient.getQueryData(bucketKeys.byChild(transfer.childId));

      queryClient.setQueryData(bucketKeys.byChild(transfer.childId), (old) => {
        // Update buckets optimistically
        return updateBucketsOptimistically(old, transfer);
      });

      return { previous };
    },
    onError: (err, transfer, context) => {
      // Rollback on error
      queryClient.setQueryData(
        bucketKeys.byChild(transfer.childId),
        context?.previous
      );
    },
    onSettled: (data, error, transfer) => {
      queryClient.invalidateQueries(bucketKeys.byChild(transfer.childId));
    },
  });
}
```

### Store do Sistema de 4 Baldes

```typescript
// packages/core/src/store/bucketsStore.ts
import { create } from 'zustand';

interface BucketAllocation {
  spend: number;    // % para Gastar
  save: number;     // % para Guardar
  give: number;     // % para Doar
  invest: number;   // % para Investir
}

interface BucketsUIState {
  selectedBucket: BucketType | null;
  isTransferModalOpen: boolean;
  transferAmount: number;

  // Actions
  selectBucket: (bucket: BucketType) => void;
  openTransferModal: () => void;
  closeTransferModal: () => void;
  setTransferAmount: (amount: number) => void;
}

export const useBucketsUIStore = create<BucketsUIState>((set) => ({
  selectedBucket: null,
  isTransferModalOpen: false,
  transferAmount: 0,

  selectBucket: (bucket) => set({ selectedBucket: bucket }),
  openTransferModal: () => set({ isTransferModalOpen: true }),
  closeTransferModal: () => set({ isTransferModalOpen: false, transferAmount: 0 }),
  setTransferAmount: (amount) => set({ transferAmount: amount }),
}));
```

---

## 4. Navegacao

### Stack de Navegacao: React Navigation 7+

```
+------------------------------------------------------------------+
|                     NAVIGATION ARCHITECTURE                       |
+------------------------------------------------------------------+
|                                                                    |
|                      RootNavigator                                |
|                           |                                        |
|         +-----------------+-----------------+                      |
|         |                 |                 |                      |
|    AuthStack         MainStack         ModalStack                 |
|         |                 |                 |                      |
|    +----+----+      +----+----+       +----+----+                 |
|    |         |      |         |       |         |                 |
|  Login   Register  Tabs    Screens   Transfer  Confirm            |
|                     |                 Modal     Modal              |
|              +------+------+                                       |
|              |      |      |                                       |
|            Home  Buckets Settings                                  |
|                     |                                              |
|              +------+------+------+                                |
|              |      |      |      |                                |
|            Spend  Save   Give  Invest                              |
|                                                                    |
+------------------------------------------------------------------+
```

### Configuracao de Navegacao - App Filho

```typescript
// apps/child-app/src/navigation/RootNavigator.tsx
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { linking } from './linking';

const Stack = createNativeStackNavigator<RootStackParamList>();
const Tab = createBottomTabNavigator<MainTabParamList>();
const BucketStack = createNativeStackNavigator<BucketStackParamList>();

// Tabs principais do App Filho
function MainTabs() {
  return (
    <Tab.Navigator
      screenOptions={{
        tabBarStyle: styles.tabBar,
        tabBarActiveTintColor: colors.primary,
        tabBarInactiveTintColor: colors.gray500,
      }}
    >
      <Tab.Screen
        name="Home"
        component={HomeScreen}
        options={{
          tabBarIcon: ({ color, size }) => <HomeIcon color={color} size={size} />,
          tabBarLabel: 'Inicio',
        }}
      />
      <Tab.Screen
        name="Buckets"
        component={BucketsNavigator}
        options={{
          tabBarIcon: ({ color, size }) => <BucketsIcon color={color} size={size} />,
          tabBarLabel: 'Baldes',
        }}
      />
      <Tab.Screen
        name="Tasks"
        component={TasksScreen}
        options={{
          tabBarIcon: ({ color, size }) => <TasksIcon color={color} size={size} />,
          tabBarLabel: 'Tarefas',
        }}
      />
      <Tab.Screen
        name="Learn"
        component={LearnScreen}
        options={{
          tabBarIcon: ({ color, size }) => <LearnIcon color={color} size={size} />,
          tabBarLabel: 'Aprender',
        }}
      />
      <Tab.Screen
        name="Profile"
        component={ProfileScreen}
        options={{
          tabBarIcon: ({ color, size }) => <ProfileIcon color={color} size={size} />,
          tabBarLabel: 'Perfil',
        }}
      />
    </Tab.Navigator>
  );
}

// Stack dos 4 Baldes
function BucketsNavigator() {
  return (
    <BucketStack.Navigator>
      <BucketStack.Screen
        name="BucketsOverview"
        component={BucketsOverviewScreen}
        options={{ headerTitle: 'Meus Baldes' }}
      />
      <BucketStack.Screen
        name="SpendBucket"
        component={SpendBucketScreen}
        options={{ headerTitle: 'Gastar' }}
      />
      <BucketStack.Screen
        name="SaveBucket"
        component={SaveBucketScreen}
        options={{ headerTitle: 'Guardar' }}
      />
      <BucketStack.Screen
        name="GiveBucket"
        component={GiveBucketScreen}
        options={{ headerTitle: 'Doar' }}
      />
      <BucketStack.Screen
        name="InvestBucket"
        component={InvestBucketScreen}
        options={{ headerTitle: 'Investir' }}
      />
      <BucketStack.Screen
        name="GoalDetail"
        component={GoalDetailScreen}
        options={{ headerTitle: 'Meta' }}
      />
    </BucketStack.Navigator>
  );
}

// Root Navigator
export function RootNavigator() {
  const { isAuthenticated, isLoading } = useAuthStore();

  if (isLoading) {
    return <SplashScreen />;
  }

  return (
    <NavigationContainer linking={linking}>
      <Stack.Navigator screenOptions={{ headerShown: false }}>
        {!isAuthenticated ? (
          <Stack.Group>
            <Stack.Screen name="PinLogin" component={PinLoginScreen} />
            <Stack.Screen name="BiometricLogin" component={BiometricLoginScreen} />
          </Stack.Group>
        ) : (
          <Stack.Group>
            <Stack.Screen name="Main" component={MainTabs} />
          </Stack.Group>
        )}

        {/* Modals - sempre disponiveis */}
        <Stack.Group screenOptions={{ presentation: 'modal' }}>
          <Stack.Screen name="TransferModal" component={TransferBetweenBucketsModal} />
          <Stack.Screen name="TransactionDetail" component={TransactionDetailModal} />
          <Stack.Screen name="CreateGoalModal" component={CreateGoalModal} />
          <Stack.Screen name="ReceiveModal" component={ReceiveMoneyModal} />
        </Stack.Group>

        {/* Full screen overlays */}
        <Stack.Group screenOptions={{ presentation: 'fullScreenModal' }}>
          <Stack.Screen name="CardDetails" component={CardDetailsScreen} />
          <Stack.Screen name="QRScanner" component={QRScannerScreen} />
        </Stack.Group>
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

### Type-Safe Navigation

```typescript
// apps/child-app/src/navigation/types.ts
import { NavigatorScreenParams } from '@react-navigation/native';

export type RootStackParamList = {
  // Auth
  PinLogin: undefined;
  BiometricLogin: undefined;

  // Main
  Main: NavigatorScreenParams<MainTabParamList>;

  // Modals
  TransferModal: { fromBucket: BucketType; toBucket?: BucketType };
  TransactionDetail: { transactionId: string };
  CreateGoalModal: { bucketType: 'save' };
  ReceiveModal: undefined;

  // Full screen
  CardDetails: undefined;
  QRScanner: { onScan: (data: string) => void };
};

export type MainTabParamList = {
  Home: undefined;
  Buckets: NavigatorScreenParams<BucketStackParamList>;
  Tasks: undefined;
  Learn: undefined;
  Profile: undefined;
};

export type BucketStackParamList = {
  BucketsOverview: undefined;
  SpendBucket: undefined;
  SaveBucket: undefined;
  GiveBucket: undefined;
  InvestBucket: undefined;
  GoalDetail: { goalId: string };
};

// Hooks tipados
declare global {
  namespace ReactNavigation {
    interface RootParamList extends RootStackParamList {}
  }
}
```

---

## 5. Design System

### Arquitetura do Design System

```
+------------------------------------------------------------------+
|                      DESIGN SYSTEM ARCHITECTURE                   |
+------------------------------------------------------------------+
|                                                                    |
|  TOKENS (Foundation)                                              |
|  +------------+  +------------+  +------------+  +------------+   |
|  |   Colors   |  | Typography |  |  Spacing   |  |  Shadows   |  |
|  +------------+  +------------+  +------------+  +------------+   |
|                                                                    |
|  PRIMITIVES (Building Blocks)                                     |
|  +--------+  +--------+  +--------+  +--------+  +--------+       |
|  |  Box   |  |  Text  |  | Stack  |  |Pressable| | Image  |       |
|  +--------+  +--------+  +--------+  +--------+  +--------+       |
|                                                                    |
|  COMPONENTS (Reusable UI)                                         |
|  +--------+  +--------+  +--------+  +--------+  +--------+       |
|  | Button |  |  Input |  |  Card  |  |  Modal |  | Avatar |       |
|  +--------+  +--------+  +--------+  +--------+  +--------+       |
|                                                                    |
|  PATTERNS (Domain-Specific)                                       |
|  +-------------+  +-------------+  +-------------+                 |
|  | BucketCard  |  | Transaction |  |  GoalCard   |                |
|  +-------------+  +-------------+  +-------------+                 |
|                                                                    |
+------------------------------------------------------------------+
```

### Tokens de Design

```typescript
// packages/ui/src/tokens/colors.ts
export const colors = {
  // Brand
  primary: {
    50: '#E8F5E9',
    100: '#C8E6C9',
    200: '#A5D6A7',
    300: '#81C784',
    400: '#66BB6A',
    500: '#4CAF50',  // Main
    600: '#43A047',
    700: '#388E3C',
    800: '#2E7D32',
    900: '#1B5E20',
  },

  // Buckets (cores especificas para cada balde)
  buckets: {
    spend: {
      main: '#2196F3',      // Azul - Gastar
      light: '#BBDEFB',
      dark: '#1565C0',
    },
    save: {
      main: '#FF9800',      // Laranja - Guardar
      light: '#FFE0B2',
      dark: '#E65100',
    },
    give: {
      main: '#E91E63',      // Rosa - Doar
      light: '#F8BBD9',
      dark: '#AD1457',
    },
    invest: {
      main: '#9C27B0',      // Roxo - Investir
      light: '#E1BEE7',
      dark: '#6A1B9A',
    },
  },

  // Semantic
  success: '#4CAF50',
  warning: '#FF9800',
  error: '#F44336',
  info: '#2196F3',

  // Neutral
  gray: {
    50: '#FAFAFA',
    100: '#F5F5F5',
    200: '#EEEEEE',
    300: '#E0E0E0',
    400: '#BDBDBD',
    500: '#9E9E9E',
    600: '#757575',
    700: '#616161',
    800: '#424242',
    900: '#212121',
  },

  // Background
  background: {
    primary: '#FFFFFF',
    secondary: '#F5F5F5',
    tertiary: '#EEEEEE',
  },

  // Text
  text: {
    primary: '#212121',
    secondary: '#757575',
    disabled: '#BDBDBD',
    inverse: '#FFFFFF',
  },
};

// packages/ui/src/tokens/typography.ts
export const typography = {
  fontFamily: {
    regular: 'Inter-Regular',
    medium: 'Inter-Medium',
    semibold: 'Inter-SemiBold',
    bold: 'Inter-Bold',
  },

  fontSize: {
    xs: 10,
    sm: 12,
    md: 14,
    lg: 16,
    xl: 18,
    '2xl': 20,
    '3xl': 24,
    '4xl': 30,
    '5xl': 36,
  },

  lineHeight: {
    tight: 1.2,
    normal: 1.5,
    relaxed: 1.75,
  },
};

// packages/ui/src/tokens/spacing.ts
export const spacing = {
  0: 0,
  1: 4,
  2: 8,
  3: 12,
  4: 16,
  5: 20,
  6: 24,
  8: 32,
  10: 40,
  12: 48,
  16: 64,
};
```

### Componente BucketCard

```typescript
// packages/ui/src/components/BucketCard/BucketCard.tsx
import { Pressable, View } from 'react-native';
import { Text, Box, ProgressBar } from '../../primitives';
import { colors, spacing } from '../../tokens';
import { formatCurrency } from '@greenlight/utils';

export type BucketType = 'spend' | 'save' | 'give' | 'invest';

interface BucketCardProps {
  type: BucketType;
  balance: number;
  percentage?: number;
  goalProgress?: number;
  goalTarget?: number;
  onPress?: () => void;
  testID?: string;
}

const bucketConfig = {
  spend: {
    icon: 'credit-card',
    label: 'Gastar',
    description: 'Disponivel para uso',
  },
  save: {
    icon: 'piggy-bank',
    label: 'Guardar',
    description: 'Poupanca para metas',
  },
  give: {
    icon: 'gift',
    label: 'Doar',
    description: 'Para ajudar outros',
  },
  invest: {
    icon: 'trending-up',
    label: 'Investir',
    description: 'Seu futuro',
  },
};

export function BucketCard({
  type,
  balance,
  percentage,
  goalProgress,
  goalTarget,
  onPress,
  testID,
}: BucketCardProps) {
  const config = bucketConfig[type];
  const bucketColors = colors.buckets[type];

  return (
    <Pressable
      onPress={onPress}
      testID={testID}
      style={({ pressed }) => [
        styles.container,
        { backgroundColor: bucketColors.light },
        pressed && styles.pressed,
      ]}
      accessibilityRole="button"
      accessibilityLabel={`${config.label}: ${formatCurrency(balance)}`}
    >
      <Box flexDirection="row" alignItems="center" marginBottom={spacing[2]}>
        <Box
          backgroundColor={bucketColors.main}
          borderRadius={8}
          padding={spacing[2]}
          marginRight={spacing[2]}
        >
          <Icon name={config.icon} color={colors.text.inverse} size={20} />
        </Box>

        <Box flex={1}>
          <Text variant="caption" color={colors.text.secondary}>
            {config.label}
          </Text>
          <Text variant="h3" color={bucketColors.dark}>
            {formatCurrency(balance)}
          </Text>
        </Box>

        {percentage !== undefined && (
          <Box
            backgroundColor={bucketColors.main}
            borderRadius={12}
            paddingHorizontal={spacing[2]}
            paddingVertical={spacing[1]}
          >
            <Text variant="caption" color={colors.text.inverse}>
              {percentage}%
            </Text>
          </Box>
        )}
      </Box>

      {goalTarget && (
        <Box marginTop={spacing[2]}>
          <ProgressBar
            progress={(goalProgress || 0) / goalTarget}
            color={bucketColors.main}
            backgroundColor={bucketColors.light}
          />
          <Text variant="caption" color={colors.text.secondary} marginTop={spacing[1]}>
            {formatCurrency(goalProgress || 0)} de {formatCurrency(goalTarget)}
          </Text>
        </Box>
      )}
    </Pressable>
  );
}
```

### Temas por App

```typescript
// packages/ui/src/theme/parentTheme.ts
export const parentTheme: Theme = {
  colors: {
    ...colors,
    primary: colors.primary,
    background: colors.background.primary,
  },
  typography: {
    ...typography,
    fontFamily: {
      ...typography.fontFamily,
    },
  },
  spacing,
  borderRadius: {
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    full: 9999,
  },
};

// packages/ui/src/theme/childTheme.ts
export const childTheme: Theme = {
  ...parentTheme,
  colors: {
    ...colors,
    // Tema mais colorido e amigavel para criancas
    primary: colors.buckets.spend,
    background: '#F8FAFF',
  },
  typography: {
    ...typography,
    fontFamily: {
      regular: 'Nunito-Regular',
      medium: 'Nunito-Medium',
      semibold: 'Nunito-SemiBold',
      bold: 'Nunito-Bold',
    },
  },
  // Bordas mais arredondadas
  borderRadius: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    full: 9999,
  },
};
```

---

## 6. Autenticacao e Seguranca

### Arquitetura de Seguranca

```
+------------------------------------------------------------------+
|                    SECURITY ARCHITECTURE                          |
+------------------------------------------------------------------+
|                                                                    |
|  APP PAI                          APP FILHO                        |
|  +------------------------+       +------------------------+       |
|  | - Email + Senha forte  |       | - PIN 6 digitos        |       |
|  | - MFA obrigatorio      |       | - Biometria opcional   |       |
|  | - Biometria opcional   |       | - Device binding (1)   |       |
|  | - Device binding (3)   |       | - Sessao 4h max        |       |
|  | - Sessao 24h max       |       | - Configs pelo pai     |       |
|  +------------------------+       +------------------------+       |
|            |                               |                       |
|            +---------------+---------------+                       |
|                            |                                       |
|                    +-------v-------+                               |
|                    |   API GATEWAY |                               |
|                    | - Rate limit  |                               |
|                    | - WAF         |                               |
|                    | - JWT verify  |                               |
|                    +-------+-------+                               |
|                            |                                       |
|                    +-------v-------+                               |
|                    | AUTH SERVICE  |                               |
|                    | - OAuth 2.0   |                               |
|                    | - Device trust|                               |
|                    | - Risk engine |                               |
|                    +---------------+                               |
|                                                                    |
+------------------------------------------------------------------+
```

### Implementacao de Autenticacao

```typescript
// packages/core/src/services/auth/AuthService.ts
import * as LocalAuthentication from 'expo-local-authentication';
import * as SecureStore from 'expo-secure-store';
import { MMKV } from 'react-native-mmkv';

const secureStorage = new MMKV({
  id: 'secure-auth',
  encryptionKey: 'generated-device-key',
});

export class AuthService {
  // Login do pai (email + senha + MFA)
  async loginParent(email: string, password: string): Promise<LoginResult> {
    const response = await api.post('/auth/login', {
      email,
      password,
      deviceInfo: await this.getDeviceInfo(),
    });

    if (response.requiresMFA) {
      return { requiresMFA: true, mfaToken: response.mfaToken };
    }

    await this.storeTokens(response.tokens);
    return { success: true, user: response.user };
  }

  // Verificacao MFA
  async verifyMFA(mfaToken: string, code: string): Promise<LoginResult> {
    const response = await api.post('/auth/verify-mfa', {
      mfaToken,
      code,
      deviceInfo: await this.getDeviceInfo(),
    });

    await this.storeTokens(response.tokens);
    await this.registerTrustedDevice();

    return { success: true, user: response.user };
  }

  // Login do filho (PIN)
  async loginChild(childId: string, pin: string): Promise<LoginResult> {
    // Verificar PIN localmente primeiro (hash)
    const storedPinHash = await SecureStore.getItemAsync(`pin_${childId}`);
    const inputPinHash = await this.hashPin(pin);

    if (storedPinHash !== inputPinHash) {
      await this.incrementFailedAttempts(childId);
      const attempts = await this.getFailedAttempts(childId);

      if (attempts >= 5) {
        // Bloquear e notificar pai
        await this.lockChildAccount(childId);
        await this.notifyParent(childId, 'PIN_LOCKED');
        throw new AccountLockedException();
      }

      throw new InvalidPinException(5 - attempts);
    }

    // PIN correto - obter token do servidor
    const response = await api.post('/auth/child-login', {
      childId,
      pinVerified: true,
      deviceInfo: await this.getDeviceInfo(),
    });

    await this.resetFailedAttempts(childId);
    await this.storeTokens(response.tokens);

    return { success: true, user: response.user };
  }

  // Autenticacao biometrica
  async authenticateWithBiometrics(): Promise<boolean> {
    const hasHardware = await LocalAuthentication.hasHardwareAsync();
    const isEnrolled = await LocalAuthentication.isEnrolledAsync();

    if (!hasHardware || !isEnrolled) {
      return false;
    }

    const result = await LocalAuthentication.authenticateAsync({
      promptMessage: 'Confirme sua identidade',
      cancelLabel: 'Usar PIN',
      disableDeviceFallback: false,
      fallbackLabel: 'Usar PIN',
    });

    return result.success;
  }

  // Device binding
  private async getDeviceInfo(): Promise<DeviceInfo> {
    return {
      deviceId: await this.getOrCreateDeviceId(),
      platform: Platform.OS,
      version: Platform.Version,
      model: Device.modelName,
      isRooted: await this.checkRootStatus(),
      isEmulator: !Device.isDevice,
    };
  }

  private async checkRootStatus(): Promise<boolean> {
    if (Platform.OS === 'ios') {
      return await JailbreakDetection.isJailbroken();
    }
    return await RootDetection.isRooted();
  }

  // Armazenamento seguro de tokens
  private async storeTokens(tokens: Tokens): Promise<void> {
    await SecureStore.setItemAsync('access_token', tokens.accessToken);
    await SecureStore.setItemAsync('refresh_token', tokens.refreshToken);

    // Expiracao em memoria (MMKV)
    secureStorage.set('token_expiry', tokens.expiresAt);
  }

  // Hash do PIN (Argon2)
  private async hashPin(pin: string): Promise<string> {
    const salt = await this.getDeviceSalt();
    return await Argon2.hash(pin, salt);
  }
}
```

### Configuracao de Seguranca por Perfil

```typescript
// packages/core/src/config/securityConfig.ts
export const securityConfig = {
  parent: {
    password: {
      minLength: 12,
      requireUppercase: true,
      requireLowercase: true,
      requireNumber: true,
      requireSpecial: true,
      checkPwned: true,
      maxAge: 180, // dias
      history: 12,
    },
    session: {
      maxDuration: 24 * 60 * 60 * 1000, // 24 horas
      inactivityTimeout: 15 * 60 * 1000, // 15 minutos
    },
    mfa: {
      required: true,
      methods: ['totp', 'sms', 'push'],
    },
    devices: {
      maxTrusted: 3,
    },
  },

  child: {
    pin: {
      length: 6,
      blockSequential: true,    // 123456
      blockRepeated: true,      // 111111
      blockBirthdate: true,
      maxAttempts: 5,
      lockoutDuration: 15 * 60 * 1000, // 15 minutos
    },
    session: {
      maxDuration: 4 * 60 * 60 * 1000, // 4 horas
      inactivityTimeout: 5 * 60 * 1000, // 5 minutos
    },
    devices: {
      maxTrusted: 1,
    },
  },

  transactions: {
    stepUpAuth: {
      amountThreshold: 500,     // R$ 500
      newRecipient: true,
      limitChange: true,
    },
  },
};
```

### Certificate Pinning

```typescript
// packages/api-client/src/config/ssl.ts
import { TrustKit } from 'react-native-ssl-pinning';

export const sslConfig = {
  pins: {
    'api.greenlight.com.br': [
      'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
      'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=',
    ],
    'auth.greenlight.com.br': [
      'sha256/CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=',
    ],
  },
  validateHost: true,
  disableDefaultTrustStore: true,
};

export async function initSSLPinning() {
  await TrustKit.initializeWithConfiguration({
    pinnedDomains: sslConfig.pins,
    swizzleNetworkDelegates: true,
  });
}
```

---

## 7. Offline-First Strategy

### Arquitetura Offline

```
+------------------------------------------------------------------+
|                    OFFLINE-FIRST ARCHITECTURE                     |
+------------------------------------------------------------------+
|                                                                    |
|  +------------------+                                              |
|  |    UI LAYER      |                                              |
|  +--------+---------+                                              |
|           |                                                        |
|  +--------v---------+     +------------------+                     |
|  |  REACT QUERY     |<--->|   SYNC ENGINE    |                    |
|  |  (Cache Layer)   |     | - Queue manager  |                    |
|  +--------+---------+     | - Conflict res.  |                    |
|           |               | - Retry logic    |                    |
|  +--------v---------+     +--------+---------+                     |
|  | WATERMELON DB    |              |                               |
|  | (Local Storage)  |<-------------+                               |
|  | - Users          |                                              |
|  | - Transactions   |     +------------------+                     |
|  | - Buckets        |     |   NETWORK        |                    |
|  | - Goals          |<--->|   MONITOR        |                    |
|  | - Tasks          |     | - Online/Offline |                    |
|  +------------------+     | - Quality        |                    |
|                           +------------------+                     |
|                                                                    |
+------------------------------------------------------------------+
```

### Implementacao WatermelonDB

```typescript
// packages/core/src/database/schema.ts
import { appSchema, tableSchema } from '@nozbe/watermelondb';

export const schema = appSchema({
  version: 1,
  tables: [
    tableSchema({
      name: 'users',
      columns: [
        { name: 'server_id', type: 'string', isIndexed: true },
        { name: 'name', type: 'string' },
        { name: 'email', type: 'string' },
        { name: 'type', type: 'string' }, // parent | child
        { name: 'avatar_url', type: 'string', isOptional: true },
        { name: 'synced_at', type: 'number' },
      ],
    }),

    tableSchema({
      name: 'buckets',
      columns: [
        { name: 'server_id', type: 'string', isIndexed: true },
        { name: 'user_id', type: 'string', isIndexed: true },
        { name: 'type', type: 'string' }, // spend | save | give | invest
        { name: 'balance', type: 'number' },
        { name: 'percentage', type: 'number' },
        { name: 'synced_at', type: 'number' },
      ],
    }),

    tableSchema({
      name: 'transactions',
      columns: [
        { name: 'server_id', type: 'string', isIndexed: true },
        { name: 'bucket_id', type: 'string', isIndexed: true },
        { name: 'amount', type: 'number' },
        { name: 'type', type: 'string' }, // credit | debit | transfer
        { name: 'description', type: 'string' },
        { name: 'category', type: 'string', isOptional: true },
        { name: 'merchant', type: 'string', isOptional: true },
        { name: 'status', type: 'string' }, // pending | completed | failed
        { name: 'created_at', type: 'number' },
        { name: 'synced_at', type: 'number' },
      ],
    }),

    tableSchema({
      name: 'goals',
      columns: [
        { name: 'server_id', type: 'string', isIndexed: true },
        { name: 'user_id', type: 'string', isIndexed: true },
        { name: 'bucket_id', type: 'string', isIndexed: true },
        { name: 'name', type: 'string' },
        { name: 'target_amount', type: 'number' },
        { name: 'current_amount', type: 'number' },
        { name: 'image_url', type: 'string', isOptional: true },
        { name: 'deadline', type: 'number', isOptional: true },
        { name: 'completed', type: 'boolean' },
        { name: 'synced_at', type: 'number' },
      ],
    }),

    tableSchema({
      name: 'offline_actions',
      columns: [
        { name: 'action_type', type: 'string' },
        { name: 'payload', type: 'string' }, // JSON
        { name: 'status', type: 'string' }, // pending | syncing | failed
        { name: 'retry_count', type: 'number' },
        { name: 'created_at', type: 'number' },
        { name: 'last_attempt_at', type: 'number', isOptional: true },
        { name: 'error', type: 'string', isOptional: true },
      ],
    }),
  ],
});
```

### Sync Engine

```typescript
// packages/core/src/sync/SyncEngine.ts
import { synchronize } from '@nozbe/watermelondb/sync';
import NetInfo from '@react-native-community/netinfo';

export class SyncEngine {
  private database: Database;
  private isOnline: boolean = true;
  private syncInProgress: boolean = false;

  constructor(database: Database) {
    this.database = database;
    this.setupNetworkListener();
  }

  private setupNetworkListener() {
    NetInfo.addEventListener((state) => {
      const wasOffline = !this.isOnline;
      this.isOnline = state.isConnected ?? false;

      // Reconectou - iniciar sync
      if (wasOffline && this.isOnline) {
        this.syncPendingActions();
        this.pullChanges();
      }
    });
  }

  // Sync completo (pull + push)
  async sync(): Promise<SyncResult> {
    if (this.syncInProgress) {
      return { status: 'already_syncing' };
    }

    if (!this.isOnline) {
      return { status: 'offline' };
    }

    this.syncInProgress = true;

    try {
      await synchronize({
        database: this.database,

        pullChanges: async ({ lastPulledAt }) => {
          const response = await api.get('/sync/pull', {
            params: { lastPulledAt },
          });

          return {
            changes: response.changes,
            timestamp: response.timestamp,
          };
        },

        pushChanges: async ({ changes, lastPulledAt }) => {
          await api.post('/sync/push', {
            changes,
            lastPulledAt,
          });
        },

        migrationsEnabledAtVersion: 1,
      });

      return { status: 'success', syncedAt: Date.now() };
    } catch (error) {
      console.error('Sync failed:', error);
      return { status: 'error', error };
    } finally {
      this.syncInProgress = false;
    }
  }

  // Queue de acoes offline
  async queueOfflineAction(action: OfflineAction): Promise<void> {
    await this.database.write(async () => {
      await this.database.get('offline_actions').create((record) => {
        record.actionType = action.type;
        record.payload = JSON.stringify(action.payload);
        record.status = 'pending';
        record.retryCount = 0;
        record.createdAt = Date.now();
      });
    });
  }

  // Processar acoes pendentes
  async syncPendingActions(): Promise<void> {
    const pendingActions = await this.database
      .get('offline_actions')
      .query(Q.where('status', 'pending'))
      .fetch();

    for (const action of pendingActions) {
      await this.processAction(action);
    }
  }

  private async processAction(action: OfflineActionRecord): Promise<void> {
    try {
      await this.database.write(async () => {
        await action.update((record) => {
          record.status = 'syncing';
          record.lastAttemptAt = Date.now();
        });
      });

      const payload = JSON.parse(action.payload);
      await this.executeAction(action.actionType, payload);

      // Sucesso - remover da fila
      await this.database.write(async () => {
        await action.destroyPermanently();
      });
    } catch (error) {
      await this.handleActionError(action, error);
    }
  }

  private async handleActionError(
    action: OfflineActionRecord,
    error: Error
  ): Promise<void> {
    const newRetryCount = action.retryCount + 1;
    const maxRetries = 5;

    await this.database.write(async () => {
      await action.update((record) => {
        record.retryCount = newRetryCount;
        record.status = newRetryCount >= maxRetries ? 'failed' : 'pending';
        record.error = error.message;
      });
    });

    // Se falhou definitivamente, notificar usuario
    if (newRetryCount >= maxRetries) {
      await this.notifyActionFailed(action);
    }
  }

  private async executeAction(type: string, payload: any): Promise<void> {
    switch (type) {
      case 'TRANSFER_BETWEEN_BUCKETS':
        await api.post('/buckets/transfer', payload);
        break;
      case 'CREATE_GOAL':
        await api.post('/goals', payload);
        break;
      case 'COMPLETE_TASK':
        await api.post(`/tasks/${payload.taskId}/complete`);
        break;
      default:
        throw new Error(`Unknown action type: ${type}`);
    }
  }
}
```

### Conflict Resolution

```typescript
// packages/core/src/sync/ConflictResolver.ts
export class ConflictResolver {
  // Estrategia: Last-Write-Wins com merge inteligente
  resolve<T extends SyncableEntity>(
    local: T,
    remote: T,
    conflictType: ConflictType
  ): T {
    switch (conflictType) {
      case 'TRANSACTION':
        // Transacoes: servidor sempre ganha (source of truth)
        return remote;

      case 'GOAL':
        // Metas: merge - pegar maior progresso
        return {
          ...remote,
          currentAmount: Math.max(local.currentAmount, remote.currentAmount),
        };

      case 'BUCKET_BALANCE':
        // Saldo: servidor sempre ganha
        return remote;

      case 'USER_PREFERENCE':
        // Preferencias: local ganha (usuario acabou de mudar)
        return local.updatedAt > remote.updatedAt ? local : remote;

      default:
        // Default: Last-Write-Wins
        return local.updatedAt > remote.updatedAt ? local : remote;
    }
  }
}
```

---

## 8. Push Notifications

### Arquitetura de Notificacoes

```
+------------------------------------------------------------------+
|                    PUSH NOTIFICATION ARCHITECTURE                 |
+------------------------------------------------------------------+
|                                                                    |
|  BACKEND                                                           |
|  +------------------+     +------------------+                     |
|  | Notification     |---->|  Message Queue   |                    |
|  | Service          |     |  (Redis/SQS)     |                    |
|  +------------------+     +--------+---------+                     |
|                                    |                               |
|                           +--------v---------+                     |
|                           |  Push Gateway    |                     |
|                           |  (Firebase Admin)|                     |
|                           +--------+---------+                     |
|                                    |                               |
|              +---------------------+---------------------+          |
|              |                                           |          |
|     +--------v---------+                       +--------v---------+ |
|     |      FCM         |                       |      APNS        | |
|     |    (Android)     |                       |      (iOS)       | |
|     +--------+---------+                       +--------+---------+ |
|              |                                           |          |
|     +--------v---------+                       +--------v---------+ |
|     |   Child App      |                       |   Parent App     | |
|     |   Android        |                       |   iOS            | |
|     +------------------+                       +------------------+ |
|                                                                    |
+------------------------------------------------------------------+
```

### Tipos de Notificacao

```typescript
// packages/core/src/notifications/types.ts
export enum NotificationType {
  // Transacionais (alta prioridade)
  TRANSACTION_RECEIVED = 'TRANSACTION_RECEIVED',
  TRANSACTION_SENT = 'TRANSACTION_SENT',
  ALLOWANCE_RECEIVED = 'ALLOWANCE_RECEIVED',
  CARD_PURCHASE = 'CARD_PURCHASE',

  // Parentais (alta prioridade)
  CHILD_PURCHASE = 'CHILD_PURCHASE',
  LIMIT_REACHED = 'LIMIT_REACHED',
  BLOCKED_CATEGORY = 'BLOCKED_CATEGORY',
  TASK_COMPLETED = 'TASK_COMPLETED',
  APPROVAL_NEEDED = 'APPROVAL_NEEDED',

  // Metas (media prioridade)
  GOAL_PROGRESS = 'GOAL_PROGRESS',
  GOAL_ACHIEVED = 'GOAL_ACHIEVED',

  // Educacionais (baixa prioridade)
  NEW_LESSON = 'NEW_LESSON',
  QUIZ_AVAILABLE = 'QUIZ_AVAILABLE',
  STREAK_REMINDER = 'STREAK_REMINDER',

  // Seguranca (alta prioridade)
  NEW_DEVICE_LOGIN = 'NEW_DEVICE_LOGIN',
  PIN_LOCKED = 'PIN_LOCKED',
  SUSPICIOUS_ACTIVITY = 'SUSPICIOUS_ACTIVITY',
}

export interface NotificationPayload {
  type: NotificationType;
  title: string;
  body: string;
  data: Record<string, string>;
  priority: 'high' | 'normal';
  channelId: string;
  badge?: number;
  sound?: string;
  imageUrl?: string;
}
```

### Implementacao React Native

```typescript
// packages/core/src/notifications/NotificationService.ts
import messaging from '@react-native-firebase/messaging';
import notifee, { AndroidImportance } from '@notifee/react-native';

export class NotificationService {
  async initialize(): Promise<void> {
    // Solicitar permissao
    const authStatus = await messaging().requestPermission();
    const enabled =
      authStatus === messaging.AuthorizationStatus.AUTHORIZED ||
      authStatus === messaging.AuthorizationStatus.PROVISIONAL;

    if (!enabled) {
      console.log('Notificacoes nao autorizadas');
      return;
    }

    // Criar canais Android
    await this.createNotificationChannels();

    // Registrar handlers
    this.setupMessageHandlers();

    // Obter e registrar token
    const token = await messaging().getToken();
    await this.registerToken(token);

    // Listener para refresh de token
    messaging().onTokenRefresh(this.registerToken);
  }

  private async createNotificationChannels(): Promise<void> {
    // Canal de transacoes (alta prioridade)
    await notifee.createChannel({
      id: 'transactions',
      name: 'Transacoes',
      importance: AndroidImportance.HIGH,
      sound: 'transaction_sound',
      vibration: true,
    });

    // Canal de alertas parentais (alta prioridade)
    await notifee.createChannel({
      id: 'parental_alerts',
      name: 'Alertas Parentais',
      importance: AndroidImportance.HIGH,
      sound: 'alert_sound',
      vibration: true,
    });

    // Canal de metas (media prioridade)
    await notifee.createChannel({
      id: 'goals',
      name: 'Metas',
      importance: AndroidImportance.DEFAULT,
    });

    // Canal educacional (baixa prioridade)
    await notifee.createChannel({
      id: 'education',
      name: 'Educacao Financeira',
      importance: AndroidImportance.LOW,
    });

    // Canal de seguranca (maxima prioridade)
    await notifee.createChannel({
      id: 'security',
      name: 'Seguranca',
      importance: AndroidImportance.HIGH,
      sound: 'security_alert',
      vibration: true,
    });
  }

  private setupMessageHandlers(): void {
    // Foreground
    messaging().onMessage(async (message) => {
      await this.displayNotification(message);
    });

    // Background
    messaging().setBackgroundMessageHandler(async (message) => {
      await this.displayNotification(message);
    });

    // Notification tap (app fechado)
    messaging().onNotificationOpenedApp((message) => {
      this.handleNotificationTap(message);
    });

    // App aberto por notificacao
    messaging()
      .getInitialNotification()
      .then((message) => {
        if (message) {
          this.handleNotificationTap(message);
        }
      });
  }

  private async displayNotification(message: FirebaseMessagingTypes.RemoteMessage): Promise<void> {
    const { data, notification } = message;

    await notifee.displayNotification({
      title: notification?.title,
      body: notification?.body,
      android: {
        channelId: data?.channelId || 'default',
        pressAction: { id: 'default' },
        largeIcon: data?.imageUrl,
        style: data?.imageUrl
          ? { type: AndroidStyle.BIGPICTURE, picture: data.imageUrl }
          : undefined,
      },
      ios: {
        sound: 'default',
        categoryId: data?.type,
      },
      data,
    });
  }

  private handleNotificationTap(message: FirebaseMessagingTypes.RemoteMessage): void {
    const { data } = message;

    // Navegar para tela apropriada baseado no tipo
    switch (data?.type) {
      case NotificationType.TRANSACTION_RECEIVED:
      case NotificationType.CARD_PURCHASE:
        navigation.navigate('TransactionDetail', { id: data.transactionId });
        break;

      case NotificationType.GOAL_ACHIEVED:
        navigation.navigate('GoalDetail', { id: data.goalId });
        break;

      case NotificationType.TASK_COMPLETED:
        navigation.navigate('Tasks');
        break;

      case NotificationType.APPROVAL_NEEDED:
        navigation.navigate('Approvals');
        break;

      default:
        navigation.navigate('Home');
    }
  }

  private async registerToken(token: string): Promise<void> {
    await api.post('/notifications/register-token', {
      token,
      platform: Platform.OS,
      deviceId: await getDeviceId(),
    });
  }
}
```

---

## 9. Deep Linking

### Estrategia de Deep Links

```
+------------------------------------------------------------------+
|                     DEEP LINKING STRATEGY                         |
+------------------------------------------------------------------+
|                                                                    |
|  URL SCHEMES:                                                      |
|  +------------------------+  +---------------------------+         |
|  | greenlight://          |  | https://greenlight.com.br |         |
|  | (App Link interno)     |  | (Universal Link)          |         |
|  +------------------------+  +---------------------------+         |
|                                                                    |
|  ROTAS SUPORTADAS:                                                 |
|  +------------------------------------------------------------------+
|  | Rota                        | Descricao                   |
|  |-----------------------------|-----------------------------|
|  | /invite/{code}              | Convite familiar            |
|  | /transaction/{id}           | Detalhe de transacao        |
|  | /goal/{id}                  | Detalhe de meta             |
|  | /task/{id}                  | Detalhe de tarefa           |
|  | /buckets/{type}             | Balde especifico            |
|  | /pix/receive                | Receber PIX                 |
|  | /pix/pay/{payload}          | Pagar PIX                   |
|  | /card/activate/{code}       | Ativar cartao fisico        |
|  | /reset-pin/{token}          | Reset de PIN                |
|  | /approve/{requestId}        | Aprovar solicitacao         |
|  +------------------------------------------------------------------+
|                                                                    |
+------------------------------------------------------------------+
```

### Configuracao React Navigation

```typescript
// apps/child-app/src/navigation/linking.ts
import { LinkingOptions } from '@react-navigation/native';

export const linking: LinkingOptions<RootStackParamList> = {
  prefixes: [
    'greenlight://',
    'https://greenlight.com.br',
    'https://app.greenlight.com.br',
  ],

  config: {
    screens: {
      // Auth
      PinLogin: 'login',

      // Main
      Main: {
        screens: {
          Home: 'home',
          Buckets: {
            screens: {
              BucketsOverview: 'buckets',
              SpendBucket: 'buckets/spend',
              SaveBucket: 'buckets/save',
              GiveBucket: 'buckets/give',
              InvestBucket: 'buckets/invest',
              GoalDetail: 'goal/:goalId',
            },
          },
          Tasks: 'tasks',
          Learn: 'learn',
          Profile: 'profile',
        },
      },

      // Modals
      TransactionDetail: 'transaction/:transactionId',
      CreateGoalModal: 'goal/create',
      ReceiveModal: 'pix/receive',

      // PIX
      PixPay: 'pix/pay/:payload',
    },
  },

  // Validacao de deep links
  async getStateFromPath(path, options) {
    // Validar antes de processar
    if (path.includes('approve/') || path.includes('reset-pin/')) {
      const isValid = await validateDeepLinkToken(path);
      if (!isValid) {
        // Redirecionar para home se invalido
        return { routes: [{ name: 'Main' }] };
      }
    }

    return getStateFromPathDefault(path, options);
  },
};
```

### Configuracao iOS (Associated Domains)

```xml
<!-- ios/GreenlightChild/GreenlightChild.entitlements -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "...">
<plist version="1.0">
<dict>
  <key>com.apple.developer.associated-domains</key>
  <array>
    <string>applinks:greenlight.com.br</string>
    <string>applinks:app.greenlight.com.br</string>
  </array>
</dict>
</plist>
```

### Configuracao Android (App Links)

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<activity
  android:name=".MainActivity"
  android:launchMode="singleTask">

  <!-- Deep links -->
  <intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="greenlight" />
  </intent-filter>

  <!-- Universal links -->
  <intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" />
    <data android:host="greenlight.com.br" />
    <data android:host="app.greenlight.com.br" />
  </intent-filter>
</activity>
```

---

## 10. Performance

### Metricas Alvo

| Metrica | Alvo | Critico |
|---------|------|---------|
| Cold Start | < 1.5s | < 2.5s |
| TTI (Time to Interactive) | < 2s | < 3s |
| FPS (animacoes) | 60 FPS | > 55 FPS |
| Memory Baseline | < 100MB | < 150MB |
| Bundle Size (Android) | < 25MB | < 40MB |
| Bundle Size (iOS) | < 30MB | < 45MB |
| API Response P95 | < 300ms | < 500ms |

### Estrategias de Otimizacao

```typescript
// 1. Hermes Engine (habilitado por padrao no RN 0.70+)
// android/gradle.properties
hermesEnabled=true

// 2. RAM Bundles e Inline Requires
// metro.config.js
module.exports = {
  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
};

// 3. Image Optimization
// packages/ui/src/components/OptimizedImage.tsx
import FastImage from 'react-native-fast-image';

export function OptimizedImage({ source, ...props }) {
  return (
    <FastImage
      source={{
        uri: source.uri,
        priority: FastImage.priority.normal,
        cache: FastImage.cacheControl.immutable,
      }}
      resizeMode={FastImage.resizeMode.cover}
      {...props}
    />
  );
}

// 4. Lista Virtualizadas com FlashList
// packages/ui/src/components/TransactionList.tsx
import { FlashList } from '@shopify/flash-list';

export function TransactionList({ transactions }) {
  return (
    <FlashList
      data={transactions}
      renderItem={({ item }) => <TransactionItem transaction={item} />}
      estimatedItemSize={72}
      keyExtractor={(item) => item.id}
      removeClippedSubviews={true}
    />
  );
}

// 5. Memoization
// packages/ui/src/components/BucketCard.tsx
import { memo, useMemo } from 'react';

export const BucketCard = memo(function BucketCard({ bucket, onPress }) {
  const formattedBalance = useMemo(
    () => formatCurrency(bucket.balance),
    [bucket.balance]
  );

  return (
    <Pressable onPress={onPress}>
      <Text>{formattedBalance}</Text>
    </Pressable>
  );
});

// 6. Lazy Loading de Screens
// apps/child-app/src/navigation/BucketsNavigator.tsx
const SpendBucketScreen = React.lazy(() => import('../screens/SpendBucketScreen'));
const SaveBucketScreen = React.lazy(() => import('../screens/SaveBucketScreen'));

// 7. Prefetch de dados
// packages/api-client/src/hooks/usePrefetch.ts
export function usePrefetchBuckets(childId: string) {
  const queryClient = useQueryClient();

  useEffect(() => {
    // Prefetch ao montar
    queryClient.prefetchQuery({
      queryKey: bucketKeys.byChild(childId),
      queryFn: () => bucketsApi.getBuckets(childId),
    });
  }, [childId]);
}
```

### Monitoramento de Performance

```typescript
// packages/core/src/monitoring/PerformanceMonitor.ts
import * as Sentry from '@sentry/react-native';
import analytics from '@react-native-firebase/analytics';

export class PerformanceMonitor {
  // Medir tempo de startup
  static measureStartup(): void {
    const startTime = global.performance.now();

    InteractionManager.runAfterInteractions(() => {
      const duration = global.performance.now() - startTime;

      Sentry.addBreadcrumb({
        category: 'performance',
        message: `App interactive in ${duration}ms`,
      });

      analytics().logEvent('app_startup', {
        duration_ms: Math.round(duration),
      });
    });
  }

  // Medir transicao de tela
  static measureNavigation(routeName: string): () => void {
    const startTime = global.performance.now();

    return () => {
      const duration = global.performance.now() - startTime;

      if (duration > 300) {
        Sentry.captureMessage(`Slow navigation to ${routeName}`, {
          level: 'warning',
          extra: { duration },
        });
      }

      analytics().logEvent('screen_transition', {
        screen_name: routeName,
        duration_ms: Math.round(duration),
      });
    };
  }

  // Medir API calls
  static measureApiCall(endpoint: string): (success: boolean) => void {
    const startTime = global.performance.now();

    return (success: boolean) => {
      const duration = global.performance.now() - startTime;

      analytics().logEvent('api_call', {
        endpoint,
        duration_ms: Math.round(duration),
        success,
      });
    };
  }
}
```

---

## 11. Testing Strategy

### Piramide de Testes

```
+------------------------------------------------------------------+
|                       TESTING PYRAMID                             |
+------------------------------------------------------------------+
|                                                                    |
|                          /\                                        |
|                         /  \                                       |
|                        / E2E \       10% - Detox/Maestro           |
|                       /  Tests \     Fluxos criticos               |
|                      /----------\                                  |
|                     /            \                                 |
|                    / Integration  \  20% - Testing Library         |
|                   /     Tests      \ Componentes + Hooks           |
|                  /------------------\                              |
|                 /                    \                             |
|                /     Unit Tests       \ 70% - Jest + Vitest        |
|               /  Business Logic/Utils  \ Pure functions            |
|              /==========================\                          |
|                                                                    |
+------------------------------------------------------------------+
```

### Configuracao Jest

```typescript
// jest.config.js
module.exports = {
  preset: 'react-native',
  setupFilesAfterEnv: ['./jest.setup.js'],
  moduleNameMapper: {
    '^@greenlight/(.*)$': '<rootDir>/packages/$1/src',
  },
  collectCoverageFrom: [
    'packages/*/src/**/*.{ts,tsx}',
    'apps/*/src/**/*.{ts,tsx}',
    '!**/*.d.ts',
    '!**/node_modules/**',
  ],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 70,
      lines: 70,
      statements: 70,
    },
  },
  testMatch: [
    '**/__tests__/**/*.test.{ts,tsx}',
    '**/*.test.{ts,tsx}',
  ],
};

// jest.setup.js
import '@testing-library/jest-native/extend-expect';
import { server } from './mocks/server';

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

### Exemplos de Testes

```typescript
// packages/core/src/domain/value-objects/__tests__/Money.test.ts
describe('Money', () => {
  describe('creation', () => {
    it('should create money from cents', () => {
      const money = Money.fromCents(1000);
      expect(money.toCents()).toBe(1000);
      expect(money.toReais()).toBe(10.00);
    });

    it('should reject negative values', () => {
      expect(() => Money.fromCents(-100)).toThrow('Amount cannot be negative');
    });
  });

  describe('operations', () => {
    it('should add two money values', () => {
      const a = Money.fromCents(1000);
      const b = Money.fromCents(500);
      const result = a.add(b);
      expect(result.toCents()).toBe(1500);
    });

    it('should distribute to buckets correctly', () => {
      const total = Money.fromCents(10000); // R$ 100
      const allocation = { spend: 50, save: 30, give: 10, invest: 10 };

      const result = total.distribute(allocation);

      expect(result.spend.toCents()).toBe(5000);
      expect(result.save.toCents()).toBe(3000);
      expect(result.give.toCents()).toBe(1000);
      expect(result.invest.toCents()).toBe(1000);
    });
  });

  describe('formatting', () => {
    it('should format as BRL currency', () => {
      const money = Money.fromCents(123456);
      expect(money.format()).toBe('R$ 1.234,56');
    });
  });
});

// packages/ui/src/components/__tests__/BucketCard.test.tsx
import { render, fireEvent, screen } from '@testing-library/react-native';
import { BucketCard } from '../BucketCard';

describe('BucketCard', () => {
  const defaultProps = {
    type: 'spend' as const,
    balance: 5000, // R$ 50,00 em centavos
    onPress: jest.fn(),
  };

  it('should render bucket with correct balance', () => {
    render(<BucketCard {...defaultProps} />);

    expect(screen.getByText('Gastar')).toBeTruthy();
    expect(screen.getByText('R$ 50,00')).toBeTruthy();
  });

  it('should show percentage when provided', () => {
    render(<BucketCard {...defaultProps} percentage={40} />);

    expect(screen.getByText('40%')).toBeTruthy();
  });

  it('should call onPress when tapped', () => {
    render(<BucketCard {...defaultProps} />);

    fireEvent.press(screen.getByRole('button'));

    expect(defaultProps.onPress).toHaveBeenCalledTimes(1);
  });

  it('should be accessible', () => {
    render(<BucketCard {...defaultProps} testID="bucket-spend" />);

    const card = screen.getByTestId('bucket-spend');
    expect(card).toHaveAccessibilityRole('button');
    expect(card).toHaveAccessibilityLabel('Gastar: R$ 50,00');
  });
});

// apps/child-app/src/screens/__tests__/BucketsOverview.test.tsx
import { renderWithProviders } from '../../test-utils';
import { BucketsOverviewScreen } from '../BucketsOverviewScreen';
import { server } from '../../mocks/server';
import { rest } from 'msw';

describe('BucketsOverviewScreen', () => {
  it('should display all 4 buckets', async () => {
    const { findByText } = renderWithProviders(<BucketsOverviewScreen />);

    expect(await findByText('Gastar')).toBeTruthy();
    expect(await findByText('Guardar')).toBeTruthy();
    expect(await findByText('Doar')).toBeTruthy();
    expect(await findByText('Investir')).toBeTruthy();
  });

  it('should navigate to bucket detail on press', async () => {
    const navigation = { navigate: jest.fn() };
    const { findByTestId } = renderWithProviders(
      <BucketsOverviewScreen navigation={navigation} />
    );

    fireEvent.press(await findByTestId('bucket-save'));

    expect(navigation.navigate).toHaveBeenCalledWith('SaveBucket');
  });

  it('should show loading state', () => {
    const { getByTestId } = renderWithProviders(<BucketsOverviewScreen />);

    expect(getByTestId('loading-skeleton')).toBeTruthy();
  });

  it('should show error state and retry', async () => {
    server.use(
      rest.get('/api/buckets', (req, res, ctx) => {
        return res(ctx.status(500));
      })
    );

    const { findByText, findByRole } = renderWithProviders(<BucketsOverviewScreen />);

    expect(await findByText('Erro ao carregar')).toBeTruthy();

    fireEvent.press(await findByRole('button', { name: 'Tentar novamente' }));

    // Verificar retry
  });
});
```

### E2E com Detox

```typescript
// e2e/child-app/buckets.e2e.ts
describe('Buckets Flow', () => {
  beforeAll(async () => {
    await device.launchApp();
    await loginAsChild();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
  });

  it('should display 4 buckets on home screen', async () => {
    await expect(element(by.id('bucket-spend'))).toBeVisible();
    await expect(element(by.id('bucket-save'))).toBeVisible();
    await expect(element(by.id('bucket-give'))).toBeVisible();
    await expect(element(by.id('bucket-invest'))).toBeVisible();
  });

  it('should transfer between buckets', async () => {
    // Abrir modal de transferencia
    await element(by.id('bucket-spend')).longPress();
    await element(by.text('Transferir para outro balde')).tap();

    // Selecionar destino
    await element(by.id('bucket-destination-save')).tap();

    // Inserir valor
    await element(by.id('transfer-amount-input')).typeText('10');

    // Confirmar
    await element(by.id('confirm-transfer-button')).tap();

    // Verificar sucesso
    await expect(element(by.text('Transferencia realizada!'))).toBeVisible();
  });

  it('should create a new goal', async () => {
    await element(by.id('bucket-save')).tap();
    await element(by.id('create-goal-button')).tap();

    // Preencher formulario
    await element(by.id('goal-name-input')).typeText('PlayStation 5');
    await element(by.id('goal-amount-input')).typeText('4000');

    // Selecionar imagem
    await element(by.id('goal-image-picker')).tap();
    await element(by.text('Videogame')).tap();

    // Salvar
    await element(by.id('save-goal-button')).tap();

    // Verificar que meta aparece
    await expect(element(by.text('PlayStation 5'))).toBeVisible();
    await expect(element(by.text('R$ 0 de R$ 4.000'))).toBeVisible();
  });
});
```

---

## 12. CI/CD Mobile

### Pipeline com GitHub Actions + EAS

```yaml
# .github/workflows/mobile-ci.yml
name: Mobile CI/CD

on:
  push:
    branches: [main, develop]
    paths:
      - 'apps/parent-app/**'
      - 'apps/child-app/**'
      - 'packages/**'
  pull_request:
    branches: [main]

env:
  EXPO_TOKEN: ${{ secrets.EXPO_TOKEN }}

jobs:
  # ============================================
  # JOB 1: Lint e Type Check
  # ============================================
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'yarn'

      - name: Install dependencies
        run: yarn install --frozen-lockfile

      - name: Lint
        run: yarn turbo lint

      - name: Type check
        run: yarn turbo type-check

  # ============================================
  # JOB 2: Unit Tests
  # ============================================
  test:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'yarn'

      - name: Install dependencies
        run: yarn install --frozen-lockfile

      - name: Run tests
        run: yarn turbo test -- --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info

  # ============================================
  # JOB 3: Build Preview (PRs)
  # ============================================
  build-preview:
    runs-on: ubuntu-latest
    needs: test
    if: github.event_name == 'pull_request'
    strategy:
      matrix:
        app: [parent-app, child-app]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'yarn'

      - name: Setup EAS
        uses: expo/expo-github-action@v8
        with:
          eas-version: latest
          token: ${{ secrets.EXPO_TOKEN }}

      - name: Install dependencies
        run: yarn install --frozen-lockfile

      - name: Build Preview
        working-directory: apps/${{ matrix.app }}
        run: eas build --profile preview --platform all --non-interactive

      - name: Comment PR with build links
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: 'Preview builds ready for ${{ matrix.app }}!'
            })

  # ============================================
  # JOB 4: E2E Tests
  # ============================================
  e2e:
    runs-on: macos-latest
    needs: test
    if: github.event_name == 'pull_request'
    strategy:
      matrix:
        app: [child-app]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'yarn'

      - name: Install dependencies
        run: yarn install --frozen-lockfile

      - name: Install Detox dependencies
        run: |
          brew tap wix/brew
          brew install applesimutils

      - name: Build for Detox
        working-directory: apps/${{ matrix.app }}
        run: yarn detox build --configuration ios.sim.debug

      - name: Run Detox tests
        working-directory: apps/${{ matrix.app }}
        run: yarn detox test --configuration ios.sim.debug --headless

  # ============================================
  # JOB 5: Build Production (main only)
  # ============================================
  build-production:
    runs-on: ubuntu-latest
    needs: test
    if: github.ref == 'refs/heads/main'
    strategy:
      matrix:
        app: [parent-app, child-app]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'yarn'

      - name: Setup EAS
        uses: expo/expo-github-action@v8
        with:
          eas-version: latest
          token: ${{ secrets.EXPO_TOKEN }}

      - name: Install dependencies
        run: yarn install --frozen-lockfile

      - name: Build Production
        working-directory: apps/${{ matrix.app }}
        run: eas build --profile production --platform all --non-interactive --auto-submit

  # ============================================
  # JOB 6: Submit to Stores
  # ============================================
  submit:
    runs-on: ubuntu-latest
    needs: build-production
    if: github.ref == 'refs/heads/main'
    strategy:
      matrix:
        app: [parent-app, child-app]
    steps:
      - uses: actions/checkout@v4

      - name: Setup EAS
        uses: expo/expo-github-action@v8
        with:
          eas-version: latest
          token: ${{ secrets.EXPO_TOKEN }}

      - name: Submit to stores
        working-directory: apps/${{ matrix.app }}
        run: eas submit --platform all --non-interactive
```

### Configuracao EAS

```json
// apps/child-app/eas.json
{
  "cli": {
    "version": ">= 5.0.0"
  },
  "build": {
    "development": {
      "developmentClient": true,
      "distribution": "internal",
      "ios": {
        "simulator": true
      },
      "env": {
        "APP_ENV": "development",
        "API_URL": "https://dev-api.greenlight.com.br"
      }
    },
    "preview": {
      "distribution": "internal",
      "channel": "preview",
      "env": {
        "APP_ENV": "staging",
        "API_URL": "https://staging-api.greenlight.com.br"
      }
    },
    "production": {
      "channel": "production",
      "env": {
        "APP_ENV": "production",
        "API_URL": "https://api.greenlight.com.br"
      },
      "ios": {
        "resourceClass": "m-medium"
      },
      "android": {
        "buildType": "apk"
      }
    }
  },
  "submit": {
    "production": {
      "ios": {
        "appleId": "dev@greenlight.com.br",
        "ascAppId": "123456789",
        "appleTeamId": "XXXXXXXXXX"
      },
      "android": {
        "serviceAccountKeyPath": "./play-store-key.json",
        "track": "internal"
      }
    }
  }
}
```

---

## 13. Feature Flags

### Arquitetura de Feature Flags

```
+------------------------------------------------------------------+
|                    FEATURE FLAGS ARCHITECTURE                     |
+------------------------------------------------------------------+
|                                                                    |
|  +------------------+                                              |
|  |  Firebase Remote |     Flags remotos                           |
|  |  Config          |     - Rollout gradual                       |
|  +--------+---------+     - A/B testing                           |
|           |               - Kill switches                          |
|           v                                                        |
|  +------------------+                                              |
|  |  Feature Flag    |     Cache local                             |
|  |  Service         |     - Fallback values                       |
|  +--------+---------+     - Offline support                       |
|           |                                                        |
|           v                                                        |
|  +------------------+                                              |
|  |  React Context   |     Consumo nos componentes                 |
|  |  + Hooks         |     - useFeatureFlag()                      |
|  +------------------+     - <FeatureGate>                         |
|                                                                    |
+------------------------------------------------------------------+
```

### Implementacao

```typescript
// packages/core/src/features/FeatureFlagService.ts
import remoteConfig from '@react-native-firebase/remote-config';
import { MMKV } from 'react-native-mmkv';

const storage = new MMKV({ id: 'feature-flags' });

export enum FeatureFlag {
  // Baldes
  BUCKET_INVEST_ENABLED = 'bucket_invest_enabled',
  BUCKET_GIVE_ENABLED = 'bucket_give_enabled',

  // Features
  PIX_ENABLED = 'pix_enabled',
  PHYSICAL_CARD_ENABLED = 'physical_card_enabled',
  PARENT_INTEREST_ENABLED = 'parent_interest_enabled',
  ROUNDUPS_ENABLED = 'roundups_enabled',

  // Experimentos
  NEW_HOME_LAYOUT = 'new_home_layout',
  GAMIFICATION_V2 = 'gamification_v2',

  // Kill switches
  MAINTENANCE_MODE = 'maintenance_mode',
  FORCE_UPDATE = 'force_update',
}

// Valores padrao (fallback)
const defaultValues: Record<FeatureFlag, boolean | string | number> = {
  [FeatureFlag.BUCKET_INVEST_ENABLED]: false,
  [FeatureFlag.BUCKET_GIVE_ENABLED]: true,
  [FeatureFlag.PIX_ENABLED]: true,
  [FeatureFlag.PHYSICAL_CARD_ENABLED]: false,
  [FeatureFlag.PARENT_INTEREST_ENABLED]: true,
  [FeatureFlag.ROUNDUPS_ENABLED]: false,
  [FeatureFlag.NEW_HOME_LAYOUT]: false,
  [FeatureFlag.GAMIFICATION_V2]: false,
  [FeatureFlag.MAINTENANCE_MODE]: false,
  [FeatureFlag.FORCE_UPDATE]: false,
};

export class FeatureFlagService {
  private initialized = false;

  async initialize(): Promise<void> {
    if (this.initialized) return;

    // Definir valores padrao
    await remoteConfig().setDefaults(defaultValues);

    // Configurar fetch
    await remoteConfig().setConfigSettings({
      minimumFetchIntervalMillis: __DEV__ ? 0 : 3600000, // 1 hora em prod
    });

    // Buscar e ativar
    try {
      await remoteConfig().fetchAndActivate();
      this.cacheValues();
    } catch (error) {
      console.warn('Failed to fetch remote config:', error);
    }

    this.initialized = true;
  }

  getBoolean(flag: FeatureFlag): boolean {
    // Tentar do remote config primeiro
    try {
      return remoteConfig().getBoolean(flag);
    } catch {
      // Fallback para cache local
      const cached = storage.getString(flag);
      if (cached !== undefined) {
        return cached === 'true';
      }
      // Fallback para valor padrao
      return defaultValues[flag] as boolean;
    }
  }

  getString(flag: FeatureFlag): string {
    try {
      return remoteConfig().getString(flag);
    } catch {
      const cached = storage.getString(flag);
      return cached ?? (defaultValues[flag] as string);
    }
  }

  getNumber(flag: FeatureFlag): number {
    try {
      return remoteConfig().getNumber(flag);
    } catch {
      const cached = storage.getString(flag);
      return cached ? parseFloat(cached) : (defaultValues[flag] as number);
    }
  }

  private cacheValues(): void {
    const all = remoteConfig().getAll();
    Object.entries(all).forEach(([key, value]) => {
      storage.set(key, value.asString());
    });
  }

  // Para segmentacao por usuario
  async setUserProperties(properties: Record<string, string>): Promise<void> {
    // Usado para rollout gradual por segmento
    await remoteConfig().setConfigSettings({
      ...properties,
    });
  }
}

export const featureFlags = new FeatureFlagService();
```

### Hooks e Componentes

```typescript
// packages/core/src/features/useFeatureFlag.ts
import { useEffect, useState } from 'react';
import { featureFlags, FeatureFlag } from './FeatureFlagService';

export function useFeatureFlag(flag: FeatureFlag): boolean {
  const [enabled, setEnabled] = useState(() => featureFlags.getBoolean(flag));

  useEffect(() => {
    // Re-check on mount (pode ter mudado)
    setEnabled(featureFlags.getBoolean(flag));
  }, [flag]);

  return enabled;
}

// packages/ui/src/components/FeatureGate.tsx
interface FeatureGateProps {
  flag: FeatureFlag;
  children: React.ReactNode;
  fallback?: React.ReactNode;
}

export function FeatureGate({ flag, children, fallback = null }: FeatureGateProps) {
  const enabled = useFeatureFlag(flag);
  return enabled ? <>{children}</> : <>{fallback}</>;
}

// Uso:
function BucketsOverview() {
  return (
    <View>
      <BucketCard type="spend" />
      <BucketCard type="save" />

      <FeatureGate flag={FeatureFlag.BUCKET_GIVE_ENABLED}>
        <BucketCard type="give" />
      </FeatureGate>

      <FeatureGate
        flag={FeatureFlag.BUCKET_INVEST_ENABLED}
        fallback={<BucketCardComingSoon type="invest" />}
      >
        <BucketCard type="invest" />
      </FeatureGate>
    </View>
  );
}
```

---

## 14. Analytics e Tracking

### Estrategia de Analytics

```
+------------------------------------------------------------------+
|                    ANALYTICS ARCHITECTURE                         |
+------------------------------------------------------------------+
|                                                                    |
|  EVENTOS                                                           |
|  +------------------+     +------------------+                     |
|  | User Actions     |     | System Events    |                    |
|  | - screen_view    |     | - app_open       |                    |
|  | - button_click   |     | - app_background |                    |
|  | - transaction    |     | - push_received  |                    |
|  | - goal_created   |     | - error          |                    |
|  +--------+---------+     +--------+---------+                     |
|           |                        |                               |
|           +------------+-----------+                               |
|                        |                                           |
|                +-------v-------+                                   |
|                | Analytics     |                                   |
|                | Service       |                                   |
|                +-------+-------+                                   |
|                        |                                           |
|        +---------------+---------------+                           |
|        |               |               |                           |
|  +-----v-----+  +------v------+  +-----v-----+                    |
|  | Firebase  |  | Amplitude   |  | Sentry    |                    |
|  | Analytics |  | (Product)   |  | (Errors)  |                    |
|  +-----------+  +-------------+  +-----------+                    |
|                                                                    |
+------------------------------------------------------------------+
```

### Eventos Principais

```typescript
// packages/core/src/analytics/events.ts
export const AnalyticsEvents = {
  // Autenticacao
  AUTH: {
    LOGIN_SUCCESS: 'login_success',
    LOGIN_FAILED: 'login_failed',
    LOGOUT: 'logout',
    BIOMETRIC_ENABLED: 'biometric_enabled',
    PIN_CHANGED: 'pin_changed',
  },

  // Baldes
  BUCKETS: {
    VIEWED: 'buckets_viewed',
    BUCKET_SELECTED: 'bucket_selected',
    TRANSFER_STARTED: 'bucket_transfer_started',
    TRANSFER_COMPLETED: 'bucket_transfer_completed',
    ALLOCATION_CHANGED: 'bucket_allocation_changed',
  },

  // Transacoes
  TRANSACTIONS: {
    VIEWED: 'transactions_viewed',
    DETAIL_VIEWED: 'transaction_detail_viewed',
    PIX_INITIATED: 'pix_initiated',
    PIX_COMPLETED: 'pix_completed',
    CARD_PURCHASE: 'card_purchase',
  },

  // Metas
  GOALS: {
    CREATED: 'goal_created',
    CONTRIBUTED: 'goal_contributed',
    COMPLETED: 'goal_completed',
    DELETED: 'goal_deleted',
    SHARED: 'goal_shared',
  },

  // Tarefas
  TASKS: {
    VIEWED: 'tasks_viewed',
    COMPLETED: 'task_completed',
    CREATED_BY_PARENT: 'task_created',
    APPROVED_BY_PARENT: 'task_approved',
  },

  // Educacao
  EDUCATION: {
    LESSON_STARTED: 'lesson_started',
    LESSON_COMPLETED: 'lesson_completed',
    QUIZ_STARTED: 'quiz_started',
    QUIZ_COMPLETED: 'quiz_completed',
    BADGE_EARNED: 'badge_earned',
  },

  // Engajamento
  ENGAGEMENT: {
    APP_OPENED: 'app_opened',
    SESSION_STARTED: 'session_started',
    SESSION_ENDED: 'session_ended',
    NOTIFICATION_OPENED: 'notification_opened',
    DEEP_LINK_OPENED: 'deep_link_opened',
  },
};
```

### Implementacao do Analytics Service

```typescript
// packages/core/src/analytics/AnalyticsService.ts
import analytics from '@react-native-firebase/analytics';
import * as Amplitude from '@amplitude/analytics-react-native';
import * as Sentry from '@sentry/react-native';

export class AnalyticsService {
  private userId: string | null = null;
  private userType: 'parent' | 'child' | null = null;

  async initialize(): Promise<void> {
    // Firebase Analytics
    await analytics().setAnalyticsCollectionEnabled(!__DEV__);

    // Amplitude
    Amplitude.init(Config.AMPLITUDE_API_KEY, undefined, {
      flushQueueSize: 10,
      flushIntervalMillis: 30000,
    });

    // Sentry (para erros)
    Sentry.init({
      dsn: Config.SENTRY_DSN,
      environment: Config.APP_ENV,
      tracesSampleRate: 0.2,
    });
  }

  setUser(userId: string, userType: 'parent' | 'child'): void {
    this.userId = userId;
    this.userType = userType;

    // Firebase
    analytics().setUserId(userId);
    analytics().setUserProperty('user_type', userType);

    // Amplitude
    Amplitude.setUserId(userId);
    const identify = new Amplitude.Identify();
    identify.set('user_type', userType);
    Amplitude.identify(identify);

    // Sentry
    Sentry.setUser({ id: userId, userType });
  }

  trackEvent(eventName: string, params?: Record<string, any>): void {
    const enrichedParams = {
      ...params,
      user_type: this.userType,
      timestamp: Date.now(),
    };

    // Firebase
    analytics().logEvent(eventName, enrichedParams);

    // Amplitude
    Amplitude.track(eventName, enrichedParams);

    if (__DEV__) {
      console.log(`[Analytics] ${eventName}`, enrichedParams);
    }
  }

  trackScreen(screenName: string, screenClass?: string): void {
    analytics().logScreenView({
      screen_name: screenName,
      screen_class: screenClass || screenName,
    });

    Amplitude.track('screen_view', { screen_name: screenName });
  }

  // Eventos de conversao
  trackConversion(conversionType: string, value?: number): void {
    this.trackEvent('conversion', {
      conversion_type: conversionType,
      value,
    });
  }

  // Erros
  trackError(error: Error, context?: Record<string, any>): void {
    Sentry.captureException(error, { extra: context });

    this.trackEvent('error', {
      error_message: error.message,
      error_name: error.name,
      ...context,
    });
  }

  // User properties
  setUserProperty(name: string, value: string): void {
    analytics().setUserProperty(name, value);

    const identify = new Amplitude.Identify();
    identify.set(name, value);
    Amplitude.identify(identify);
  }
}

export const analyticsService = new AnalyticsService();
```

### Hook de Tracking

```typescript
// packages/core/src/analytics/useTracking.ts
import { useCallback } from 'react';
import { useFocusEffect } from '@react-navigation/native';
import { analyticsService } from './AnalyticsService';
import { AnalyticsEvents } from './events';

export function useScreenTracking(screenName: string) {
  useFocusEffect(
    useCallback(() => {
      analyticsService.trackScreen(screenName);
    }, [screenName])
  );
}

export function useEventTracking() {
  const track = useCallback((event: string, params?: Record<string, any>) => {
    analyticsService.trackEvent(event, params);
  }, []);

  return { track };
}

// Uso:
function BucketsOverviewScreen() {
  useScreenTracking('BucketsOverview');
  const { track } = useEventTracking();

  const handleBucketPress = (bucketType: BucketType) => {
    track(AnalyticsEvents.BUCKETS.BUCKET_SELECTED, {
      bucket_type: bucketType,
    });
    navigation.navigate(`${bucketType}Bucket`);
  };

  return (
    // ...
  );
}
```

---

## 15. Acessibilidade

### Diretrizes de Acessibilidade

```
+------------------------------------------------------------------+
|                    ACCESSIBILITY GUIDELINES                       |
+------------------------------------------------------------------+
|                                                                    |
|  WCAG 2.1 Level AA Compliance                                     |
|  +------------------------------------------------------------+   |
|  |                                                            |   |
|  |  PERCEIVABLE                    OPERABLE                   |   |
|  |  - Contraste minimo 4.5:1       - Navegacao por teclado   |   |
|  |  - Texto escalavel              - Foco visivel            |   |
|  |  - Alternativas para midia      - Tempo suficiente        |   |
|  |                                                            |   |
|  |  UNDERSTANDABLE                 ROBUST                     |   |
|  |  - Linguagem clara              - Compativel com AT       |   |
|  |  - Navegacao consistente        - Parsing correto         |   |
|  |  - Prevencao de erros           - Roles semanticos        |   |
|  |                                                            |   |
|  +------------------------------------------------------------+   |
|                                                                    |
|  ESPECIFICO PARA CRIANCAS                                         |
|  - Linguagem simples (idade 6-17)                                 |
|  - Icones claros e coloridos                                      |
|  - Feedback visual e haptico                                      |
|  - Tolerancia a erros                                             |
|                                                                    |
+------------------------------------------------------------------+
```

### Implementacao de Acessibilidade

```typescript
// packages/ui/src/components/BucketCard/BucketCard.tsx
import { AccessibilityInfo, Pressable, View } from 'react-native';

export function BucketCard({
  type,
  balance,
  percentage,
  onPress,
  testID,
}: BucketCardProps) {
  const config = bucketConfig[type];
  const formattedBalance = formatCurrency(balance);

  return (
    <Pressable
      onPress={onPress}
      testID={testID}

      // Acessibilidade
      accessible={true}
      accessibilityRole="button"
      accessibilityLabel={`${config.label}: ${formattedBalance}`}
      accessibilityHint={`Toque para ver detalhes do balde ${config.label}`}
      accessibilityState={{
        disabled: false,
      }}

      // Feedback haptico
      onPressIn={() => {
        if (Platform.OS === 'ios') {
          Haptics.selectionAsync();
        }
      }}

      style={({ pressed }) => [
        styles.container,
        pressed && styles.pressed,
      ]}
    >
      <View
        accessible={false}
        importantForAccessibility="no-hide-descendants"
      >
        <Icon
          name={config.icon}
          size={24}
          accessibilityElementsHidden={true}
        />
      </View>

      <View>
        <Text
          style={styles.label}
          accessibilityRole="header"
        >
          {config.label}
        </Text>

        <Text
          style={styles.balance}
          accessibilityLabel={`Saldo: ${formattedBalance}`}
        >
          {formattedBalance}
        </Text>

        {percentage !== undefined && (
          <Text
            style={styles.percentage}
            accessibilityLabel={`${percentage} por cento da mesada`}
          >
            {percentage}%
          </Text>
        )}
      </View>
    </Pressable>
  );
}

// packages/ui/src/components/Input/Input.tsx
export function Input({
  label,
  value,
  error,
  hint,
  onChangeText,
  ...props
}: InputProps) {
  const inputId = useId();
  const errorId = `${inputId}-error`;
  const hintId = `${inputId}-hint`;

  return (
    <View>
      <Text
        nativeID={`${inputId}-label`}
        style={styles.label}
        accessibilityRole="text"
      >
        {label}
      </Text>

      <TextInput
        value={value}
        onChangeText={onChangeText}

        // Acessibilidade
        accessible={true}
        accessibilityLabel={label}
        accessibilityLabelledBy={`${inputId}-label`}
        accessibilityDescribedBy={error ? errorId : hint ? hintId : undefined}
        accessibilityState={{
          disabled: props.editable === false,
        }}
        accessibilityValue={{
          text: value,
        }}

        style={[
          styles.input,
          error && styles.inputError,
        ]}
        {...props}
      />

      {hint && !error && (
        <Text
          nativeID={hintId}
          style={styles.hint}
          accessibilityRole="text"
        >
          {hint}
        </Text>
      )}

      {error && (
        <Text
          nativeID={errorId}
          style={styles.error}
          accessibilityRole="alert"
          accessibilityLiveRegion="polite"
        >
          {error}
        </Text>
      )}
    </View>
  );
}
```

### Testes de Acessibilidade

```typescript
// packages/ui/src/components/__tests__/accessibility.test.tsx
import { render } from '@testing-library/react-native';
import { axe, toHaveNoViolations } from 'jest-axe';

expect.extend(toHaveNoViolations);

describe('Accessibility', () => {
  describe('BucketCard', () => {
    it('should have proper accessibility props', () => {
      const { getByRole } = render(
        <BucketCard type="spend" balance={5000} onPress={() => {}} />
      );

      const button = getByRole('button');
      expect(button).toHaveAccessibilityLabel('Gastar: R$ 50,00');
      expect(button).toHaveAccessibilityState({ disabled: false });
    });

    it('should meet contrast requirements', () => {
      // Verificar contraste programaticamente
      const foreground = colors.text.primary; // #212121
      const background = colors.background.primary; // #FFFFFF
      const ratio = getContrastRatio(foreground, background);

      expect(ratio).toBeGreaterThanOrEqual(4.5);
    });
  });

  describe('Form inputs', () => {
    it('should announce errors to screen reader', () => {
      const { getByLabelText, rerender } = render(
        <Input label="PIN" value="" error="" onChangeText={() => {}} />
      );

      rerender(
        <Input label="PIN" value="123" error="PIN deve ter 6 digitos" onChangeText={() => {}} />
      );

      const errorText = getByLabelText('PIN deve ter 6 digitos');
      expect(errorText).toHaveAccessibilityRole('alert');
      expect(errorText).toHaveProp('accessibilityLiveRegion', 'polite');
    });
  });
});
```

### Escala de Texto Dinamica

```typescript
// packages/ui/src/hooks/useAccessibleFontSize.ts
import { useWindowDimensions, PixelRatio } from 'react-native';

export function useAccessibleFontSize(baseSize: number): number {
  const { fontScale } = useWindowDimensions();

  // Limitar escala para evitar quebra de layout
  const limitedScale = Math.min(fontScale, 1.5);

  return PixelRatio.roundToNearestPixel(baseSize * limitedScale);
}

// packages/ui/src/primitives/Text/Text.tsx
export function Text({ variant = 'body', style, ...props }: TextProps) {
  const baseSize = typography.fontSize[variantSizeMap[variant]];
  const fontSize = useAccessibleFontSize(baseSize);

  return (
    <RNText
      style={[
        { fontSize },
        styles[variant],
        style,
      ]}
      allowFontScaling={true}
      maxFontSizeMultiplier={1.5}
      {...props}
    />
  );
}
```

### Reducao de Movimento

```typescript
// packages/ui/src/hooks/useReducedMotion.ts
import { useEffect, useState } from 'react';
import { AccessibilityInfo } from 'react-native';

export function useReducedMotion(): boolean {
  const [reduceMotion, setReduceMotion] = useState(false);

  useEffect(() => {
    AccessibilityInfo.isReduceMotionEnabled().then(setReduceMotion);

    const subscription = AccessibilityInfo.addEventListener(
      'reduceMotionChanged',
      setReduceMotion
    );

    return () => subscription.remove();
  }, []);

  return reduceMotion;
}

// Uso em animacoes
function AnimatedBucketCard({ bucket }) {
  const reduceMotion = useReducedMotion();

  const animatedStyle = useAnimatedStyle(() => {
    if (reduceMotion) {
      // Sem animacao
      return { transform: [{ scale: 1 }] };
    }

    return {
      transform: [{ scale: withSpring(pressed ? 0.95 : 1) }],
    };
  });

  return (
    <Animated.View style={animatedStyle}>
      <BucketCard bucket={bucket} />
    </Animated.View>
  );
}
```

---

## Resumo das Decisoes Tecnicas

| Area | Decisao | Justificativa |
|------|---------|---------------|
| **Arquitetura** | Monorepo com Turborepo | 80% code sharing, atomic commits |
| **State** | Zustand + TanStack Query | Simples, performatico, separacao client/server |
| **Navegacao** | React Navigation 7 | Maturidade, type-safety, deep linking |
| **Design System** | Tokens + Primitivos + Componentes | Consistencia, reusabilidade |
| **Autenticacao** | PIN (filho) + MFA (pai) + Biometria | Seguranca por perfil |
| **Offline** | WatermelonDB + Sync Engine | Offline-first, conflict resolution |
| **Push** | Firebase + Notifee | Cross-platform, canais Android |
| **Deep Linking** | Universal Links + App Links | SEO, compartilhamento |
| **Performance** | Hermes + FlashList + Memoization | Cold start < 1.5s |
| **Testing** | Jest + Testing Library + Detox | Piramide de testes |
| **CI/CD** | GitHub Actions + EAS | Build nativo na nuvem |
| **Feature Flags** | Firebase Remote Config | Rollout gradual, A/B |
| **Analytics** | Firebase + Amplitude | Product analytics |
| **A11y** | WCAG 2.1 AA | Inclusao, compliance |

---

## Proximos Passos

1. **Setup inicial do monorepo** com Turborepo
2. **Configurar packages compartilhados** (ui, core, api-client)
3. **Implementar Design System** com tokens e componentes
4. **Criar fluxo de autenticacao** (PIN + Biometria)
5. **Desenvolver tela de 4 Baldes** (core feature)
6. **Configurar CI/CD** com EAS
7. **Implementar testes E2E** com Detox
8. **Setup de analytics** e feature flags

---

**Documento criado por**: Mobile Developer Agent
**Data**: Janeiro 2026
**Versao**: 1.0
