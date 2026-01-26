# Claude Code Tools

> Ferramentas utilitarias para o repositorio de skills

## Skill Finder

Detecta o tipo de projeto e sugere skills/agents apropriados.

### Instalacao

```bash
# Nenhuma dependencia externa necessaria
# Requer Python 3.7+
python --version
```

### Uso

```bash
# Analisar diretorio atual
python skill-finder.py

# Analisar projeto especifico
python skill-finder.py /caminho/do/projeto

# Modo interativo
python skill-finder.py --interactive

# Listar todas as skills
python skill-finder.py --list-all

# Exportar em JSON
python skill-finder.py /projeto --json output.json

# Sem cores (para pipes)
python skill-finder.py --no-color
```

### O que Detecta

#### Arquivos de Configuracao
| Arquivo | Stack |
|---------|-------|
| `package.json` | Node.js/JavaScript |
| `tsconfig.json` | TypeScript |
| `next.config.js` | Next.js |
| `requirements.txt` | Python |
| `pyproject.toml` | Python (modern) |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `Dockerfile` | Docker |
| `main.tf` | Terraform |

#### Estrutura de Diretorios
| Diretorio | Tipo |
|-----------|------|
| `src/components/` | Frontend React/Vue |
| `src/app/` | Next.js App Router |
| `api/` | Backend API |
| `prisma/` | Prisma ORM |
| `tests/` | Testing |
| `.github/workflows/` | CI/CD |

#### Patterns no Codigo
| Pattern | Framework |
|---------|-----------|
| `import React` | React |
| `from fastapi` | FastAPI |
| `from django` | Django |
| `import torch` | PyTorch |
| `import pandas` | Pandas |

### Saida Exemplo

```
============================================================
  Analise do Projeto: meu-app
============================================================
  Caminho: /home/user/meu-app

>> Arquivos de Configuracao Detectados
----------------------------------------
  package.json - Node.js/JavaScript
  tsconfig.json - TypeScript
  next.config.js - Next.js

>> Estrutura de Diretorios
----------------------------------------
  src/components - Frontend React/Vue
  src/app - Next.js App Router
  prisma - Prisma ORM

>> Frameworks Detectados no Codigo
----------------------------------------
  React - encontrado em src/app/page.tsx
  Prisma - encontrado em src/lib/db.ts

>> Agents Recomendados
----------------------------------------
  nextjs-developer
  react-specialist
  typescript-pro
  database-administrator

>> Skills Sugeridas por Tarefa
----------------------------------------
  Development:
    - python-pro
    - typescript-pro
    - react-best-practices
  Testing:
    - tdd-guide
    - systematic-debugging
    - code-review

>> Comandos Rapidos
----------------------------------------
  Para usar um agent:
    "Use o agent nextjs-developer para revisar este codigo"

  Para planejar feature:
    "Use o workflow-orchestrator para planejar a implementacao"
```

### Exportacao JSON

```bash
python skill-finder.py . --json analysis.json
```

Formato do JSON:

```json
{
  "path": "/home/user/project",
  "name": "project",
  "config_files": [
    {
      "file": "package.json",
      "stack": "Node.js/JavaScript",
      "agents": ["javascript-pro", "typescript-pro"]
    }
  ],
  "directories": [...],
  "code_patterns": [...],
  "recommended_agents": ["agent1", "agent2"],
  "task_skills": {
    "development": ["python-pro", "typescript-pro"],
    "testing": ["tdd-guide", "code-review"]
  }
}
```

## Futuras Ferramentas

- [ ] `skill-validator.py` - Valida formato das skills
- [ ] `skill-generator.py` - Gera templates de skills
- [ ] `agent-tester.py` - Testa agents automaticamente
- [ ] `stats-collector.py` - Coleta estatisticas de uso
