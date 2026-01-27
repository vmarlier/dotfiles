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
        -- Configuration can be customized here
        -- vault_addr = "https://vault.example.com",
        -- aws_region = "us-east-1",
        -- mount_path = "database/creds",
        -- vault_namespace = nil,
        -- timeout = 30,
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
