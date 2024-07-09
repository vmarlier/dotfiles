-- get_plugins_repository_names return a list of plugins installed by Lazy
local function get_plugins_repository_names()
  local lazy_path = vim.fn.expand("~/.local/share/nvim/lazy/")
  local plugins = {}

  -- Function to read a file
  local function read_file(file_path)
    local file = io.open(file_path, "r")
    if file then
      local content = file:read("*all")
      file:close()
      return content
    end
    return nil
  end

  -- Function to extract repository name from .git/config
  local function extract_repo_name(config_content)
    local repo_name = config_content:match("url = .*/(.+)%.git")
    return repo_name
  end

  -- Iterate through subdirectories in ~/.local/share/nvim/lazy/
  local subdirectories = vim.fn.glob(lazy_path .. "/*", 1, 1)
  for _, entry in ipairs(subdirectories) do
    local plugin_dir = vim.fn.fnamemodify(entry, ":t")
    local config_path = entry .. '/.git/config'
    -- Check if .git/config exists
    if vim.fn.filereadable(config_path) == 1 then
      local config_content = read_file(config_path)
      if config_content then
        local repo_name = extract_repo_name(config_content)
        if repo_name then
          table.insert(plugins, repo_name)
        end
      end
    end
  end

  return plugins
end

-- get_mason_lsp_names return a list of LSP installed by Mason
local function get_mason_lsp_names()
  local mason_path = vim.fn.expand("~/.local/share/nvim/mason/packages/")
  local lsp_names = {}

  -- Get directory names using Neovim's built-in functions
  local directories = vim.fn.readdir(mason_path)

  -- Check if directories were successfully retrieved
  if directories then
    for _, dir_name in ipairs(directories) do
      if vim.fn.isdirectory(mason_path .. dir_name) == 1 then
        table.insert(lsp_names, dir_name)
      end
    end
  else
    print("Failed to retrieve directories from", mason_path)
  end

  return lsp_names
end

-- get_neovim_versions to get Neovim versions installed by different package managers
local function get_neovim_versions()
  local versions = {}

  -- Pip3
  local pip3_version = io.popen("pip3 show neovim 2>&1"):read("*a")
  local pip3_installed = pip3_version:match("Version: (%d+.%d+.%d+)")
  versions["Pip3"] = pip3_installed or "Not Installed"

  -- ASDF
  local asdf_version = io.popen("asdf current neovim 2>&1"):read("*a")
  local asdf_installed = asdf_version:match("(%d+.%d+.%d+)")
  versions["ASDF"] = asdf_installed or "Not Installed"

  -- NPM
  local npm_version = io.popen("npm list -g neovim 2>&1"):read("*a")
  local npm_installed = npm_version:match("neovim@(%d+.%d+.%d+)")
  versions["NPM"] = npm_installed or "Not Installed"

  -- Ruby (gem)
  local gem_version = io.popen("gem list neovim 2>&1"):read("*a")
  local gem_installed = gem_version:match("neovim %((%d+.%d+.%d+)%)")
  versions["Ruby"] = gem_installed or "Not Installed"

  return versions
end

-- generate_directory_tree will generate a filesystem tree
local function generate_directory_tree(dir, indent, tree)
  local files = vim.fn.readdir(dir)
  if not files then
    return
  end

  indent = indent or 0
  tree = tree or {}

  for i, file in ipairs(files) do
    -- Skip hidden files and directories
    if file:sub(1, 1) ~= '.' then
      local path = dir .. '/' .. file
      local is_dir = vim.fn.isdirectory(path) == 1

      if is_dir then
        local prefix = (i < #files) and '├── ' or '└── '
        table.insert(tree, string.rep('│   ', indent) .. prefix .. file)
        generate_directory_tree(path, indent + 1, tree)
      else
        local prefix = (i < #files) and '├── ' or '└── '
        table.insert(tree, string.rep('│   ', indent) .. prefix .. file)
      end
    end
  end

  return tree
end

-- generate README
-- Define function to get plugin names formatted for README
local function get_plugins_for_readme()
  local plugins = get_plugins_repository_names()
  local plugin_table = {}
  for _, plugin in ipairs(plugins) do
    table.insert(plugin_table, "| " .. plugin .. " |")
  end
  return table.concat(plugin_table, "\n")
end

-- Define function to get LSP names formatted for README
local function get_lsps_for_readme()
  local lsp_names = get_mason_lsp_names()
  local lsp_table = {}
  for _, lsp_name in ipairs(lsp_names) do
    table.insert(lsp_table, "| " .. lsp_name .. " |")
  end
  return table.concat(lsp_table, "\n")
end

-- Function to format Neovim versions for README
local function get_versions_for_readme()
  local versions = get_neovim_versions()

  -- Format versions for README table
  local version_table = {}
  for installer, version in pairs(versions) do
    table.insert(version_table, string.format("| Neovim | %s | %s |", installer, version))
  end

  return table.concat(version_table, "\n")
end

-- Function to format directory tree for README
local function format_directory_tree(tree)
  return table.concat(tree, "\n")
end

-- Generate directory tree
local root_dir = vim.fn.expand("~/.config/nvim")
local directory_tree = generate_directory_tree(root_dir)

-- Format directory tree for README
local formatted_tree = format_directory_tree(directory_tree)


-- Generate README content
local readme_content = [[
# NVim configuration

- [Neovim Versions](#neovim-versions)
- [Plugins](#plugins)
- [LSPs](#lsps)
- [Directory Tree](#directory-tree)

## Neovim Versions

| Package | Installer | Version |
|--------|--------|--------|
]] .. get_versions_for_readme() .. [[


## Plugins

| Plugin |
|--------|
]] .. get_plugins_for_readme() .. [[


## LSPs

| LSP |
|--------|
]] .. get_lsps_for_readme() .. [[


## Directory Tree

```lua
]] .. formatted_tree .. [[

```
]]

-- Write README content to file
function Generate_readme()
  local readme_file_path = vim.fn.expand("~/.config/nvim/README.md")
  local readme_file = io.open(readme_file_path, "w")
  if readme_file then
    readme_file:write(readme_content)
    readme_file:close()
    print("README.md generated successfully at " .. readme_file_path)
  else
    print("Failed to write README.md")
  end
end
