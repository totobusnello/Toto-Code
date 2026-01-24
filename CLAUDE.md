# Claude Code - Project Detection & Agent Guide

> Este arquivo ajuda Claude a identificar o tipo de projeto e sugerir os agents/skills apropriados.

## Como Funciona

### Skills (Automáticas)
Skills são ativadas **automaticamente** baseadas em:
- Palavras-chave no seu prompt (ex: "criar PRD" → skill `prd`)
- Contexto do arquivo sendo editado
- Campo `description` no SKILL.md de cada skill

### Agents (Manuais ou Sugeridos)
Agents precisam ser **chamados explicitamente** ou sugeridos por Claude:
```
Use o agent typescript-pro para revisar este código
```

---

## Project Detection Rules

Ao iniciar trabalho em um projeto, Claude deve verificar estes arquivos para identificar o stack:

### 1. Detect by Config Files

| Arquivo | Stack Detectado | Agents Recomendados |
|---------|-----------------|---------------------|
| `package.json` | Node.js/JavaScript | `javascript-pro`, `typescript-pro` |
| `tsconfig.json` | TypeScript | `typescript-pro` |
| `next.config.js` | Next.js | `nextjs-developer`, `react-specialist` |
| `vite.config.ts` | Vite + React/Vue | `react-specialist` ou `vue-expert` |
| `angular.json` | Angular | `angular-architect` |
| `nuxt.config.ts` | Nuxt.js | `vue-expert` |
| `requirements.txt` | Python | `python-pro` |
| `pyproject.toml` | Python (modern) | `python-pro` |
| `Cargo.toml` | Rust | `rust-engineer` |
| `go.mod` | Go | `golang-pro` |
| `pom.xml` | Java/Maven | `java-architect` |
| `build.gradle` | Java/Gradle | `java-architect`, `kotlin-specialist` |
| `Gemfile` | Ruby | `rails-expert` |
| `composer.json` | PHP | `php-pro`, `laravel-specialist` |
| `pubspec.yaml` | Flutter/Dart | `flutter-expert` |
| `Dockerfile` | Containers | `devops-engineer`, `kubernetes-specialist` |
| `terraform/` | IaC | `terraform-engineer`, `cloud-architect` |
| `kubernetes/` ou `k8s/` | K8s | `kubernetes-specialist` |
| `.github/workflows/` | CI/CD | `devops-engineer` |

### 2. Detect by Directory Structure

| Diretório | Tipo de Projeto | Agents Recomendados |
|-----------|-----------------|---------------------|
| `src/components/` | Frontend React/Vue | `frontend-developer`, `react-specialist` |
| `src/app/` (Next.js) | Next.js App Router | `nextjs-developer` |
| `pages/` | Next.js/Nuxt Pages | `nextjs-developer`, `vue-expert` |
| `api/` ou `routes/` | Backend API | `backend-developer`, `api-designer` |
| `prisma/` | Prisma ORM | `database-administrator`, `typescript-pro` |
| `migrations/` | Database migrations | `database-administrator` |
| `tests/` ou `__tests__/` | Testing | `qa-expert`, `test-automator` |
| `docs/` | Documentation | `documentation-engineer`, `technical-writer` |
| `infra/` | Infrastructure | `cloud-architect`, `terraform-engineer` |
| `ml/` ou `models/` | Machine Learning | `ml-engineer`, `data-scientist` |
| `notebooks/` | Data Science | `data-scientist`, `data-analyst` |

### 3. Detect by File Content

| Pattern no Código | Stack | Agents Recomendados |
|-------------------|-------|---------------------|
| `import React` | React | `react-specialist` |
| `from fastapi` | FastAPI | `fastapi-expert`, `python-pro` |
| `from django` | Django | `django-developer` |
| `@nestjs/` | NestJS | `nestjs-expert` |
| `import express` | Express.js | `backend-developer` |
| `import torch` | PyTorch | `ml-engineer` |
| `import tensorflow` | TensorFlow | `ml-engineer` |
| `import pandas` | Data Analysis | `data-analyst`, `python-pro` |
| `import boto3` | AWS | `cloud-architect` |
| `@azure/` | Azure | `azure-infra-engineer` |

---

## Suggested Agents by Task Type

### 🆕 Novo Projeto
```
Detectar stack → Sugerir:
- `workflow-orchestrator` para planejar
- `product-manager` para definir escopo
- Agent específico do stack (ex: nextjs-developer)
```

### 🐛 Debugging
```
- `debugger` - Análise geral
- `error-detective` - Investigação de erros
- `performance-engineer` - Problemas de performance
```

### 🔒 Segurança
```
- `security-auditor` - Auditoria geral
- `penetration-tester` - Testes de invasão
- `code-reviewer` - Revisão de código seguro
```

### 📊 Data/ML
```
- `data-engineer` - Pipelines de dados
- `ml-engineer` - Modelos ML
- `data-scientist` - Análise e insights
- `llm-architect` - Sistemas com LLMs
```

### 🏗️ Infraestrutura
```
- `cloud-architect` - Design de cloud
- `kubernetes-specialist` - Containers/K8s
- `terraform-engineer` - IaC
- `devops-engineer` - CI/CD
```

### 📝 Documentação
```
- `documentation-engineer` - Docs técnicos
- `technical-writer` - Documentação geral
- `api-documenter` - API docs
```

### 🔄 Refatoração
```
- `refactoring-specialist` - Refatoração geral
- `legacy-modernizer` - Código legado
- `architect-reviewer` - Revisão de arquitetura
```

---

## Quick Agent Invocation Examples

```markdown
# Chamar agent específico
"Use o agent rust-engineer para otimizar este código"

# Pedir sugestão
"Qual agent devo usar para este projeto React com TypeScript?"

# Multi-agent
"Use o workflow-orchestrator para coordenar a implementação desta feature"

# Revisão
"Peça ao code-reviewer para analisar este PR"
"Use o security-auditor para verificar vulnerabilidades"
```

---

## Skill Activation Keywords

Skills são ativadas automaticamente quando você menciona:

| Keyword/Frase | Skill Ativada |
|---------------|---------------|
| "criar PRD", "escrever requisitos" | `prd` |
| "navegar site", "testar UI" | `dev-browser` |
| "commit", "commitar" | `commit` |
| "desenvolvimento autônomo" | `autonomous-dev` |
| "criar MCP server" | `mcp-builder` |
| "extrair dados financeiros" | `financial-data-extractor` |
| "análise M&A" | `mna-toolkit` |
| "criar apresentação" | `ma-board-presentation` |
| "download video" | `video-downloader` |
| "organizar arquivos" | `file-organizer` |

---

## Project Startup Checklist

Quando iniciar um novo projeto, Claude deve:

1. **Detectar Stack**
   - Verificar arquivos de configuração
   - Identificar linguagens e frameworks

2. **Sugerir Agents**
   - Listar 2-3 agents mais relevantes
   - Explicar quando usar cada um

3. **Identificar Skills Úteis**
   - Listar skills que podem ajudar
   - Explicar ativação automática

4. **Setup Recomendado**
   - Verificar se precisa de `ralph` para loop autônomo
   - Sugerir `prd` se for feature complexa

---

## Installed Extensions Summary

- **273 Skills** em `~/.claude/skills/`
- **134 Agents** em `~/.claude/agents/`
- **INDEX.md** em `~/.claude/INDEX.md` com catálogo completo

---

*Para ver o catálogo completo: `cat ~/.claude/INDEX.md`*
