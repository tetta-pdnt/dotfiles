-- Options for LazyVim

-- Set lazyvim.json to a writable location since ~/.config/nvim is read-only in Nix
vim.g.lazyvim_json = vim.fn.stdpath("data") .. "/lazyvim.json"

-- Set dotfiles path for syncing extras
vim.g.dotfiles_path = os.getenv("HOME") .. "/dotfiles"
