#!/bin/bash

# Script para configurar API Keys dos MCPs do Claude Desktop
# Uso: ./configure-mcps.sh

set -e

CONFIG_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json"
BACKUP_FILE="$HOME/Library/Application Support/Claude/claude_desktop_config.json.backup"

echo "================================================"
echo "   Configurador de MCPs - Claude Desktop"
echo "================================================"
echo ""

# Criar backup
if [ -f "$CONFIG_FILE" ]; then
    echo "📦 Criando backup do arquivo de configuração..."
    cp "$CONFIG_FILE" "$BACKUP_FILE"
    echo "   Backup salvo em: $BACKUP_FILE"
    echo ""
fi

echo "🔑 Vamos configurar as API Keys necessárias"
echo ""
echo "Pressione ENTER para pular se não quiser configurar agora."
echo ""

# GitHub Token
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1️⃣  GITHUB TOKEN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Obtenha em: https://github.com/settings/tokens"
echo "   Permissões: repo, read:org, read:user"
echo ""
read -p "GitHub Personal Access Token: " GITHUB_TOKEN
echo ""

# Brave API Key
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2️⃣  BRAVE SEARCH API"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Obtenha em: https://brave.com/search/api/"
echo ""
read -p "Brave Search API Key: " BRAVE_KEY
echo ""

# Google Maps API Key
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3️⃣  GOOGLE MAPS API"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Obtenha em: https://console.cloud.google.com/"
echo ""
read -p "Google Maps API Key: " GOOGLE_MAPS_KEY
echo ""

# Slack Bot Token
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4️⃣  SLACK INTEGRATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Configure em: https://api.slack.com/apps"
echo ""
read -p "Slack Bot Token (xoxb-...): " SLACK_TOKEN
read -p "Slack Team ID: " SLACK_TEAM_ID
echo ""

# PostgreSQL Connection
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5️⃣  POSTGRESQL DATABASE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Formato: postgresql://user:pass@host:port/database"
echo "   Exemplo: postgresql://localhost/mydb"
echo ""
read -p "PostgreSQL Connection String: " POSTGRES_CONN
echo ""

# SQLite Path
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6️⃣  SQLITE DATABASE PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Diretório padrão: $HOME/databases"
echo ""
read -p "SQLite Database Path [$HOME/databases]: " SQLITE_PATH
SQLITE_PATH=${SQLITE_PATH:-"$HOME/databases"}
echo ""

# Criar diretório SQLite se não existir
mkdir -p "$SQLITE_PATH"

# Aplicar configurações
echo "💾 Salvando configurações..."
echo ""

# Usar jq para atualizar o JSON
if command -v jq &> /dev/null; then
    TMP_FILE=$(mktemp)

    jq --arg github_token "${GITHUB_TOKEN:-<YOUR_GITHUB_TOKEN>}" \
       --arg brave_key "${BRAVE_KEY:-<YOUR_BRAVE_API_KEY>}" \
       --arg google_key "${GOOGLE_MAPS_KEY:-<YOUR_GOOGLE_MAPS_KEY>}" \
       --arg slack_token "${SLACK_TOKEN:-<YOUR_SLACK_BOT_TOKEN>}" \
       --arg slack_team "${SLACK_TEAM_ID:-<YOUR_SLACK_TEAM_ID>}" \
       --arg postgres_conn "${POSTGRES_CONN:-postgresql://localhost/mydb}" \
       --arg sqlite_path "$SQLITE_PATH" \
       '
       .mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN = $github_token |
       .mcpServers."brave-search".env.BRAVE_API_KEY = $brave_key |
       .mcpServers."google-maps".env.GOOGLE_MAPS_API_KEY = $google_key |
       .mcpServers.slack.env.SLACK_BOT_TOKEN = $slack_token |
       .mcpServers.slack.env.SLACK_TEAM_ID = $slack_team |
       .mcpServers.postgres.args[2] = $postgres_conn |
       .mcpServers.sqlite.args[2] = $sqlite_path
       ' "$CONFIG_FILE" > "$TMP_FILE"

    mv "$TMP_FILE" "$CONFIG_FILE"
    echo "✅ Configurações salvas com sucesso!"
else
    echo "⚠️  jq não está instalado. Instalando..."
    brew install jq
    echo "Por favor, execute o script novamente."
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ Configuração concluída!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Próximos passos:"
echo ""
echo "   1. Reinicie o Claude Desktop"
echo "   2. Verifique se os MCPs aparecem no menu"
echo "   3. Teste cada MCP conforme necessário"
echo ""
echo "📖 Para mais informações, consulte:"
echo "   $HOME/Toto-Code/MCP_SETUP_GUIDE.md"
echo ""
echo "🔄 Para restaurar o backup:"
echo "   cp \"$BACKUP_FILE\" \"$CONFIG_FILE\""
echo ""
