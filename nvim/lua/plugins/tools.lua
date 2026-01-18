-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
return {
  -- REST Client Interface for Neovim
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<TAB>r",
      kulala_keymaps_prefix = "<TAB>r",
      urlencode = "skipencoded",
      urlencode_skip = "",
      urlencode_force = "[%[%]%(%)]",
    },
  },
  -- DB client
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install("go")
    end,
    config = function()
      require("dbee").setup( --[[optional config]])
    end,
  }
}
