# Contributing to Claude-Command-Suite

First off, thank you for considering contributing to Claude-Command-Suite! This repository exists to collect and share useful slash commands for Claude Code, and contributions from the community are what make it great.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Process](#development-process)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Command Development Guidelines](#command-development-guidelines)
- [Release Process](#release-process)

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior vs actual behavior
- Claude Code version and OS information
- Any relevant error messages or logs

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- A clear and descriptive title
- A detailed description of the proposed enhancement
- Examples of how the enhancement would be used
- Any potential drawbacks or considerations

### Contributing New Commands

New commands are always welcome! When creating a new command:

1. Follow the command structure guidelines
2. Test thoroughly with different scenarios
3. Include clear documentation
4. Consider edge cases and error handling
5. Make sure it works across different programming languages where applicable

## Development Process

1. Fork the repository
2. Create a feature branch from `main`
3. Make your changes following our guidelines
4. Test your changes thoroughly
5. Commit using conventional commit messages
6. Push to your fork and submit a pull request

## Commit Message Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear and automated release management.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: A new feature or command (triggers minor version bump)
- **fix**: A bug fix (triggers patch version bump)
- **docs**: Documentation only changes
- **style**: Formatting changes that don't affect functionality
- **refactor**: Code changes that neither fix bugs nor add features
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **chore**: Maintenance tasks, dependency updates
- **ci**: Changes to CI/CD configuration

### Breaking Changes

For breaking changes, add `BREAKING CHANGE:` in the footer or append `!` to the type:

```
feat!: remove support for deprecated command format

BREAKING CHANGE: Commands now require the ## Instructions section
```

### Examples

```bash
# New command
feat(commands): add docker-compose-setup command

# Bug fix
fix(commands): correct file path handling in Windows

# Documentation update
docs: update installation instructions for macOS

# Breaking change
feat(commands)!: change command argument format

BREAKING CHANGE: Arguments now use $ARGS instead of {{args}}
```

## Pull Request Process

1. **Title**: Use a conventional commit format for the PR title
2. **Description**: Fill out the PR template completely
3. **Tests**: Ensure all commands work as expected
4. **Documentation**: Update relevant documentation
5. **Review**: Address reviewer feedback promptly

### PR Checklist

- [ ] I have tested the changes locally
- [ ] I have updated documentation where needed
- [ ] My commits follow the conventional commit format
- [ ] I have added/updated commands to the appropriate category
- [ ] The PR title follows conventional commit format

## Command Development Guidelines

### Command Structure

Every command must follow this structure:

```markdown
# Command Name

Brief description of what the command does.

## Instructions

1. **Step One**
   - Detailed instructions
   - Sub-steps as needed

2. **Step Two**
   - More instructions
   - Include all necessary details

Arguments: $ARGUMENTS (if applicable)
```

### Best Practices

1. **Clarity**: Write clear, step-by-step instructions
2. **Completeness**: Include all necessary steps
3. **Error Handling**: Consider what could go wrong
4. **Cross-platform**: Ensure commands work on different OS/languages
5. **Testing**: Test with various scenarios before submitting

### Categories

Place commands in appropriate categories:
- 🔍 **Analysis**: Code analysis and review commands
- 🛠️ **Development**: Feature development and debugging
- 🚀 **Project Setup**: Project initialization and configuration
- 🧪 **Testing**: Test setup and execution
- 📚 **Documentation**: Documentation generation
- 🔒 **Security**: Security-related commands
- 🐳 **DevOps**: Deployment and operations
- 🗄️ **Database**: Database-related commands
- 🌐 **API**: API development commands
- 🔄 **Maintenance**: Code maintenance and updates
- 🔧 **Utility**: General utility commands
- 📋 **Project Management**: Task and project management

## Release Process

We use automated releases based on conventional commits:

1. **Automatic Version Bumping**:
   - `fix:` commits trigger patch releases (1.0.0 → 1.0.1)
   - `feat:` commits trigger minor releases (1.0.0 → 1.1.0)
   - Breaking changes trigger major releases (1.0.0 → 2.0.0)

2. **Release Workflow**:
   - Merges to `main` trigger the release workflow
   - Version is automatically determined from commits
   - Changelog is updated automatically
   - GitHub Release is created with notes
   - Command bundle is attached to release

3. **Manual Releases**:
   - Maintainers can trigger releases manually if needed
   - Use the "Run workflow" button on the Release action

## Questions?

Feel free to open an issue for any questions about contributing. We're here to help make your contribution process smooth and enjoyable!

Thank you for contributing to Claude-Command-Suite! 🎉