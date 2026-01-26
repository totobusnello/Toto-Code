#!/usr/bin/env python3
"""
Skill Finder - Detecta tipo de projeto e sugere skills/agents apropriados

Uso:
    python skill-finder.py [caminho_do_projeto]
    python skill-finder.py --interactive
    python skill-finder.py --list-all
"""

import os
import sys
import json
import argparse
from pathlib import Path
from typing import Dict, List, Tuple, Optional

# Cores para output
class Colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'

# Mapeamento de arquivos de config para stacks
CONFIG_FILE_MAPPING = {
    'package.json': {'stack': 'Node.js/JavaScript', 'agents': ['javascript-pro', 'typescript-pro']},
    'tsconfig.json': {'stack': 'TypeScript', 'agents': ['typescript-pro']},
    'next.config.js': {'stack': 'Next.js', 'agents': ['nextjs-developer', 'react-specialist']},
    'next.config.mjs': {'stack': 'Next.js', 'agents': ['nextjs-developer', 'react-specialist']},
    'next.config.ts': {'stack': 'Next.js', 'agents': ['nextjs-developer', 'react-specialist']},
    'vite.config.ts': {'stack': 'Vite', 'agents': ['react-specialist', 'frontend-developer']},
    'vite.config.js': {'stack': 'Vite', 'agents': ['react-specialist', 'frontend-developer']},
    'angular.json': {'stack': 'Angular', 'agents': ['angular-architect']},
    'nuxt.config.ts': {'stack': 'Nuxt.js', 'agents': ['vue-expert']},
    'nuxt.config.js': {'stack': 'Nuxt.js', 'agents': ['vue-expert']},
    'requirements.txt': {'stack': 'Python', 'agents': ['python-pro']},
    'pyproject.toml': {'stack': 'Python (modern)', 'agents': ['python-pro']},
    'setup.py': {'stack': 'Python', 'agents': ['python-pro']},
    'Cargo.toml': {'stack': 'Rust', 'agents': ['rust-engineer']},
    'go.mod': {'stack': 'Go', 'agents': ['golang-pro']},
    'pom.xml': {'stack': 'Java/Maven', 'agents': ['java-architect']},
    'build.gradle': {'stack': 'Java/Gradle', 'agents': ['java-architect', 'kotlin-specialist']},
    'build.gradle.kts': {'stack': 'Kotlin/Gradle', 'agents': ['kotlin-specialist']},
    'Gemfile': {'stack': 'Ruby', 'agents': ['rails-expert']},
    'composer.json': {'stack': 'PHP', 'agents': ['php-pro', 'laravel-specialist']},
    'pubspec.yaml': {'stack': 'Flutter/Dart', 'agents': ['flutter-expert']},
    'Dockerfile': {'stack': 'Docker', 'agents': ['devops-engineer', 'kubernetes-specialist']},
    'docker-compose.yml': {'stack': 'Docker Compose', 'agents': ['devops-engineer']},
    'docker-compose.yaml': {'stack': 'Docker Compose', 'agents': ['devops-engineer']},
    '.terraform': {'stack': 'Terraform', 'agents': ['terraform-engineer', 'cloud-architect']},
    'main.tf': {'stack': 'Terraform', 'agents': ['terraform-engineer', 'cloud-architect']},
    'serverless.yml': {'stack': 'Serverless', 'agents': ['cloud-architect', 'devops-engineer']},
    'netlify.toml': {'stack': 'Netlify', 'agents': ['frontend-developer', 'devops-engineer']},
    'vercel.json': {'stack': 'Vercel', 'agents': ['nextjs-developer', 'frontend-developer']},
    '.eslintrc.js': {'stack': 'ESLint', 'agents': ['code-reviewer']},
    '.prettierrc': {'stack': 'Prettier', 'agents': ['code-reviewer']},
    'jest.config.js': {'stack': 'Jest', 'agents': ['qa-expert', 'test-automator']},
    'pytest.ini': {'stack': 'Pytest', 'agents': ['qa-expert', 'python-pro']},
    'cypress.config.js': {'stack': 'Cypress', 'agents': ['qa-expert', 'test-automator']},
    'playwright.config.ts': {'stack': 'Playwright', 'agents': ['qa-expert', 'test-automator']},
}

