# Global workstation rules

## Operating principles

Prefer simple, inspectable, filesystem-based workflows.

- Prefer existing local CLI tools over MCP integrations when capabilities are equivalent.
- Prefer narrow queries and filtered output over retrieving large datasets and filtering them afterward.
- Before adding a new agent framework, proxy, MCP server, daemon, or abstraction, check whether existing CLI tools and files can solve the problem.
- Do not add infrastructure or dependencies solely for convenience when the same task can be performed reliably with existing tools.

Optimize for correctness first and token efficiency second.

Keep conversational output concise by default:
- report decisions, findings, errors, and relevant commands;
- avoid narrating routine operations;
- do not repeat information already established;
- preserve full detail when ambiguity, debugging, security, or destructive operations require it.

## Tool installation policy

Never install, upgrade, remove, or modify a system-wide or user-wide tool without my explicit approval.

This includes, but is not limited to:

- `brew install`, `brew upgrade`, `brew uninstall`, or `brew tap`
- `asdf plugin add`, `asdf install`, or changes to `.tool-versions`
- global `npm`, `pnpm`, `yarn`, `pip`, `pipx`, `gem`, `cargo`, or `go install`
- `curl | sh`, downloaded installers, or manually copied binaries
- changes to shell startup files, PATH, package-manager configuration, Claude hooks/settings, or system settings

Before installing or configuring anything:

1. Check whether the tool or an equivalent capability already exists.
2. Explain why the new tool is useful.
3. State the exact tool and installation/configuration method.
4. State which files would be created or modified.
5. Show the proposed configuration changes.
6. Ask for explicit approval.

Approval of a task does not imply approval to install its dependencies.

## Dependency management

After approval:

- Use Homebrew for system utilities, desktop applications, and tools not managed by asdf.
- Record every Homebrew dependency in `~/.config/Brewfile`.
- Prefer `brew bundle --file=~/.config/Brewfile` over an unrecorded `brew install`.
- Use asdf for supported language runtimes.
- Use the repository `.tool-versions` for project-specific runtime versions.
- Use `~/.tool-versions` only when I explicitly request a global/default runtime.
- Never install the same tool through multiple package managers.
- Prefer repository-local language dependencies over global package installations.
- Pin or explicitly select versions when practical.

If no appropriate declarative installation method exists, explain the exception and ask before proceeding.

## Existing configuration

Preserve existing entries, formatting, and comments in:

- `~/.config/Brewfile`
- `~/.tool-versions`
- project `.tool-versions`
- Claude settings and hooks
- shell configuration files

Never overwrite configuration files wholesale unless explicitly requested.

Make the smallest necessary change.

## Tool and context efficiency

When using shell tools:

- request only the information needed for the task;
- prefer `rg`, targeted `find`, `git diff`, `git show`, `jq`, `yq`, selectors, field filtering, and equivalent narrow queries;
- avoid dumping entire logs, repositories, Kubernetes resources, API responses, or large files into context;
- inspect summaries or relevant ranges before requesting complete output;
- preserve raw output when investigating unexpected behavior or when filtering could hide relevant evidence.

If RTK is available, allow it to optimize supported CLI output unless raw output is explicitly required for debugging.

Do not repeatedly read unchanged files. Reuse information already obtained during the current task.

## Code intelligence

When an LSP is available for the current language, use it proactively for:
- symbol definitions
- references
- implementations
- type information
- diagnostics

Prefer LSP semantic queries over textual search when reasoning about code relationships.
Use grep/rg for textual discovery, configuration, strings, comments, or when LSP is unavailable.

## External tools and MCP

Prefer, in order:

1. an existing local CLI or repository tool;
2. a direct, documented API when it is simpler and safer than additional tooling;
3. MCP when it provides useful structured functionality, authentication, remote access, or capabilities unavailable locally.

Do not install or enable an MCP server merely because one exists.

Before introducing a persistent MCP server, consider its context/tool-schema overhead and whether a CLI provides the same functionality.

## Production safety

Treat production and production-like environments as protected.

Never execute a destructive or state-changing production operation solely because the broader task was approved.

For production changes:

- identify the active account, cluster, environment, subscription, or context first;
- distinguish read-only investigation from state-changing operations;
- show the exact state-changing command before execution;
- explain the expected impact;
- require explicit approval for the specific operation.

Examples include:

- `kubectl apply`, `delete`, `patch`, `edit`, `scale`, or rollout-changing operations;
- `helm install`, `upgrade`, `rollback`, or `uninstall`;
- `terraform apply`, `destroy`, or state mutation;
- AWS/GCP/Azure create/update/delete operations;
- database writes or schema changes;
- deployment, release, DNS, IAM, networking, secrets, or production configuration changes.

Do not bypass production safety hooks, wrappers, permission systems, or confirmation mechanisms.

Read-only inspection does not require additional confirmation unless credentials or sensitive data are involved.

## Repository knowledge

Prefer repository-owned documentation over global memory.

When a repository provides `CLAUDE.md`, `AGENTS.md`, `lat.md/`, architecture documentation, runbooks, or other local instructions:

- use them as the authoritative project context;
- retrieve only the relevant sections when possible;
- keep durable project knowledge in the repository rather than expanding this global file.

Do not create new documentation systems unless their long-term value justifies their maintenance cost.

## Verification

After an approved installation or configuration change:

1. verify that the tool works;
2. verify its installed version when applicable;
3. verify the declarative configuration entry;
4. show the relevant diff;
5. report exactly what changed;
6. report any unexpected side effects or remaining manual actions.

@RTK.md
