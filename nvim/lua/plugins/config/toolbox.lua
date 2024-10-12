require('toolbox').setup({
  commands = {
    {
      name = "Format Json",
      execute = function()
        vim.cmd("%!jq '.'");
      end,
      require_input = true,
    },
    {
      name = "Trim trailing whitespaces",
      execute = function()
        require('mini.trailspace').trim()
      end,
      require_input = false,
    },
    {
      name = "Trim trailing empty lines",
      execute = function()
        require('mini.trailspace').trim_last_lines()
      end,
      require_input = false,
    },
    {
      name = "Disable search highlights",
      execute = function()
        vim.cmd('noh');
      end,
      require_input = false,
    },
    {
      name = "Go back to Dashboard",
      execute = function()
        vim.cmd('BufDelAll');
        require('mini.starter').open();
      end,
      require_input = false,
    },
  },
})
