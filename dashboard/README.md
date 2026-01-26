# Claude Code Dashboard

> Interface visual para navegar skills e agents

## Como Usar

### Abrir no Navegador

```bash
# macOS
open index.html

# Linux
xdg-open index.html

# Windows
start index.html

# Ou com Python
python -m http.server 8000
# Depois acesse http://localhost:8000
```

## Features

### Busca
- Digite para filtrar skills/agents em tempo real
- Busca por nome, descricao e tags

### Abas
- **Skills**: 688 skills disponiveis
- **Agents**: 472 agents especializados
- **Web Skills**: 40 skills otimizadas para claude.ai
- **Workflows**: Fluxos de trabalho pre-configurados

### Categorias
- Development
- Marketing
- Data & ML
- DevOps
- Security
- Testing
- Documentation
- Product

### Modal de Detalhes
- Clique em qualquer card para ver detalhes
- Copie comandos de invocacao diretamente
- Veja tags e exemplos de uso

## Screenshots

```
+--------------------------------------------------+
|  Claude Code Dashboard            [688] [472]    |
|  [Buscar skills ou agents...]                    |
+--------------------------------------------------+
|  [Skills] [Agents] [Web] [Workflows]             |
|                                                  |
|  [Todos] [Dev] [Marketing] [Data] [DevOps]...    |
+--------------------------------------------------+
|  +-------------+  +-------------+  +-------------+
|  | Copywriting |  | Python Pro  |  | React Best  |
|  | Copy de     |  | Python      |  | Practices   |
|  | alta        |  | avancado    |  | com hooks   |
|  | conversao   |  | com best... |  | e patterns  |
|  +-------------+  +-------------+  +-------------+
+--------------------------------------------------+
```

## Tecnologias

- HTML5
- CSS3 (variaveis CSS, Grid, Flexbox)
- JavaScript vanilla
- Sem dependencias externas

## Customizacao

### Alterar Cores

Edite as variaveis CSS no `:root`:

```css
:root {
    --bg-primary: #0d1117;
    --accent: #58a6ff;
    /* ... */
}
```

### Adicionar Skills/Agents

Edite os arrays no JavaScript:

```javascript
const skills = [
    {
        id: 'nova-skill',
        name: 'Nova Skill',
        icon: '📌',
        category: 'development',
        description: 'Descricao...',
        tags: ['tag1', 'tag2'],
        usage: 'Como usar...'
    },
    // ...
];
```

## Contribuindo

1. Adicione novas skills/agents nos arrays JavaScript
2. Mantenha o formato consistente
3. Teste no navegador antes de commitar
