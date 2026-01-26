# Claude Code Agents - GitHub Actions Setup

## Quick Start

### 1. Configurar API Key

Adicione sua API key da Anthropic como secret no repositorio:

1. Va em **Settings > Secrets and variables > Actions**
2. Clique **New repository secret**
3. Nome: `ANTHROPIC_API_KEY`
4. Valor: sua API key (comeca com `sk-ant-...`)

### 2. Usar os Agents

## Comandos Rapidos (em PRs)

Comente em qualquer PR para acionar os agents:

| Comando | Agent | Descricao |
|---------|-------|-----------|
| `/review` | code-reviewer-pro | Code review completo |
| `/security` | security-auditor | Auditoria de seguranca |
| `/test` | test-automator | Sugestoes de testes |
| `/docs` | documentation-engineer | Melhorias de documentacao |
| `/refactor` | refactoring-specialist | Sugestoes de refatoracao |
| `/debug` | debugger | Analise de bugs potenciais |
| `/explain` | - | Explicacao do codigo |

### Exemplo

```
/review focando em performance
```

```
/security verificar SQL injection
```

## Comandos Avancados

Use `/agent <nome>` para chamar qualquer agent:

```
/agent data-scientist analisar os dados neste arquivo
```

```
/agent ml-engineer sugerir melhorias no modelo
```

### Agents Disponiveis

Veja o catalogo completo em `CATALOG.md`. Alguns exemplos:

**Desenvolvimento:**
- `frontend-developer`, `backend-developer`, `fullstack-developer`
- `react-specialist`, `nextjs-developer`, `vue-expert`
- `python-pro`, `typescript-pro`, `rust-engineer`

**DevOps:**
- `devops-engineer`, `kubernetes-specialist`, `terraform-engineer`

**Dados/ML:**
- `data-scientist`, `data-engineer`, `ml-engineer`

**Qualidade:**
- `code-reviewer`, `security-auditor`, `debugger`

## Auto-Review em PRs

Para ativar review automatico:

1. Adicione a label `claude-review` ao PR
2. O workflow roda automaticamente em cada push

## Execucao Manual

Va em **Actions > Claude Code Agents > Run workflow**:

1. Escolha o agent
2. Digite o prompt
3. Clique **Run workflow**

## Customizacao

### Adicionar Novos Comandos

Edite `.github/workflows/claude-quick-commands.yml`:

```yaml
"/meu-comando")
  PROMPT="Act as meu-agent. Faca algo especifico."
  TITLE="Meu Titulo"
  ;;
```

### Usar Skills Especificos

Mencione o skill no prompt:

```
/agent python-pro usando o skill pandas-pro, analise este dataset
```

## Troubleshooting

### Workflow nao executa
- Verifique se o secret `ANTHROPIC_API_KEY` esta configurado
- Verifique permissoes do workflow

### Resposta truncada
- Output muito longo e truncado em 60k chars
- Peca resultados mais concisos no prompt

### Erro de API
- Verifique se a API key e valida
- Verifique limites de rate da API

## Links Uteis

- [Claude Code Docs](https://docs.anthropic.com/claude-code)
- [Anthropic API](https://console.anthropic.com)
- [CATALOG.md](../CATALOG.md) - Lista completa de agents e skills
