#!/bin/bash
# install-all.sh - Instala todas as skills e agents do Toto-Code

TOTO_CODE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "🚀 Instalando skills e agents do Toto-Code..."
echo ""

# Criar diretórios
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/agents"

# Instalar skills
echo "📚 Instalando skills..."
skills_count=0
find "$TOTO_CODE_DIR" -name "SKILL.md" -o -name "skill.md" 2>/dev/null | while read skill_file; do
    skill_dir=$(dirname "$skill_file")
    skill_name=$(basename "$skill_dir")
    if [ ! -d "$CLAUDE_DIR/skills/$skill_name" ]; then
        cp -r "$skill_dir" "$CLAUDE_DIR/skills/$skill_name" 2>/dev/null
        ((skills_count++))
    fi
done
echo "   Skills instaladas: $(ls "$CLAUDE_DIR/skills/" 2>/dev/null | wc -l)"

# Instalar agents
echo "🤖 Instalando agents..."
find "$TOTO_CODE_DIR" -path "*agents*" -name "*.md" ! -name "README.md" 2>/dev/null | while read agent_file; do
    agent_name=$(basename "$agent_file" .md)
    if [ ! -d "$CLAUDE_DIR/agents/$agent_name" ]; then
        mkdir -p "$CLAUDE_DIR/agents/$agent_name"
        cp "$agent_file" "$CLAUDE_DIR/agents/$agent_name/AGENT.md" 2>/dev/null
    fi
done
echo "   Agents instalados: $(ls "$CLAUDE_DIR/agents/" 2>/dev/null | wc -l)"

echo ""
echo "✅ Instalação concluída!"
echo ""
echo "📊 Resumo:"
echo "   Skills: $(ls "$CLAUDE_DIR/skills/" 2>/dev/null | wc -l)"
echo "   Agents: $(ls "$CLAUDE_DIR/agents/" 2>/dev/null | wc -l)"
echo ""
echo "💡 Use './scripts/detect-project.sh' em qualquer projeto para ver recomendações"
