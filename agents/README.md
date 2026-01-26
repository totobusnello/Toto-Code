# Agents

> Agents customizados para tarefas especificas.

## Agents Disponiveis

### Code Quality

| Agent | Descricao | Uso |
|-------|-----------|-----|
| `code-reviewer` | Review de codigo | `/review` ou `/agent code-reviewer` |
| `code-simplifier` | Simplificar codigo | `/agent code-simplifier` |
| `comment-analyzer` | Analisar comentarios | Em PRs |

### Development

| Agent | Descricao | Uso |
|-------|-----------|-----|
| `code-architect` | Arquitetura de codigo | `/agent code-architect` |
| `code-explorer` | Explorar codebase | `/agent code-explorer` |

### PR Review

| Agent | Descricao | Uso |
|-------|-----------|-----|
| `pr-test-analyzer` | Analisar testes em PRs | Automatico |
| `type-design-analyzer` | Analisar tipos | Automatico |
| `silent-failure-hunter` | Encontrar falhas silenciosas | Automatico |

### Plugin Development

| Agent | Descricao | Uso |
|-------|-----------|-----|
| `agent-creator` | Criar novos agents | `/agent agent-creator` |
| `subagent-creator` | Criar sub-agents | `/agent subagent-creator` |
| `plugin-dev-agent` | Desenvolver plugins | `/agent plugin-dev-agent` |

## Como Criar Novo Agent

1. Crie um arquivo `.md` nesta pasta
2. Use o template:

```markdown
---
name: meu-agent
description: Descricao do agent
model: sonnet
color: blue
---

# System Prompt

Voce e um agent especializado em...

## Instrucoes

1. ...
2. ...

## Output Format

...
```

3. Registre no `index.json` na raiz do projeto
