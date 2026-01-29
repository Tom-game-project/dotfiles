-- ==========================================
-- 1. 基本設定 (Options)
-- ==========================================
local opt = vim.opt

-- 【重要】サインカラム（左端のアイコン列）の設定
-- "yes" : 常に表示（無駄なスペース）
-- "auto": アイコンがある時だけ表示（ガタガタする）
-- "number": 行番号の場所にアイコンを重ねる（スペース消費ゼロ！）
opt.signcolumn = "number" 

-- 基本的な表示・動作設定
opt.number = true        -- 行番号
vim.cmd('syntax on')     -- シンタックスハイライト

-- インデント設定 (デフォルトは4スペース)
-- ※言語ごとの個別設定は下部の Autocmd で制御します
opt.expandtab = true     -- タブをスペースに変換
opt.tabstop = 4          -- 画面上のタブ幅
opt.shiftwidth = 4       -- 自動インデント幅
opt.softtabstop = 4      -- タブ/BSキーでの移動幅
opt.smartindent = true   -- スマートインデント

-- 表示系
opt.cursorline = true    -- 現在行をハイライト
opt.hlsearch = true      -- 検索結果をハイライト
opt.incsearch = true     -- インクリメンタルサーチ
opt.ignorecase = true    -- 大文字小文字を無視
opt.smartcase = true     -- 大文字が含まれる場合のみ区別
opt.laststatus = 2       -- ステータスラインを常に表示
opt.termguicolors = true -- True Colorを使用
opt.fillchars = {        -- 区切り線をシンプルに
    vert = "│",
    stl = "─",
    stlnc = "─",
    eob = " ",           -- ファイル末尾のチルダを消す
}

-- フォント設定
opt.guifont = "Droid Sans Mono for Powerline Nerd Font Complete:h12"

-- カーソル設定
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- マップリーダーをスペースに設定
vim.g.mapleader = " "

-- ==========================================
-- 2. 言語ごとの設定 (Autocmd)
-- ==========================================

-- C/C++ 用設定 (インデント2)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        opt.shiftwidth = 2
        opt.softtabstop = 4
        opt.tabstop = 4
        opt.expandtab = true
    end,
})

-- Lean 用設定 (インデント2 + Lean固有設定)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lean" },
    callback = function()
        opt.shiftwidth = 2
        opt.softtabstop = 2
        opt.tabstop = 2
        opt.expandtab = true
        opt.number = true
        -- Leanファイルではキーマッピングの衝突を避けるため、必要ならここで調整可能
    end,
})

-- ==========================================
-- 3. プラグイン管理 (lazy.nvim)
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- [既存] Coc.nvim (C/C++等のLSP & 補完)
    {
        "neoclide/coc.nvim",
        branch = "release",
        config = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "CocNvimInit",
                command = "call webdevicons#refresh()",
            })
        end
    },

    -- [新規] Lean.nvim (Lean4専用設定)
    -- ネイティブLSPを使用するためCocとは独立して動きます
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            -- 'hrsh7th/nvim-cmp', -- ※将来的に補完を強化したい場合はこれが必要になります
        },
        opts = {
            -- インフォビュー（証明状態）の自動表示を有効化
            infoview = { autoopen = true },
            -- デフォルトのキーマッピングを有効化 (<Leader>i でInfoview切替など)
            mappings = true,
        }
    },

    -- [新規] Gitの表示 (gitsigns.nvim)
    -- vim-gitgutter は削除し、こちらに移行しました
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup({
                -- アイコン列（左端の列）は使わない
                signcolumn = false,
                
                -- その代わり、行番号の色を変える
                numhl = true, 
                
                -- 行内に行ハイライトを出したい場合はここをtrue（お好みで）
                linehl = false,
                
                -- 変更箇所のプレビュー設定
                current_line_blame = false, -- 行末に "誰がいつ変更したか" を出す機能（邪魔ならfalse）
            })
        end
    },

    -- [既存] マーカー表示
    "kshenoy/vim-signature",

    -- [既存] アイコン
    "ryanoasis/vim-devicons",

    -- [既存] 非アクティブウィンドウを暗くする
    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup({ tint = -40, saturation = 0.6 })
        end
    },

    -- [既存] カラースキーム
    {
        "owickstrom/vim-colors-paramount",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("paramount")
            
            -- ハイライト微調整
            vim.api.nvim_set_hl(0, "MatchParen", { bold = true, fg = "white", bg = "darkred" })
            vim.api.nvim_set_hl(0, "StatusLine", { link = "Comment" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { link = "Comment" })
            vim.api.nvim_set_hl(0, "WinSeparator", { link = "Comment" })
            vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#ffffff" })

            -- 【ここを追加！】行番号の色を変更するための定義
            -- Add (追加): 緑系, Change (変更): 青系, Delete (削除): 赤系
            vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#26a269", bold = true })
            vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#61afef", bold = true })
            vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#e06c75", bold = true })
        end
    },
})

