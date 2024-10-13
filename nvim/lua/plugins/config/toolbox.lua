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
      name = "CWD update",
      execute = function()
        vim.cmd("cd %:p:h");
        vim.cmd("pwd");
      end,
      require_input = false,
    },
    {
      name = "Trim trailing whitespaces",
      execute = function()
        require('mini.trailspace').trim()
      end,
      require_input = false,
    },
    {
      name = "Trim trailing lines",
      execute = function()
        require('mini.trailspace').trim_last_lines()
      end,
      require_input = false,
    },
    {
      name = "No Search Highlight",
      execute = function()
        vim.cmd('noh');
      end,
      require_input = false,
    },
    {
      name = "Dashboard",
      execute = function()
        vim.cmd('BufDelAll');
        require('mini.starter').open();
      end,
      require_input = false,
    },
  },
})
