# Global workstation rules

## Tool installation policy

Never install, upgrade, remove, or modify a system-wide or user-wide tool without my explicit approval.

This includes, but is not limited to:

- `brew install`, `brew upgrade`, `brew uninstall`, or `brew tap`
- `asdf plugin add`, `asdf install`, or changes to `.tool-versions`
- global `npm`, `pnpm`, `yarn`, `pip`, `pipx`, `gem`, `cargo`, or `go install`
- `curl | sh`, downloaded installers, or manually copied binaries
- changes to shell startup files, PATH, package-manager configuration, or system settings

Before installing anything:

1. Explain why the tool is required.
2. Check whether it, or an equivalent tool, is already installed.
3. State the exact tool, version, installation method, and files that would change.
4. Ask for explicit approval.
5. Do not treat approval of the overall task as approval to install dependencies.

After approval:

- Use Homebrew for system utilities, desktop applications, and tools not managed by asdf.
- Record every Homebrew dependency in `~/.config/Brewfile`.
- Prefer `brew bundle --file=~/Brewfile` over an unrecorded `brew install`.
- Use asdf for language runtimes and runtime versions supported by asdf.
- Record asdf-managed versions in the appropriate `.tool-versions`:
  - use the repository `.tool-versions` for project-specific runtimes;
  - use `~/.tool-versions` only when I explicitly request a global/default version.
- Do not install the same tool through both Homebrew and asdf.
- Prefer project-local dependencies over global language-package installations.
- Pin or explicitly select versions when practical.
- Show me the proposed Brewfile or `.tool-versions` change before applying it.

If no appropriate declarative installation method exists, explain the exception and ask for approval before proceeding.

## Existing configuration

Preserve existing entries and comments in:

- `~/.config/Brewfile`
- `~/.tool-versions`
- project-level `.tool-versions`

Never overwrite these files wholesale. Make the smallest necessary edit.

## Verification

After an approved installation:

1. Verify the installed version.
2. Confirm that the relevant Brewfile or `.tool-versions` entry exists.
3. Report exactly what was installed and which configuration file changed.
