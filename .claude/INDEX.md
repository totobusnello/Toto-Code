# Claude Code Extensions Index

> Catálogo completo de skills e agents disponíveis neste setup.
> Última atualização: 2025-01-28

---

## Skills (8)

| Skill | Descrição | Triggers |
|-------|-----------|----------|
| **autonomous-dev** | Desenvolvimento autônomo com breakdown de user stories, Memory MCP, smart delegation | `/autonomous`, "autonomous mode", "build autonomously", "create prd" |
| **claude-setup-optimizer** | Analisa changelog e otimiza setup de agents/skills | "optimize claude setup", "check claude updates", "improve my agents" |
| **cpo-ai-skill** | Chief Product Officer AI - orquestra ciclo completo de produto | `/cpo-go`, "cpo mode", "build this product", "idea to production" |
| **cto** | Advisor universal de CTO para arquitetura, segurança, performance | `/cto`, "cto advice", "architecture review", "security audit" |
| **fulltest-skill** | Testes full-spectrum com execução paralela e auto-fix | `/fulltest`, "test the website", "comprehensive testing" |
| **session-start-hook** | Criação de hooks de sessão para Claude Code web | "create session hook", "startup hook", "setup for claude web" |
| **skill-loader** | Carrega skills de repositórios GitHub externos | `/load-skills`, "load skills from", "install skills from" |
| **worktree-scaffold** | Automação de git worktrees para desenvolvimento paralelo | "checkout feature", "create workspace", "list workspaces" |

---

## Agents (8)

| Agent | Especialização | Triggers |
|-------|----------------|----------|
| **api-agent** | REST/GraphQL APIs, OpenAPI, testes de API | "create api endpoint", "design rest api", "graphql schema" |
| **database-agent** | Schema design, migrations, query optimization | "create database schema", "database migration", "prisma schema" |
| **devops-agent** | CI/CD, Docker, Kubernetes, cloud deployments | "create dockerfile", "ci/cd pipeline", "github actions" |
| **frontend-agent** | React, Vue, Angular, Next.js, Svelte, Tailwind | "create react component", "build frontend", "ui component" |
| **fulltesting-agent** | E2E testing com Chrome DevTools, auto-fix | "test the website", "run e2e tests", "browser testing" |
| **orchestrator-fullstack** | Coordena agents para features multi-camada | "build fullstack feature", "orchestrate implementation" |
| **code-review-agent** | Review multi-perspectiva (security, perf, arch) | "review this code", "code review", "review before pr" |

---

## Quick Reference

### Ativar Skills por Linguagem Natural

```
"Quero desenvolver esta feature de forma autônoma"  → autonomous-dev
"Otimize meu setup do Claude"                       → claude-setup-optimizer
"Construa este produto do zero"                     → cpo-ai-skill
"Revise a arquitetura deste projeto"                → cto
"Teste este site completamente"                     → fulltest-skill
```

### Ativar Agents

```
"Use o api-agent para criar os endpoints"
"Peça ao database-agent para otimizar as queries"
"Delegue para o frontend-agent criar os componentes"
"Use o code-review-agent antes de criar o PR"
```

### Fluxos Recomendados

**Nova Feature Complexa:**
1. `cpo-ai-skill` → planejamento estratégico
2. `autonomous-dev` → implementação iterativa
3. `fulltest-skill` → validação completa
4. `code-review-agent` → revisão final

**Desenvolvimento Fullstack:**
1. `orchestrator-fullstack` → coordena tudo
   - `database-agent` → schema/migrations
   - `api-agent` → endpoints
   - `frontend-agent` → UI
   - `devops-agent` → deploy

**Manutenção/Review:**
1. `cto` → análise técnica
2. `code-review-agent` → revisão de código
3. `fulltest-skill` → regressão

---

## Configuração

**Skills location:** `~/.claude/skills/`
**Agents location:** `~/.claude/agents/`

Para adicionar novos skills de repositórios externos:
```
"Load skills from https://github.com/user/repo"
```

---

*Gerado automaticamente pelo claude-setup-optimizer*
