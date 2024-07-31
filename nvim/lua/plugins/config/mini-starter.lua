------------------
-- Mini Starter --
------------------
local starter = require('mini.starter')

local function generate_repositories_items(base_path)
  local items = {}
  local handle = io.popen('ls -d ' .. base_path .. '/*/')
  if handle then
    for dir in handle:lines() do
      -- Remove the trailing slash if it exists
      local trimmed_dir = dir:gsub("/$", "")
      -- Extract the repository name from the full path
      local repo_name = trimmed_dir:match("([^/]+)$")
      if repo_name then
        local item_name = string.format("%s", repo_name)
        local item_action = string.format(":lua vim.cmd('cd %s'); MiniStarter.refresh(); vim.cmd('NvimTreeToggle')",
          trimmed_dir)
        table.insert(items, { name = item_name, action = item_action, section = 'Pleo' })
      end
    end
    handle:close()
  end
  return items
end

local pleo_repo = generate_repositories_items("~/Git/pleo")

starter.setup({
  evaluate_single = true,
  items = {
    { name = "Dotfiles", action = ":lua vim.cmd('cd ~/Git/valentin.marlier/dotfiles'); MiniStarter.refresh(); vim.cmd('NvimTreeToggle')", section = 'Perso' },
    pleo_repo,
    starter.sections.recent_files(5, true),
    starter.sections.builtin_actions(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning('center', 'center'),
  },
})
