"----------------------------------------
" Plugin Manager(using vim-plug)
"----------------------------------------
call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'mattn/emmet-vim'
  Plug 'mattn/learn-vimscript'
  Plug 'nikvdp/ejs-syntax'
  Plug 'vim-python/python-syntax'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'gilgigilgil/anderson.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'haystackandroid/carbonized'
  Plug 'rakr/vim-two-firewatch'
  Plug 'altercation/vim-colors-solarized'
  Plug 'jremmen/vim-ripgrep'
  Plug 'sainnhe/edge'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'thinca/vim-quickrun'
  Plug 'godlygeek/tabular'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'chrisbra/csv.vim'
  Plug 'vim-denops/denops.vim'
  Plug 'lambdalisue/gin.vim'
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
" colorscheme carbonized-light
" colorscheme anderson
" colorscheme solarized
" colorscheme twilight
" colorscheme minimalist
" colorscheme two-firewatch
colorscheme habamax
" colorscheme edge
" set background=dark " or light
" let g:two_firewatch_italics=1
" colo two-firewatch

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
set shiftwidth=4    " インデント幅

"----------------------------------------
" その他
"----------------------------------------
set backspace=2     " インサートモードの時にバックスペースでdelete
set expandtab     " 入力モードでTabキー押下時に半角スペースを挿入
set softtabstop=4     " タブキー押下時に挿入される文字幅を指定
set tabstop=4     " ファイル内にあるタブ文字の表示幅
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
set undolevels=100000     " undoできる最大回数を100000回にする
set wildmenu    " コマンドライン補完
set noswapfile    " swpファイルを作らない
set virtualedit=block     " テキストがないところまで矩形選択できるようにする
set helplang=ja,en    " ヘルプ日本語化
set colorcolumn=80
highlight ColorColumn guibg=#202020 ctermbg=lightgray

"----------------------------------------
" ステータスライン(lightline)
"----------------------------------------
set laststatus=2    " ステータスライン表示
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'LightlineBranch',
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ },
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
nnoremap <Leader>. :tabnew ~/.vimrc<CR>     " スペース + . でvimrc(init.vim)を開く
nnoremap <Leader>se :SaveSession
nnoremap <Leader>lse :FloadSession<CR>
nnoremap <Leader>f :<C-u>Files<CR>
nnoremap <Leader>b :<C-u>Buffers<CR>
nnoremap <Leader>h :<C-u>History<CR>
nnoremap <Leader>r :<C-u>Rg 
nnoremap <Leader>e <Cmd>CocCommand explorer<CR>
nnoremap <Leader>n :tabnew ~/notes_2022.md<CR>
nnoremap <Leader>r :QuickRun<CR><C-w>hG
nnoremap <Leader>m :MarkdownPreview<CR>
nnoremap <Leader>0 :tabnew ~/faq.md<CR>

"----------------------------------------
" Vim Indent Guides
"----------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"----------------------------------------
" セッション
"----------------------------------------
let s:session_path = expand('~/.vim/sessions')

if !isdirectory(s:session_path)
  call mkdir(s:session_path, "p")
endif

" セッションの保存
" ファイル名が同じ場合は上書きされる
command! -nargs=1 SaveSession call s:saveSession(<f-args>)
function! s:saveSession(file)
  execute 'silent mksession!' s:session_path . '/' . a:file
endfunction

" セッションの復元
" :LoadSession ~/.vim/sessions/test1.vim という感じで読み込む
command! FloadSession call fzf#run({
      \  'source':  split(glob(s:session_path, "/*"), "\n"),
      \  'sink':    function('s:loadSession'),
      \  'options': '-m -x +s',
      \  'down':    '40%'})

command! FdeleteSession call fzf#run({
      \  'source':  split(glob(s:session_path . "/*"), "\n"),
      \  'sink':    function('s:deleteSession'),
      \  'options': '-m -x +s',
      \  'down':    '40%'})

"----------------------------------------
" ターミナルモード
"----------------------------------------
if has('nvim')
  " <ESC>でノーマルモードに切り替え
  tnoremap <ESC> <C-\><C-n>
  autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-g>
endif

"----------------------------------------
" Vim Markdown
"----------------------------------------
let g:vim_markdown_toc_autfit = 1
