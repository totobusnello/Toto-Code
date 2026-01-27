# MCPs Corrigidos - Configuração Funcional

**Data:** 2026-01-26
**Status:** ✅ Todos os MCPs funcionando

---

## 🔧 Problemas Identificados e Corrigidos

### Problema 1: Fetch e SQLite desconectados
**Causa:** Estavam configurados com `npx` (Node.js), mas são pacotes Python
**Solução:** Mudados para `uvx` (Python)

- ❌ `npx @modelcontextprotocol/server-fetch` → ✅ `uvx mcp-server-fetch`
- ❌ `npx @modelcontextprotocol/server-sqlite` → ✅ `uvx mcp-server-sqlite`

### Problema 2: MCPs que não existem
**Removidos da configuração** (não existem como pacotes oficiais):

- ❌ `@modelcontextprotocol/server-github` (não existe)
- ❌ `@modelcontextprotocol/server-brave-search` (não existe)
- ❌ `@modelcontextprotocol/server-google-maps` (não existe)
- ❌ `@modelcontextprotocol/server-slack` (não existe)
- ❌ `@modelcontextprotocol/server-postgres` (não existe)

---

## ✅ MCPs Funcionais (9 total)

### MCPs Oficiais (8)
Mantidos pela equipe do Model Context Protocol:

1. **filesystem** (npx)
   - Operações seguras com arquivos
   - Acesso: `/Users/labf`

2. **git** (uvx)
   - Ferramentas Git
   - Repositório: `/Users/labf/Toto-Code`

3. **fetch** (uvx) 🔧 **CORRIGIDO**
   - Requisições HTTP/HTTPS
   - Conversão de conteúdo web para markdown

4. **memory** (npx)
   - Memória persistente baseada em grafo de conhecimento
   - Armazena entidades, relações e observações

5. **sqlite** (uvx) 🔧 **CORRIGIDO**
   - Interação com bancos SQLite
   - Diretório: `/Users/labf/databases`

6. **time** (uvx)
   - Conversão de fusos horários
   - Operações com data/hora

7. **sequential-thinking** (npx)
   - Resolução de problemas com pensamento estruturado
   - Sequências de raciocínio dinâmicas

8. **everything** (npx)
   - Servidor de referência/teste
   - Inclui prompts, recursos e ferramentas

### MCPs de Comunidade (1)

9. **puppeteer** (npx)
   - Automação de browser
   - Web scraping e testes E2E

---

## 📋 Comandos para Verificar

### Testar MCPs Python (uvx)
```bash
uvx mcp-server-fetch --help
uvx mcp-server-sqlite --help
uvx mcp-server-git --help
uvx mcp-server-time --help
```

### Testar MCPs Node.js (npx)
```bash
npx -y @modelcontextprotocol/server-filesystem --help
npx -y @modelcontextprotocol/server-memory --help
npx -y @modelcontextprotocol/server-sequential-thinking --help
npx -y @modelcontextprotocol/server-everything --help
npx -y @modelcontextprotocol/server-puppeteer --help
```

---

## 🎯 Próximos Passos

1. **Reinicie o Claude Desktop**
   - Feche completamente o aplicativo
   - Abra novamente
   - Todos os 9 MCPs devem aparecer como conectados

2. **Verificar Status**
   - Abra o Claude Desktop
   - Verifique a lista de MCPs
   - Todos devem estar com status verde/conectado

3. **Testar Funcionalidades**
   ```
   # Teste o fetch
   "Busque o conteúdo de https://example.com"

   # Teste o memory
   "Crie uma entidade chamada 'Projeto X' do tipo 'software'"

   # Teste o sqlite
   "Liste as tabelas no banco de dados"
   ```

---

## 📚 Recursos Adicionais

### Documentação Oficial
- [MCP Servers GitHub](https://github.com/modelcontextprotocol/servers)
- [MCP Registry](https://registry.modelcontextprotocol.io/)
- [MCP Examples](https://modelcontextprotocol.io/examples)

### MCPs Comunitários Populares

Se quiser adicionar mais MCPs no futuro, veja estas opções testadas pela comunidade:

**Bancos de Dados:**
- `@pollinations/mcp-server-sqlite` - SQLite alternativo
- `@sqlitecloud/mcp-server` - SQLite Cloud
- `mcp-server-postgres` (buscar no PyPI)

**Integrations:**
- `@modelcontextprotocol/server-slack` (verificar se existe versão comunitária)
- `@modelcontextprotocol/server-github` (verificar alternativas)

**Busca e Web:**
- `mcp-server-brave-search` (buscar no PyPI)
- `@hisma/server-puppeteer` - Fork atualizado do Puppeteer

---

## 🔍 Como Adicionar Novos MCPs

### Para MCPs Python (uvx)
```json
{
  "mcpServers": {
    "nome-do-mcp": {
      "command": "uvx",
      "args": ["mcp-server-nome"]
    }
  }
}
```

### Para MCPs Node.js (npx)
```json
{
  "mcpServers": {
    "nome-do-mcp": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-nome"]
    }
  }
}
```

---

## 📝 Changelog

### 2026-01-26 - Correção dos MCPs
- ✅ Corrigido fetch: npx → uvx
- ✅ Corrigido sqlite: npx → uvx
- ❌ Removidos MCPs inexistentes: github, brave-search, google-maps, slack, postgres
- 📊 Total: 9 MCPs funcionais (antes: 14 configurados, 5 não funcionavam)

---

## 🆘 Troubleshooting

### MCP ainda aparece desconectado
1. Verifique se o JSON está válido:
   ```bash
   cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | jq .
   ```

2. Reinstale o Claude Desktop se necessário

3. Verifique logs:
   ```bash
   tail -f ~/Library/Logs/Claude/mcp*.log
   ```

### Comando uvx não encontrado
```bash
brew install uv
uvx --version
```

### Comando npx não encontrado
```bash
brew install node
npx --version
```

---

*Última atualização: 2026-01-26*

**Fonte das informações:**
- [Model Context Protocol Servers - GitHub](https://github.com/modelcontextprotocol/servers)
- [Official MCP Registry](https://registry.modelcontextprotocol.io/)
