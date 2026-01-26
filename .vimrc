set number
syntax on
" set smartindent
" タブ入力を複数のスペースに置き換える（最重要）
set expandtab

" 画面上でタブ文字が占める幅
set tabstop=4

" 自動インデントでずれる幅
"set shiftwidth=4

if has("autocmd")
    "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
    autocmd FileType cpp setlocal sw=2 sts=4 ts=4 et
    autocmd FileType c setlocal sw=2 sts=4 ts=4 et
endif

" タブキーやバックスペースキーでカーソルが動く幅
" (これを設定すると、スペース4つを1つのタブのように削除・移動できます)
set softtabstop=4

set cursorline
"set cursorcolumn 落ち着かない
set hlsearch
set incsearch
set smartcase
set laststatus=2

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8

" フォルダアイコンを表示
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" 縦区切り線をシンプルに
set fillchars+=vert:│

" 横区切り線をシンプルに
" set statusline=─
set fillchars+=stl:─,stlnc:─

" 区切り線のハイライトを抑え気味に
highlight! link StatusLine Comment
highlight! link StatusLineNC Comment
if has('nvim')
  highlight! link WinSeparator Comment
else
  highlight! link VertSplit Comment
endif


" vimがguibgを見て判断してくれる
" 必ずcolorschemeの前に置く
set termguicolors 

" 個人的に好きなカラースキーム
" colorscheme wildcharm
" colorscheme retrobox
" colorscheme sorbet
" colorscheme habamax
" colorscheme peachpuff
" colorscheme zaibatsu
colorscheme unokai
highlight MatchParen cterm=bold ctermfg=white ctermbg=darkred guifg=#ffffff guibg=#aa42f5 gui=bold

let showmarks_enable = 1
" coc lsp manager

" vim-plug
" https://github.com/junegunn/vim-plug?tab=readme-ov-file
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'airblade/vim-gitgutter'
" https://github.com/kshenoy/vim-signature
Plug 'kshenoy/vim-signature'

" 非アクティブバッファーの色設定
Plug 'levouh/tint.nvim'

" icon
" some settings needed
Plug 'ryanoasis/vim-devicons'
call plug#end()


" autocomplete
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"

" if has('nvim-0.4.0') || has('patch-8.2.0750')
nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
" endif

"ノーマルモードで
"スペース2回でCocList
nmap <silent> <space><space> :<C-u>CocList<cr>
"スペースhでHover
nmap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
"スペースdfでDefinition
nmap <silent> <space>df <Plug>(coc-definition)
"スペースrfでReferences
nmap <silent> <space>rf <Plug>(coc-references)
"スペースrnでRename
nmap <silent> <space>rn <Plug>(coc-rename)
"スペースfmtでFormat
nmap <silent> <space>fmt <Plug>(coc-format)

" definition jump
nmap <silent> <space>dfs :sp<CR><Plug>(coc-definition)
nmap <silent> <space>dfv :vs<CR><Plug>(coc-definition)

nmap <space>e <Cmd>CocCommand explorer<CR>

" エクスプローラを閉じる速度の改善 
nmap <space>q <Cmd>CocCommand explorer<CR>

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Coc explorer Setting
" Use preset argument to open it
nmap <space>ed <Cmd>CocCommand explorer --preset .vim<CR>
nmap <space>ef <Cmd>CocCommand explorer --preset floating<CR>
nmap <space>ec <Cmd>CocCommand explorer --preset cocConfig<CR>
nmap <space>eb <Cmd>CocCommand explorer --preset buffer<CR>

" List all presets
nmap <space>el <Cmd>CocList explPresets<CR>


" 選択範囲を () で囲む
"vnoremap <leader>( :s/\%V\(.*\)/(\1)/<CR>
" 選択範囲を {} で囲む
"ivnoremap <leader>{ :s/\%V\(.*\)/{\1}/<CR>
" 選択範囲を [] で囲む
"vnoremap <leader>[ :s/\%V\(.*\)/[\1]/<CR>

" ジャンプリストを後退する
nnoremap <leader>[ <C-o>
" ジャンプリストを前進する
nnoremap <leader>] <C-i>


" coc.nvim で Tab を補完決定に使う設定
"inoremap <silent><expr> <Tab>
"  \ pumvisible() ? "\<C-n>" :
"  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])<CR>" :
"  \ CheckBackspace() ? "\<Tab>" :
"  \ coc#refresh()
"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" inoremap { {}<LEFT>
" inoremap {<Enter> {}<Left><CR><ESC><S-o>
" inoremap ( ()<LEFT>
" inoremap (<Enter> ()<Left><CR><ESC><S-o>
" inoremap [ []<LEFT>
" inoremap [<Enter> []<Left><CR><ESC><S-o>

" カーソルの設定
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
" highlight Cursor guifg=NONE guibg=#808080 ctermbg=NONE
" hi Cursor guifg=NONE guibg=NONE gui=reverse
hi Cursor guifg=#000000 guibg=#ffffff

" 非アクティブウィンドウ用のハイライトグループを定義
" guibgはGUI用の16進数カラーコード, ctermbgはCUI用の256色コード
" highlight WindowInactive guibg=#00ff00
" ctermbg=235

" ウィンドウイベントに応じてwincolorを設定するautocmd
" augroup DimInactive
"   autocmd!
"   " アクティブになったウィンドウではwincolorをリセット
"   autocmd WinEnter,BufEnter * set wincolor=
"   " 非アクティブになったウィンドウでwincolorを設定
"   autocmd WinLeave,BufLeave * set wincolor=WindowInactive
" augroup END

command Clip call system('xclip -selection clipboard', @0)
