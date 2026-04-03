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

-- .tpp 拡張子を "cpp" のファイルタイプとしてNeovimに教える
vim.filetype.add({
    extension = {
        tpp = "cpp",
    },
})

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

-- Gleam 用設定 (インデント2)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gleam" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.expandtab = true
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
    -- [1] Coc.nvim
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

    -- [2] Lean.nvim
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
        },
        opts = {
            infoview = { autoopen = true },
            mappings = true,
        }
    },

    -- [3] Nvim-lspconfig (Gleam等)
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("gleam")
        end
    },

    -- [4] ⭐️ 修正済: nvim-treesitter
    -- require() を直接書かず、lazy.nvim の opts に委譲して安全にロードする
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     branch = "master",
    --     build = ":TSUpdate",
    --     -- event = { "BufReadPost", "BufNewFile" }, -- 起動速度を上げるならコメントアウトを外す
    --     main = "nvim-treesitter.configs", -- lazy.nvim が自動的に require("nvim-treesitter.configs").setup(opts) を実行する
    --     opts = {
    --         ensure_installed = { "gleam", "c", "lua", "vim", "vimdoc", "query", "rust", "python", "javascript" }, -- 使用言語を追加しました
    --         highlight = {
    --             enable = true,
    --             additional_vim_regex_highlighting = false,
    --         },
    --     },
    -- },
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- 👇 ❌ 旧: "nvim-treesitter.configs"
    -- 👇 ✅ 新: "nvim-treesitter.config" (末尾の 's' を削除)
    require("nvim-treesitter.config").setup({
      ensure_installed = { "gleam", "c", "lua", "vim", "vimdoc", "query" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
},

    -- [5] gitsigns.nvim
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signcolumn = false,
            numhl = true,
            linehl = false,
            current_line_blame = false,
        }
    },

    -- [6] その他のプラグイン
    "kshenoy/vim-signature",

    {
        "nvim-tree/nvim-web-devicons",
        opts = {}
    },

    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup({ tint = -40, saturation = 0.6 })
        end
    },

    -- [7] カラースキーム
    {
        "owickstrom/vim-colors-paramount",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("unokai")
            
            vim.api.nvim_set_hl(0, "MatchParen", { bold = true, fg = "white", bg = "darkred" })
            vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#222222" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#ffffff", bg = "#111111" })
            vim.api.nvim_set_hl(0, "WinSeparator", { link = "Comment" })
            vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#ffffff" })

            vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = "#26a269" })
            vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = "#61afef" })
            vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = "#e06c75" })

            vim.api.nvim_set_hl(0, "CocInlayHint", { fg = "#016991", bg = "NONE", italic = true })
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

-- ==========================================
-- 6. Lean (Native LSP) 用のキーマッピング同期設定
-- ==========================================
-- Native LSP (lean.nvim) がアタッチされた時だけ、Cocと同じキーバインドを適用する
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- バッファローカルな設定にするためのオプション
        local opts = { buffer = args.buf, silent = true }
        local map = vim.keymap.set

        -- ホバー表示 (<leader>h)
        map("n", "<leader>h", vim.lsp.buf.hover, opts)

        -- 定義ジャンプ (<leader>df)
        map("n", "<leader>df", vim.lsp.buf.definition, opts)

        -- 参照先一覧 (<leader>rf)
        map("n", "<leader>rf", vim.lsp.buf.references, opts)

        -- リネーム (<leader>rn)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- フォーマット (<leader>fmt)
        map("n", "<leader>fmt", vim.lsp.buf.format, opts)

        -- 定義を分割ウィンドウで開く (<leader>dfs / <leader>dfv)
        -- Native LSPには直接の機能がないため、コマンドを組み合わせます
        map("n", "<leader>dfs", function()
            vim.cmd("split")
            vim.lsp.buf.definition()
        end, opts)

        map("n", "<leader>dfv", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
        end, opts)
    end,
})

-- Gleamファイルを開いたときに、自動でTree-sitterを起動する
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gleam",
  callback = function()
    vim.treesitter.start()
  end,
})
