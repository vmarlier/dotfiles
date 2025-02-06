local M = {}

-- palette from catppuccin-frappe: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/frappe.lua
local palette = {
  surface0 = "#414559",
  bg = "#303446", -- Assuming this is the background color
  fg = "#c6d0f5", -- Assuming this is the foreground color
}

-- Function to blend colors
function M.blend(fg, bg, alpha)
  local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
  end

  local function rgb_to_hex(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
  end

  local r1, g1, b1 = hex_to_rgb(fg)
  local r2, g2, b2 = hex_to_rgb(bg)

  local r = math.floor(r1 * alpha + r2 * (1 - alpha))
  local g = math.floor(g1 * alpha + g2 * (1 - alpha))
  local b = math.floor(b1 * alpha + b2 * (1 - alpha))

  return rgb_to_hex(r, g, b)
end

-- Function to lighten a color
function M.lighten(hex, amount, fg)
  return M.blend(hex, fg or palette.fg, math.abs(amount))
end

-- Function to highlight the current row and add markers every 10 columns
function M.highlight_current_row()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1

  -- Clear previous highlights
  vim.api.nvim_buf_clear_namespace(bufnr, -1, 0, -1)

  -- Add markers every 10 columns
  local marker_color = M.lighten(palette.surface0, 0.9)
  vim.api.nvim_set_hl(0, 'CursorColumn', { bg = marker_color })
  for i = 10, vim.api.nvim_buf_get_option(bufnr, 'textwidth'), 10 do
    vim.api.nvim_buf_add_highlight(bufnr, -1, 'CursorColumn', row, i - 1, i)
  end
end

-- Function to check if the buffer should be highlighted
function M.should_highlight()
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  local win_config = vim.api.nvim_win_get_config(0)

  -- Exclude non-normal buffers (like NvimTree, terminals, etc.)
  if buftype ~= "" then
    return false
  end

  -- Exclude specific filetypes
  local excluded_filetypes = { "NvimTree", "starter", "dashboard"}
  for _, ft in ipairs(excluded_filetypes) do
    if filetype == ft then
      return false
    end
  end

  -- Ensure it's not a floating window
  return win_config.relative == ""
end

-- Create autocommand group
vim.api.nvim_create_augroup('CursorHighlight', { clear = true })
vim.api.nvim_create_autocmd('CursorMoved', {
  group = 'CursorHighlight',
  callback = function()
    if M.should_highlight() then
      M.highlight_current_row()
    end
  end,
})

return M
