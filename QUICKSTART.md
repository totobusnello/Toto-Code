# Guia Rapido - Claude Code Skills & Agents

> Comece a usar em 2 minutos!

## 1. Detecte seu Projeto

```bash
# Execute o Skill Finder no seu projeto
python tools/skill-finder.py /caminho/do/seu/projeto
```

**Saida exemplo:**
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

>> Agents Recomendados
----------------------------------------
  nextjs-developer
  react-specialist
  typescript-pro
```

## 2. Invoque Skills/Agents

### Skills (ativam automaticamente por palavras-chave)

```markdown
# PRD - Product Requirements Document
"Crie um PRD para a feature de autenticacao"

# Copywriting
"Escreva uma copy persuasiva para a landing page"

# SEO
"Faca um audit SEO desta pagina"

# Code Review
"Revise este codigo para seguranca e qualidade"
```

### Agents (invoque explicitamente)

```markdown
# Desenvolvimento
"Use o agent react-specialist para criar este componente"
"Use o agent fastapi-expert para implementar esta API"

# DevOps
"Use o agent devops-engineer para configurar CI/CD"
"Use o agent kubernetes-specialist para o deployment"

# Seguranca
"Use o agent security-auditor para verificar vulnerabilidades"
"Use o agent penetration-tester para testar a aplicacao"

# Dados
"Use o agent data-scientist para analisar estes dados"
"Use o agent ml-engineer para criar um modelo"
```

## 3. Use Workflows Completos

```markdown
# Implementar feature completa
"Use o workflow-orchestrator para implementar:
1. PRD da feature
2. Backend API
3. Frontend components
4. Testes
5. Documentacao"

# Lancar produto
"Execute o workflow de lancamento:
1. Estrategia de lancamento
2. Copy da landing page
3. Sequencia de emails
4. Setup de analytics"

# Auditoria de seguranca
"Execute auditoria completa:
1. Code review
2. Pentest checklist
3. Correcao de vulnerabilidades
4. Relatorio final"
```

## 4. Dashboard Visual

Abra o dashboard para navegar skills visualmente:

```bash
# macOS
open dashboard/index.html

# Linux
xdg-open dashboard/index.html

# Windows
start dashboard/index.html
```

**Features do Dashboard:**
- Busca de skills/agents
- Filtro por categoria
- Copiar comandos de invocacao
- Ver detalhes e exemplos

## 5. Comandos Rapidos

| Tarefa | Comando |
|--------|---------|
| Criar PRD | "Crie um PRD para [feature]" |
| Code Review | "Revise este codigo" |
| Escrever Testes | "Crie testes para [codigo]" |
| Debug | "Debug este problema: [erro]" |
| Documentar | "Documente este [codigo/API]" |
| Otimizar | "Otimize a performance de [codigo]" |
| Refatorar | "Refatore [codigo] seguindo clean code" |
| Deploy | "Configure deploy para [plataforma]" |

## 6. Melhores Praticas

### Seja Especifico
```markdown
# Bom
"Use o agent react-specialist para criar um componente
de formulario de login com validacao, estados de loading
e tratamento de erros"

# Menos eficaz
"Crie um formulario de login"
```

### Combine Skills + Agents
```markdown
"Primeiro use a skill prd para definir os requisitos,
depois use o agent nextjs-developer para implementar"
```

### Use Contexto do Projeto
```markdown
"Considerando que este projeto usa Next.js 14 com App Router
e Prisma, use o agent nextjs-developer para [tarefa]"
```

## Proximos Passos

1. **Explore o Catalogo**: `cat CATALOG.md`
2. **Veja Deteccao**: `cat CLAUDE.md`
3. **Use o Dashboard**: `open dashboard/index.html`
4. **Experimente Skills**: Tente diferentes comandos!

---

**Duvidas?** Abra uma issue no repositorio!
