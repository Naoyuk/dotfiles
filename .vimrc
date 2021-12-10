"----------------------------------------
" 表示設定
"----------------------------------------
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
" カーソル位置の行番号
set number
" 相対行番号を表示
set relativenumber
" カーソルラインを表示
set cursorline
" syntax hilight
set t_Co=256
" syntax on
syntax on
" カラースキーム
colorscheme anderson
" colorscheme twilight
" colorscheme minimalist

"----------------------------------------
" 検索
"----------------------------------------
" 大文字小文字を無視
set ignorecase
" 最後までいったら最初に戻る
set wrapscan
" 検索文字を入力するたびに検索結果を更新する
set incsearch
" マッチした全てをハイライトする
set hlsearch

"----------------------------------------
" その他
"----------------------------------------
" インサートモードの時にバックスペースでdelete
set backspace=2
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
" ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect
" set clipboard+=unnamed
" バッファスクロール
set mouse=a
" ビープ音を消す
set belloff=all
" ファイルを開き直してもアンドゥの履歴が残ってるようにする
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif
" コマンドライン補完
set wildmenu
" swpファイルを作らない
set noswapfile

"----------------------------------------
" ステータスライン
"----------------------------------------
" ステータスライン表示
set laststatus=2
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
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
" <Leader>というプレフィックスキーにスペースを使用する
let g:mapleader = "\<Space>"
" スペース + . でvimrcを開く
nnoremap <Leader>. :new ~/.vimrc<CR>
" Ctrl + j と Ctrl + k で 段落の前後に移動
nnoremap <C-j> }
nnoremap <C-k> {

"----------------------------------------
" Plugin Manager(using vim-plug)
"----------------------------------------
call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
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

"----------------------------------------
" Vim Indent Guides
"----------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"----------------------------------------
" ヘルプ日本語化
"----------------------------------------
set helplang=ja,en
