vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- Share the same key mappings with standalone Vim.
local xdg_config_home = vim.env.XDG_CONFIG_HOME
if not xdg_config_home or xdg_config_home == "" then
  xdg_config_home = vim.fn.expand("~/.config")
end
vim.cmd("source " .. vim.fn.fnameescape(xdg_config_home .. "/vim/mappings.vim"))
