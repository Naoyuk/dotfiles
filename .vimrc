"----------------------------------------
" Plugin Manager(using vim-plug)
"----------------------------------------
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'Shougo/unite.vim'
  Plug 'mattn/emmet-vim'
  Plug 'mattn/learn-vimscript'
  Plug 'nikvdp/ejs-syntax'
  Plug 'vim-python/python-syntax'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'gilgigilgil/anderson.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'haystackandroid/carbonized'
call plug#end()

"----------------------------------------
" 表示設定
"----------------------------------------
if has('vim_starting')
    let &t_SI .= "\e[6 q"     " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_EI .= "\e[2 q"     " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_SR .= "\e[4 q"     " 置換モード時に非点滅の下線タイプのカーソル
endif
set number    " カーソル位置の行番号
set relativenumber    " 相対行番号を表示
set cursorline    " カーソルラインを表示
set termguicolors     " 24ビットカラーを使用する
set t_Co=256    " 色数を256にする
syntax on     " syntax on
" カラースキーム
colorscheme carbonized-light
" colorscheme anderson
" colorscheme twilight
" colorscheme minimalist
" let ayucolor="light"
" colorscheme ayu

"----------------------------------------
" 検索
"----------------------------------------
set ignorecase    " 大文字小文字を無視
set smartcase     " 大文字で検索したら大文字小文字を区別する
set wrapscan    " 最後までいったら最初に戻る
set incsearch     " 検索文字を入力するたびに検索結果を更新する
set hlsearch    " マッチした全てをハイライトする

"----------------------------------------
" インデント
"----------------------------------------
set smartindent     " インデントを考慮して改行
set shiftwidth=2    " インデント幅

"----------------------------------------
" その他
"----------------------------------------
set backspace=2     " インサートモードの時にバックスペースでdelete
set expandtab     " 入力モードでTabキー押下時に半角スペースを挿入
set softtabstop=2     " タブキー押下時に挿入される文字幅を指定
set tabstop=2     " ファイル内にあるタブ文字の表示幅
set showmatch     " 対応する括弧を強調表示
set smartindent     " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set clipboard+=unnamed    " 無名レジスタとクリップボードレジスタを同期させ、ヤンクしたらクリップボードにも入る
set mouse=a     " バッファスクロール
set belloff=all     " ビープ音を消す
" ファイルを開き直してもアンドゥの履歴が残ってるようにする
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif
  let &undodir = undo_path
	set undofile
endif
set undolevels=1000     " undoできる最大回数を1000回にする
set wildmenu    " コマンドライン補完
set noswapfile    " swpファイルを作らない
set virtualedit=block     " テキストがないところまで矩形選択できるようにする
set helplang=ja,en    " ヘルプ日本語化

"----------------------------------------
" ステータスライン
"----------------------------------------
set laststatus=2    " ステータスライン表示
" lightline.vimのカラースキーム
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"----------------------------------------
" キーマップ
"----------------------------------------
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>    " Escの2回押しでハイライト消去
let g:mapleader = "\<Space>"    " <Leader>というプレフィックスキーにスペースを使用する
nnoremap <Leader>. :tabnew ~/.vimrc<CR>     " スペース + . でvimrcを開く
nnoremap <C-j> }    " Ctrl + j で 段落の後に移動
nnoremap <C-k> {    " Ctrl + k で 段落の前に移動
nnoremap H ^    " 行頭への移動
nnoremap L $    " 行末への移動 
nnoremap <C-s>\ :vert term ++close    " ターミナルを垂直で開く
nnoremap <C-s>- :bo term ++close    " ターミナルを水平で開く
nnoremap <C-s>^ :tab term ++close     " ターミナルを新しいタブページで開く

"----------------------------------------
" Unite.vim
"----------------------------------------
let g:unite_enable_start_insert=1     " 入力モードで開始する
noremap <C-P> :Unite buffer<CR>     " バッファ一覧
noremap <C-N> :Unite -buffer-name=file file<CR>     " ファイル一覧
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"----------------------------------------
" Vim Indent Guides
"----------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

