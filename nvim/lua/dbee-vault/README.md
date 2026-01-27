# dbee-vault

A Neovim plugin that integrates [nvim-dbee](https://github.com/kndndrj/nvim-dbee) with HashiCorp Vault for dynamic database credential management.

## Features

- 🔐 Retrieve database credentials from HashiCorp Vault
- 🔑 AWS IAM authentication for Vault
- 🎯 Two methods to select database roles:
  - Direct selection using `database-permission` format (e.g., `deimos-admin`, `calypso-read`)
  - Interactive picker using [snacks.nvim](https://github.com/folke/snacks.nvim)
- 🔄 Automatic integration with nvim-dbee
- ⚡ Credential caching with token management

## Requirements

- Neovim >= 0.9.0
- [nvim-dbee](https://github.com/kndndrj/nvim-dbee)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [snacks.nvim](https://github.com/folke/snacks.nvim)
- `curl` with AWS SigV4 support (curl >= 7.75.0)
- AWS credentials configured (via environment variables or AWS credentials file)
- HashiCorp Vault with AWS auth method enabled

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "vmarlier/dbee-vault",
  dir = vim.fn.stdpath("config") .. "/lua/dbee-vault",
  dependencies = {
    "kndndrj/nvim-dbee",
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
  },
  config = function()
    require("dbee-vault").setup({
      vault_addr = "https://vault.example.com",
      aws_region = "us-east-1",
      mount_path = "database/creds",
      vault_namespace = nil, -- Optional: for Vault Enterprise
      timeout = 30,
    })
  end,
}
```

## Configuration

The plugin can be configured using environment variables or the setup function:

### Environment Variables

- `VAULT_ADDR`: Vault server address (e.g., `https://vault.example.com`)
- `VAULT_NAMESPACE`: Vault namespace (for Vault Enterprise)
- `AWS_REGION`: AWS region for authentication (default: `us-east-1`)
- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `AWS_SESSION_TOKEN`: AWS session token (for temporary credentials)

### Setup Options

```lua
require("dbee-vault").setup({
  vault_addr = "https://vault.example.com",  -- Vault server URL
  aws_region = "us-east-1",                   -- AWS region
  mount_path = "database/creds",              -- Vault mount path for DB creds
  vault_namespace = nil,                      -- Optional Vault namespace
  timeout = 30,                                -- Request timeout in seconds
})
```

## Usage

### Commands

The plugin provides the following commands:

#### `:DbeeVaultPick`

Opens an interactive picker to select a database role from Vault.

```vim
:DbeeVaultPick
```

#### `:DbeeVaultUse <role>`

Retrieve credentials for a specific role directly.

```vim
:DbeeVaultUse deimos-admin
:DbeeVaultUse calypso-read
:DbeeVaultUse titan-write
```

Supports tab completion for available roles.

#### `:DbeeVaultDirect <database> <permission>`

Construct role name from database and permission parts.

```vim
:DbeeVaultDirect deimos admin
:DbeeVaultDirect calypso read
:DbeeVaultDirect titan write
```

#### `:DbeeVaultClearToken`

Clear the cached Vault token to force re-authentication.

```vim
:DbeeVaultClearToken
```

### Keymaps

Example keymaps (add to your config):

```lua
vim.keymap.set("n", "<leader>dvp", "<cmd>DbeeVaultPick<cr>", {
  desc = "Pick database role from Vault",
})

vim.keymap.set("n", "<leader>dvc", "<cmd>DbeeVaultClearToken<cr>", {
  desc = "Clear Vault token",
})
```

### Programmatic Usage

```lua
local dbee_vault = require("dbee-vault")

-- Pick role interactively
dbee_vault.ui.pick_role()

-- Use specific role
dbee_vault.ui.use_role("deimos-admin")

-- Use direct format
dbee_vault.ui.use_direct_role("deimos", "admin")

-- List available roles
local roles, err = dbee_vault.vault.list_roles()
if err then
  vim.notify("Error: " .. err, vim.log.levels.ERROR)
else
  vim.print(roles)
end
```

## How It Works

1. **Authentication**: The plugin authenticates with Vault using AWS IAM credentials
   - Uses AWS STS GetCallerIdentity with SigV4 signing
   - Vault validates the signature with AWS to verify identity

2. **Role Selection**: Choose a database role either:
   - Via interactive picker showing all available roles
   - Directly by specifying the role name

3. **Credential Retrieval**: Fetches dynamic credentials from Vault at `database/creds/<role>`

4. **Integration**: Automatically creates/updates a connection in nvim-dbee with the credentials

5. **Token Caching**: Vault tokens are cached to avoid repeated authentication

## Vault Setup

Your Vault server should be configured with:

1. AWS auth method enabled at `/auth/aws`
2. Database secrets engine mounted at `/database`
3. Roles configured at `database/creds/<role-name>`
4. IAM policies allowing your AWS identity to access the roles

Example Vault configuration:

```bash
# Enable AWS auth
vault auth enable aws

# Configure AWS auth
vault write auth/aws/config/client \
  iam_server_id_header_value=vault.example.com

# Create a role
vault write auth/aws/role/dev-role \
  auth_type=iam \
  bound_iam_principal_arn="arn:aws:iam::123456789012:role/MyRole" \
  policies=database-read \
  ttl=1h

# Enable database secrets
vault secrets enable database

# Configure database connection
vault write database/config/my-postgres \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@localhost:5432/mydb"

# Create a database role
vault write database/roles/deimos-admin \
  db_name=my-postgres \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';" \
  default_ttl=1h \
  max_ttl=24h
```

## Troubleshooting

### AWS credentials not found

Ensure your AWS credentials are available via:
- Environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)
- AWS credentials file (`~/.aws/credentials`)
- EC2 instance profile (when running on EC2)

### Vault authentication failed

Check:
- Vault address is correct and accessible
- AWS auth method is enabled in Vault
- Your AWS IAM identity has permission to authenticate
- The IAM server ID header matches your configuration

### curl AWS SigV4 not supported

Update curl to version 7.75.0 or later:
```bash
curl --version
```

## License

MIT

## Contributing

Contributions welcome! This is a personal dotfiles plugin but feel free to suggest improvements.
