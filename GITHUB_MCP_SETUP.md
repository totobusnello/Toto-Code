# GitHub MCP - Configuração

**Status:** ✅ Instalado (aguardando token do GitHub)

---

## 📋 O que é o GitHub MCP?

O GitHub MCP permite que o Claude interaja diretamente com o GitHub sem você sair da conversa:

**Funcionalidades:**
- 📖 Ler conteúdo de repositórios
- 🔍 Buscar código e issues
- 📝 Criar e gerenciar issues
- 🔀 Criar e revisar Pull Requests
- 📊 Analisar commits e diffs
- 🏷️ Gerenciar labels e milestones
- 👥 Gerenciar colaboradores

---

## 🔑 Configurar GitHub Token (NECESSÁRIO)

### Passo 1: Criar Personal Access Token

1. Acesse: https://github.com/settings/tokens

2. Clique em **"Generate new token"** → **"Generate new token (classic)"**

3. Configure o token:
   - **Note:** `Claude Desktop MCP`
   - **Expiration:** 90 days (ou No expiration)

4. Selecione os **scopes necessários:**
   ```
   ✅ repo (Full control of private repositories)
      ├─ repo:status
      ├─ repo_deployment
      ├─ public_repo
      └─ repo:invite

   ✅ read:org (Read org and team membership)

   ✅ read:user (Read user profile data)

   ✅ user:email (Access user email addresses)
   ```

5. Clique em **"Generate token"**

6. **COPIE O TOKEN** (você só verá uma vez!)
   - Formato: `ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

### Passo 2: Adicionar Token ao Config

**Opção A: Script Rápido**
```bash
cd ~/Toto-Code
./quick-mcp-config.sh
# Escolha opção 1 (GitHub Token)
# Cole o token quando solicitado
```

**Opção B: Editar Manualmente**
```bash
# Abrir config
open ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Encontre a linha:
"GITHUB_PERSONAL_ACCESS_TOKEN": "<YOUR_GITHUB_TOKEN>"

# Substitua <YOUR_GITHUB_TOKEN> pelo token copiado:
"GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

**Opção C: Usar jq (linha de comando)**
```bash
# Substitua SEU_TOKEN pelo token real
TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

jq --arg token "$TOKEN" \
   '.mcpServers.github.env.GITHUB_PERSONAL_ACCESS_TOKEN = $token' \
   ~/Library/Application\ Support/Claude/claude_desktop_config.json > /tmp/config.json

mv /tmp/config.json ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

### Passo 3: Reiniciar Claude Desktop

1. Feche completamente o Claude Desktop
2. Abra novamente
3. O GitHub MCP deve aparecer como **conectado** ✅

---

## 🎯 Como Usar o GitHub MCP

### Comandos Básicos

**Ver Repositório**
```
"Mostre os arquivos do repositório totobusnello/Toto-Code"
```

**Buscar Código**
```
"Busque por 'MCP' no código do repo totobusnello/Toto-Code"
```

**Listar Issues**
```
"Liste as issues abertas do repo totobusnello/Toto-Code"
```

**Criar Issue**
```
"Crie uma issue no repo totobusnello/Toto-Code:
Título: Melhorar documentação
Descrição: Adicionar exemplos de uso dos MCPs"
```

**Ver Pull Requests**
```
"Mostre os PRs abertos do repo totobusnello/Toto-Code"
```

**Criar Pull Request**
```
"Crie um PR no repo totobusnello/Toto-Code da branch feature/nova-funcao para main"
```

**Analisar Commits**
```
"Mostre os últimos 10 commits do repo totobusnello/Toto-Code"
```

---

## 🔒 Segurança do Token

### Boas Práticas

1. **Nunca compartilhe o token**
   - Não commite em repositórios
   - Não compartilhe em mensagens
   - Não exponha em logs

2. **Use tokens com escopo mínimo**
   - Só adicione permissões que realmente precisa
   - Para apenas ler: só `public_repo` e `read:user`

3. **Defina expiração**
   - Tokens com expiração são mais seguros
   - Renove periodicamente

4. **Revogue tokens antigos**
   - Em https://github.com/settings/tokens
   - Delete tokens não utilizados

### Revogar Token

Se o token for comprometido:

1. Vá em: https://github.com/settings/tokens
2. Encontre o token
3. Clique em **"Delete"**
4. Gere um novo token
5. Atualize a configuração do MCP

---

## 🧪 Testar GitHub MCP

### Teste 1: Verificar Conexão
```
"O GitHub MCP está funcionando?"
```

### Teste 2: Listar Seus Repos
```
"Liste meus repositórios no GitHub"
```

### Teste 3: Ver Repo Específico
```
"Mostre os arquivos principais do repo totobusnello/Toto-Code"
```

### Teste 4: Buscar Código
```
"Busque arquivos .md no repo totobusnello/Toto-Code"
```

---

## 📊 Casos de Uso Avançados

### 1. Revisar Pull Request
```
"Revise o PR #123 do repo totobusnello/Toto-Code e sugira melhorias"
```

### 2. Análise de Código
```
"Analise o arquivo CLAUDE.md do repo totobusnello/Toto-Code e sugira melhorias"
```

### 3. Gerenciar Issues
```
"Feche a issue #45 do repo totobusnello/Toto-Code com comentário 'Resolvido na PR #50'"
```

### 4. Comparar Branches
```
"Compare as branches main e feature/nova do repo totobusnello/Toto-Code"
```

### 5. Estatísticas do Repo
```
"Mostre estatísticas do repo totobusnello/Toto-Code: commits, contributors, linguagens"
```

---

## 🆘 Troubleshooting

### GitHub MCP aparece desconectado

**Causa:** Token inválido ou expirado

**Solução:**
1. Verifique se o token está correto no config
2. Verifique se o token não expirou em https://github.com/settings/tokens
3. Gere um novo token se necessário

### Erro "Bad credentials"

**Causa:** Token incorreto ou sem permissões

**Solução:**
1. Verifique se copiou o token completo (começa com `ghp_`)
2. Verifique os scopes do token
3. Regenere o token com permissões corretas

### Erro "Not found" ao acessar repo privado

**Causa:** Token sem permissão `repo`

**Solução:**
1. Vá em https://github.com/settings/tokens
2. Edite o token
3. Adicione scope `repo` completo
4. Atualize o token no config

### MCP lento

**Causa:** Muitas requisições simultâneas

**Solução:**
- Faça perguntas mais específicas
- Limite escopo das buscas
- Use cache do MCP

---

## 📚 Documentação Adicional

- [GitHub REST API](https://docs.github.com/en/rest)
- [GitHub Personal Access Tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [github-mcp no npm](https://www.npmjs.com/package/github-mcp)

---

## ✅ Checklist de Configuração

- [ ] Token criado em https://github.com/settings/tokens
- [ ] Scopes configurados: `repo`, `read:org`, `read:user`
- [ ] Token copiado (começa com `ghp_`)
- [ ] Token adicionado ao config do Claude Desktop
- [ ] Claude Desktop reiniciado
- [ ] GitHub MCP aparece conectado
- [ ] Teste: "Liste meus repositórios no GitHub"

---

*Última atualização: 2026-01-26*
