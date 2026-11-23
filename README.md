# AI Agent Configuration Templates

Reusable, opinionated instructions and custom agents for VS Code GitHub Copilot. Designed for minimal changes, proportionate testing, and selective, centralized delegation.

## Contents

- `AGENTS.md`: shared engineering philosophy, testing, and stopping rules.
- `instructions/*.instructions.md`: language-specific conventions with `applyTo` patterns.
- `agents/*.agent.md`: Orchestrator, Pragmatic Coder, Focused Debugger, Reviewer.
- `scripts/install.ps1`: one-time, non-overwriting installation into a repository.

## Install (Windows PowerShell)

From the configuration repository:

```powershell
.\scripts\install.ps1 -Target 'C:\Projects\MyApp' -Language typescript
```

For both languages:

```powershell
.\scripts\install.ps1 -Target 'C:\Projects\MyApp' -Language both
```

To select agents:

```powershell
.\scripts\install.ps1 -Target 'C:\Projects\MyApp' -Language python -Agents orchestrator,pragmatic-coder,focused-debugger
```

The installer **skips existing destination files**, installs the remaining files, and reports which were skipped. It never overwrites. Existing files can be reconciled manually. Files are copied, not linked or auto-updated.

## Installed paths

```text
project/
  AGENTS.md
  .github/
    instructions/
      python.instructions.md       # when selected
      typescript.instructions.md   # when selected
    agents/
      orchestrator.agent.md
      pragmatic-coder.agent.md
      focused-debugger.agent.md
      reviewer.agent.md
```

## Usage

1. Open the target repository in VS Code with the **GitHub Copilot** agent harness.
2. Select **Orchestrator** as your working agent. It handles simple tasks itself and delegates focused work to the specialists when warranted.
3. In Copilot Chat, verify that subagent invocation is available/enabled (the `agent` / `runSubagent` capability, depending on the interface).
4. Check **Chat: Open Customizations** to confirm the installed agents and instructions are discovered.
5. Add project-specific instructions only as needed. Avoid duplicating or contradicting `AGENTS.md`.

The Orchestrator has the `agent` tool and is instructed to delegate only to the three named specialists; this is **not** an enforced allowlist in the GitHub Copilot harness. Specialists do not delegate further. The shared effort budget (three delegations per request, two meaningful attempts per failure, focused validation) is behavioral guidance, not a guaranteed runtime limit.

Documentation:

- https://code.visualstudio.com/docs/agent-customization/custom-agents
- https://code.visualstudio.com/docs/agents/run/subagents
- https://code.visualstudio.com/docs/agents/reference/custom-instructions-reference
