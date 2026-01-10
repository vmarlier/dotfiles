-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local M = {}

function M.create_worktree_context()
  local repo_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  -- 2. Ask for the purpose
  local purpose = vim.fn.input("Worktree purpose: ")
  if purpose == "" then return end

  -- 3. Construct the directory name: worktree__repo__purpose
  local worktree_name = "worktree__" .. repo_dir .. "__" .. purpose
  local target_path = "../" .. worktree_name

  -- 4. Execute git command
  local cmd = string.format("git worktree add %s -b %s", target_path, purpose)
  local output = vim.fn.system(cmd)
  print(output)

  -- 5. Optional: Automatically jump to it
  if vim.v.shell_error == 0 then
    vim.cmd("cd " .. target_path)
    vim.notify("Switched to context: " .. purpose)
  end
end

function M.cleanup_all_worktrees()
  local confirm = vim.fn.confirm("Delete ALL worktree contexts?", "&Yes\n&No", 2)
  if confirm ~= 1 then return end

  -- Get all worktrees from git
  local handle = io.popen("git worktree list --porcelain")
  local result = handle:read("*a")
  handle:close()

  for line in result:gmatch("worktree ([^\n]+)") do
    -- Only delete if it matches your specific naming convention
    if line:match("worktree__") then
      print("Removing: " .. line)
      -- 'force' removes worktrees with uncommitted changes
      vim.fn.system("git worktree remove --force " .. line)
    end
  end
  print("Cleanup complete.")

  -- Refresh mini.starter if you are on the dashboard
  if vim.bo.filetype == "ministarter" then
    require('mini.starter').refresh()
  end
end

return M
