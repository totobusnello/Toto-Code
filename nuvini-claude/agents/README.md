# Agentes do Claude Code

Documentação em Português Brasileiro dos agentes disponíveis no Claude Code.

## O Que São Agentes?

Agentes são assistentes de IA especializados que podem ser invocados para executar tarefas complexas de forma autônoma. Cada agente tem um conjunto específico de ferramentas, conhecimento de domínio e comportamentos otimizados para seu propósito.

## Estrutura de Diretórios

```
agents/
├── README.md              # Este arquivo
├── development/           # Desenvolvimento de Software
│   ├── frontend-agent.md
│   ├── backend-agent.md
│   ├── database-agent.md
│   ├── devops-agent.md
│   └── documentation-agent.md
├── quality/               # Qualidade e Segurança
│   ├── codereview-agent.md
│   └── security-agent.md
├── testing/               # Testes e Validação
│   ├── fulltesting-agent.md
│   ├── page-tester.md
│   └── test-analyst.md
└── orchestration/         # Orquestração
    └── project-orchestrator.md
```

## Agentes por Categoria

### Development - Desenvolvimento de Software

| Agente                                                      | Descrição                                     | Ferramentas                         |
| ----------------------------------------------------------- | --------------------------------------------- | ----------------------------------- |
| [frontend-agent](./development/frontend-agent.md)           | React, Vue, Angular, Next.js, Svelte          | Bash, Read, Write, Edit, Glob, Grep |
| [backend-agent](./development/backend-agent.md)             | Node.js, Python, Go, serverless               | Bash, Read, Write, Edit, Glob, Grep |
| [database-agent](./development/database-agent.md)           | Schema design, migrations, query optimization | Bash, Read, Write, Edit, Glob, Grep |
| [devops-agent](./development/devops-agent.md)               | CI/CD, Docker, cloud deployments              | Bash, Read, Write, Edit, Glob, Grep |
| [documentation-agent](./development/documentation-agent.md) | README, API docs, documentação de arquitetura | Bash, Read, Write, Edit, Glob, Grep |

### Quality - Qualidade e Segurança

| Agente                                            | Descrição                                        | Ferramentas            |
| ------------------------------------------------- | ------------------------------------------------ | ---------------------- |
| [codereview-agent](./quality/codereview-agent.md) | Revisão de PRs, verificação de qualidade         | Read, Glob, Grep, Bash |
| [security-agent](./quality/security-agent.md)     | Varredura de vulnerabilidades, melhores práticas | Read, Glob, Grep, Bash |

### Testing - Testes e Validação

| Agente                                              | Descrição                                          | Ferramentas |
| --------------------------------------------------- | -------------------------------------------------- | ----------- |
| [fulltesting-agent](./testing/fulltesting-agent.md) | Orquestrador de testes E2E com Chrome DevTools MCP | \* (todas)  |
| [page-tester](./testing/page-tester.md)             | Subagente para teste de páginas individuais        | \* (todas)  |
| [test-analyst](./testing/test-analyst.md)           | Análise de falhas e correção de problemas          | \* (todas)  |

### Orchestration - Orquestração

| Agente                                                          | Descrição                                | Ferramentas |
| --------------------------------------------------------------- | ---------------------------------------- | ----------- |
| [project-orchestrator](./orchestration/project-orchestrator.md) | Coordenação completa de projeto e deploy | \* (todas)  |

## Hierarquia de Agentes

```
┌─────────────────────────────────────────────────────┐
│              PROJECT-ORCHESTRATOR                    │
│         (Coordenador Mestre de Projeto)             │
├─────────────────────────────────────────────────────┤
│                                                      │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │
│  │  DATABASE   │  │   BACKEND   │  │  FRONTEND   │ │
│  │    AGENT    │→ │    AGENT    │→ │    AGENT    │ │
│  └─────────────┘  └─────────────┘  └─────────────┘ │
│                                                      │
│  ┌─────────────────────────────────────────────────┐│
│  │           FULLTESTING-AGENT                     ││
│  │  ┌───────────┐ ┌───────────┐ ┌───────────┐     ││
│  │  │PAGE-TESTER│ │PAGE-TESTER│ │PAGE-TESTER│     ││
│  │  └───────────┘ └───────────┘ └───────────┘     ││
│  │         ↓            ↓            ↓             ││
│  │              TEST-ANALYST                       ││
│  └─────────────────────────────────────────────────┘│
│                                                      │
│  ┌──────────────┐  ┌──────────────┐                │
│  │   SECURITY   │  │    DEVOPS    │                │
│  │    AGENT     │  │    AGENT     │                │
│  └──────────────┘  └──────────────┘                │
│                                                      │
└─────────────────────────────────────────────────────┘
```

## Como Invocar Agentes

Agentes são invocados automaticamente pelo Claude Code usando a ferramenta `Task`:

```javascript
Task({
  subagent_type: "Frontend Agent",
  prompt: "Implementar componente de login com validação",
  description: "Criar componente login",
});
```

## Configuração de Agentes

Agentes são configurados via frontmatter YAML:

```yaml
---
name: Nome do Agente
model: sonnet
color: blue
tools:
  - Bash
  - Read
  - Write
  - Edit
---
```

### Parâmetros Comuns

| Parâmetro | Descrição                           |
| --------- | ----------------------------------- |
| `name`    | Nome de exibição do agente          |
| `model`   | Modelo a usar (sonnet, opus, haiku) |
| `color`   | Cor do agente no terminal           |
| `tools`   | Lista de ferramentas permitidas     |

## Fluxo de Trabalho Típico

1. **Análise** - Entender o codebase e requisitos
2. **Planejamento** - Criar estratégia de implementação
3. **Implementação** - Executar usando agentes especializados
4. **Testes** - Validar usando fulltesting-agent
5. **Correção** - Corrigir problemas com test-analyst
6. **Deploy** - Publicar usando devops-agent

## Melhores Práticas

- Use o **project-orchestrator** para tarefas complexas end-to-end
- Deixe agentes especializados lidarem com seus domínios
- Execute testes após cada fase de implementação
- Use **security-agent** para auditorias de segurança
- Documente com **documentation-agent** ao finalizar

---

Mantido por [Nuvini Group](https://github.com/Nuvinigroup)
