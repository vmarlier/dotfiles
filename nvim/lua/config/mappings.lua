-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local wk = require("which-key")

-- Keybindings for Normal Mode with "<space>" for prefix
wk.register({
  ["<space>e"] = { ":NvimTreeToggle<cr>", "File Tree" },
  ["<space>h"] = { "<C-W>h", "Go To Left Window" },
  ["<space>j"] = { "<C-W>j", "Go To Window Below" },
  ["<space>k"] = { "<C-W>k", "Go To Upper Window" },
  ["<space>l"] = { "<C-W>l", "Go To Right Window" },
  ["<space>m"] = { ":messages<cr>", "Show neovim logs output" },
  ["<space>M"] = { ":Mason<cr>", "Open Mason package manager" },
  ["<space>P"] = { ":Lazy<cr>", "Open Lazy plugin manager" },
  ["<space>p"] = {require('toolbox').show_picker, "Show toolbox picker"},

  ["<space>t"] = { name = "Terminal" },
  ["<space>tb"] = { ":ToggleTerm direction=tab<cr>", "Toggle in tab" },
  ["<space>th"] = { ":ToggleTerm direction=horizontal<cr>", "Toggle horizontally" },
})

-- Keybindings for Normal Mode with "<TAB>" for prefix
wk.register({
  ["<TAB>b"] = { ":Telescope buffers<cr>", "Open Buffer Navigator" },
  ["<TAB>p"] = { ":Telescope neoclip<cr>", "Open NVim Clipboard" },
  ["<TAB>r"] = { ":set invrelativenumber<cr>", "Relative Numbering On/Off" },
  ["<TAB>t"] = { ":Telescope<cr>", "Telescope" },

  ["<TAB>c"] = { name = "Copilot" },
  ["<TAB>ce"] = { ":Copilot enable<cr>", "Copilot Enable" },
  ["<TAB>cd"] = { ":Copilot disable<cr>", "Copilot Disable" },
  ["<TAB>ct"] = { ":CopilotChatToggle<cr>", "Toggle Copilot Chat" },
  ["<TAB>cC"] = { ":CopilotChatCommit<cr>", "Write commit message for the change with commitizen convention" },

  ["<TAB>f"] = { name = "Searches" },
  ["<TAB>ff"] = { ":Telescope find_files<cr>", "Find Files" },
  ["<TAB>fl"] = { ":Telescope live_grep_args<cr>", "Live Grep" },
  ["<TAB>fg"] = { ":Telescope git_files<cr>", "Git Files" },

  ["<TAB>g"] = { name = "Git" },
  ["<TAB>gc"] = { ":Telescope git_commits<cr>", "Git Commits" },
  ["<TAB>gs"] = { ":Telescope git_status<cr>", "Git Status" },
  ["<TAB>gb"] = { ":Telescope git_branches<cr>", "Git Branches" },
  ["<TAB>gu"] = { ":GitBlameOpenCommitUrl<cr>", "Open Commit Url" },
  ["<TAB>gf"] = { ":GitBlameOpenFileURL<cr>", "Open File Url" },
  ["<TAB>gd"] = { ":DiffviewOpen<cr>", "Git Diff" },

  ["<TAB>l"] = { name = "LSP" },
  ["<TAB>ll"] = { ":Trouble lsp toggle focus=true<cr>", "Definitions & References" },
  ["<TAB>ls"] = { ":Trouble lsp_document_symbols win.position=right focus=false<cr>", "Symbols" },
  ["<TAB>li"] = { ":Trouble lsp_incoming_calls toggle focus=true<cr>", "Incoming calls" },
  ["<TAB>lo"] = { ":Trouble lsp_outgoing_calls toggle focus=true<cr>", "Outgoing calls" },
  ["<TAB>lt"] = { ":Trouble lsp_type_definitions toggle focus=true<cr>", "Type definitions" },

  ["<TAB>lD"] = { name = "Diagnostics" },
  ["<TAB>lDp"] = { ":Trouble diagnostics toggle focus=true<cr>", "Project Diagnostic" },
  ["<TAB>lDd"] = { ":Trouble diagnostics toggle filter.buf=0 focus=true<cr>", "Buffer diagnostic" },

})

-- Keybindings for Normal Mode with "<leader>" for prefix
wk.register({
  ["<leader>n"] = { ":bnext<cr>", "Next Buffer" },
  ["<leader>b"] = { ":bprevious<cr>", "Previous Buffer" },
  ["<leader>l"] = { ":tabnext<cr>", "Next Tab" },
  ["<leader>k"] = { ":tabprevious<cr>", "Previous Tab" },

  ["<leader>M"] = { ":MarkdownPreviewToggle<cr>", "Preview Markdown File" },

  ["<leader><space>"] = { name = "Buffer/Tab Management" },
  ["<leader><space>d"] = { ":BufDel!<cr>", "Delete Current Buffer" },
  ["<leader><space>c"] = { ":BufDelAll<cr>", "Delete All Buffers" },
  ["<leader><space>o"] = { ":BufDelOthers<cr>", "Delete Other Buffers" },
  ["<leader><space>t"] = { ":tabnew<cr>", "New Tab" },
  ["<leader><space>q"] = { ":tabclose<cr>", "Close Tab" },

  ["<leader>s"] = { name = "Horizontal Split Management" },
  ["<leader>ss"] = { ":split<cr>", "Split Window Horizontally" },
  ["<leader>sj"] = { ":horizontal resize -5<cr>", "Resize -5" },
  ["<leader>sk"] = { ":horizontal resize +5<cr>", "Resize +5" },

  ["<leader>v"] = { name = "Vertical Split Management" },
  ["<leader>vv"] = { ":vsplit<cr>", "Split Window Verticaly" },
  ["<leader>vh"] = { ":vertical resize -5<cr>", "Resize -5" },
  ["<leader>vl"] = { ":vertical resize +5<cr>", "Resize +5" },

})

-- Keybindings for Normal Mode with "z" for prefix -- Mostly folding aptitude
wk.register({
  ["zR"] = { require('ufo').openAllFolds, "Open all folds" },
  ["zM"] = { require('ufo').closeAllFolds, "Close all folds" },
})

-- Keybindings for Visual modes with "<TAB>" for prefix
wk.register({
  ["<TAB>c"] = { name = "Copilot" },
  ["<TAB>cE"] = { ":CopilotChatExplain<cr>", "Explain how it works" },
  ["<TAB>cT"] = { ":CopilotChatTests<cr>", "Briefly explain how selected code works then generate unit tests" },
  ["<TAB>cF"] = { ":CopilotChatFix<cr>", "There is a problem in this code. Rewrite the code to show it with the bug fixed" },
  ["<TAB>cO"] = { ":CopilotChatOptimize<cr>", "Optimize the selected code to improve performance and readablilty" },
  ["<TAB>cD"] = { ":CopilotChatDocs<cr>", "Write documentation for the selected code" },
  ["<TAB>cC"] = { ":CopilotChatCommit<cr>", "Write commit message for the change with commitizen convention" },
}, { mode = "v" })