# Mapeamento de diretórios para tipos de projeto
DIRECTORY_MAPPING = {
    'src/components': {'type': 'Frontend React/Vue', 'agents': ['frontend-developer', 'react-specialist']},
    'src/app': {'type': 'Next.js App Router', 'agents': ['nextjs-developer']},
    'pages': {'type': 'Next.js/Nuxt Pages', 'agents': ['nextjs-developer', 'vue-expert']},
    'api': {'type': 'Backend API', 'agents': ['backend-developer', 'api-designer']},
    'routes': {'type': 'Backend Routes', 'agents': ['backend-developer']},
    'prisma': {'type': 'Prisma ORM', 'agents': ['database-administrator', 'typescript-pro']},
    'migrations': {'type': 'Database Migrations', 'agents': ['database-administrator']},
    'tests': {'type': 'Testing', 'agents': ['qa-expert', 'test-automator']},
    '__tests__': {'type': 'Jest Testing', 'agents': ['qa-expert', 'test-automator']},
    'docs': {'type': 'Documentation', 'agents': ['documentation-engineer', 'technical-writer']},
    'infra': {'type': 'Infrastructure', 'agents': ['cloud-architect', 'terraform-engineer']},
    'infrastructure': {'type': 'Infrastructure', 'agents': ['cloud-architect', 'terraform-engineer']},
    'ml': {'type': 'Machine Learning', 'agents': ['ml-engineer', 'data-scientist']},
    'models': {'type': 'ML Models', 'agents': ['ml-engineer']},
    'notebooks': {'type': 'Data Science', 'agents': ['data-scientist', 'data-analyst']},
    '.github/workflows': {'type': 'GitHub Actions', 'agents': ['devops-engineer']},
    'kubernetes': {'type': 'Kubernetes', 'agents': ['kubernetes-specialist']},
    'k8s': {'type': 'Kubernetes', 'agents': ['kubernetes-specialist']},
    'helm': {'type': 'Helm Charts', 'agents': ['kubernetes-specialist', 'devops-engineer']},
}

# Patterns no código para detectar frameworks
CODE_PATTERNS = {
    'import React': {'framework': 'React', 'agents': ['react-specialist']},
    'from react': {'framework': 'React', 'agents': ['react-specialist']},
    'from fastapi': {'framework': 'FastAPI', 'agents': ['fastapi-expert', 'python-pro']},
    'from django': {'framework': 'Django', 'agents': ['django-developer']},
    'from flask': {'framework': 'Flask', 'agents': ['python-pro', 'backend-developer']},
    '@nestjs/': {'framework': 'NestJS', 'agents': ['nestjs-expert']},
    'import express': {'framework': 'Express.js', 'agents': ['backend-developer']},
    'require("express")': {'framework': 'Express.js', 'agents': ['backend-developer']},
    'import torch': {'framework': 'PyTorch', 'agents': ['ml-engineer']},
    'import tensorflow': {'framework': 'TensorFlow', 'agents': ['ml-engineer']},
    'import pandas': {'framework': 'Pandas', 'agents': ['data-analyst', 'python-pro']},
    'import numpy': {'framework': 'NumPy', 'agents': ['data-scientist', 'python-pro']},
    'import boto3': {'framework': 'AWS SDK', 'agents': ['cloud-architect']},
    '@azure/': {'framework': 'Azure SDK', 'agents': ['azure-infra-engineer']},
    'import openai': {'framework': 'OpenAI', 'agents': ['llm-architect']},
    'from langchain': {'framework': 'LangChain', 'agents': ['llm-architect']},
    'import anthropic': {'framework': 'Anthropic', 'agents': ['llm-architect']},
    'from supabase': {'framework': 'Supabase', 'agents': ['database-administrator', 'backend-developer']},
    'import prisma': {'framework': 'Prisma', 'agents': ['database-administrator']},
    '@prisma/client': {'framework': 'Prisma', 'agents': ['database-administrator']},
    'import vue': {'framework': 'Vue.js', 'agents': ['vue-expert']},
    'from vue': {'framework': 'Vue.js', 'agents': ['vue-expert']},
    'import svelte': {'framework': 'Svelte', 'agents': ['frontend-developer']},
    'import solid': {'framework': 'SolidJS', 'agents': ['frontend-developer']},
}

# Skills recomendadas por tipo de tarefa
TASK_SKILLS = {
    'development': ['python-pro', 'typescript-pro', 'react-best-practices', 'api-designer', 'fastapi-expert'],
    'testing': ['tdd-guide', 'systematic-debugging', 'code-review'],
    'security': ['pentest-checklist', 'burp-suite', 'sqlmap'],
    'documentation': ['technical-writer', 'api-documenter'],
    'devops': ['devops-engineer', 'kubernetes-specialist', 'terraform-engineer'],
    'data': ['excel-analysis', 'database-design', 'data-analyst'],
    'marketing': ['copywriting', 'seo-audit', 'pricing-strategy', 'launch-strategy'],
    'product': ['prd', 'product-manager', 'workflow-orchestrator'],
}


