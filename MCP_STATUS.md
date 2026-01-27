# Status de Instalação dos MCPs

## Resumo da Instalação

**Data:** 2026-01-26
**Total de MCPs:** 14
**Status:** ✅ Instalados (pendente configuração de API keys)

---

## MCPs por Status

### ✅ Prontos para Usar (6)
Estes MCPs funcionam imediatamente, sem configuração adicional:

1. **filesystem** - Acesso a arquivos do sistema
2. **git** - Operações Git
3. **fetch** - Requisições HTTP/HTTPS
4. **puppeteer** - Automação de browser
5. **memory** - Memória persistente
6. **time** - Operações com data/hora
7. **sequential-thinking** - Pensamento estruturado
8. **everything** - Busca universal

### ⚙️ Requer Configuração Simples (1)
Apenas criar diretório:

9. **sqlite** - Banco SQLite
   - Comando: `mkdir -p ~/databases` ✅ **Criado**

### 🔑 Requer API Keys (4)
Necessário obter API keys dos serviços:

10. **github** - GitHub API
    - URL: https://github.com/settings/tokens
    - Status: ⏳ Pendente

11. **brave-search** - Busca web
    - URL: https://brave.com/search/api/
    - Status: ⏳ Pendente

12. **google-maps** - Google Maps
    - URL: https://console.cloud.google.com/
    - Status: ⏳ Pendente

13. **slack** - Integração Slack
    - URL: https://api.slack.com/apps
    - Status: ⏳ Pendente

### 🗄️ Requer Banco de Dados (1)
Necessário ter PostgreSQL instalado:

14. **postgres** - PostgreSQL
    - Instalar: `brew install postgresql@15`
    - Status: ⏳ Pendente

---

## Ferramentas Instaladas

- ✅ **uv** (0.9.26) - Gerenciador Python
- ✅ **uvx** - Executor de pacotes Python
- ✅ **npx** - Executor de pacotes Node.js

---

## Arquivos Criados

```
Toto-Code/
├── MCP_SETUP_GUIDE.md      # Guia completo de configuração
├── MCP_STATUS.md            # Este arquivo
└── configure-mcps.sh        # Script de configuração interativo
```

```
~/databases/                 # Diretório para SQLite ✅
```

```
~/Library/Application Support/Claude/
├── claude_desktop_config.json          # Configuração ativa
└── claude_desktop_config.json.backup   # Backup (criado ao rodar script)
```

---

## Como Configurar API Keys

### Opção 1: Script Interativo (Recomendado)
```bash
cd ~/Toto-Code
./configure-mcps.sh
```

### Opção 2: Manual
```bash
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

Substitua os placeholders:
- `<YOUR_GITHUB_TOKEN>`
- `<YOUR_BRAVE_API_KEY>`
- `<YOUR_GOOGLE_MAPS_KEY>`
- `<YOUR_SLACK_BOT_TOKEN>`
- `<YOUR_SLACK_TEAM_ID>`

---

## Próximos Passos

1. **Obter API Keys** (opcional, conforme necessidade)
   - [ ] GitHub Token
   - [ ] Brave Search API
   - [ ] Google Maps API
   - [ ] Slack Bot Token

2. **Instalar PostgreSQL** (opcional)
   ```bash
   brew install postgresql@15
   brew services start postgresql@15
   createdb mydb
   ```

3. **Configurar MCPs**
   ```bash
   ./configure-mcps.sh
   ```

4. **Reiniciar Claude Desktop**
   - Feche completamente o app
   - Abra novamente
   - Verifique se MCPs aparecem nas ferramentas

5. **Testar MCPs**
   - Teste cada MCP conforme necessidade
   - Verifique logs em caso de erro: `~/Library/Logs/Claude/`

---

## Verificação Rápida

Execute para verificar a configuração:

```bash
# Ver configuração atual
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Contar MCPs configurados
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq '.mcpServers | length'

# Listar MCPs configurados
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq '.mcpServers | keys[]'
```

---

## Troubleshooting

### MCP não aparece
- Verifique se o JSON é válido: `cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq .`
- Reinicie o Claude Desktop completamente
- Verifique logs: `tail -f ~/Library/Logs/Claude/mcp*.log`

### Erro de API Key inválida
- Regenere a API key no serviço
- Verifique se não há espaços extras
- Confirme as permissões da API key

### Puppeteer não funciona
- Primeira execução demora (download do Chrome)
- Aguarde o download completar
- Verifique espaço em disco

---

## MCPs Mais Úteis por Categoria

### Desenvolvimento
- filesystem, git, github, fetch, memory

### Pesquisa/Busca
- brave-search, everything, fetch

### Automação
- puppeteer, sequential-thinking

### Dados
- sqlite, postgres, memory

### Comunicação
- slack

---

*Atualizado em: 2026-01-26 21:23*
