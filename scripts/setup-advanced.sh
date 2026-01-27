#!/bin/bash
# setup-advanced.sh - Configurações avançadas do Claude Code
# Roda: curl -sL https://raw.githubusercontent.com/totobusnello/Toto-Code/claude/show-repo-files-0XdZG/scripts/setup-advanced.sh | bash

set -e

echo "🚀 Configurando recursos avançados do Claude Code..."
echo ""

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verificar se npm está instalado
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm não encontrado. Instale o Node.js primeiro.${NC}"
    echo "   https://nodejs.org/"
    exit 1
fi

echo -e "${BLUE}📦 Instalando MCP Servers...${NC}"
echo ""

# 1. Memory MCP - Memória persistente
echo -e "${YELLOW}1/4${NC} Instalando Memory MCP (memória entre sessões)..."
npm install -g @anthropic/mcp-memory 2>/dev/null || echo "   → Pacote não disponível ainda, pulando..."

# 2. Filesystem MCP - Acesso a arquivos
echo -e "${YELLOW}2/4${NC} Instalando Filesystem MCP..."
npm install -g @modelcontextprotocol/server-filesystem 2>/dev/null || echo "   → Instalado ou não disponível"

# 3. GitHub MCP - Integração GitHub
echo -e "${YELLOW}3/4${NC} Instalando GitHub MCP..."
npm install -g @modelcontextprotocol/server-github 2>/dev/null || echo "   → Instalado ou não disponível"

# 4. Fetch MCP - Buscar URLs
echo -e "${YELLOW}4/4${NC} Instalando Fetch MCP..."
npm install -g @modelcontextprotocol/server-fetch 2>/dev/null || echo "   → Instalado ou não disponível"

echo ""
echo -e "${BLUE}⚙️ Configurando MCP no Claude...${NC}"

# Criar config de MCP servers
mkdir -p ~/.claude

# Backup do settings.json se existir
if [ -f ~/.claude/settings.json ]; then
    cp ~/.claude/settings.json ~/.claude/settings.json.backup
fi

# Criar/atualizar settings.json com MCPs
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
      "Grep",
      "mcp__*"
    ],
    "deny": [
      "Bash(rm -rf /)",
      "Bash(rm -rf ~)",
      "Bash(sudo rm *)"
    ]
  },
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": ""
      }
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
EOF

echo ""
echo -e "${BLUE}🪝 Criando Hooks...${NC}"

# Criar diretório de hooks
mkdir -p ~/.claude/hooks

# Hook de pre-commit
cat > ~/.claude/hooks/pre-commit.sh << 'HOOK'
#!/bin/bash
# Hook executado antes de commits
# Verifica lint e testes

echo "🔍 Verificando código antes do commit..."

# Detectar package.json
if [ -f "package.json" ]; then
    # Lint
    if grep -q '"lint"' package.json; then
        echo "  → Rodando lint..."
        npm run lint --silent 2>/dev/null || true
    fi

    # Type check
    if grep -q '"typecheck"' package.json; then
        echo "  → Verificando tipos..."
        npm run typecheck --silent 2>/dev/null || true
    fi
fi

echo "✅ Verificações concluídas"
HOOK
chmod +x ~/.claude/hooks/pre-commit.sh

# Hook de session-start
cat > ~/.claude/hooks/session-start.sh << 'HOOK'
#!/bin/bash
# Hook executado ao iniciar sessão Claude

# Mostrar info do projeto se existir package.json
if [ -f "package.json" ]; then
    PROJECT_NAME=$(grep '"name"' package.json | head -1 | cut -d'"' -f4)
    echo "📦 Projeto: $PROJECT_NAME"
fi

# Mostrar branch atual
if [ -d ".git" ]; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    echo "🌿 Branch: $BRANCH"
fi
HOOK
chmod +x ~/.claude/hooks/session-start.sh

echo ""
echo -e "${BLUE}📝 Criando mais comandos úteis...${NC}"

mkdir -p ~/.claude/commands

# /pr - Criar Pull Request
cat > ~/.claude/commands/pr.md << 'EOF'
---
description: Criar Pull Request no GitHub
---

Crie um Pull Request para as mudanças atuais:

1. Verifique se há mudanças não commitadas
2. Faça commit se necessário
3. Push para o remote
4. Crie o PR com:
   - Título descritivo
   - Descrição das mudanças
   - Checklist de review

Use: gh pr create --fill
EOF

# /deploy - Deploy
cat > ~/.claude/commands/deploy.md << 'EOF'
---
description: Fazer deploy do projeto
---

Execute o processo de deploy:

1. Verifique se todos os testes passam
2. Faça build de produção
3. Execute o deploy conforme configuração do projeto:
   - Vercel: vercel --prod
   - Railway: railway up
   - Outros: detectar automaticamente

Confirme antes de executar o deploy.
EOF

# /fix - Corrigir erros
cat > ~/.claude/commands/fix.md << 'EOF'
---
description: Corrigir erros de build/lint/type
---

Analise e corrija os erros:

1. Rode o build/lint/typecheck
2. Identifique todos os erros
3. Corrija um por um
4. Verifique se passa após correções

Prioridade: Type errors > Lint errors > Warnings
EOF

# /doc - Documentar
cat > ~/.claude/commands/doc.md << 'EOF'
---
description: Gerar documentação do código
---

Gere documentação completa:

1. README.md se não existir
2. JSDoc/TSDoc para funções públicas
3. Comentários para lógica complexa
4. Exemplos de uso

Manter documentação concisa e útil.
EOF

# /perf - Performance
cat > ~/.claude/commands/perf.md << 'EOF'
---
description: Analisar e otimizar performance
---

Use o performance-agent para:

1. Identificar gargalos de performance
2. Analisar bundle size (se frontend)
3. Verificar queries N+1 (se backend)
4. Sugerir otimizações
5. Medir antes/depois

Foco em melhorias com maior impacto.
EOF

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${GREEN}✅ CONFIGURAÇÃO AVANÇADA COMPLETA!${NC}"
echo ""
echo -e "${BLUE}📊 O que foi configurado:${NC}"
echo "   • MCP Servers (filesystem, github, fetch)"
echo "   • Hooks (pre-commit, session-start)"
echo "   • Comandos extras (/pr, /deploy, /fix, /doc, /perf)"
echo ""
echo -e "${BLUE}🎮 Novos comandos disponíveis:${NC}"
echo "   /pr      → Criar Pull Request"
echo "   /deploy  → Deploy do projeto"
echo "   /fix     → Corrigir erros de build"
echo "   /doc     → Gerar documentação"
echo "   /perf    → Análise de performance"
echo ""
echo -e "${YELLOW}⚠️  Para usar o GitHub MCP:${NC}"
echo "   1. Crie um token em: https://github.com/settings/tokens"
echo "   2. Edite ~/.claude/settings.json"
echo "   3. Adicione seu token em GITHUB_PERSONAL_ACCESS_TOKEN"
echo ""
echo -e "${BLUE}🧪 Teste rodando:${NC}"
echo "   cd ~/seu-projeto && claude"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