def print_header(text: str):
    """Imprime header formatado"""
    print(f"\n{Colors.BOLD}{Colors.HEADER}{'='*60}{Colors.ENDC}")
    print(f"{Colors.BOLD}{Colors.HEADER}  {text}{Colors.ENDC}")
    print(f"{Colors.BOLD}{Colors.HEADER}{'='*60}{Colors.ENDC}\n")


def print_section(text: str):
    """Imprime seção formatada"""
    print(f"\n{Colors.BOLD}{Colors.CYAN}>> {text}{Colors.ENDC}")
    print(f"{Colors.CYAN}{'-'*40}{Colors.ENDC}")


def print_item(icon: str, text: str, detail: str = ""):
    """Imprime item formatado"""
    if detail:
        print(f"  {icon} {Colors.GREEN}{text}{Colors.ENDC} - {detail}")
    else:
        print(f"  {icon} {Colors.GREEN}{text}{Colors.ENDC}")


def detect_config_files(project_path: Path) -> List[Dict]:
    """Detecta arquivos de configuração no projeto"""
    detected = []
    for config_file, info in CONFIG_FILE_MAPPING.items():
        if (project_path / config_file).exists():
            detected.append({
                'file': config_file,
                'stack': info['stack'],
                'agents': info['agents']
            })
    return detected


def detect_directories(project_path: Path) -> List[Dict]:
    """Detecta estrutura de diretórios"""
    detected = []
    for dir_pattern, info in DIRECTORY_MAPPING.items():
        check_path = project_path / dir_pattern
        if check_path.exists() and check_path.is_dir():
            detected.append({
                'directory': dir_pattern,
                'type': info['type'],
                'agents': info['agents']
            })
    return detected


def detect_code_patterns(project_path: Path, extensions: List[str] = None) -> List[Dict]:
    """Detecta patterns no código fonte"""
    if extensions is None:
        extensions = ['.py', '.js', '.ts', '.tsx', '.jsx', '.vue', '.go', '.rs', '.java', '.kt']

    detected = []
    detected_frameworks = set()

    # Limita a busca para performance
    max_files = 100
    files_checked = 0

    for ext in extensions:
        for file_path in project_path.rglob(f'*{ext}'):
            if files_checked >= max_files:
                break
            if 'node_modules' in str(file_path) or '.git' in str(file_path):
                continue

            try:
                content = file_path.read_text(encoding='utf-8', errors='ignore')[:5000]
                for pattern, info in CODE_PATTERNS.items():
                    if pattern.lower() in content.lower() and info['framework'] not in detected_frameworks:
                        detected.append({
                            'pattern': pattern,
                            'framework': info['framework'],
                            'agents': info['agents'],
                            'file': str(file_path.relative_to(project_path))
                        })
                        detected_frameworks.add(info['framework'])
            except Exception:
                pass
            files_checked += 1

    return detected


def get_all_recommended_agents(detections: Dict) -> List[str]:
    """Consolida todos os agents recomendados"""
    agents = set()

    for item in detections.get('config_files', []):
        agents.update(item['agents'])

    for item in detections.get('directories', []):
        agents.update(item['agents'])

    for item in detections.get('code_patterns', []):
        agents.update(item['agents'])

    return sorted(list(agents))


def analyze_project(project_path: str) -> Dict:
    """Analisa um projeto e retorna detecções"""
    path = Path(project_path).resolve()

    if not path.exists():
        return {'error': f'Caminho não encontrado: {project_path}'}

    if not path.is_dir():
        return {'error': f'Não é um diretório: {project_path}'}

    return {
        'path': str(path),
        'name': path.name,
        'config_files': detect_config_files(path),
        'directories': detect_directories(path),
        'code_patterns': detect_code_patterns(path),
    }


