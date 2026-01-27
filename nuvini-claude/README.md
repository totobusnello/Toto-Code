# Claude Code - Nuvini Group

Documentação em Português Brasileiro das skills e agentes do Claude Code utilizados pelo Nuvini Group.

## Visão Geral

Este repositório contém a documentação completa das extensões do Claude Code configuradas para o Nuvini Group, incluindo:

- **Skills**: Capacidades especializadas para análise financeira, M&A e desenvolvimento
- **Agentes**: Assistentes de IA especializados para tarefas complexas

## Estrutura do Repositório

```
nuvini-claude/
├── README.md
├── skills/
│   ├── README.md
│   ├── mna/                    # Análise Financeira e M&A
│   │   ├── aimpact.md
│   │   ├── financial-data-extractor.md
│   │   ├── investment-analysis-generator.md
│   │   ├── mna-proposal-generator.md
│   │   └── triage-analyzer.md
│   ├── presentations/          # Apresentações e Decks
│   │   ├── committee-presenter.md
│   │   └── ma-board-presentation.md
│   ├── webdesign/             # Design Web
│   │   ├── website-design.md
│   │   └── website-replicator.md
│   └── coding/                # Desenvolvimento
│       ├── autonomous-agent.md
│       └── codebase-cleanup.md
└── agents/
    ├── README.md
    ├── development/            # Desenvolvimento de Software
    │   ├── frontend-agent.md
    │   ├── backend-agent.md
    │   ├── database-agent.md
    │   ├── devops-agent.md
    │   └── documentation-agent.md
    ├── quality/                # Qualidade e Segurança
    │   ├── codereview-agent.md
    │   └── security-agent.md
    ├── testing/                # Testes e Validação
    │   ├── fulltesting-agent.md
    │   ├── page-tester.md
    │   └── test-analyst.md
    └── orchestration/          # Orquestração
        └── project-orchestrator.md
```

## Skills

Skills são capacidades especializadas que podem ser invocadas diretamente ou ativadas automaticamente.

### MNA - Análise Financeira e M&A

| Skill                                                                | Descrição                           |
| -------------------------------------------------------------------- | ----------------------------------- |
| [AI Impact](./skills/mna/aimpact.md)                                 | Análise de redução de custos com IA |
| [Triage Analyzer](./skills/mna/triage-analyzer.md)                   | Pontuação de oportunidades M&A      |
| [Financial Data Extractor](./skills/mna/financial-data-extractor.md) | Extração de dados de PDFs/Excel     |
| [Investment Analysis](./skills/mna/investment-analysis-generator.md) | Relatórios de investimento          |
| [M&A Proposal Generator](./skills/mna/mna-proposal-generator.md)     | Propostas financeiras               |

### Presentations - Apresentações

| Skill                                                                     | Descrição              |
| ------------------------------------------------------------------------- | ---------------------- |
| [M&A Board Presentation](./skills/presentations/ma-board-presentation.md) | Apresentações de board |
| [Committee Presenter](./skills/presentations/committee-presenter.md)      | PowerPoints de comitê  |

### Webdesign - Design Web

| Skill                                                          | Descrição                     |
| -------------------------------------------------------------- | ----------------------------- |
| [Website Design](./skills/webdesign/website-design.md)         | Design de websites B2B SaaS   |
| [Website Replicator](./skills/webdesign/website-replicator.md) | Clonagem de sites para estudo |

### Coding - Desenvolvimento

| Skill                                                   | Descrição                           |
| ------------------------------------------------------- | ----------------------------------- |
| [Autonomous Agent](./skills/coding/autonomous-agent.md) | Implementação iterativa de features |
| [Codebase Cleanup](./skills/coding/codebase-cleanup.md) | Remoção de arquivos não utilizados  |

➡️ [Ver documentação completa de skills](./skills/README.md)

## Agentes

Agentes são assistentes especializados para tarefas complexas.

### Development - Desenvolvimento

| Agente                                                             | Descrição                            |
| ------------------------------------------------------------------ | ------------------------------------ |
| [Frontend Agent](./agents/development/frontend-agent.md)           | React, Vue, Angular, Next.js, Svelte |
| [Backend Agent](./agents/development/backend-agent.md)             | Node.js, Python, Go, serverless      |
| [Database Agent](./agents/development/database-agent.md)           | Schema, migrations, queries          |
| [DevOps Agent](./agents/development/devops-agent.md)               | CI/CD, Docker, cloud                 |
| [Documentation Agent](./agents/development/documentation-agent.md) | README, API docs, arquitetura        |

### Quality - Qualidade

| Agente                                                    | Descrição                     |
| --------------------------------------------------------- | ----------------------------- |
| [Code Review Agent](./agents/quality/codereview-agent.md) | Revisão de PRs e qualidade    |
| [Security Agent](./agents/quality/security-agent.md)      | Varredura de vulnerabilidades |

### Testing - Testes

| Agente                                                      | Descrição                    |
| ----------------------------------------------------------- | ---------------------------- |
| [Full Testing Agent](./agents/testing/fulltesting-agent.md) | Testes E2E completos         |
| [Page Tester](./agents/testing/page-tester.md)              | Teste de páginas individuais |
| [Test Analyst](./agents/testing/test-analyst.md)            | Análise e correção de falhas |

### Orchestration - Orquestração

| Agente                                                                 | Descrição                       |
| ---------------------------------------------------------------------- | ------------------------------- |
| [Project Orchestrator](./agents/orchestration/project-orchestrator.md) | Coordenação completa de projeto |

➡️ [Ver documentação completa de agentes](./agents/README.md)

## Como Usar

### Pré-requisitos

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) instalado
- Acesso à API da Anthropic

### Configuração

1. Clone este repositório:

```bash
git clone https://github.com/Nuvinigroup/claude.git
cd claude
```

2. As skills e agentes serão automaticamente reconhecidos pelo Claude Code.

### Usando Skills e Agentes

Skills e agentes são invocados automaticamente pelo Claude Code quando o contexto é apropriado.

## Contribuindo

1. Fork o repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-skill`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona nova skill'`)
4. Push para a branch (`git push origin feature/nova-skill`)
5. Abra um Pull Request

## Licença

Propriedade do Nuvini Group. Todos os direitos reservados.

---

Mantido por [Nuvini Group](https://github.com/Nuvinigroup)
