# SQLite MCP - Correção e Guia de Uso

**Data:** 2026-01-26
**Status:** ✅ Corrigido e funcionando

---

## 🔧 Problema Identificado

### Erro Original
```
sqlite3.OperationalError: unable to open database file
```

### Causa Raiz
O SQLite MCP esperava um **arquivo .db específico**, mas estava configurado com um **diretório**.

```json
❌ ERRADO:
"--db-path", "/Users/labf/databases"

✅ CORRETO:
"--db-path", "/Users/labf/databases/main.db"
```

---

## ✅ Solução Aplicada

### 1. Criado Banco de Dados
```bash
sqlite3 /Users/labf/databases/main.db "CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY, name TEXT);"
```

### 2. Atualizada Configuração
```json
{
  "sqlite": {
    "command": "uvx",
    "args": [
      "mcp-server-sqlite",
      "--db-path",
      "/Users/labf/databases/main.db"
    ]
  }
}
```

---

## 📊 Estrutura do Banco de Dados

### Localização
```
/Users/labf/databases/main.db
```

### Tabelas Existentes
```sql
-- Tabela de teste criada automaticamente
CREATE TABLE test (
    id INTEGER PRIMARY KEY,
    name TEXT
);
```

---

## 🚀 Como Usar o SQLite MCP

### No Claude Desktop

Após reiniciar o Claude Desktop, você pode:

**1. Listar Tabelas**
```
"Mostre todas as tabelas no banco SQLite"
```

**2. Ver Estrutura de Tabela**
```
"Mostre a estrutura da tabela test"
```

**3. Inserir Dados**
```
"Insira um registro na tabela test com name='Exemplo'"
```

**4. Consultar Dados**
```
"Mostre todos os registros da tabela test"
```

**5. Executar SQL Customizado**
```
"Execute: SELECT * FROM test WHERE name LIKE '%exemplo%'"
```

---

## 💡 Casos de Uso

### 1. Desenvolvimento Local
```bash
# Criar banco para testes
sqlite3 ~/databases/dev.db <<EOF
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT UNIQUE,
    email TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email) VALUES
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com');
EOF
```

### 2. Análise de Dados
```bash
# Criar banco com dados de exemplo
sqlite3 ~/databases/analytics.db <<EOF
CREATE TABLE pageviews (
    id INTEGER PRIMARY KEY,
    page TEXT,
    views INTEGER,
    date TEXT
);

INSERT INTO pageviews (page, views, date) VALUES
    ('/home', 1523, '2026-01-26'),
    ('/about', 342, '2026-01-26'),
    ('/contact', 128, '2026-01-26');
EOF
```

### 3. Configuração de Aplicação
```bash
# Criar banco para settings
sqlite3 ~/databases/config.db <<EOF
CREATE TABLE settings (
    key TEXT PRIMARY KEY,
    value TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO settings (key, value) VALUES
    ('theme', 'dark'),
    ('language', 'pt-BR'),
    ('notifications', 'enabled');
EOF
```

---

## 🔄 Trocar de Banco de Dados

Para usar outro banco de dados SQLite:

### Opção 1: Editar Configuração
```bash
# Abrir arquivo de config
open ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Trocar o caminho:
"--db-path", "/Users/labf/databases/outro_banco.db"
```

### Opção 2: Criar Múltiplos MCPs SQLite
```json
{
  "mcpServers": {
    "sqlite-main": {
      "command": "uvx",
      "args": ["mcp-server-sqlite", "--db-path", "/Users/labf/databases/main.db"]
    },
    "sqlite-dev": {
      "command": "uvx",
      "args": ["mcp-server-sqlite", "--db-path", "/Users/labf/databases/dev.db"]
    },
    "sqlite-analytics": {
      "command": "uvx",
      "args": ["mcp-server-sqlite", "--db-path", "/Users/labf/databases/analytics.db"]
    }
  }
}
```

---

## 📂 Gerenciamento de Bancos

### Listar Bancos Existentes
```bash
ls -lh ~/databases/
```

### Criar Novo Banco
```bash
sqlite3 ~/databases/novo_banco.db "SELECT 1;"
```

### Backup de Banco
```bash
cp ~/databases/main.db ~/databases/main.db.backup
```

### Remover Banco
```bash
rm ~/databases/nome_banco.db
```

---

## 🧪 Testar SQLite MCP no Terminal

```bash
# Testar conexão
uvx mcp-server-sqlite --db-path ~/databases/main.db

# Criar banco de teste
sqlite3 ~/databases/test.db <<EOF
CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT,
    price REAL
);

INSERT INTO products (name, price) VALUES
    ('Laptop', 999.99),
    ('Mouse', 29.99),
    ('Keyboard', 79.99);
EOF

# Verificar dados
sqlite3 ~/databases/test.db "SELECT * FROM products;"
```

---

## 🛠️ Ferramentas Úteis

### SQLite Browser (GUI)
```bash
brew install --cask db-browser-for-sqlite
```

### SQLite CLI
```bash
# Já vem instalado no macOS
sqlite3 --version

# Abrir banco interativamente
sqlite3 ~/databases/main.db
```

### Comandos SQLite Úteis
```sql
-- Listar tabelas
.tables

-- Ver schema
.schema table_name

-- Exportar para CSV
.mode csv
.output output.csv
SELECT * FROM table_name;

-- Importar CSV
.mode csv
.import data.csv table_name
```

---

## 📋 Checklist de Verificação

Após configurar o SQLite MCP:

- [ ] Arquivo de banco existe em `/Users/labf/databases/main.db`
- [ ] Configuração aponta para arquivo .db (não diretório)
- [ ] Claude Desktop reiniciado
- [ ] SQLite MCP aparece conectado
- [ ] Teste: "Mostre as tabelas no banco SQLite"

---

## 🆘 Troubleshooting

### Erro: "unable to open database file"
**Solução:** Verifique se o caminho aponta para um arquivo .db, não um diretório
```bash
# Verificar
ls -l ~/databases/main.db

# Se não existir, criar
sqlite3 ~/databases/main.db "SELECT 1;"
```

### Erro: "database is locked"
**Solução:** Outro processo está usando o banco
```bash
# Verificar processos usando o arquivo
lsof ~/databases/main.db

# Fechar SQLite CLI se estiver aberto
```

### Erro: "permission denied"
**Solução:** Ajustar permissões
```bash
chmod 644 ~/databases/main.db
chmod 755 ~/databases/
```

---

## 📚 Recursos

### Documentação
- [SQLite Official Docs](https://www.sqlite.org/docs.html)
- [MCP SQLite Server](https://github.com/modelcontextprotocol/servers/tree/main/src/sqlite)

### Tutoriais SQL
- [SQL Tutorial - W3Schools](https://www.w3schools.com/sql/)
- [SQLite Tutorial](https://www.sqlitetutorial.net/)

---

## 🎯 Próximos Passos

1. **Reinicie o Claude Desktop**
2. Verifique se SQLite MCP está conectado
3. Teste com: "Mostre as tabelas do banco SQLite"
4. Crie seus próprios bancos conforme necessário

---

*Última atualização: 2026-01-26*
