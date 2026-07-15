local M = {}

local function set_iterm_tab_title(title)
  -- OSC 1 = iTerm2 tab title
  io.write(string.format("\027]1;%s\007", title))
  io.flush()
end

function M.update()
  local cwd = vim.fn.getcwd()
  local repo = vim.fn.fnamemodify(cwd, ":t")

  set_iterm_tab_title("(nvim) " .. repo)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ITermTabTitle", { clear = true })

  vim.api.nvim_create_autocmd({
    "VimEnter",
    "DirChanged",
  }, {
    group = group,
    callback = M.update,
  })
end

return M
