# LiteLLM proxy for GitHub Copilot and ChatGPT subscriptions

Runs a local [LiteLLM](https://github.com/BerriAI/litellm) proxy that exposes
GitHub Copilot's Claude models through an Anthropic-compatible API, so
Claude Code can be pointed at it instead of api.anthropic.com.

Lives in this **public** dotfiles repo at `litellm/`, symlinked to `~/.litellm`
by `install.sh`.

## Layout

| File                        | Tracked? | Purpose                                                  |
|-----------------------------|----------|-----------------------------------------------------------|
| `docker-compose.yaml`       | yes      | Runs the LiteLLM proxy as a background container under OrbStack |
| `copilot-config.yaml`       | yes      | LiteLLM model list (maps model names to `github_copilot/*`) |
| `litellm-keys.env.example`  | yes      | Template showing the two env vars `litellm-keys.env` needs |
| `litellm-keys.env`          | **no** (gitignored) | `LITELLM_MASTER_KEY` / `LITELLM_SALT_KEY` — local-only proxy auth, generated per machine, never committed (this repo is public) |

`litellm-keys.env` is generated automatically by `install.sh` (random
`uuidgen` values) if it doesn't already exist. To generate/regenerate it by
hand:

```sh
printf 'LITELLM_MASTER_KEY=litellm-%s\n' "$(uuidgen)" > ~/.litellm/litellm-keys.env
printf 'LITELLM_SALT_KEY=litellm-%s\n' "$(uuidgen)" >> ~/.litellm/litellm-keys.env
```

GitHub Copilot device-code auth is cached outside this folder, at
`~/.config/litellm/github_copilot/` (contains `access-token` and
`api-key.json` — real GitHub OAuth credentials). It's bind-mounted into the
container so re-creating the container doesn't require re-authenticating
with Copilot, and it is **never** stored in this repo either — see Backup /
restore below.

## Prerequisites

- [OrbStack](https://orbstack.dev/) installed and running (provides the
  Docker engine — no separate Docker Desktop needed). Installed via
  `brew install --cask orbstack` on this machine (not yet tracked in
  `brew/Brewfile`).
- A GitHub Copilot subscription/seat.

## Running it

Start (or restart) the proxy:

```sh
cd ~/.litellm
docker compose up -d
```

`restart: unless-stopped` in `docker-compose.yaml` means:
- OrbStack starting up (e.g. after a reboot) restarts the container automatically.
- You never need to run `litellm --config ...` in a foreground terminal again.

Check status / logs:

```sh
cd ~/.litellm
docker compose ps
docker compose logs -f
```

Stop it:

```sh
cd ~/.litellm
docker compose down
```

Update the LiteLLM image:

```sh
cd ~/.litellm
docker compose pull
docker compose up -d
```

## Using it from Claude Code

The proxy listens on `http://localhost:4000`. It requires the master key
from `litellm-keys.env` as a bearer token.

```sh
source ~/.litellm/litellm-keys.env
ANTHROPIC_BASE_URL=http://localhost:4000 \
ANTHROPIC_AUTH_TOKEN="$LITELLM_MASTER_KEY" \
ANTHROPIC_MODEL=claude-sonnet-5 \
claude
```

Copilot-backed `ANTHROPIC_MODEL` values in `copilot-config.yaml` are
`claude-sonnet-5` and `claude-opus-5`.

To avoid typing this every time, wrap it in a shell function/alias, e.g. in
`~/.zshrc`:

```sh
claude-copilot() {
  source ~/.litellm/litellm-keys.env
  ANTHROPIC_BASE_URL=http://localhost:4000 \
  ANTHROPIC_AUTH_TOKEN="$LITELLM_MASTER_KEY" \
  ANTHROPIC_MODEL="${ANTHROPIC_MODEL:-claude-sonnet-5}" \
  claude "$@"
}
```

## Auth token, not connectors

Setting `ANTHROPIC_AUTH_TOKEN` (or `ANTHROPIC_API_KEY`) makes Claude Code
treat this as a non-standard auth source, so it disables loading your
organization's claude.ai connectors for that session. This is expected and
only affects sessions launched with those variables set.

## Troubleshooting

**`API Error: 400 No connected db`**
LiteLLM is set up with `LITELLM_MASTER_KEY` for auth but no database.
Requests must present that exact key as a bearer token
(`Authorization: Bearer <LITELLM_MASTER_KEY>`, which is what
`ANTHROPIC_AUTH_TOKEN` above does). If a request presents *some other*
key, LiteLLM falls back to looking it up as a virtual key in its database —
which doesn't exist here — and fails with this error. Fix: make sure
`ANTHROPIC_AUTH_TOKEN`/`ANTHROPIC_API_KEY` is unset or exactly equal to
`LITELLM_MASTER_KEY` when launching `claude`.

**`unknown Copilot-Integration-Id` / `Github_copilotException`**
Don't set `extra_headers` (`Editor-Version`, `Copilot-Integration-Id`) on
the `github_copilot/*` model entries in `copilot-config.yaml`. Newer
LiteLLM versions already send sane default Copilot headers internally;
overriding them from the config produced conflicting/invalid header values
that GitHub's Copilot API rejected. Removing `extra_headers` fixed this.

**Re-authenticating with GitHub Copilot**
If Copilot auth expires, delete the cache and let LiteLLM prompt a new
device-code flow on the next request:

```sh
rm -rf ~/.config/litellm/github_copilot
cd ~/.litellm && docker compose restart
docker compose logs -f   # watch for the device-code login URL
```

## Backup / restore

What's tracked in this (public) repo: `docker-compose.yaml`,
`copilot-config.yaml`, `litellm-keys.env.example`, this README. That's
enough to reproduce the *setup*, but not enough to run it — two things stay
local-only and are never committed:

- `litellm-keys.env` — regenerated automatically by `install.sh` (or by
  hand, see above). Fine to lose; it only gates access to your own local
  proxy.
- `~/.config/litellm/github_copilot/` — your real GitHub Copilot OAuth
  token. Regenerated via device-code login (see below) if lost. **Never**
  commit this anywhere, public or private.

On a fresh machine: `install.sh` clones this repo, symlinks
`~/Git/$USER/dotfiles/litellm` to `~/.litellm`, and generates a fresh
`litellm-keys.env`. Then `cd ~/.litellm && docker compose up -d` and
re-authenticate with Copilot on first request.

## Codex models through your ChatGPT subscription

The same proxy also exposes `gpt-5.3-codex` through LiteLLM's native
`chatgpt/` provider. This uses a ChatGPT browser/device login, separately
from Copilot. No OpenAI API key is required for this route. Model access
and usage remain subject to your ChatGPT plan; the configured model is
a documented example, not a guarantee of availability for every account.

Reference: https://docs.litellm.ai/docs/providers/chatgpt

### First login and smoke test

Prepare a private token directory outside this public repo, then refresh
the proxy image to pick up ChatGPT provider support:

```sh
mkdir -p ~/.config/litellm/chatgpt
chmod 700 ~/.config/litellm/chatgpt
cd ~/.litellm
docker compose pull
docker compose up -d
docker compose logs -f
```

In a second terminal, send a Responses request. The first request triggers
the device login; watch the logs in the first terminal for the verification
URL and code, then complete the login in your browser. If the initial
request times out while you sign in, retry it after login completes.

```sh
source ~/.litellm/litellm-keys.env
curl --no-buffer http://localhost:4000/v1/responses \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-5.3-codex","input":"Reply with OK.","stream":true}'
```

`CHATGPT_TOKEN_DIR` points to the bind-mounted
`~/.config/litellm/chatgpt/` directory. It holds real OAuth credentials,
including refresh tokens: never commit it or share its contents. The mount
is writable so LiteLLM can persist and refresh its own login across
container recreation. It does not mount or modify your Codex CLI login.

### Use Codex CLI through this proxy

If Codex CLI is already installed, add this provider block to
`~/.codex/config.toml` (merge it into existing configuration; do not replace
the entire file):

```toml
[model_providers.litellm]
name = "LiteLLM"
base_url = "http://localhost:4000/v1"
env_key = "LITELLM_MASTER_KEY"
wire_api = "responses"
```

Launch a session with this provider explicitly:

```sh
source ~/.litellm/litellm-keys.env
export LITELLM_MASTER_KEY
codex -c 'model_provider="litellm"' --model gpt-5.3-codex
```

Codex authenticates to the local proxy using your LiteLLM master key.
LiteLLM authenticates upstream using its cached ChatGPT login. Existing
Claude/Copilot launch commands continue to use their existing models.

Reference: https://docs.litellm.ai/docs/proxy/client_setup/codex_cli

If you see a model-access error, select a model available to your account
and update both `model_name` and the `chatgpt/<model>` mapping accordingly.
If authentication fails, check the proxy logs for the device-login flow;
device-code login may need to be enabled in your ChatGPT security settings.
