# Claude Code Configuration

## Auto-Start Skill

When this session starts, automatically invoke the `/autonomous-dev` skill to enter autonomous development mode.

This enables:
- PRD generation from feature ideas
- Breaking features into small user stories
- Iterative implementation with fresh context per iteration
- Cross-codebase learning via Memory MCP

## Entry Point Detection

On startup, check for existing files to determine which phase to enter:
- No `prd.json` → Start Phase 1 (PRD Generation)
- `prd.json` exists but no markdown PRD → Start Phase 2 (JSON Conversion)
- `prd.json` exists with pending stories → Start Phase 3 (Autonomous Loop)
- All stories `passes: true` → Report completion
