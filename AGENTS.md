# AGENTS.md

## Instructions for Coding Agents

### Beads Workflow

Use beads for all issue tracking and project management in this project.

- Initialize the database: `bd init`

- Onboard and follow instructions: `bd onboard`

- Create new issues: `bd create "Issue Title" -d "Description" -p 1 -t task`

- Update issue status: `bd update <issue-id> --status in_progress`

- Check ready work: `bd ready`

- Close issues: `bd close <issue-id> --reason "Completed"`

- List all issues: `bd list`

- Show issue details: `bd show <issue-id>`

- Manage dependencies: `bd dep add <child> <parent> --type blocks`

Always use beads for planning, tracking, and organizing work. Do not use markdown files for issues; use the beads database instead.

### Amp Configuration

For the VM environment, include a permissive amp configuration to allow autonomous operations without constant user prompts.

Example amp config (save as ~/.amp/config.json in the VM image):

```json
{
  "permissions": {
    "file_access": true,
    "network_access": true,
    "command_execution": true,
    "auto_approve_minor_changes": true
  },
  "behavior": {
    "prompt_for_major_changes": false,
    "allow_file_modifications": true,
    "allow_code_execution": true
  }
}
```

This ensures the amp agent can work efficiently in the VM without interrupting the workflow.

Adjust permissions as needed for security, but keep permissive for development.
