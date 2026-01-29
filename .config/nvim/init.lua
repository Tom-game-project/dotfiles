-- 1. プラグインマネージャ (lazy.nvim) の自動インストール設定
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. Leanプラグインの設定
require("lazy").setup({
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      -- インフォビュー（証明状態）の自動表示を有効化
      infoview = { autoopen = true },
      -- デフォルトのキーマッピングを有効化
      mappings = true,
    }
  }
})

-- 3. Lean向けの基本設定 (インデントなど)
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
