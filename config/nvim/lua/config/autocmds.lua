-- Autocmds for syncing LazyVim extras to dotfiles

-- Get the dotfiles path from options
local dotfiles_path = vim.g.dotfiles_path or (os.getenv("HOME") .. "/dotfiles")
local extras_file = dotfiles_path .. "/config/nvim/lua/config/extras.lua"
-- lazyvim.json is in a writable location (set in options.lua)
local lazyvim_json = vim.g.lazyvim_json or (vim.fn.stdpath("data") .. "/lazyvim.json")

-- Function to update extras.lua based on lazyvim.json
local function sync_lazy_extras()
  -- Read lazyvim.json
  local file = io.open(lazyvim_json, "r")
  if not file then
    vim.notify("lazyvim.json not found. Enable some extras first in :LazyExtras", vim.log.levels.WARN)
    return
  end

  local content = file:read("*all")
  file:close()

  -- Parse JSON
  local ok, data = pcall(vim.json.decode, content)
  if not ok or not data.extras then
    vim.notify("Failed to parse lazyvim.json", vim.log.levels.ERROR)
    return
  end

  -- Get enabled extras (already have full path in lazyvim.json)
  local extras = {}
  for _, extra in ipairs(data.extras) do
    table.insert(extras, extra)
  end

  -- Sort for consistent ordering
  table.sort(extras)

  -- Generate the new extras.lua content
  local lines = {
    "-- LazyVim extras configuration",
    "-- This file is automatically updated when you enable/disable extras in :LazyExtras",
    "-- After making changes in :LazyExtras, run :SyncLazyExtras to update this file",
    "return {",
  }

  for _, extra in ipairs(extras) do
    table.insert(lines, '  { import = "' .. extra .. '" },')
  end

  table.insert(lines, "}")

  -- Write to file
  local out_file = io.open(extras_file, "w")
  if out_file then
    out_file:write(table.concat(lines, "\n") .. "\n")
    out_file:close()
    vim.notify("✓ Synced " .. #extras .. " LazyVim extras to config/extras.lua", vim.log.levels.INFO)
  else
    vim.notify("Failed to write to " .. extras_file, vim.log.levels.ERROR)
  end
end

-- Create a user command to manually sync
vim.api.nvim_create_user_command("SyncLazyExtras", sync_lazy_extras, {
  desc = "Sync LazyVim extras from lazyvim.json to dotfiles config",
})

-- Watch lazyvim.json for changes and auto-sync
local function setup_auto_sync()
  -- Check if lazyvim.json exists
  if vim.fn.filereadable(lazyvim_json) == 0 then
    return
  end

  -- Watch for changes to lazyvim.json
  local timer = vim.loop.new_timer()
  if timer then
    local last_mtime = vim.fn.getftime(lazyvim_json)
    timer:start(
      2000,
      2000,
      vim.schedule_wrap(function()
        local current_mtime = vim.fn.getftime(lazyvim_json)
        if current_mtime > last_mtime then
          last_mtime = current_mtime
          sync_lazy_extras()
        end
      end)
    )
  end
end

-- Auto-sync after LazyVim loads
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    setup_auto_sync()
  end,
})
