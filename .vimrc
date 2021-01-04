"----------------------------------------
" Search
"----------------------------------------
" ignore upper case or lower case
set ignorecase
" when 'search next' reaches end of file, it wraps around to the beginning
set wrapscan
" enable incremental search
set incsearch
" hilight all search pattern matches
set hlsearch


"----------------------------------------
" 表示設定
"----------------------------------------
" ステータス行を常に表示
set laststatus=2
" 入力モードでTabキー押下時に半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
set tabstop=2
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 行番号を表示
set number
" ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" バッファスクロール
set mouse=a
" syntax on
syntax on
" colour scheme
colorscheme desert

" Plugins(using vim-plug)
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-endwise'
  Plug 'Shougo/unite.vim'
call plug#end()


"----------------------------------------
" NERDTree
"----------------------------------------
nnoremap <silent><C-t> :NERDTreeToggle<CR>


"----------------------------------------
" Unite.vim
"----------------------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
