"----------------------------------------
" Plugin Manager(using dein.vim)
"----------------------------------------
" インストールディレクトリの設定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimをインストールしているかのチェック。してなければする。
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vimの設定
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " .toml file
    let s:rc_dir = expand('~/.vim')
    if !isdirectory(s:rc_dir)
        call mkdir(s:rc_dir, 'p')
    endif
    let s:toml = s:rc_dir . '/dein.toml'

    " read toml and cache
    call dein#load_toml(s:toml, {'lazy': 0})

    " end settings
    call dein#end()
    call dein#save_state()
endif

" プラグインのインストールチェック
if dein#check_install()
    call dein#install()
endif

" プラグインのアンインストールチェック
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif

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
nnoremap <Leader>. :tabnew ~/.vimrc<CR> :vs<CR><C-w>l :e ~/.vim/dein.toml<CR> :sp<CR><C-w>j :e ~/.vim/dein_lazy.toml<CR><C-w>h " スペース + . でvimrc(init.vim)とdein.tomlとdein_lazy.tomlをウインドウ分割して開く
nnoremap <Leader>se :SaveSession
nnoremap <Leader>lse :FloadSession<CR>

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