def print_analysis(analysis: Dict):
    """Imprime análise formatada"""
    if 'error' in analysis:
        print(f"{Colors.RED}Erro: {analysis['error']}{Colors.ENDC}")
        return

    print_header(f"Análise do Projeto: {analysis['name']}")
    print(f"  {Colors.YELLOW}Caminho:{Colors.ENDC} {analysis['path']}")

    # Config Files
    if analysis['config_files']:
        print_section("Arquivos de Configuração Detectados")
        for item in analysis['config_files']:
            print_item("📄", item['file'], item['stack'])

    # Directories
    if analysis['directories']:
        print_section("Estrutura de Diretórios")
        for item in analysis['directories']:
            print_item("📁", item['directory'], item['type'])

    # Code Patterns
    if analysis['code_patterns']:
        print_section("Frameworks Detectados no Código")
        for item in analysis['code_patterns']:
            print_item("🔍", item['framework'], f"encontrado em {item['file']}")

    # Recommended Agents
    agents = get_all_recommended_agents(analysis)
    if agents:
        print_section("Agents Recomendados")
        for agent in agents:
            print_item("🤖", agent)

    # Suggested Skills
    print_section("Skills Sugeridas por Tarefa")
    for task, skills in TASK_SKILLS.items():
        print(f"  {Colors.YELLOW}{task.title()}:{Colors.ENDC}")
        for skill in skills[:3]:
            print(f"    - {skill}")

    # Quick Commands
    print_section("Comandos Rápidos")
    print(f"  {Colors.CYAN}Para usar um agent:{Colors.ENDC}")
    if agents:
        print(f'    "Use o agent {agents[0]} para revisar este código"')
    print(f"\n  {Colors.CYAN}Para planejar feature:{Colors.ENDC}")
    print(f'    "Use o workflow-orchestrator para planejar a implementação"')
    print(f"\n  {Colors.CYAN}Para criar PRD:{Colors.ENDC}")
    print(f'    "Crie um PRD para [feature]"  (ativa skill prd automaticamente)')


def interactive_mode():
    """Modo interativo para escolher projeto"""
    print_header("Skill Finder - Modo Interativo")

    print("Opções:")
    print("  1. Analisar diretório atual")
    print("  2. Digitar caminho do projeto")
    print("  3. Listar todas as skills por categoria")
    print("  4. Sair")

    choice = input(f"\n{Colors.YELLOW}Escolha uma opção (1-4):{Colors.ENDC} ").strip()

    if choice == '1':
        analysis = analyze_project('.')
        print_analysis(analysis)
    elif choice == '2':
        path = input(f"{Colors.YELLOW}Digite o caminho do projeto:{Colors.ENDC} ").strip()
        analysis = analyze_project(path)
        print_analysis(analysis)
    elif choice == '3':
        list_all_skills()
    elif choice == '4':
        print("Até logo!")
        sys.exit(0)
    else:
        print(f"{Colors.RED}Opção inválida{Colors.ENDC}")


def list_all_skills():
    """Lista todas as skills por categoria"""
    print_header("Todas as Skills por Categoria")

    for task, skills in TASK_SKILLS.items():
        print_section(task.title())
        for skill in skills:
            print_item("📌", skill)


def export_json(analysis: Dict, output_path: str):
    """Exporta análise em JSON"""
    analysis['recommended_agents'] = get_all_recommended_agents(analysis)
    analysis['task_skills'] = TASK_SKILLS

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(analysis, f, indent=2, ensure_ascii=False)

    print(f"{Colors.GREEN}Análise exportada para: {output_path}{Colors.ENDC}")


def main():
    parser = argparse.ArgumentParser(
        description='Skill Finder - Detecta tipo de projeto e sugere skills/agents',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Exemplos:
  python skill-finder.py                    # Analisa diretório atual
  python skill-finder.py /path/to/project   # Analisa projeto específico
  python skill-finder.py --interactive      # Modo interativo
  python skill-finder.py --list-all         # Lista todas as skills
  python skill-finder.py . --json out.json  # Exporta em JSON
        """
    )

    parser.add_argument('path', nargs='?', default='.', help='Caminho do projeto (padrão: diretório atual)')
    parser.add_argument('--interactive', '-i', action='store_true', help='Modo interativo')
    parser.add_argument('--list-all', '-l', action='store_true', help='Lista todas as skills')
    parser.add_argument('--json', '-j', metavar='FILE', help='Exporta resultado em JSON')
    parser.add_argument('--no-color', action='store_true', help='Desativa cores no output')

    args = parser.parse_args()

    # Desativa cores se solicitado
    if args.no_color:
        for attr in dir(Colors):
            if not attr.startswith('_'):
                setattr(Colors, attr, '')

    if args.interactive:
        interactive_mode()
    elif args.list_all:
        list_all_skills()
    else:
        analysis = analyze_project(args.path)

        if args.json:
            export_json(analysis, args.json)
        else:
            print_analysis(analysis)


if __name__ == '__main__':
    main()
