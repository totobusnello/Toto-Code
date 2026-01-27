#!/bin/bash
# detect-project.sh - Detecta o tipo de projeto e sugere skills/agents

echo "🔍 Analisando projeto..."
echo ""

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Arrays para skills e agents recomendados
declare -a SKILLS
declare -a AGENTS

# Detectar por arquivos de configuração
detect_by_config() {
    # Node.js / JavaScript
    if [ -f "package.json" ]; then
        echo -e "${GREEN}✓${NC} Node.js/JavaScript detectado"
        SKILLS+=("javascript-pro" "npm-scripts")
        AGENTS+=("javascript-pro" "backend-developer")

        # TypeScript
        if [ -f "tsconfig.json" ]; then
            echo -e "${GREEN}✓${NC} TypeScript detectado"
            SKILLS+=("typescript-pro")
            AGENTS+=("typescript-pro")
        fi

        # Next.js
        if [ -f "next.config.js" ] || [ -f "next.config.mjs" ] || [ -f "next.config.ts" ]; then
            echo -e "${GREEN}✓${NC} Next.js detectado"
            SKILLS+=("nextjs" "react-best-practices")
            AGENTS+=("nextjs-developer" "react-specialist")
        fi

        # React (sem Next)
        if grep -q '"react"' package.json 2>/dev/null && [ ! -f "next.config.js" ]; then
            echo -e "${GREEN}✓${NC} React detectado"
            SKILLS+=("react-best-practices" "frontend-design")
            AGENTS+=("react-specialist" "frontend-developer")
        fi

        # Vue
        if grep -q '"vue"' package.json 2>/dev/null; then
            echo -e "${GREEN}✓${NC} Vue.js detectado"
            AGENTS+=("vue-expert")
        fi

        # Express
        if grep -q '"express"' package.json 2>/dev/null; then
            echo -e "${GREEN}✓${NC} Express.js detectado"
            SKILLS+=("api-designer")
            AGENTS+=("backend-developer" "api-designer")
        fi
    fi

    # Python
    if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
        echo -e "${GREEN}✓${NC} Python detectado"
        SKILLS+=("python-pro")
        AGENTS+=("python-pro")

        # Django
        if [ -f "manage.py" ] || grep -q "django" requirements.txt 2>/dev/null; then
            echo -e "${GREEN}✓${NC} Django detectado"
            AGENTS+=("django-developer")
        fi

        # FastAPI
        if grep -q "fastapi" requirements.txt 2>/dev/null; then
            echo -e "${GREEN}✓${NC} FastAPI detectado"
            SKILLS+=("fastapi")
            AGENTS+=("backend-developer")
        fi

        # Data Science
        if grep -qE "pandas|numpy|scikit|tensorflow|torch" requirements.txt 2>/dev/null; then
            echo -e "${GREEN}✓${NC} Data Science detectado"
            AGENTS+=("data-scientist" "ml-engineer")
        fi
    fi

    # Go
    if [ -f "go.mod" ]; then
        echo -e "${GREEN}✓${NC} Go detectado"
        AGENTS+=("golang-pro")
    fi

    # Rust
    if [ -f "Cargo.toml" ]; then
        echo -e "${GREEN}✓${NC} Rust detectado"
        AGENTS+=("rust-engineer")
    fi

    # Java
    if [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
        echo -e "${GREEN}✓${NC} Java detectado"
        AGENTS+=("java-architect")

        if [ -f "build.gradle.kts" ]; then
            AGENTS+=("kotlin-specialist")
        fi
    fi

    # Ruby
    if [ -f "Gemfile" ]; then
        echo -e "${GREEN}✓${NC} Ruby detectado"
        AGENTS+=("rails-expert")
    fi

    # PHP
    if [ -f "composer.json" ]; then
        echo -e "${GREEN}✓${NC} PHP detectado"
        AGENTS+=("php-pro")

        if grep -q "laravel" composer.json 2>/dev/null; then
            echo -e "${GREEN}✓${NC} Laravel detectado"
            AGENTS+=("laravel-specialist")
        fi
    fi

    # Flutter
    if [ -f "pubspec.yaml" ]; then
        echo -e "${GREEN}✓${NC} Flutter detectado"
        AGENTS+=("flutter-expert")
    fi
}

# Detectar por estrutura de diretórios
detect_by_structure() {
    # Docker
    if [ -f "Dockerfile" ] || [ -f "docker-compose.yml" ]; then
        echo -e "${GREEN}✓${NC} Docker detectado"
        SKILLS+=("docker")
        AGENTS+=("devops-engineer")
    fi

    # Kubernetes
    if [ -d "kubernetes" ] || [ -d "k8s" ] || ls *.yaml 2>/dev/null | grep -q "deployment\|service"; then
        echo -e "${GREEN}✓${NC} Kubernetes detectado"
        AGENTS+=("kubernetes-specialist")
    fi

    # Terraform
    if [ -d "terraform" ] || ls *.tf 2>/dev/null | head -1; then
        echo -e "${GREEN}✓${NC} Terraform detectado"
        AGENTS+=("terraform-engineer" "cloud-architect")
    fi

    # CI/CD
    if [ -d ".github/workflows" ]; then
        echo -e "${GREEN}✓${NC} GitHub Actions detectado"
        AGENTS+=("devops-engineer")
    fi

    if [ -f ".gitlab-ci.yml" ]; then
        echo -e "${GREEN}✓${NC} GitLab CI detectado"
        AGENTS+=("devops-engineer")
    fi

    # Tests
    if [ -d "tests" ] || [ -d "__tests__" ] || [ -d "test" ]; then
        echo -e "${GREEN}✓${NC} Testes detectados"
        SKILLS+=("tdd-guide")
        AGENTS+=("qa-expert" "test-automator")
    fi

    # Docs
    if [ -d "docs" ]; then
        echo -e "${GREEN}✓${NC} Documentação detectada"
        AGENTS+=("documentation-engineer" "technical-writer")
    fi

    # Database
    if [ -d "prisma" ] || [ -d "migrations" ] || [ -d "db" ]; then
        echo -e "${GREEN}✓${NC} Database detectado"
        SKILLS+=("database-design")
        AGENTS+=("database-administrator")
    fi
}

# Detectar Git
detect_git() {
    if [ -d ".git" ]; then
        echo -e "${GREEN}✓${NC} Git detectado"
        SKILLS+=("git-commits" "git-worktree")
        AGENTS+=("git-workflow-manager")
    fi
}

# Executar detecções
detect_by_config
detect_by_structure
detect_git

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Remover duplicatas e mostrar resultados
if [ ${#SKILLS[@]} -gt 0 ]; then
    echo -e "${BLUE}📚 Skills Recomendadas:${NC}"
    printf '%s\n' "${SKILLS[@]}" | sort -u | while read skill; do
        if [ -d "$HOME/.claude/skills/$skill" ]; then
            echo -e "  ${GREEN}✓${NC} $skill (instalada)"
        else
            echo -e "  ${YELLOW}○${NC} $skill"
        fi
    done
    echo ""
fi

if [ ${#AGENTS[@]} -gt 0 ]; then
    echo -e "${BLUE}🤖 Agents Recomendados:${NC}"
    printf '%s\n' "${AGENTS[@]}" | sort -u | while read agent; do
        if [ -d "$HOME/.claude/agents/$agent" ]; then
            echo -e "  ${GREEN}✓${NC} $agent (instalado)"
        else
            echo -e "  ${YELLOW}○${NC} $agent"
        fi
    done
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${BLUE}💡 Dica:${NC} Use agents assim:"
echo '   "Use o agent typescript-pro para revisar este código"'
echo ""
