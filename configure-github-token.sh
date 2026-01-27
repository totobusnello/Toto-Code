#!/bin/bash

# Script para configurar apenas o GitHub Token
# Uso: ./configure-github-token.sh

CONFIG_FILE="/Users/labf/Library/Application Support/Claude/claude_desktop_config.json"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Configurar GitHub Token para MCP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 Passos para obter o token:"
echo ""
echo "1. Acesse: https://github.com/settings/tokens"
echo "2. Clique em 'Generate new token (classic)'"
echo "3. Selecione os scopes:"
echo "   ✅ repo (Full control)"
echo "   ✅ read:org"
echo "   ✅ read:user"
echo "   ✅ user:email"
echo "4. Clique em 'Generate token'"
echo "5. COPIE O TOKEN (você só verá uma vez!)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Verificar se jq está instalado
if ! command -v jq &> /dev/null; then
    echo "⚠️  jq não está instalado. Instalando..."
    brew install jq
fi

# Pedir o token
read -p "Cole seu GitHub Token (ghp_...): " GITHUB_TOKEN

if [ -z "$GITHUB_TOKEN" ]; then
    echo ""
    echo "❌ Nenhum token fornecido. Cancelando."
    exit 1
fi

# Verificar formato básico
if [[ ! $GITHUB_TOKEN =~ ^ghp_ ]]; then
    echo ""
    echo "⚠️  Aviso: O token não começa com 'ghp_'"
    echo "   Tokens clássicos geralmente começam com 'ghp_'"
    echo ""
    read -p "Continuar mesmo assim? (y/n): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Cancelando."
        exit 1
    fi
fi

# Criar backup
if [ -f "$CONFIG_FILE" ]; then
    echo ""
    echo "📦 Criando backup..."
    cp "$CONFIG_FILE" "$CONFIG_FILE.backup-$(date +%Y%m%d-%H%M%S)"
    echo "   Backup salvo!"
fi

# Atualizar configuração
echo ""
echo "💾 Salvando configuração..."

TMP_FILE=$(mktemp)
jq --arg token "$GITHUB_TOKEN" \
   '.mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN = $token' \
   "$CONFIG_FILE" > "$TMP_FILE"

if [ $? -eq 0 ]; then
    mv "$TMP_FILE" "$CONFIG_FILE"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✅ GitHub Token configurado com sucesso!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📋 Próximos passos:"
    echo ""
    echo "   1. Reinicie o Claude Desktop"
    echo "   2. Verifique se o GitHub MCP está conectado"
    echo "   3. Teste com: 'Liste meus repositórios no GitHub'"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
else
    echo ""
    echo "❌ Erro ao salvar configuração"
    rm -f "$TMP_FILE"
    exit 1
fi