-- ==========================================
-- 4. WebDevIcons 設定
-- ==========================================
vim.g.WebDevIconsNerdTreeBeforeGlyphPadding = ""
vim.g.WebDevIconsUnicodeDecorateFolderNodes = true

-- ==========================================
-- 5. キーマッピング & Coc設定
-- ==========================================
local keyset = vim.keymap.set
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

-- --- Coc補完設定 ---
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

keyset("i", "<C-j>", 'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"', opts)
keyset("i", "<C-k>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"', opts)

-- --- Coc 汎用キーマップ ---
-- ※ Leanファイルでも有効ですが、Lean側がバッファローカルマップを持っていればそちらが優先されます
keyset("n", "<leader><leader>", ":<C-u>CocList<cr>", { silent = true })
keyset("n", "<leader>h", ":<C-u>call CocAction('doHover')<cr>", { silent = true })
keyset("n", "<leader>df", "<Plug>(coc-definition)", { silent = true })
keyset("n", "<leader>rf", "<Plug>(coc-references)", { silent = true })
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
keyset("n", "<leader>fmt", "<Plug>(coc-format)", { silent = true })
keyset("n", "<leader>dfs", ":sp<CR><Plug>(coc-definition)", { silent = true })
keyset("n", "<leader>dfv", ":vs<CR><Plug>(coc-definition)", { silent = true })

-- ジャンプリスト移動
keyset("n", "<leader>[", "<C-o>", { silent = true })
keyset("n", "<leader>]", "<C-i>", { silent = true })

-- クリップボード
vim.api.nvim_create_user_command('Clip', function()
    vim.fn.system('xclip -selection clipboard', vim.fn.getreg('0'))
end, {})

-- --- Coc Explorer ---
keyset("n", "<leader>e", "<Cmd>CocCommand explorer<CR>", { silent = true })
keyset("n", "<leader>q", "<Cmd>CocCommand explorer<CR>", { silent = true })
keyset("n", "<leader>ed", "<Cmd>CocCommand explorer --preset .vim<CR>", { silent = true })
keyset("n", "<leader>ef", "<Cmd>CocCommand explorer --preset floating<CR>", { silent = true })
keyset("n", "<leader>ec", "<Cmd>CocCommand explorer --preset cocConfig<CR>", { silent = true })
keyset("n", "<leader>eb", "<Cmd>CocCommand explorer --preset buffer<CR>", { silent = true })
keyset("n", "<leader>el", "<Cmd>CocList explPresets<CR>", { silent = true })

-- Explorer Presets
vim.g.coc_explorer_global_presets = {
    [".vim"] = { ["root-uri"] = "~/.vim" },
    cocConfig = { ["root-uri"] = "~/.config/coc" },
    tab = { position = "tab", ["quit-on-open"] = true },
    ["tab:$"] = { position = "tab:$", ["quit-on-open"] = true },
    floating = { position = "floating", ["open-action-strategy"] = "sourceWindow" },
    floatingTop = { position = "floating", ["floating-position"] = "center-top", ["open-action-strategy"] = "sourceWindow" },
    floatingLeftside = { position = "floating", ["floating-position"] = "left-center", ["floating-width"] = 50, ["open-action-strategy"] = "sourceWindow" },
    floatingRightside = { position = "floating", ["floating-position"] = "right-center", ["floating-width"] = 50, ["open-action-strategy"] = "sourceWindow" },
    simplify = { ["file-child-template"] = "[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]" },
    buffer = { sources = { { name = "buffer", expand = true } } },
}
