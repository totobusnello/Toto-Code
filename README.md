# Claude Code Skills & Agents Repository

> A maior coleção organizada de skills e agents para Claude Code

[![Skills](https://img.shields.io/badge/Skills-688-blue)](./CATALOG.md)
[![Agents](https://img.shields.io/badge/Agents-472-green)](./CATALOG.md)
[![Web Skills](https://img.shields.io/badge/Web%20Skills-40-purple)](./claude-ai-prompts/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](./LICENSE)

## O que e isso?

Este repositorio contem **a maior colecao organizada** de skills e agents para Claude Code, incluindo:

| Recurso | Quantidade | Descricao |
|---------|------------|-----------|
| **Skills** | 688 | Instrucoes especializadas para tarefas especificas |
| **Agents** | 472 | Personas especializadas com expertise em areas |
| **Web Skills** | 40 | Skills otimizadas para claude.ai web |
| **Workflows** | 6 | Fluxos de trabalho pre-configurados |

## Inicio Rapido

### 1. Usar o Skill Finder (Recomendado)

```bash
# Detecta seu projeto e sugere skills/agents
python tools/skill-finder.py /path/to/seu/projeto

# Modo interativo
python tools/skill-finder.py --interactive

# Ver todas as skills
python tools/skill-finder.py --list-all
```

### 2. Usar o Dashboard Visual

```bash
# Abrir o dashboard no navegador
open dashboard/index.html
# ou
xdg-open dashboard/index.html  # Linux
```

### 3. Invocar Skills/Agents Diretamente

```markdown
# Usar um agent especifico
"Use o agent react-specialist para revisar este componente"

# Ativar skill automaticamente
"Crie um PRD para [feature]"  -> ativa skill 'prd'

# Orquestrar implementacao
"Use o workflow-orchestrator para planejar a implementacao"
```

## Estrutura do Repositorio

```
Toto-Code/
├── README.md                  # Este arquivo
├── CATALOG.md                 # Catalogo completo de skills/agents
├── CLAUDE.md                  # Guia de deteccao de projetos
├── QUICKSTART.md              # Guia rapido de inicio
│
├── tools/                     # Ferramentas utilitarias
│   └── skill-finder.py        # Detector de projeto e sugestor
│
├── dashboard/                 # Interface visual
│   └── index.html             # Dashboard para navegar skills
│
├── claude-ai-prompts/         # 40 skills para claude.ai web
│   ├── README.md
│   ├── 01-copywriting.md
│   ├── 02-seo-audit.md
│   └── ... (38 mais)
│
├── .github/
│   └── workflows/             # CI/CD para validacao
│       └── validate-skills.yml
│
└── [30+ repos externos]       # Repositorios integrados via symlink
```

## Skills por Categoria

### Marketing & Copywriting
| Skill | Descricao | Uso |
|-------|-----------|-----|
| `copywriting` | Copy persuasiva de alta conversao | "Escreva copy para [produto]" |
| `seo-audit` | Auditoria SEO completa | "Faca SEO audit de [URL]" |
| `pricing-strategy` | Estrategias de preco | "Crie pricing para [produto]" |
| `launch-strategy` | Planejamento de lancamentos | "Planeje lancamento de [produto]" |
| `email-sequences` | Sequencias de email | "Crie emails para [objetivo]" |

### Development
| Skill | Descricao | Uso |
|-------|-----------|-----|
| `python-pro` | Python avancado | "Use python-pro para [tarefa]" |
| `typescript-pro` | TypeScript avancado | "Use typescript-pro para [tarefa]" |
| `api-designer` | Design de APIs REST | "Projete API para [recurso]" |
| `react-best-practices` | React com best practices | "Revise componente React" |
| `fastapi-expert` | APIs com FastAPI | "Crie endpoint FastAPI" |
| `nextjs-developer` | Next.js moderno | "Use nextjs-developer" |

### Data & ML
| Skill | Descricao | Uso |
|-------|-----------|-----|
| `excel-analysis` | Analise de dados Excel | "Analise estes dados" |
| `data-analyst` | Analise com Python/Pandas | "Analise dataset" |
| `ml-engineer` | Machine Learning | "Crie modelo para [problema]" |
| `llm-architect` | Sistemas com LLMs | "Projete sistema LLM" |

### DevOps
| Skill | Descricao | Uso |
|-------|-----------|-----|
| `devops-engineer` | CI/CD e automacao | "Configure CI/CD" |
| `kubernetes-specialist` | Orquestracao K8s | "Configure K8s" |
| `terraform-engineer` | Infrastructure as Code | "Crie infra Terraform" |
| `cloud-architect` | Arquitetura cloud | "Projete arquitetura cloud" |

### Security
| Skill | Descricao | Uso |
|-------|-----------|-----|
| `pentest-checklist` | Checklist de pentest | "Pentest checklist para [app]" |
| `security-auditor` | Auditoria de seguranca | "Audite seguranca de [codigo]" |
| `burp-suite` | Testes com Burp | "Teste [aplicacao] com Burp" |

### Testing & Quality
| Skill | Descricao | Uso |
|-------|-----------|-----|
| `tdd-guide` | Test-Driven Development | "Aplique TDD para [feature]" |
| `code-review` | Revisao de codigo | "Revise este codigo" |
| `systematic-debugging` | Debugging sistematico | "Debug: [problema]" |

## Agents Principais

### Por Stack
| Stack | Agents |
|-------|--------|
| **React** | `react-specialist`, `nextjs-developer` |
| **Vue** | `vue-expert`, `nuxt-developer` |
| **Python** | `python-pro`, `django-developer`, `fastapi-expert` |
| **Node.js** | `backend-developer`, `nestjs-expert` |
| **Mobile** | `flutter-expert`, `react-native-dev` |
| **Systems** | `rust-engineer`, `golang-pro` |

### Por Funcao
| Funcao | Agents |
|--------|--------|
| **Frontend** | `frontend-developer`, `ui-designer` |
| **Backend** | `backend-developer`, `api-designer` |
| **DevOps** | `devops-engineer`, `cloud-architect` |
| **Data** | `data-scientist`, `ml-engineer` |
| **Security** | `security-auditor`, `penetration-tester` |
| **Quality** | `qa-expert`, `test-automator` |

## Workflows Pre-configurados

```markdown
# Full Stack Feature
Use workflow-orchestrator: PRD -> Backend -> Frontend -> Testes -> Deploy

# Product Launch
Launch strategy -> Copy -> Landing -> Email -> Analytics

# Security Audit
Code Review -> Pentest -> Fixes -> Relatorio

# Legacy Refactor
Analise -> Testes -> Refactor -> Validacao -> Docs
```

## Deteccao Automatica de Projeto

O sistema detecta automaticamente o tipo de projeto pelos arquivos:

| Arquivo | Stack Detectado |
|---------|-----------------|
| `package.json` | Node.js/JavaScript |
| `tsconfig.json` | TypeScript |
| `next.config.js` | Next.js |
| `requirements.txt` | Python |
| `Cargo.toml` | Rust |
| `go.mod` | Go |
| `Dockerfile` | Docker |

## Contribuindo

1. Fork este repositorio
2. Crie uma branch (`git checkout -b feature/nova-skill`)
3. Adicione sua skill/agent seguindo o padrao
4. Commit (`git commit -m 'Add nova skill'`)
5. Push (`git push origin feature/nova-skill`)
6. Abra um Pull Request

## Recursos Externos Integrados

Este repositorio integra skills de varios projetos da comunidade:

- [anthropics/claude-code](https://github.com/anthropics/claude-code)
- [ruvnet/agentic-flow](https://github.com/ruvnet/agentic-flow)
- [superclaude-framework](https://github.com/superclaude/superclaude)
- [oh-my-claudecode](https://github.com/oh-my-claudecode/oh-my-claudecode)
- E mais 26+ repositorios...

## License

MIT License - veja [LICENSE](./LICENSE) para detalhes.

---

**Dica**: Use `python tools/skill-finder.py` para descobrir as melhores skills para seu projeto!
