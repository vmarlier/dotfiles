-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
-- Vault credentials integration for nvim-dbee
return {
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
        -- REQUIRED: Configure your Vault address
        -- Either set VAULT_ADDR environment variable or configure here
        vault_addr = os.getenv("VAULT_ADDR") or "https://vault.example.com",
        
        -- AWS region for authentication
        aws_region = os.getenv("AWS_REGION") or "us-east-1",
        
        -- AWS profile (recommended - uses ~/.aws/credentials)
        -- If set, this takes precedence over explicit credentials
        aws_profile = os.getenv("AWS_PROFILE"),
        
        -- Vault mount path for database credentials
        mount_path = "database/creds",
        
        -- Optional: Vault namespace (for Vault Enterprise)
        vault_namespace = os.getenv("VAULT_NAMESPACE"),
        
        -- Optional: AWS auth role name
        -- Leave empty for automatic role detection
        vault_aws_role = os.getenv("VAULT_AWS_ROLE") or "",
        
        -- Optional: IAM Server ID header (if required by your Vault config)
        vault_iam_server_id = os.getenv("VAULT_IAM_SERVER_ID"),
        
        -- Request timeout in seconds
        timeout = 30,
        
        -- Default database type (postgres, mysql, mongodb, etc.)
        default_db_type = "postgres",
      })
      
      -- Optional: Create keymaps
      vim.keymap.set("n", "<leader>dvp", "<cmd>DbeeVaultPick<cr>", {
        desc = "Pick database role from Vault",
      })
      
      vim.keymap.set("n", "<leader>dvc", "<cmd>DbeeVaultClearToken<cr>", {
        desc = "Clear Vault token",
      })
    end,
  },
}
