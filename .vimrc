set number
syntax on
set smartindent
set cursorline

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

" command Clip call system('wl-copy', @0)
command Clip call system('xclip -selection clipboard', @0)
