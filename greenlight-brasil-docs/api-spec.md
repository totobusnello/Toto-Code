# API REST Specification - Fintech Educacao Financeira Familiar

> **Versao:** 1.0.0 | **Data:** Janeiro 2026
> **Base URL:** `https://api.greenlightbrasil.com.br/v1`
> **Formato:** OpenAPI 3.1 Style

---

## Sumario

1. [Visao Geral](#1-visao-geral)
2. [Autenticacao](#2-autenticacao)
3. [Usuarios](#3-usuarios)
4. [Contas e Baldes](#4-contas-e-baldes)
5. [Cartoes](#5-cartoes)
6. [Transacoes](#6-transacoes)
7. [Mesada](#7-mesada)
8. [Tarefas](#8-tarefas)
9. [Metas](#9-metas)
10. [Webhooks](#10-webhooks)
11. [Rate Limiting](#11-rate-limiting)
12. [Erros](#12-erros)

---

## 1. Visao Geral

### 1.1 Principios de Design

- **RESTful**: Recursos como substantivos, verbos HTTP semanticos
- **JSON**: Todas as requisicoes e respostas em JSON
- **Versionamento**: Via URL path (`/v1/`)
- **Paginacao**: Cursor-based para listas
- **Idempotencia**: Headers `Idempotency-Key` para operacoes criticas
- **HATEOAS**: Links para recursos relacionados

### 1.2 Headers Obrigatorios

```http
Content-Type: application/json
Accept: application/json
Authorization: Bearer <access_token>
X-Device-ID: <device_uuid>
X-Request-ID: <uuid>
Accept-Language: pt-BR
```

### 1.3 Headers Opcionais

```http
Idempotency-Key: <uuid>          # Para POST/PUT em transacoes
X-Client-Version: 1.0.0          # Versao do app
X-Platform: ios|android|web      # Plataforma
```

### 1.4 Formato de Resposta Padrao

```json
{
  "data": { },
  "meta": {
    "request_id": "req_abc123",
    "timestamp": "2026-01-29T10:30:00Z"
  },
  "links": {
    "self": "/v1/resource/123"
  }
}
```

### 1.5 Formato de Lista com Paginacao

```json
{
  "data": [ ],
  "meta": {
    "total_count": 150,
    "page_size": 20,
    "has_more": true
  },
  "links": {
    "self": "/v1/resource?cursor=abc",
    "next": "/v1/resource?cursor=def",
    "prev": "/v1/resource?cursor=xyz"
  }
}
```

---

## 2. Autenticacao

### 2.1 Visao Geral

| Metodo | Uso | Expiracao |
|--------|-----|-----------|
| **Access Token (JWT)** | Autenticacao de requests | 15 minutos |
| **Refresh Token** | Renovar access token | 7 dias |
| **Device Token** | Identificar dispositivo | Permanente |

### 2.2 Endpoints de Autenticacao

---

#### POST /auth/register

Cadastro de novo usuario (pai/responsavel).

**Request:**
```json
{
  "email": "pai@email.com",
  "password": "SenhaSegura123!",
  "full_name": "Joao Silva Santos",
  "cpf": "12345678901",
  "phone": "+5511999998888",
  "birth_date": "1985-03-15",
  "address": {
    "street": "Rua das Flores",
    "number": "123",
    "complement": "Apto 45",
    "neighborhood": "Jardim Paulista",
    "city": "Sao Paulo",
    "state": "SP",
    "zip_code": "01310100"
  },
  "device": {
    "device_id": "uuid-device-123",
    "platform": "ios",
    "model": "iPhone 15",
    "os_version": "17.2"
  },
  "terms_accepted": true,
  "privacy_accepted": true
}
```

**Response: 201 Created**
```json
{
  "data": {
    "user_id": "usr_abc123def456",
    "email": "pai@email.com",
    "full_name": "Joao Silva Santos",
    "cpf_masked": "***.***. 789-01",
    "status": "pending_verification",
    "created_at": "2026-01-29T10:30:00Z"
  },
  "meta": {
    "next_step": "verify_phone",
    "verification_expires_at": "2026-01-29T10:35:00Z"
  }
}
```

---

#### POST /auth/verify/phone

Verificar telefone via SMS OTP.

**Request:**
```json
{
  "user_id": "usr_abc123def456",
  "otp_code": "123456"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "phone_verified": true,
    "status": "pending_kyc"
  },
  "meta": {
    "next_step": "upload_documents"
  }
}
```

---

#### POST /auth/login

Login de usuario existente.

**Request:**
```json
{
  "email": "pai@email.com",
  "password": "SenhaSegura123!",
  "device": {
    "device_id": "uuid-device-123",
    "platform": "ios"
  },
  "mfa_code": "123456"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "ref_xyz789abc123",
    "token_type": "Bearer",
    "expires_in": 900,
    "user": {
      "user_id": "usr_abc123def456",
      "email": "pai@email.com",
      "full_name": "Joao Silva Santos",
      "role": "parent",
      "status": "active",
      "has_children": true,
      "children_count": 2
    }
  },
  "meta": {
    "device_trusted": true,
    "last_login": "2026-01-28T18:45:00Z"
  }
}
```

---

#### POST /auth/login/child

Login de filho (menor) via PIN.

**Request:**
```json
{
  "child_id": "usr_child_123",
  "pin": "123456",
  "device": {
    "device_id": "uuid-device-456",
    "platform": "android"
  },
  "biometric_token": "bio_token_xyz"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "ref_child_abc123",
    "token_type": "Bearer",
    "expires_in": 900,
    "user": {
      "user_id": "usr_child_123",
      "first_name": "Pedro",
      "role": "child",
      "age": 12,
      "avatar_url": "https://cdn.example.com/avatars/pedro.png",
      "parent_id": "usr_abc123def456"
    }
  }
}
```

---

#### POST /auth/refresh

Renovar access token.

**Request:**
```json
{
  "refresh_token": "ref_xyz789abc123"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh_token": "ref_new_token_456",
    "token_type": "Bearer",
    "expires_in": 900
  }
}
```

---

#### POST /auth/logout

Encerrar sessao e revogar tokens.

**Request:**
```json
{
  "refresh_token": "ref_xyz789abc123",
  "logout_all_devices": false
}
```

**Response: 204 No Content**

---

#### POST /auth/password/reset

Solicitar reset de senha.

**Request:**
```json
{
  "email": "pai@email.com"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "message": "Se o email existir, enviaremos instrucoes de reset.",
    "expires_in": 3600
  }
}
```

---

#### POST /auth/password/change

Alterar senha (autenticado).

**Request:**
```json
{
  "current_password": "SenhaAntiga123!",
  "new_password": "NovaSenha456!",
  "mfa_code": "123456"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "message": "Senha alterada com sucesso",
    "all_sessions_revoked": true
  }
}
```

---

#### POST /auth/mfa/setup

Configurar MFA (TOTP).

**Request:**
```json
{
  "method": "totp"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "secret": "JBSWY3DPEHPK3PXP",
    "qr_code_url": "otpauth://totp/GreenlightBR:pai@email.com?secret=JBSWY3DPEHPK3PXP",
    "recovery_codes": [
      "abc123def456",
      "ghi789jkl012",
      "mno345pqr678",
      "stu901vwx234",
      "yza567bcd890"
    ]
  },
  "meta": {
    "warning": "Guarde os codigos de recuperacao em local seguro"
  }
}
```

---

#### POST /auth/mfa/verify

Verificar codigo MFA.

**Request:**
```json
{
  "code": "123456"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "mfa_enabled": true,
    "method": "totp"
  }
}
```

---

### 2.3 Estrutura do JWT

**Header:**
```json
{
  "alg": "RS256",
  "typ": "JWT",
  "kid": "key-2026-01"
}
```

**Payload:**
```json
{
  "sub": "usr_abc123def456",
  "iss": "https://api.greenlightbrasil.com.br",
  "aud": "greenlight-app",
  "iat": 1706523000,
  "exp": 1706523900,
  "role": "parent",
  "scope": ["read", "write", "transfer"],
  "device_id": "uuid-device-123",
  "risk_score": 15
}
```

---

## 3. Usuarios

### 3.1 Endpoints de Usuario (Pai)

---

#### GET /users/me

Obter perfil do usuario autenticado.

**Response: 200 OK**
```json
{
  "data": {
    "user_id": "usr_abc123def456",
    "email": "pai@email.com",
    "full_name": "Joao Silva Santos",
    "cpf_masked": "***.***. 789-01",
    "phone_masked": "+55 11 *****-8888",
    "birth_date": "1985-03-15",
    "role": "parent",
    "status": "active",
    "kyc_status": "approved",
    "mfa_enabled": true,
    "created_at": "2026-01-01T10:00:00Z",
    "address": {
      "street": "Rua das Flores",
      "number": "123",
      "city": "Sao Paulo",
      "state": "SP",
      "zip_code": "01310100"
    },
    "subscription": {
      "plan": "max",
      "status": "active",
      "expires_at": "2027-01-01T00:00:00Z"
    },
    "settings": {
      "notifications_enabled": true,
      "biometric_enabled": true,
      "language": "pt-BR",
      "timezone": "America/Sao_Paulo"
    }
  },
  "links": {
    "self": "/v1/users/me",
    "children": "/v1/users/me/children",
    "accounts": "/v1/accounts"
  }
}
```

---

#### PATCH /users/me

Atualizar perfil do usuario.

**Request:**
```json
{
  "full_name": "Joao Silva Santos Junior",
  "phone": "+5511999997777",
  "address": {
    "street": "Av. Paulista",
    "number": "1000"
  },
  "settings": {
    "notifications_enabled": false
  }
}
```

**Response: 200 OK**
```json
{
  "data": {
    "user_id": "usr_abc123def456",
    "full_name": "Joao Silva Santos Junior",
    "updated_at": "2026-01-29T11:00:00Z"
  },
  "meta": {
    "changes_applied": ["full_name", "phone", "address", "settings"]
  }
}
```

---

### 3.2 Endpoints de Filhos

---

#### POST /users/me/children

Cadastrar filho (menor).

**Request:**
```json
{
  "first_name": "Pedro",
  "last_name": "Silva Santos",
  "cpf": "98765432100",
  "birth_date": "2014-06-20",
  "gender": "male",
  "avatar_style": "robot_blue",
  "pin": "123456",
  "bucket_allocation": {
    "spend": 50,
    "save": 30,
    "give": 10,
    "invest": 10
  },
  "parental_consent": {
    "accepted": true,
    "consent_text_version": "1.0",
    "timestamp": "2026-01-29T10:30:00Z"
  }
}
```

**Response: 201 Created**
```json
{
  "data": {
    "child_id": "usr_child_123",
    "first_name": "Pedro",
    "last_name": "Silva Santos",
    "birth_date": "2014-06-20",
    "age": 11,
    "status": "active",
    "avatar_url": "https://cdn.example.com/avatars/robot_blue.png",
    "account": {
      "account_id": "acc_child_abc",
      "status": "active"
    },
    "buckets": {
      "spend": { "allocation_percent": 50, "balance": 0 },
      "save": { "allocation_percent": 30, "balance": 0 },
      "give": { "allocation_percent": 10, "balance": 0 },
      "invest": { "allocation_percent": 10, "balance": 0 }
    },
    "created_at": "2026-01-29T10:30:00Z"
  },
  "meta": {
    "next_steps": [
      "configure_allowance",
      "order_card"
    ]
  },
  "links": {
    "self": "/v1/users/me/children/usr_child_123",
    "account": "/v1/accounts/acc_child_abc"
  }
}
```

---

#### GET /users/me/children

Listar filhos do usuario.

**Response: 200 OK**
```json
{
  "data": [
    {
      "child_id": "usr_child_123",
      "first_name": "Pedro",
      "age": 11,
      "avatar_url": "https://cdn.example.com/avatars/robot_blue.png",
      "status": "active",
      "total_balance": 245.50,
      "buckets_summary": {
        "spend": 120.00,
        "save": 85.50,
        "give": 20.00,
        "invest": 20.00
      },
      "pending_tasks": 2,
      "active_goals": 1
    },
    {
      "child_id": "usr_child_456",
      "first_name": "Maria",
      "age": 8,
      "avatar_url": "https://cdn.example.com/avatars/unicorn_pink.png",
      "status": "active",
      "total_balance": 78.25,
      "buckets_summary": {
        "spend": 45.00,
        "save": 23.25,
        "give": 5.00,
        "invest": 5.00
      },
      "pending_tasks": 0,
      "active_goals": 2
    }
  ],
  "meta": {
    "total_count": 2
  }
}
```

---

#### GET /users/me/children/{child_id}

Obter detalhes de um filho.

**Response: 200 OK**
```json
{
  "data": {
    "child_id": "usr_child_123",
    "first_name": "Pedro",
    "last_name": "Silva Santos",
    "cpf_masked": "***.***. 321-00",
    "birth_date": "2014-06-20",
    "age": 11,
    "gender": "male",
    "avatar_url": "https://cdn.example.com/avatars/robot_blue.png",
    "status": "active",
    "created_at": "2026-01-01T10:00:00Z",
    "account": {
      "account_id": "acc_child_abc",
      "total_balance": 245.50,
      "buckets": {
        "spend": {
          "allocation_percent": 50,
          "balance": 120.00,
          "available": 120.00
        },
        "save": {
          "allocation_percent": 30,
          "balance": 85.50,
          "goals_count": 1
        },
        "give": {
          "allocation_percent": 10,
          "balance": 20.00
        },
        "invest": {
          "allocation_percent": 10,
          "balance": 20.00
        }
      }
    },
    "card": {
      "card_id": "card_xyz789",
      "type": "virtual",
      "status": "active",
      "last_four": "4532"
    },
    "allowance": {
      "enabled": true,
      "amount": 100.00,
      "frequency": "weekly",
      "next_payment": "2026-02-03T08:00:00Z"
    },
    "controls": {
      "daily_spend_limit": 50.00,
      "transaction_limit": 30.00,
      "blocked_categories": ["gambling", "adult"],
      "spending_hours": {
        "enabled": true,
        "start": "08:00",
        "end": "22:00"
      },
      "notifications_to_parent": true
    }
  },
  "links": {
    "self": "/v1/users/me/children/usr_child_123",
    "transactions": "/v1/accounts/acc_child_abc/transactions",
    "goals": "/v1/children/usr_child_123/goals",
    "tasks": "/v1/children/usr_child_123/tasks"
  }
}
```

---

#### PATCH /users/me/children/{child_id}

Atualizar configuracoes do filho.

**Request:**
```json
{
  "bucket_allocation": {
    "spend": 40,
    "save": 40,
    "give": 10,
    "invest": 10
  },
  "controls": {
    "daily_spend_limit": 30.00,
    "blocked_categories": ["gambling", "adult", "games"]
  }
}
```

**Response: 200 OK**
```json
{
  "data": {
    "child_id": "usr_child_123",
    "updated_at": "2026-01-29T11:30:00Z",
    "changes": {
      "bucket_allocation": {
        "spend": { "old": 50, "new": 40 },
        "save": { "old": 30, "new": 40 }
      },
      "controls": {
        "daily_spend_limit": { "old": 50.00, "new": 30.00 }
      }
    }
  },
  "meta": {
    "notification_sent_to_child": true
  }
}
```

---

#### PATCH /users/me/children/{child_id}/pin/reset

Resetar PIN do filho (apenas pai).

**Request:**
```json
{
  "new_pin": "654321",
  "parent_password": "SenhaSegura123!"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "message": "PIN resetado com sucesso",
    "child_id": "usr_child_123"
  },
  "meta": {
    "child_sessions_revoked": true
  }
}
```

---

## 4. Contas e Baldes

### 4.1 Endpoints de Conta

---

#### GET /accounts

Listar contas do usuario (pai + filhos).

**Response: 200 OK**
```json
{
  "data": {
    "parent_account": {
      "account_id": "acc_parent_123",
      "owner_name": "Joao Silva Santos",
      "type": "parent",
      "balance": 1500.00,
      "available_balance": 1500.00,
      "status": "active",
      "pix_keys": [
        { "type": "cpf", "key_masked": "***.***. 789-01" },
        { "type": "email", "key_masked": "p***@email.com" }
      ]
    },
    "children_accounts": [
      {
        "account_id": "acc_child_abc",
        "owner_name": "Pedro Silva Santos",
        "child_id": "usr_child_123",
        "type": "child",
        "total_balance": 245.50,
        "status": "active",
        "buckets": {
          "spend": { "balance": 120.00, "percent": 50 },
          "save": { "balance": 85.50, "percent": 30 },
          "give": { "balance": 20.00, "percent": 10 },
          "invest": { "balance": 20.00, "percent": 10 }
        }
      }
    ]
  },
  "meta": {
    "family_total_balance": 1745.50
  }
}
```

---

#### GET /accounts/{account_id}

Obter detalhes de uma conta.

**Response: 200 OK**
```json
{
  "data": {
    "account_id": "acc_child_abc",
    "owner": {
      "user_id": "usr_child_123",
      "name": "Pedro Silva Santos",
      "type": "child"
    },
    "type": "child",
    "status": "active",
    "created_at": "2026-01-01T10:00:00Z",
    "total_balance": 245.50,
    "buckets": {
      "spend": {
        "bucket_id": "bucket_spend_123",
        "name": "Gastar",
        "icon": "credit-card",
        "color": "#4CAF50",
        "allocation_percent": 50,
        "balance": 120.00,
        "available_balance": 120.00,
        "pending_amount": 0,
        "description": "Saldo disponivel para gastos com cartao"
      },
      "save": {
        "bucket_id": "bucket_save_123",
        "name": "Guardar",
        "icon": "piggy-bank",
        "color": "#2196F3",
        "allocation_percent": 30,
        "balance": 85.50,
        "goals": [
          {
            "goal_id": "goal_ps5_123",
            "name": "PlayStation 5",
            "target_amount": 500.00,
            "current_amount": 85.50,
            "progress_percent": 17.1
          }
        ],
        "parent_interest": {
          "enabled": true,
          "rate_percent": 5.0,
          "frequency": "monthly"
        }
      },
      "give": {
        "bucket_id": "bucket_give_123",
        "name": "Doar",
        "icon": "heart",
        "color": "#E91E63",
        "allocation_percent": 10,
        "balance": 20.00,
        "total_donated": 50.00,
        "donations_count": 3
      },
      "invest": {
        "bucket_id": "bucket_invest_123",
        "name": "Investir",
        "icon": "trending-up",
        "color": "#9C27B0",
        "allocation_percent": 10,
        "balance": 20.00,
        "investments": [],
        "description": "Investimentos com aprovacao dos pais"
      }
    },
    "pix_key": {
      "type": "evp",
      "key": "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
    }
  },
  "links": {
    "self": "/v1/accounts/acc_child_abc",
    "transactions": "/v1/accounts/acc_child_abc/transactions",
    "statement": "/v1/accounts/acc_child_abc/statement"
  }
}
```

---

#### GET /accounts/{account_id}/buckets/{bucket_type}

Obter detalhes de um balde especifico.

**Path Parameters:**
- `bucket_type`: `spend` | `save` | `give` | `invest`

**Response: 200 OK**
```json
{
  "data": {
    "bucket_id": "bucket_save_123",
    "account_id": "acc_child_abc",
    "type": "save",
    "name": "Guardar",
    "balance": 85.50,
    "allocation_percent": 30,
    "statistics": {
      "total_deposited": 200.00,
      "total_withdrawn": 114.50,
      "interest_earned": 0,
      "avg_monthly_deposit": 50.00
    },
    "goals": [
      {
        "goal_id": "goal_ps5_123",
        "name": "PlayStation 5",
        "target_amount": 500.00,
        "current_amount": 85.50,
        "progress_percent": 17.1,
        "image_url": "https://cdn.example.com/goals/ps5.jpg",
        "target_date": "2026-12-25",
        "days_remaining": 330,
        "suggested_weekly_deposit": 12.56
      }
    ],
    "recent_transactions": [
      {
        "transaction_id": "txn_abc123",
        "type": "deposit",
        "amount": 30.00,
        "description": "Mesada semanal",
        "created_at": "2026-01-27T08:00:00Z"
      }
    ]
  },
  "links": {
    "self": "/v1/accounts/acc_child_abc/buckets/save",
    "transactions": "/v1/accounts/acc_child_abc/buckets/save/transactions",
    "goals": "/v1/children/usr_child_123/goals"
  }
}
```

---

#### POST /accounts/{account_id}/buckets/transfer

Transferir entre baldes (com aprovacao parental se necessario).

**Request:**
```json
{
  "from_bucket": "spend",
  "to_bucket": "save",
  "amount": 20.00,
  "note": "Guardando para o PS5"
}
```

**Response: 200 OK (se filho tem permissao)**
```json
{
  "data": {
    "transfer_id": "transfer_xyz123",
    "status": "completed",
    "from_bucket": {
      "type": "spend",
      "old_balance": 120.00,
      "new_balance": 100.00
    },
    "to_bucket": {
      "type": "save",
      "old_balance": 85.50,
      "new_balance": 105.50
    },
    "amount": 20.00,
    "note": "Guardando para o PS5",
    "created_at": "2026-01-29T12:00:00Z"
  }
}
```

**Response: 202 Accepted (se requer aprovacao)**
```json
{
  "data": {
    "transfer_id": "transfer_xyz123",
    "status": "pending_approval",
    "amount": 20.00,
    "note": "Guardando para o PS5",
    "approval_required_from": "parent",
    "expires_at": "2026-01-30T12:00:00Z"
  },
  "meta": {
    "parent_notified": true
  }
}
```

---

#### GET /accounts/{account_id}/transactions

Listar transacoes da conta.

**Query Parameters:**
- `bucket`: Filtrar por balde (`spend`, `save`, `give`, `invest`)
- `type`: Filtrar por tipo (`deposit`, `withdrawal`, `transfer`, `purchase`, `pix`)
- `start_date`: Data inicio (ISO 8601)
- `end_date`: Data fim (ISO 8601)
- `cursor`: Cursor para paginacao
- `limit`: Quantidade por pagina (max 100)

**Response: 200 OK**
```json
{
  "data": [
    {
      "transaction_id": "txn_abc123",
      "type": "purchase",
      "status": "completed",
      "bucket": "spend",
      "amount": -25.90,
      "description": "Livraria Cultura",
      "merchant": {
        "name": "Livraria Cultura",
        "category": "books",
        "category_icon": "book"
      },
      "card": {
        "last_four": "4532",
        "type": "virtual"
      },
      "location": {
        "city": "Sao Paulo",
        "state": "SP"
      },
      "created_at": "2026-01-29T14:30:00Z",
      "settled_at": "2026-01-29T14:30:05Z"
    },
    {
      "transaction_id": "txn_def456",
      "type": "deposit",
      "status": "completed",
      "bucket": "all",
      "amount": 100.00,
      "description": "Mesada semanal",
      "distribution": {
        "spend": 50.00,
        "save": 30.00,
        "give": 10.00,
        "invest": 10.00
      },
      "source": {
        "type": "allowance",
        "from_user": "Joao (Pai)"
      },
      "created_at": "2026-01-27T08:00:00Z"
    },
    {
      "transaction_id": "txn_ghi789",
      "type": "pix",
      "status": "completed",
      "bucket": "spend",
      "amount": -15.00,
      "description": "PIX para Maria",
      "pix_details": {
        "recipient": {
          "name": "Maria S***",
          "key_type": "cpf",
          "key_masked": "***.***. 456-78"
        },
        "end_to_end_id": "E12345678202601291430abc123"
      },
      "created_at": "2026-01-28T16:45:00Z"
    }
  ],
  "meta": {
    "total_count": 45,
    "page_size": 20,
    "has_more": true,
    "summary": {
      "total_income": 200.00,
      "total_expense": -156.90,
      "net": 43.10
    }
  },
  "links": {
    "self": "/v1/accounts/acc_child_abc/transactions?cursor=abc",
    "next": "/v1/accounts/acc_child_abc/transactions?cursor=def"
  }
}
```

---

#### GET /accounts/{account_id}/statement

Obter extrato mensal formatado.

**Query Parameters:**
- `month`: Mes (YYYY-MM)
- `format`: `json` | `pdf`

**Response: 200 OK**
```json
{
  "data": {
    "account_id": "acc_child_abc",
    "owner_name": "Pedro Silva Santos",
    "period": {
      "month": "2026-01",
      "start_date": "2026-01-01",
      "end_date": "2026-01-31"
    },
    "opening_balance": 150.00,
    "closing_balance": 245.50,
    "summary": {
      "total_income": 400.00,
      "total_expense": -304.50,
      "net_change": 95.50
    },
    "by_bucket": {
      "spend": {
        "opening": 75.00,
        "closing": 120.00,
        "income": 200.00,
        "expense": -155.00
      },
      "save": {
        "opening": 55.00,
        "closing": 85.50,
        "income": 120.00,
        "expense": -89.50
      },
      "give": {
        "opening": 10.00,
        "closing": 20.00,
        "income": 40.00,
        "expense": -30.00
      },
      "invest": {
        "opening": 10.00,
        "closing": 20.00,
        "income": 40.00,
        "expense": -30.00
      }
    },
    "by_category": {
      "food": { "amount": -85.00, "percent": 28 },
      "entertainment": { "amount": -65.50, "percent": 22 },
      "books": { "amount": -45.00, "percent": 15 },
      "other": { "amount": -109.00, "percent": 35 }
    },
    "transactions_count": 45
  },
  "links": {
    "pdf": "/v1/accounts/acc_child_abc/statement?month=2026-01&format=pdf",
    "transactions": "/v1/accounts/acc_child_abc/transactions?start_date=2026-01-01&end_date=2026-01-31"
  }
}
```

---

## 5. Cartoes

### 5.1 Endpoints de Cartao

---

#### GET /cards

Listar cartoes do usuario e filhos.

**Response: 200 OK**
```json
{
  "data": [
    {
      "card_id": "card_parent_123",
      "owner": {
        "user_id": "usr_abc123def456",
        "name": "Joao Silva Santos",
        "type": "parent"
      },
      "type": "physical",
      "brand": "mastercard",
      "last_four": "7890",
      "status": "active",
      "expiry_month": 12,
      "expiry_year": 2028
    },
    {
      "card_id": "card_xyz789",
      "owner": {
        "user_id": "usr_child_123",
        "name": "Pedro Silva Santos",
        "type": "child"
      },
      "type": "virtual",
      "brand": "mastercard",
      "last_four": "4532",
      "status": "active",
      "expiry_month": 6,
      "expiry_year": 2027,
      "spending_source": "spend_bucket"
    }
  ]
}
```

---

#### GET /cards/{card_id}

Obter detalhes do cartao.

**Response: 200 OK**
```json
{
  "data": {
    "card_id": "card_xyz789",
    "owner": {
      "user_id": "usr_child_123",
      "name": "Pedro Silva Santos"
    },
    "type": "virtual",
    "brand": "mastercard",
    "last_four": "4532",
    "status": "active",
    "expiry_month": 6,
    "expiry_year": 2027,
    "created_at": "2026-01-01T10:00:00Z",
    "spending_source": {
      "bucket": "spend",
      "available_balance": 120.00
    },
    "controls": {
      "daily_limit": 50.00,
      "transaction_limit": 30.00,
      "monthly_limit": 500.00,
      "blocked_categories": ["gambling", "adult"],
      "allowed_merchants": [],
      "spending_hours": {
        "enabled": true,
        "start": "08:00",
        "end": "22:00",
        "timezone": "America/Sao_Paulo"
      },
      "online_purchases": true,
      "international": false,
      "contactless": true,
      "atm_withdrawal": false
    },
    "statistics": {
      "this_month": {
        "transactions_count": 12,
        "total_spent": 185.50,
        "remaining_daily": 24.10,
        "remaining_monthly": 314.50
      }
    }
  },
  "links": {
    "self": "/v1/cards/card_xyz789",
    "transactions": "/v1/cards/card_xyz789/transactions",
    "sensitive": "/v1/cards/card_xyz789/sensitive"
  }
}
```

---

#### GET /cards/{card_id}/sensitive

Obter dados sensiveis do cartao (requer step-up auth).

**Headers adicionais:**
```http
X-Step-Up-Token: <step_up_token>
```

**Response: 200 OK**
```json
{
  "data": {
    "card_id": "card_xyz789",
    "pan": "5432 1234 5678 4532",
    "cvv": "123",
    "expiry": "06/27",
    "cardholder_name": "PEDRO S SANTOS"
  },
  "meta": {
    "expires_in_seconds": 60,
    "warning": "Estes dados serao ocultados apos 60 segundos"
  }
}
```

---

#### POST /cards

Solicitar novo cartao.

**Request:**
```json
{
  "owner_id": "usr_child_123",
  "type": "physical",
  "design": "space_explorer",
  "delivery_address": {
    "street": "Rua das Flores",
    "number": "123",
    "complement": "Apto 45",
    "neighborhood": "Jardim Paulista",
    "city": "Sao Paulo",
    "state": "SP",
    "zip_code": "01310100"
  },
  "name_on_card": "PEDRO SANTOS"
}
```

**Response: 201 Created**
```json
{
  "data": {
    "card_id": "card_new_456",
    "owner_id": "usr_child_123",
    "type": "physical",
    "status": "ordered",
    "design": "space_explorer",
    "estimated_delivery": "2026-02-10",
    "tracking_code": null,
    "created_at": "2026-01-29T15:00:00Z"
  },
  "meta": {
    "fee_charged": 0,
    "message": "Cartao solicitado! Voce recebera o codigo de rastreio em breve."
  }
}
```

---

#### PATCH /cards/{card_id}

Atualizar configuracoes do cartao.

**Request:**
```json
{
  "controls": {
    "daily_limit": 40.00,
    "blocked_categories": ["gambling", "adult", "games"],
    "online_purchases": false
  }
}
```

**Response: 200 OK**
```json
{
  "data": {
    "card_id": "card_xyz789",
    "controls": {
      "daily_limit": 40.00,
      "blocked_categories": ["gambling", "adult", "games"],
      "online_purchases": false
    },
    "updated_at": "2026-01-29T15:30:00Z"
  }
}
```

---

#### POST /cards/{card_id}/block

Bloquear cartao.

**Request:**
```json
{
  "reason": "lost",
  "request_replacement": true
}
```

**Response: 200 OK**
```json
{
  "data": {
    "card_id": "card_xyz789",
    "status": "blocked",
    "blocked_reason": "lost",
    "blocked_at": "2026-01-29T16:00:00Z",
    "replacement": {
      "card_id": "card_replacement_789",
      "status": "ordered",
      "estimated_delivery": "2026-02-10"
    }
  }
}
```

---

#### POST /cards/{card_id}/unblock

Desbloquear cartao.

**Request:**
```json
{
  "parent_password": "SenhaSegura123!"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "card_id": "card_xyz789",
    "status": "active",
    "unblocked_at": "2026-01-29T16:30:00Z"
  }
}
```

---

#### POST /cards/{card_id}/activate

Ativar cartao fisico recebido.

**Request:**
```json
{
  "last_four_digits": "4532",
  "cvv": "123"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "card_id": "card_new_456",
    "status": "active",
    "activated_at": "2026-01-29T17:00:00Z"
  },
  "meta": {
    "message": "Cartao ativado com sucesso! Ja pode ser utilizado."
  }
}
```

---

## 6. Transacoes

### 6.1 PIX

---

#### GET /pix/keys

Listar chaves PIX do usuario.

**Response: 200 OK**
```json
{
  "data": [
    {
      "key_id": "pix_key_123",
      "account_id": "acc_parent_123",
      "type": "cpf",
      "key_masked": "***.***. 789-01",
      "status": "active",
      "created_at": "2026-01-01T10:00:00Z"
    },
    {
      "key_id": "pix_key_456",
      "account_id": "acc_parent_123",
      "type": "email",
      "key_masked": "p***@email.com",
      "status": "active",
      "created_at": "2026-01-01T10:00:00Z"
    },
    {
      "key_id": "pix_key_child_789",
      "account_id": "acc_child_abc",
      "owner_name": "Pedro Silva Santos",
      "type": "evp",
      "key": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "status": "active",
      "created_at": "2026-01-01T10:00:00Z"
    }
  ]
}
```

---

#### POST /pix/keys

Criar nova chave PIX.

**Request:**
```json
{
  "account_id": "acc_parent_123",
  "type": "phone",
  "key": "+5511999998888"
}
```

**Response: 201 Created**
```json
{
  "data": {
    "key_id": "pix_key_new_123",
    "account_id": "acc_parent_123",
    "type": "phone",
    "key_masked": "+55 11 *****-8888",
    "status": "pending_verification",
    "verification_expires_at": "2026-01-29T18:00:00Z"
  }
}
```

---

#### POST /pix/transfer

Enviar PIX.

**Request:**
```json
{
  "source_account_id": "acc_child_abc",
  "amount": 25.00,
  "recipient": {
    "key_type": "cpf",
    "key": "98765432100"
  },
  "description": "Presente de aniversario",
  "idempotency_key": "uuid-idempotency-123"
}
```

**Response: 202 Accepted (se requer aprovacao parental)**
```json
{
  "data": {
    "pix_id": "pix_txn_abc123",
    "status": "pending_approval",
    "amount": 25.00,
    "recipient": {
      "name": "Maria da Silva",
      "key_type": "cpf",
      "key_masked": "***.***. 432-10",
      "institution": "Nubank"
    },
    "description": "Presente de aniversario",
    "approval_required": true,
    "approval_reason": "new_recipient",
    "expires_at": "2026-01-30T17:00:00Z"
  },
  "meta": {
    "parent_notified": true,
    "message": "PIX aguardando aprovacao do responsavel"
  }
}
```

**Response: 200 OK (se aprovado automaticamente)**
```json
{
  "data": {
    "pix_id": "pix_txn_abc123",
    "status": "completed",
    "amount": 25.00,
    "recipient": {
      "name": "Maria da Silva",
      "key_type": "cpf",
      "key_masked": "***.***. 432-10",
      "institution": "Nubank"
    },
    "description": "Presente de aniversario",
    "end_to_end_id": "E12345678202601291700abc123",
    "completed_at": "2026-01-29T17:00:05Z"
  }
}
```

---

#### POST /pix/transfer/{pix_id}/approve

Aprovar PIX pendente (apenas pai).

**Request:**
```json
{
  "approved": true,
  "parent_pin": "123456"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "pix_id": "pix_txn_abc123",
    "status": "completed",
    "amount": 25.00,
    "approved_by": "usr_abc123def456",
    "approved_at": "2026-01-29T17:30:00Z",
    "end_to_end_id": "E12345678202601291730abc123"
  }
}
```

---

#### GET /pix/contacts

Listar contatos PIX frequentes/aprovados.

**Response: 200 OK**
```json
{
  "data": [
    {
      "contact_id": "contact_123",
      "name": "Maria da Silva",
      "nickname": "Maria (Avo)",
      "key_type": "cpf",
      "key_masked": "***.***. 432-10",
      "institution": "Nubank",
      "approved_for_children": true,
      "last_transfer": "2026-01-15T10:00:00Z",
      "total_transfers": 5
    },
    {
      "contact_id": "contact_456",
      "name": "Joao Pedro Santos",
      "nickname": "Joao (Tio)",
      "key_type": "phone",
      "key_masked": "+55 11 *****-1234",
      "institution": "Inter",
      "approved_for_children": true,
      "last_transfer": "2026-01-20T14:00:00Z",
      "total_transfers": 3
    }
  ]
}
```

---

#### POST /pix/contacts

Adicionar contato PIX.

**Request:**
```json
{
  "name": "Carlos Oliveira",
  "nickname": "Carlos (Primo)",
  "key_type": "email",
  "key": "carlos@email.com",
  "approved_for_children": false
}
```

**Response: 201 Created**
```json
{
  "data": {
    "contact_id": "contact_new_789",
    "name": "Carlos Oliveira",
    "nickname": "Carlos (Primo)",
    "key_type": "email",
    "key_masked": "c***@email.com",
    "institution": "Itau",
    "approved_for_children": false,
    "created_at": "2026-01-29T18:00:00Z"
  }
}
```

---

### 6.2 Transferencias Internas

---

#### POST /transfers/internal

Transferir entre contas da familia.

**Request:**
```json
{
  "from_account_id": "acc_parent_123",
  "to_account_id": "acc_child_abc",
  "amount": 50.00,
  "description": "Bonus por boas notas",
  "distribute_to_buckets": true
}
```

**Response: 200 OK**
```json
{
  "data": {
    "transfer_id": "transfer_int_123",
    "status": "completed",
    "amount": 50.00,
    "from_account": {
      "account_id": "acc_parent_123",
      "owner_name": "Joao Silva Santos",
      "new_balance": 1450.00
    },
    "to_account": {
      "account_id": "acc_child_abc",
      "owner_name": "Pedro Silva Santos",
      "distribution": {
        "spend": 25.00,
        "save": 15.00,
        "give": 5.00,
        "invest": 5.00
      },
      "new_total_balance": 295.50
    },
    "description": "Bonus por boas notas",
    "completed_at": "2026-01-29T18:30:00Z"
  }
}
```

---

## 7. Mesada

### 7.1 Endpoints de Mesada

---

#### GET /allowances

Listar configuracoes de mesada.

**Response: 200 OK**
```json
{
  "data": [
    {
      "allowance_id": "allowance_123",
      "child": {
        "child_id": "usr_child_123",
        "name": "Pedro Silva Santos"
      },
      "amount": 100.00,
      "frequency": "weekly",
      "day_of_week": 0,
      "time": "08:00",
      "status": "active",
      "next_payment": "2026-02-03T08:00:00Z",
      "bucket_distribution": {
        "spend": 50,
        "save": 30,
        "give": 10,
        "invest": 10
      },
      "source_account": "acc_parent_123",
      "created_at": "2026-01-01T10:00:00Z"
    },
    {
      "allowance_id": "allowance_456",
      "child": {
        "child_id": "usr_child_456",
        "name": "Maria Silva Santos"
      },
      "amount": 50.00,
      "frequency": "monthly",
      "day_of_month": 1,
      "time": "08:00",
      "status": "active",
      "next_payment": "2026-02-01T08:00:00Z",
      "bucket_distribution": {
        "spend": 60,
        "save": 25,
        "give": 10,
        "invest": 5
      },
      "source_account": "acc_parent_123",
      "created_at": "2026-01-01T10:00:00Z"
    }
  ]
}
```

---

#### POST /allowances

Configurar nova mesada.

**Request:**
```json
{
  "child_id": "usr_child_123",
  "amount": 100.00,
  "frequency": "weekly",
  "day_of_week": 0,
  "time": "08:00",
  "timezone": "America/Sao_Paulo",
  "bucket_distribution": {
    "spend": 50,
    "save": 30,
    "give": 10,
    "invest": 10
  },
  "source_account_id": "acc_parent_123",
  "start_date": "2026-02-01"
}
```

**Response: 201 Created**
```json
{
  "data": {
    "allowance_id": "allowance_new_789",
    "child_id": "usr_child_123",
    "amount": 100.00,
    "frequency": "weekly",
    "day_of_week": 0,
    "day_name": "Domingo",
    "time": "08:00",
    "status": "active",
    "first_payment": "2026-02-02T08:00:00Z",
    "bucket_distribution": {
      "spend": { "percent": 50, "amount": 50.00 },
      "save": { "percent": 30, "amount": 30.00 },
      "give": { "percent": 10, "amount": 10.00 },
      "invest": { "percent": 10, "amount": 10.00 }
    },
    "created_at": "2026-01-29T19:00:00Z"
  }
}
```

---

#### PATCH /allowances/{allowance_id}

Atualizar mesada.

**Request:**
```json
{
  "amount": 120.00,
  "bucket_distribution": {
    "spend": 40,
    "save": 40,
    "give": 10,
    "invest": 10
  }
}
```

**Response: 200 OK**
```json
{
  "data": {
    "allowance_id": "allowance_123",
    "amount": 120.00,
    "bucket_distribution": {
      "spend": 40,
      "save": 40,
      "give": 10,
      "invest": 10
    },
    "updated_at": "2026-01-29T19:30:00Z",
    "effective_from": "2026-02-03T08:00:00Z"
  }
}
```

---

#### POST /allowances/{allowance_id}/pause

Pausar mesada.

**Request:**
```json
{
  "reason": "ferias",
  "resume_date": "2026-02-15"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "allowance_id": "allowance_123",
    "status": "paused",
    "paused_reason": "ferias",
    "paused_at": "2026-01-29T19:45:00Z",
    "scheduled_resume": "2026-02-15T08:00:00Z"
  }
}
```

---

#### POST /allowances/{allowance_id}/execute

Executar mesada manualmente (fora do agendamento).

**Request:**
```json
{
  "note": "Mesada antecipada - viagem"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "execution_id": "exec_123",
    "allowance_id": "allowance_123",
    "amount": 100.00,
    "status": "completed",
    "distribution": {
      "spend": 50.00,
      "save": 30.00,
      "give": 10.00,
      "invest": 10.00
    },
    "note": "Mesada antecipada - viagem",
    "executed_at": "2026-01-29T20:00:00Z"
  },
  "meta": {
    "child_notified": true,
    "next_scheduled_skipped": true,
    "next_payment": "2026-02-10T08:00:00Z"
  }
}
```

---

#### GET /allowances/{allowance_id}/history

Historico de pagamentos de mesada.

**Response: 200 OK**
```json
{
  "data": [
    {
      "execution_id": "exec_123",
      "amount": 100.00,
      "status": "completed",
      "type": "manual",
      "distribution": {
        "spend": 50.00,
        "save": 30.00,
        "give": 10.00,
        "invest": 10.00
      },
      "executed_at": "2026-01-29T20:00:00Z"
    },
    {
      "execution_id": "exec_120",
      "amount": 100.00,
      "status": "completed",
      "type": "scheduled",
      "distribution": {
        "spend": 50.00,
        "save": 30.00,
        "give": 10.00,
        "invest": 10.00
      },
      "executed_at": "2026-01-27T08:00:00Z"
    },
    {
      "execution_id": "exec_115",
      "amount": 100.00,
      "status": "failed",
      "type": "scheduled",
      "failure_reason": "insufficient_funds",
      "scheduled_at": "2026-01-20T08:00:00Z"
    }
  ],
  "meta": {
    "total_paid": 1200.00,
    "payments_count": 12,
    "missed_payments": 1
  }
}
```

---

## 8. Tarefas

### 8.1 Endpoints de Tarefas

---

#### GET /children/{child_id}/tasks

Listar tarefas do filho.

**Query Parameters:**
- `status`: `pending` | `completed` | `approved` | `rejected` | `expired`
- `created_by`: `parent` | `child`

**Response: 200 OK**
```json
{
  "data": [
    {
      "task_id": "task_123",
      "title": "Arrumar o quarto",
      "description": "Arrumar a cama, organizar brinquedos e roupas",
      "reward_amount": 10.00,
      "reward_bucket": "spend",
      "status": "pending",
      "due_date": "2026-01-30T18:00:00Z",
      "recurring": {
        "enabled": true,
        "frequency": "weekly",
        "days": [1, 3, 5]
      },
      "created_by": {
        "user_id": "usr_abc123def456",
        "name": "Joao (Pai)"
      },
      "created_at": "2026-01-29T10:00:00Z",
      "photo_proof_required": true
    },
    {
      "task_id": "task_456",
      "title": "Lavar a louca",
      "description": "Lavar toda a louca do almoco",
      "reward_amount": 5.00,
      "reward_bucket": "spend",
      "status": "completed",
      "completed_at": "2026-01-29T14:00:00Z",
      "proof": {
        "photo_url": "https://cdn.example.com/proofs/task_456.jpg",
        "note": "Terminei!"
      },
      "awaiting_approval": true,
      "created_by": {
        "user_id": "usr_abc123def456",
        "name": "Joao (Pai)"
      },
      "created_at": "2026-01-29T08:00:00Z"
    },
    {
      "task_id": "task_789",
      "title": "Tirar nota boa em matematica",
      "description": "Tirar nota acima de 8 na prova",
      "reward_amount": 50.00,
      "reward_bucket": "save",
      "status": "approved",
      "completed_at": "2026-01-25T16:00:00Z",
      "approved_at": "2026-01-25T20:00:00Z",
      "proof": {
        "photo_url": "https://cdn.example.com/proofs/task_789.jpg",
        "note": "Tirei 9.5!"
      },
      "payment": {
        "transaction_id": "txn_reward_789",
        "paid_at": "2026-01-25T20:00:05Z"
      },
      "created_by": {
        "user_id": "usr_abc123def456",
        "name": "Joao (Pai)"
      },
      "created_at": "2026-01-15T10:00:00Z"
    }
  ],
  "meta": {
    "pending_count": 3,
    "completed_count": 5,
    "total_earned_this_month": 75.00
  }
}
```

---

#### POST /children/{child_id}/tasks

Criar nova tarefa.

**Request:**
```json
{
  "title": "Passear com o cachorro",
  "description": "Passear com o Max por pelo menos 20 minutos",
  "reward_amount": 8.00,
  "reward_bucket": "spend",
  "due_date": "2026-01-30T18:00:00Z",
  "recurring": {
    "enabled": true,
    "frequency": "daily",
    "end_date": "2026-02-28"
  },
  "photo_proof_required": true,
  "auto_approve": false
}
```

**Response: 201 Created**
```json
{
  "data": {
    "task_id": "task_new_123",
    "title": "Passear com o cachorro",
    "description": "Passear com o Max por pelo menos 20 minutos",
    "reward_amount": 8.00,
    "reward_bucket": "spend",
    "status": "pending",
    "due_date": "2026-01-30T18:00:00Z",
    "recurring": {
      "enabled": true,
      "frequency": "daily",
      "end_date": "2026-02-28",
      "next_occurrence": "2026-01-31T18:00:00Z"
    },
    "photo_proof_required": true,
    "auto_approve": false,
    "created_at": "2026-01-29T21:00:00Z"
  },
  "meta": {
    "child_notified": true
  }
}
```

---

#### PATCH /children/{child_id}/tasks/{task_id}

Atualizar tarefa.

**Request:**
```json
{
  "reward_amount": 12.00,
  "due_date": "2026-01-31T18:00:00Z"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "task_id": "task_new_123",
    "reward_amount": 12.00,
    "due_date": "2026-01-31T18:00:00Z",
    "updated_at": "2026-01-29T21:30:00Z"
  }
}
```

---

#### POST /children/{child_id}/tasks/{task_id}/complete

Marcar tarefa como concluida (pelo filho).

**Request:**
```json
{
  "note": "Passeei por 25 minutos!",
  "proof_photo": "base64_encoded_image_data..."
}
```

**Response: 200 OK**
```json
{
  "data": {
    "task_id": "task_new_123",
    "status": "completed",
    "completed_at": "2026-01-30T17:30:00Z",
    "proof": {
      "photo_url": "https://cdn.example.com/proofs/task_new_123.jpg",
      "note": "Passeei por 25 minutos!"
    },
    "awaiting_approval": true
  },
  "meta": {
    "parent_notified": true,
    "message": "Otimo trabalho! Aguardando aprovacao do responsavel."
  }
}
```

---

#### POST /children/{child_id}/tasks/{task_id}/approve

Aprovar ou rejeitar tarefa (pelo pai).

**Request (aprovar):**
```json
{
  "approved": true,
  "bonus_amount": 2.00,
  "feedback": "Parabens! Muito bem feito!"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "task_id": "task_new_123",
    "status": "approved",
    "approved_at": "2026-01-30T20:00:00Z",
    "approved_by": {
      "user_id": "usr_abc123def456",
      "name": "Joao (Pai)"
    },
    "feedback": "Parabens! Muito bem feito!",
    "payment": {
      "transaction_id": "txn_reward_new_123",
      "amount": 14.00,
      "breakdown": {
        "base_reward": 12.00,
        "bonus": 2.00
      },
      "bucket": "spend",
      "paid_at": "2026-01-30T20:00:05Z"
    }
  },
  "meta": {
    "child_notified": true
  }
}
```

**Request (rejeitar):**
```json
{
  "approved": false,
  "feedback": "A tarefa nao foi completada corretamente. Tente novamente."
}
```

**Response: 200 OK**
```json
{
  "data": {
    "task_id": "task_new_123",
    "status": "rejected",
    "rejected_at": "2026-01-30T20:00:00Z",
    "rejected_by": {
      "user_id": "usr_abc123def456",
      "name": "Joao (Pai)"
    },
    "feedback": "A tarefa nao foi completada corretamente. Tente novamente.",
    "can_retry": true
  }
}
```

---

#### DELETE /children/{child_id}/tasks/{task_id}

Excluir tarefa.

**Response: 204 No Content**

---

## 9. Metas

### 9.1 Endpoints de Metas

---

#### GET /children/{child_id}/goals

Listar metas de poupanca do filho.

**Response: 200 OK**
```json
{
  "data": [
    {
      "goal_id": "goal_ps5_123",
      "name": "PlayStation 5",
      "description": "Economizar para comprar um PS5",
      "image_url": "https://cdn.example.com/goals/ps5.jpg",
      "target_amount": 500.00,
      "current_amount": 185.50,
      "progress_percent": 37.1,
      "status": "active",
      "target_date": "2026-12-25",
      "days_remaining": 330,
      "suggested_weekly_deposit": 9.53,
      "contributions": {
        "from_allowance": 120.00,
        "from_tasks": 45.50,
        "from_family": 20.00,
        "manual": 0
      },
      "contributors": [
        { "name": "Pedro", "amount": 165.50 },
        { "name": "Avo Maria", "amount": 20.00 }
      ],
      "created_at": "2026-01-01T10:00:00Z"
    },
    {
      "goal_id": "goal_bike_456",
      "name": "Bicicleta nova",
      "description": "Bike aro 24",
      "image_url": "https://cdn.example.com/goals/bike.jpg",
      "target_amount": 300.00,
      "current_amount": 300.00,
      "progress_percent": 100,
      "status": "completed",
      "completed_at": "2026-01-15T14:00:00Z",
      "created_at": "2025-10-01T10:00:00Z"
    }
  ],
  "meta": {
    "active_goals": 1,
    "completed_goals": 3,
    "total_saved_for_goals": 485.50
  }
}
```

---

#### POST /children/{child_id}/goals

Criar nova meta.

**Request:**
```json
{
  "name": "Nintendo Switch",
  "description": "Economizar para o Switch OLED",
  "image_url": "https://cdn.example.com/goals/switch.jpg",
  "target_amount": 2500.00,
  "target_date": "2026-12-25",
  "shareable": true
}
```

**Response: 201 Created**
```json
{
  "data": {
    "goal_id": "goal_switch_789",
    "name": "Nintendo Switch",
    "description": "Economizar para o Switch OLED",
    "image_url": "https://cdn.example.com/goals/switch.jpg",
    "target_amount": 2500.00,
    "current_amount": 0,
    "progress_percent": 0,
    "status": "active",
    "target_date": "2026-12-25",
    "days_remaining": 330,
    "suggested_weekly_deposit": 53.03,
    "shareable": true,
    "share_link": "https://app.greenlight.com.br/goals/goal_switch_789/contribute",
    "created_at": "2026-01-30T10:00:00Z"
  }
}
```

---

#### POST /children/{child_id}/goals/{goal_id}/deposit

Depositar na meta.

**Request:**
```json
{
  "amount": 30.00,
  "source": "spend_bucket",
  "note": "Economizando da mesada"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "deposit_id": "deposit_123",
    "goal_id": "goal_ps5_123",
    "amount": 30.00,
    "source": "spend_bucket",
    "note": "Economizando da mesada",
    "goal_progress": {
      "previous_amount": 185.50,
      "new_amount": 215.50,
      "progress_percent": 43.1,
      "remaining": 284.50
    },
    "deposited_at": "2026-01-30T11:00:00Z"
  },
  "meta": {
    "celebration": "Voce esta quase na metade! Continue assim!"
  }
}
```

---

#### POST /goals/{goal_id}/contribute

Contribuir para meta (familiar externo via link compartilhado).

**Request:**
```json
{
  "contributor_name": "Avo Maria",
  "amount": 50.00,
  "message": "Para ajudar na sua meta! Beijos da vovo.",
  "payment_method": "pix"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "contribution_id": "contrib_123",
    "goal_id": "goal_ps5_123",
    "goal_name": "PlayStation 5",
    "child_name": "Pedro",
    "amount": 50.00,
    "contributor_name": "Avo Maria",
    "message": "Para ajudar na sua meta! Beijos da vovo.",
    "status": "pending_payment",
    "pix_payment": {
      "qr_code": "00020126580014br.gov.bcb.pix...",
      "qr_code_image": "https://api.example.com/pix/qr/contrib_123.png",
      "copy_paste": "00020126580014br.gov.bcb.pix...",
      "expires_at": "2026-01-30T12:00:00Z"
    }
  }
}
```

---

#### POST /children/{child_id}/goals/{goal_id}/withdraw

Retirar da meta (com aprovacao parental).

**Request:**
```json
{
  "amount": 500.00,
  "reason": "Comprar o PS5!",
  "destination_bucket": "spend"
}
```

**Response: 202 Accepted**
```json
{
  "data": {
    "withdrawal_id": "withdraw_123",
    "goal_id": "goal_ps5_123",
    "amount": 500.00,
    "reason": "Comprar o PS5!",
    "status": "pending_approval",
    "expires_at": "2026-01-31T11:00:00Z"
  },
  "meta": {
    "parent_notified": true,
    "message": "Solicitacao de resgate enviada para aprovacao"
  }
}
```

---

#### PATCH /children/{child_id}/goals/{goal_id}

Atualizar meta.

**Request:**
```json
{
  "target_amount": 600.00,
  "target_date": "2027-01-15"
}
```

**Response: 200 OK**
```json
{
  "data": {
    "goal_id": "goal_ps5_123",
    "target_amount": 600.00,
    "target_date": "2027-01-15",
    "progress_percent": 35.9,
    "suggested_weekly_deposit": 7.98,
    "updated_at": "2026-01-30T12:00:00Z"
  }
}
```

---

#### DELETE /children/{child_id}/goals/{goal_id}

Excluir/cancelar meta.

**Query Parameters:**
- `refund_to`: `spend` | `save` (para onde vai o saldo acumulado)

**Response: 200 OK**
```json
{
  "data": {
    "goal_id": "goal_switch_789",
    "status": "cancelled",
    "refund": {
      "amount": 215.50,
      "destination_bucket": "save",
      "transaction_id": "txn_refund_123"
    },
    "cancelled_at": "2026-01-30T13:00:00Z"
  }
}
```

---

## 10. Webhooks

### 10.1 Configuracao de Webhooks

---

#### GET /webhooks

Listar webhooks configurados.

**Response: 200 OK**
```json
{
  "data": [
    {
      "webhook_id": "webhook_123",
      "url": "https://myapp.com/webhooks/greenlight",
      "events": ["transaction.created", "task.completed", "goal.reached"],
      "status": "active",
      "secret_masked": "whsec_***abc123",
      "created_at": "2026-01-01T10:00:00Z",
      "last_triggered": "2026-01-30T14:00:00Z",
      "success_rate": 99.5
    }
  ]
}
```

---

#### POST /webhooks

Criar webhook.

**Request:**
```json
{
  "url": "https://myapp.com/webhooks/greenlight",
  "events": [
    "transaction.created",
    "transaction.declined",
    "allowance.paid",
    "task.completed",
    "task.approved",
    "goal.reached",
    "card.blocked"
  ]
}
```

**Response: 201 Created**
```json
{
  "data": {
    "webhook_id": "webhook_new_456",
    "url": "https://myapp.com/webhooks/greenlight",
    "events": [
      "transaction.created",
      "transaction.declined",
      "allowance.paid",
      "task.completed",
      "task.approved",
      "goal.reached",
      "card.blocked"
    ],
    "secret": "whsec_abc123def456ghi789",
    "status": "active",
    "created_at": "2026-01-30T15:00:00Z"
  },
  "meta": {
    "warning": "Guarde o secret em local seguro. Ele nao sera exibido novamente."
  }
}
```

---

### 10.2 Eventos de Webhook

#### Estrutura Padrao do Payload

```json
{
  "id": "evt_abc123def456",
  "type": "transaction.created",
  "created_at": "2026-01-30T15:30:00Z",
  "data": { },
  "meta": {
    "webhook_id": "webhook_123",
    "attempt": 1
  }
}
```

---

#### Evento: transaction.created

```json
{
  "id": "evt_txn_123",
  "type": "transaction.created",
  "created_at": "2026-01-30T15:30:00Z",
  "data": {
    "transaction_id": "txn_abc123",
    "account_id": "acc_child_abc",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "type": "purchase",
    "amount": -25.90,
    "merchant": {
      "name": "Livraria Cultura",
      "category": "books"
    },
    "card_last_four": "4532",
    "bucket": "spend",
    "balance_after": 94.10
  }
}
```

---

#### Evento: transaction.declined

```json
{
  "id": "evt_txn_456",
  "type": "transaction.declined",
  "created_at": "2026-01-30T16:00:00Z",
  "data": {
    "transaction_id": "txn_declined_123",
    "account_id": "acc_child_abc",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "type": "purchase",
    "amount": 150.00,
    "merchant": {
      "name": "Game Store",
      "category": "games"
    },
    "decline_reason": "blocked_category",
    "decline_code": "CATEGORY_BLOCKED"
  }
}
```

---

#### Evento: allowance.paid

```json
{
  "id": "evt_allowance_123",
  "type": "allowance.paid",
  "created_at": "2026-02-03T08:00:00Z",
  "data": {
    "allowance_id": "allowance_123",
    "execution_id": "exec_456",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "amount": 100.00,
    "distribution": {
      "spend": 50.00,
      "save": 30.00,
      "give": 10.00,
      "invest": 10.00
    },
    "total_balance_after": 345.50
  }
}
```

---

#### Evento: task.completed

```json
{
  "id": "evt_task_123",
  "type": "task.completed",
  "created_at": "2026-01-30T17:00:00Z",
  "data": {
    "task_id": "task_123",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "title": "Arrumar o quarto",
    "reward_amount": 10.00,
    "proof_url": "https://cdn.example.com/proofs/task_123.jpg",
    "awaiting_approval": true
  }
}
```

---

#### Evento: task.approved

```json
{
  "id": "evt_task_456",
  "type": "task.approved",
  "created_at": "2026-01-30T18:00:00Z",
  "data": {
    "task_id": "task_123",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "title": "Arrumar o quarto",
    "reward_amount": 12.00,
    "bonus_amount": 2.00,
    "approved_by": "Joao (Pai)",
    "payment_transaction_id": "txn_reward_123"
  }
}
```

---

#### Evento: goal.reached

```json
{
  "id": "evt_goal_123",
  "type": "goal.reached",
  "created_at": "2026-01-30T19:00:00Z",
  "data": {
    "goal_id": "goal_ps5_123",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "name": "PlayStation 5",
    "target_amount": 500.00,
    "current_amount": 500.00,
    "days_to_complete": 45,
    "contributors_count": 3
  }
}
```

---

#### Evento: card.blocked

```json
{
  "id": "evt_card_123",
  "type": "card.blocked",
  "created_at": "2026-01-30T20:00:00Z",
  "data": {
    "card_id": "card_xyz789",
    "child_id": "usr_child_123",
    "child_name": "Pedro",
    "card_last_four": "4532",
    "blocked_reason": "parent_request",
    "blocked_by": "Joao (Pai)"
  }
}
```

---

### 10.3 Verificacao de Assinatura

Todos os webhooks sao assinados usando HMAC-SHA256.

**Headers enviados:**
```http
X-Webhook-Signature: sha256=abc123def456...
X-Webhook-Timestamp: 1706634600
X-Webhook-ID: evt_abc123
```

**Verificacao (exemplo Node.js):**
```javascript
const crypto = require('crypto');

function verifyWebhookSignature(payload, signature, secret, timestamp) {
  const signedPayload = `${timestamp}.${JSON.stringify(payload)}`;
  const expectedSignature = crypto
    .createHmac('sha256', secret)
    .update(signedPayload)
    .digest('hex');

  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(`sha256=${expectedSignature}`)
  );
}
```

---

## 11. Rate Limiting

### 11.1 Limites por Endpoint

| Categoria | Limite | Janela | Burst |
|-----------|--------|--------|-------|
| **Geral** | 100 req | 1 min | 20 |
| **Autenticacao** | 5 req | 1 min | 3 |
| **Login** | 5 req | 5 min | 2 |
| **Transacoes** | 10 req | 1 min | 5 |
| **PIX** | 10 req | 1 min | 3 |
| **Export** | 3 req | 1 dia | 1 |

### 11.2 Headers de Rate Limit

Todas as respostas incluem:

```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1706634660
X-RateLimit-Retry-After: 30
```

### 11.3 Resposta de Rate Limit Excedido

**Response: 429 Too Many Requests**
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Limite de requisicoes excedido. Tente novamente em 30 segundos.",
    "details": {
      "limit": 100,
      "window": "1 minute",
      "retry_after": 30
    }
  },
  "meta": {
    "request_id": "req_abc123"
  }
}
```

---

## 12. Erros

### 12.1 Formato Padrao de Erro

```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Mensagem legivel para o usuario",
    "details": { },
    "field": "campo_com_erro",
    "documentation_url": "https://docs.greenlight.com.br/errors/ERROR_CODE"
  },
  "meta": {
    "request_id": "req_abc123",
    "timestamp": "2026-01-30T10:00:00Z"
  }
}
```

### 12.2 Codigos de Status HTTP

| Status | Significado | Uso |
|--------|-------------|-----|
| 200 | OK | Sucesso |
| 201 | Created | Recurso criado |
| 202 | Accepted | Processamento assincrono |
| 204 | No Content | Sucesso sem corpo |
| 400 | Bad Request | Erro de validacao |
| 401 | Unauthorized | Token invalido/expirado |
| 403 | Forbidden | Sem permissao |
| 404 | Not Found | Recurso nao encontrado |
| 409 | Conflict | Conflito de estado |
| 422 | Unprocessable | Regra de negocio violada |
| 429 | Too Many Requests | Rate limit |
| 500 | Internal Error | Erro do servidor |
| 503 | Service Unavailable | Manutencao |

### 12.3 Catalogo de Erros

#### Erros de Autenticacao (AUTH_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `AUTH_INVALID_CREDENTIALS` | 401 | Email ou senha incorretos |
| `AUTH_TOKEN_EXPIRED` | 401 | Token de acesso expirado |
| `AUTH_TOKEN_INVALID` | 401 | Token de acesso invalido |
| `AUTH_MFA_REQUIRED` | 401 | Autenticacao de dois fatores necessaria |
| `AUTH_MFA_INVALID` | 401 | Codigo MFA invalido |
| `AUTH_DEVICE_NOT_TRUSTED` | 401 | Dispositivo nao reconhecido |
| `AUTH_ACCOUNT_LOCKED` | 403 | Conta temporariamente bloqueada |
| `AUTH_ACCOUNT_DISABLED` | 403 | Conta desativada |

#### Erros de Validacao (VALIDATION_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `VALIDATION_REQUIRED` | 400 | Campo obrigatorio nao informado |
| `VALIDATION_FORMAT` | 400 | Formato invalido |
| `VALIDATION_MIN_LENGTH` | 400 | Tamanho minimo nao atingido |
| `VALIDATION_MAX_LENGTH` | 400 | Tamanho maximo excedido |
| `VALIDATION_INVALID_CPF` | 400 | CPF invalido |
| `VALIDATION_INVALID_EMAIL` | 400 | Email invalido |
| `VALIDATION_INVALID_PHONE` | 400 | Telefone invalido |
| `VALIDATION_PASSWORD_WEAK` | 400 | Senha nao atende requisitos |

#### Erros de Transacao (TRANSACTION_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `TRANSACTION_INSUFFICIENT_FUNDS` | 422 | Saldo insuficiente |
| `TRANSACTION_LIMIT_EXCEEDED` | 422 | Limite de transacao excedido |
| `TRANSACTION_BLOCKED_CATEGORY` | 422 | Categoria bloqueada |
| `TRANSACTION_BLOCKED_MERCHANT` | 422 | Estabelecimento bloqueado |
| `TRANSACTION_OUTSIDE_HOURS` | 422 | Fora do horario permitido |
| `TRANSACTION_APPROVAL_REQUIRED` | 422 | Requer aprovacao parental |
| `TRANSACTION_DUPLICATE` | 409 | Transacao duplicada |
| `TRANSACTION_NOT_FOUND` | 404 | Transacao nao encontrada |

#### Erros de Cartao (CARD_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `CARD_NOT_FOUND` | 404 | Cartao nao encontrado |
| `CARD_BLOCKED` | 422 | Cartao bloqueado |
| `CARD_EXPIRED` | 422 | Cartao expirado |
| `CARD_ALREADY_ACTIVE` | 409 | Cartao ja esta ativo |
| `CARD_INVALID_PIN` | 401 | PIN incorreto |
| `CARD_ACTIVATION_FAILED` | 422 | Falha na ativacao |

#### Erros de PIX (PIX_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `PIX_KEY_NOT_FOUND` | 404 | Chave PIX nao encontrada |
| `PIX_KEY_ALREADY_EXISTS` | 409 | Chave PIX ja cadastrada |
| `PIX_RECIPIENT_NOT_FOUND` | 404 | Destinatario nao encontrado |
| `PIX_LIMIT_EXCEEDED` | 422 | Limite PIX excedido |
| `PIX_BLOCKED_RECIPIENT` | 422 | Destinatario bloqueado |
| `PIX_PROCESSING_ERROR` | 500 | Erro no processamento PIX |

#### Erros de Usuario (USER_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `USER_NOT_FOUND` | 404 | Usuario nao encontrado |
| `USER_ALREADY_EXISTS` | 409 | Usuario ja cadastrado |
| `USER_CPF_IN_USE` | 409 | CPF ja cadastrado |
| `USER_EMAIL_IN_USE` | 409 | Email ja cadastrado |
| `USER_CHILD_LIMIT_REACHED` | 422 | Limite de filhos atingido |
| `USER_KYC_PENDING` | 422 | Verificacao de identidade pendente |
| `USER_KYC_REJECTED` | 422 | Verificacao de identidade rejeitada |

#### Erros de Permissao (PERMISSION_*)

| Codigo | HTTP | Mensagem |
|--------|------|----------|
| `PERMISSION_DENIED` | 403 | Sem permissao para esta acao |
| `PERMISSION_PARENT_ONLY` | 403 | Acao permitida apenas para responsaveis |
| `PERMISSION_OWNER_ONLY` | 403 | Acao permitida apenas para o proprietario |
| `PERMISSION_CHILD_RESTRICTED` | 403 | Acao restrita para menores |

### 12.4 Exemplo de Erro de Validacao

**Response: 400 Bad Request**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Dados de entrada invalidos",
    "details": {
      "errors": [
        {
          "field": "email",
          "code": "VALIDATION_INVALID_EMAIL",
          "message": "Formato de email invalido"
        },
        {
          "field": "password",
          "code": "VALIDATION_PASSWORD_WEAK",
          "message": "Senha deve ter pelo menos 12 caracteres, incluindo maiuscula, minuscula, numero e caractere especial"
        },
        {
          "field": "cpf",
          "code": "VALIDATION_INVALID_CPF",
          "message": "CPF invalido"
        }
      ]
    }
  },
  "meta": {
    "request_id": "req_abc123"
  }
}
```

### 12.5 Exemplo de Erro de Negocio

**Response: 422 Unprocessable Entity**
```json
{
  "error": {
    "code": "TRANSACTION_INSUFFICIENT_FUNDS",
    "message": "Saldo insuficiente no balde 'Gastar'",
    "details": {
      "requested_amount": 50.00,
      "available_balance": 35.50,
      "bucket": "spend",
      "shortfall": 14.50
    },
    "suggestions": [
      "Transferir saldo de outro balde",
      "Solicitar mesada antecipada ao responsavel",
      "Aguardar proxima mesada"
    ]
  },
  "meta": {
    "request_id": "req_abc123"
  }
}
```

---

## Anexo A: Codigos de Categoria de Estabelecimento

| Codigo | Categoria | Bloqueavel |
|--------|-----------|------------|
| `food` | Alimentacao | Nao |
| `groceries` | Supermercado | Nao |
| `transport` | Transporte | Nao |
| `entertainment` | Entretenimento | Sim |
| `games` | Jogos | Sim |
| `books` | Livros | Nao |
| `clothing` | Vestuario | Sim |
| `electronics` | Eletronicos | Sim |
| `gambling` | Jogos de Azar | Sim (padrao) |
| `adult` | Adulto | Sim (padrao) |
| `alcohol` | Bebidas Alcoolicas | Sim (padrao) |
| `tobacco` | Tabaco | Sim (padrao) |
| `weapons` | Armas | Sim (padrao) |
| `other` | Outros | Nao |

---

## Anexo B: Frequencias de Mesada

| Valor | Descricao | Campos Necessarios |
|-------|-----------|-------------------|
| `daily` | Diariamente | `time` |
| `weekly` | Semanalmente | `day_of_week` (0-6), `time` |
| `biweekly` | Quinzenalmente | `days_of_month` ([1, 15]), `time` |
| `monthly` | Mensalmente | `day_of_month` (1-28), `time` |

---

## Anexo C: Status de Recursos

### Status de Usuario
- `pending_verification` - Aguardando verificacao
- `pending_kyc` - Aguardando KYC
- `active` - Ativo
- `suspended` - Suspenso
- `disabled` - Desativado

### Status de Cartao
- `ordered` - Solicitado
- `shipped` - Enviado
- `delivered` - Entregue
- `pending_activation` - Aguardando ativacao
- `active` - Ativo
- `blocked` - Bloqueado
- `expired` - Expirado
- `cancelled` - Cancelado

### Status de Tarefa
- `pending` - Pendente
- `completed` - Concluida (aguardando aprovacao)
- `approved` - Aprovada (paga)
- `rejected` - Rejeitada
- `expired` - Expirada

### Status de Meta
- `active` - Ativa
- `completed` - Concluida
- `cancelled` - Cancelada

### Status de Transacao
- `pending` - Pendente
- `pending_approval` - Aguardando aprovacao
- `processing` - Processando
- `completed` - Concluida
- `failed` - Falhou
- `cancelled` - Cancelada
- `refunded` - Estornada

---

**Fim do Documento**

*Ultima atualizacao: Janeiro 2026*
*Versao: 1.0.0*
