#!/bin/bash

# Quick MCP Configuration Commands
# Use estes comandos para configurar API keys individuais

CONFIG_FILE="/Users/labf/Library/Application Support/Claude/claude_desktop_config.json"

echo "🔧 Configuração Rápida de MCPs"
echo ""
echo "Escolha uma opção:"
echo ""
echo "1. Configurar GitHub Token"
echo "2. Configurar Brave Search API"
echo "3. Configurar Google Maps API"
echo "4. Configurar Slack"
echo "5. Ver configuração atual"
echo "6. Remover API keys (voltar aos placeholders)"
echo ""
read -p "Opção (1-6): " option

case $option in
  1)
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "GITHUB TOKEN"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Obtenha em: https://github.com/settings/tokens"
    echo "Permissões: repo, read:org, read:user"
    echo ""
    read -p "GitHub Token: " GITHUB_TOKEN

    if [ ! -z "$GITHUB_TOKEN" ]; then
      jq --arg token "$GITHUB_TOKEN" \
         '.mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN = $token' \
         "$CONFIG_FILE" > /tmp/mcp_config.json && \
      mv /tmp/mcp_config.json "$CONFIG_FILE"
      echo "✅ GitHub Token configurado!"
    fi
    ;;

  2)
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "BRAVE SEARCH API"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Obtenha em: https://brave.com/search/api/"
    echo ""
    read -p "Brave API Key: " BRAVE_KEY

    if [ ! -z "$BRAVE_KEY" ]; then
      jq --arg key "$BRAVE_KEY" \
         '.mcpServers."brave-search".env.BRAVE_API_KEY = $key' \
         "$CONFIG_FILE" > /tmp/mcp_config.json && \
      mv /tmp/mcp_config.json "$CONFIG_FILE"
      echo "✅ Brave Search API configurado!"
    fi
    ;;

  3)
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "GOOGLE MAPS API"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Obtenha em: https://console.cloud.google.com/"
    echo ""
    read -p "Google Maps API Key: " GOOGLE_KEY

    if [ ! -z "$GOOGLE_KEY" ]; then
      jq --arg key "$GOOGLE_KEY" \
         '.mcpServers."google-maps".env.GOOGLE_MAPS_API_KEY = $key' \
         "$CONFIG_FILE" > /tmp/mcp_config.json && \
      mv /tmp/mcp_config.json "$CONFIG_FILE"
      echo "✅ Google Maps API configurado!"
    fi
    ;;

  4)
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "SLACK INTEGRATION"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Configure em: https://api.slack.com/apps"
    echo ""
    read -p "Slack Bot Token (xoxb-...): " SLACK_TOKEN
    read -p "Slack Team ID: " SLACK_TEAM

    if [ ! -z "$SLACK_TOKEN" ] && [ ! -z "$SLACK_TEAM" ]; then
      jq --arg token "$SLACK_TOKEN" --arg team "$SLACK_TEAM" \
         '.mcpServers.slack.env.SLACK_BOT_TOKEN = $token |
          .mcpServers.slack.env.SLACK_TEAM_ID = $team' \
         "$CONFIG_FILE" > /tmp/mcp_config.json && \
      mv /tmp/mcp_config.json "$CONFIG_FILE"
      echo "✅ Slack configurado!"
    fi
    ;;

  5)
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "CONFIGURAÇÃO ATUAL"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    echo "GitHub Token:"
    jq -r '.mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN' "$CONFIG_FILE"
    echo ""

    echo "Brave API Key:"
    jq -r '.mcpServers."brave-search".env.BRAVE_API_KEY' "$CONFIG_FILE"
    echo ""

    echo "Google Maps API Key:"
    jq -r '.mcpServers."google-maps".env.GOOGLE_MAPS_API_KEY' "$CONFIG_FILE"
    echo ""

    echo "Slack Bot Token:"
    jq -r '.mcpServers.slack.env.SLACK_BOT_TOKEN' "$CONFIG_FILE"
    echo ""

    echo "Slack Team ID:"
    jq -r '.mcpServers.slack.env.SLACK_TEAM_ID' "$CONFIG_FILE"
    echo ""
    ;;

  6)
    echo ""
    echo "⚠️  Removendo todas as API keys..."

    jq '.mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN = "<YOUR_GITHUB_TOKEN>" |
        .mcpServers."brave-search".env.BRAVE_API_KEY = "<YOUR_BRAVE_API_KEY>" |
        .mcpServers."google-maps".env.GOOGLE_MAPS_API_KEY = "<YOUR_GOOGLE_MAPS_KEY>" |
        .mcpServers.slack.env.SLACK_BOT_TOKEN = "<YOUR_SLACK_BOT_TOKEN>" |
        .mcpServers.slack.env.SLACK_TEAM_ID = "<YOUR_SLACK_TEAM_ID>"' \
       "$CONFIG_FILE" > /tmp/mcp_config.json && \
    mv /tmp/mcp_config.json "$CONFIG_FILE"

    echo "✅ API keys removidas (voltaram aos placeholders)"
    ;;

  *)
    echo "Opção inválida"
    exit 1
    ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  IMPORTANTE: Reinicie o Claude Desktop para"
echo "   aplicar as mudanças!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
