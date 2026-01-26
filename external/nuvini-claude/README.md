# Nuvini Claude Skills & Agents

> Skills e agents importados de [Nuvinigroup/claude](https://github.com/Nuvinigroup/claude)

## Conteúdo Importado

### Skills

| Skill | Descrição | Uso |
|-------|-----------|-----|
| **autonomous-dev** | Agente autônomo que quebra features em user stories | `autonomous agent`, `ralph:`, `create prd` |
| **website-replicator** | Clona websites para estudo | `replicate website`, `clone site` |

### Agents

| Agent | Descrição |
|-------|-----------|
| **project-orchestrator** | Coordena análise → build → test → deploy |

## Como Usar

### Autonomous Dev

```bash
# Iniciar desenvolvimento autônomo
"build this feature autonomously"

# Criar PRD
"create prd for user authentication"

# Modo ralph (loop persistente)
"ralph: implement payment system"
```

### Website Replicator

```bash
# Clonar site público
python3 external/nuvini-claude/skills/website-replicator/scripts/replicate_website.py https://example.com -o ./output

# Clonar site com autenticação
python3 external/nuvini-claude/skills/website-replicator/scripts/authenticated_website_replicator.py \
    https://app.example.com/login \
    https://app.example.com/dashboard \
    -o ./output
```

### Project Orchestrator

```bash
# Usar o agent orchestrator
"/agent project-orchestrator analyze and build this project"
```

## Atualizar do Repositório de Origem

Execute o script de atualização:

```bash
./external/nuvini-claude/update.sh
```

Ou manualmente:

```bash
# Buscar atualizações via GitHub API
gh api repos/Nuvinigroup/claude/contents/skills/autonomous-dev/SKILL.md \
  --jq '.content' | base64 -d > external/nuvini-claude/skills/autonomous-dev/SKILL.md
```

## Fonte

- **Repositório**: https://github.com/Nuvinigroup/claude
- **Última atualização**: 2026-01-26
