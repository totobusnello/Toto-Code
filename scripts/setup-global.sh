#!/bin/bash
# setup-global.sh - Configura Claude Code para máxima eficiência
# Roda: curl -sL https://raw.githubusercontent.com/totobusnello/Toto-Code/claude/show-repo-files-0XdZG/scripts/setup-global.sh | bash

set -e

echo "🚀 Configurando Claude Code Global..."
echo ""

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Criar diretórios
echo -e "${BLUE}📁 Criando diretórios...${NC}"
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/agents

# 1. CLAUDE.md Global
echo -e "${BLUE}📝 Criando CLAUDE.md global...${NC}"
cat > ~/.claude/CLAUDE.md << 'CLAUDEMD'
# Claude Global Instructions

## Preferências Gerais
- Responder em português quando perguntado em português
- Código limpo, bem documentado, com testes
- Sempre considerar segurança e performance

## Agents Favoritos
Usar automaticamente quando apropriado:
- `codereview-agent` - Antes de finalizar código
- `security-agent` - Em código com autenticação/dados sensíveis
- `autonomous-dev` - Para features complexas (modo autônomo)
- `debugger` - Para resolver bugs difíceis
- `performance-agent` - Para otimizações

## Convenções de Código
- TypeScript: sempre strict mode
- Python: type hints sempre
- Commits: Conventional Commits em inglês
- Comentários: podem ser em português

## Workflow Padrão
1. Entender o problema completamente
2. Planejar antes de codar
3. Implementar em pequenos passos
4. Testar cada mudança
5. Revisar com codereview-agent antes de commitar

## Nunca Fazer
- Commits sem testar
- Código sem tipos (quando linguagem suporta)
- Secrets/senhas hardcoded
- console.log/print em produção
- Ignorar erros silenciosamente

## Stacks Comuns
- Frontend: Next.js, React, Vue, Tailwind
- Backend: Node.js, Python, FastAPI, Express
- Database: PostgreSQL, Supabase, MongoDB
- Deploy: Vercel, Railway, AWS

## Comandos Customizados
- /review - Code review completo
- /secure - Análise de segurança
- /auto - Modo desenvolvimento autônomo
- /test - Gerar testes
CLAUDEMD

# 2. Comandos Globais
echo -e "${BLUE}⚡ Criando comandos globais...${NC}"

# /review
cat > ~/.claude/commands/review.md << 'EOF'
---
description: Code review completo do código atual
---

Faça uma revisão completa usando o codereview-agent:

1. **Bugs**: Identifique bugs potenciais e edge cases
2. **Performance**: Sugira otimizações de performance
3. **Segurança**: Verifique vulnerabilidades
4. **Legibilidade**: Avalie clareza e manutenibilidade
5. **Testes**: Verifique cobertura de testes

Formato da resposta:
- 🔴 Crítico (deve corrigir)
- 🟡 Importante (deveria corrigir)
- 🟢 Sugestão (nice to have)
EOF

# /secure
cat > ~/.claude/commands/secure.md << 'EOF'
---
description: Análise de segurança do código
---

Use o security-agent para verificar:

1. **OWASP Top 10**: Vulnerabilidades comuns
2. **Secrets**: Senhas, API keys, tokens expostos
3. **Input Validation**: Sanitização de inputs
4. **Auth**: Autenticação e autorização
5. **Dependencies**: Pacotes com vulnerabilidades conhecidas

Gere um relatório com severidade (Alta/Média/Baixa) para cada item.
EOF

# /auto
cat > ~/.claude/commands/auto.md << 'EOF'
---
description: Ativar modo de desenvolvimento autônomo
---

Ative o skill autonomous-dev para:

1. Criar PRD (Product Requirements Document)
2. Dividir em user stories pequenas
3. Implementar uma story por vez
4. Testar cada implementação
5. Commitar automaticamente quando passar

Persistir contexto em:
- prd.json - Tasks e status
- progress.md - Aprendizados
- AGENTS.md - Padrões do repo
EOF

# /test
cat > ~/.claude/commands/test.md << 'EOF'
---
description: Gerar testes para o código
---

Analise o código e gere testes completos:

1. **Unit tests**: Para cada função/método
2. **Edge cases**: Inputs inválidos, limites
3. **Integration**: Se houver dependências externas
4. **Mocks**: Quando necessário

Usar o framework de testes do projeto (Jest, Vitest, Pytest, etc).
EOF

# /explain
cat > ~/.claude/commands/explain.md << 'EOF'
---
description: Explicar código em detalhes
---

Explique o código selecionado:

1. **O que faz**: Descrição geral
2. **Como funciona**: Passo a passo
3. **Por que**: Decisões de design
4. **Dependências**: O que usa/importa
5. **Exemplo**: Como usar na prática
EOF

# /refactor
cat > ~/.claude/commands/refactor.md << 'EOF'
---
description: Refatorar código para melhor qualidade
---

Refatore o código aplicando:

1. **Clean Code**: Nomes claros, funções pequenas
2. **SOLID**: Princípios de design
3. **DRY**: Remover duplicação
4. **Performance**: Otimizações sem sacrificar legibilidade

Mostrar antes/depois com explicação das mudanças.
EOF

# 3. Settings.json
echo -e "${BLUE}⚙️ Configurando settings.json...${NC}"
cat > ~/.claude/settings.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash(npm *)",
      "Bash(npx *)",
      "Bash(yarn *)",
      "Bash(pnpm *)",
      "Bash(git *)",
      "Bash(python *)",
      "Bash(python3 *)",
      "Bash(pip *)",
      "Bash(pip3 *)",
      "Bash(node *)",
      "Bash(deno *)",
      "Bash(bun *)",
      "Bash(cargo *)",
      "Bash(go *)",
      "Bash(make *)",
      "Bash(docker *)",
      "Bash(docker-compose *)",
      "Bash(kubectl *)",
      "Bash(terraform *)",
      "Bash(ls *)",
      "Bash(cat *)",
      "Bash(head *)",
      "Bash(tail *)",
      "Bash(grep *)",
      "Bash(find *)",
      "Bash(wc *)",
      "Bash(curl *)",
      "Bash(wget *)",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep"
    ],
    "deny": [
      "Bash(rm -rf /)",
      "Bash(rm -rf ~)",
      "Bash(sudo rm *)",
      "Bash(chmod 777 *)",
      "Bash(> /dev/sda*)"
    ]
  }
}
EOF

# 4. Aliases no shell
echo -e "${BLUE}🔧 Configurando aliases...${NC}"

# Detectar shell
SHELL_RC=""
if [ -f ~/.zshrc ]; then
    SHELL_RC=~/.zshrc
elif [ -f ~/.bashrc ]; then
    SHELL_RC=~/.bashrc
fi

if [ -n "$SHELL_RC" ]; then
    # Verificar se já existe configuração
    if ! grep -q "# === CLAUDE CODE ===" "$SHELL_RC" 2>/dev/null; then
        cat >> "$SHELL_RC" << 'ALIASES'

# === CLAUDE CODE ===
alias cc="claude"
alias ccp="claude --print"
alias ccr="claude --resume"

# Detectar projeto
alias detect="~/Toto-Code/scripts/detect-project.sh"

# Atalhos para agents
alias review="claude -p 'Use o codereview-agent para revisar este código'"
alias secure="claude -p 'Use o security-agent para verificar segurança'"

# Iniciar projeto com Claude
ccnew() {
    if [ -n "$1" ]; then
        mkdir -p "$1" && cd "$1"
    fi
    if [ -f ~/Toto-Code/scripts/detect-project.sh ]; then
        ~/Toto-Code/scripts/detect-project.sh
    fi
    claude
}
# === END CLAUDE CODE ===
ALIASES
        echo -e "${GREEN}✓${NC} Aliases adicionados ao $SHELL_RC"
    else
        echo -e "${YELLOW}→${NC} Aliases já existem no $SHELL_RC"
    fi
fi

# 5. Resumo
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${GREEN}✅ CONFIGURAÇÃO COMPLETA!${NC}"
echo ""
echo -e "${BLUE}📊 O que foi configurado:${NC}"
echo "   • ~/.claude/CLAUDE.md (preferências globais)"
echo "   • ~/.claude/settings.json (permissões)"
echo "   • ~/.claude/commands/ (6 comandos personalizados)"
echo "   • Aliases no terminal"
echo ""
echo -e "${BLUE}🎮 Comandos disponíveis:${NC}"
echo "   cc          → Abre Claude Code"
echo "   detect      → Detecta projeto e sugere agents"
echo "   ccnew pasta → Cria pasta e abre Claude"
echo ""
echo -e "${BLUE}⚡ Dentro do Claude, use:${NC}"
echo "   /review     → Code review completo"
echo "   /secure     → Análise de segurança"
echo "   /auto       → Modo autônomo"
echo "   /test       → Gerar testes"
echo "   /explain    → Explicar código"
echo "   /refactor   → Refatorar código"
echo ""
echo -e "${YELLOW}⚠️  Reinicie o terminal ou rode:${NC}"
echo "   source $SHELL_RC"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
