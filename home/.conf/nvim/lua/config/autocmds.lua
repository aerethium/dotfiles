-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
vim.g.autoformat = false
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local transparent_groups = {
      -- Core Editor UI
      "Normal", "NormalNC", "NormalFloat", "SignColumn", "EndOfBuffer", "MsgArea",
      "LineNr", "CursorLineNr", "FoldColumn", "ColorColumn",
      
      -- Windows, Floats & Borders
      "FloatBorder", "FloatTitle", "WinBar", "WinBarNC",
      
      -- Statusline & Tabline / Buffers
      "StatusLine", "StatusLineNC", "TabLine", "TabLineFill", "TabLineSel",
      "BufferLineBackground", "BufferLineBufferSelected", "BufferLineFill",
      
      -- Neo-tree / File Explorer
      "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeWinSeparator", "NeoTreeEndOfBuffer",
      "NeoTreeSignColumn", "NeoTreeCursorLine",
      
      -- Which-Key Popup
      "WhichKey", "WhichKeyFloat", "WhichKeyBorder", "WhichKeyDesc", "WhichKeyGroup", "WhichKeySeparator",
      
      -- Telescope Pickers
      "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal", "TelescopePromptBorder", 
      "TelescopePromptTitle", "TelescopeResultsNormal", "TelescopeResultsBorder", "TelescopeResultsTitle", 
      "TelescopePreviewNormal", "TelescopePreviewBorder", "TelescopePreviewTitle",
      
      -- Snacks.nvim Pickers & Dashboard
      "SnacksNormal", "SnacksBorder", "SnacksPickerNormal", "SnacksPickerBorder", 
      "SnacksPickerList", "SnacksPickerInput", "SnacksPickerTitle",
      "SnacksDashboardHeader", "SnacksDashboardDesc", "SnacksDashboardKey", 
      "SnacksDashboardFooter", "SnacksDashboardIcon", "SnacksDashboardSpecial", "SnacksDashboard",
      
      -- Dashboard-nvim (Older LazyVim default dashboard)
      "DashboardHeader", "DashboardCenter", "DashboardFooter", "DashboardKey", "DashboardDesc", "DashboardIcon",
      
      -- Alpha dashboard (Alternative LazyVim dashboard)
      "AlphaHeader", "AlphaButton", "AlphaFooter",
      
      -- Lazy.nvim & Mason Plugin UIs
      "LazyNormal", "LazyButton", "LazyButtonActive", "MasonNormal",
      
      -- Notifications & Messages (Noice / Notify)
      "NotifyBackground", "NoiceCmdlinePopup", "NoiceCmdlinePopupBorder", "NoicePopupmenu",
    }

    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})
