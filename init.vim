" Plugins  ------------------------------------------------------------------

"----------------------------------------
" Seatup dein
"----------------------------------------

if (!isdirectory(expand("~/.cache/dein/repos/github.com/Shougo/dein.vim")))
  call system(expand("mkdir -p ~/.cache/dein/repos/github.com/"))
  call system(expand("git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim"))
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

"----------------------------------------
" Load plugins
"----------------------------------------

if &compatible
  set nocompatible
endif

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
  
"----------------------------------------
" Check plugin and install
"----------------------------------------

if dein#check_install()
  call dein#install()
endif

" Settings ------------------------------------------------------------------

"----------------------------------------
" System
"----------------------------------------

set nowritebackup " ファイルを上書きする前にバックアップを作ることを無効化
set nobackup " ファイルを上書きする前にバックアップを作ることを無効化
set noswapfile " スワップファイルを作成しない
set virtualedit=block " vim の矩形選択で文字が無くても右へ進める
set backspace=indent,eol,start " 挿入モードでバックスペースで削除できるようにする
set ambiwidth=double " 全角文字専用の設定
set wildmenu " wildmenuオプションを有効(vimバーからファイルを選択できる)
set helplang=ja,en " :help を日本語化
set clipboard=unnamedplus " ヤンクでクリップボードにコピー

"----------------------------------------
" Search
"----------------------------------------

set ignorecase " 検索するときに大文字小文字を区別しない
set smartcase " 小文字で検索すると大文字と小文字を無視して検索
set wrapscan " 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set incsearch " インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set hlsearch " 検索結果をハイライト表示

"----------------------------------------
" UI
"----------------------------------------

set noerrorbells " エラーメッセージの表示時にビープを鳴らさない
set showmatch matchtime=1 " 対応する括弧やブレースを表示
set cinoptions+=:0 " インデント方法の変更
set cmdheight=2 " メッセージ表示欄を2行確保
set laststatus=2 " ステータス行を常に表示
set showcmd " ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set display=lastline " 省略されずに表示
set history=10000 " コマンドラインの履歴を10000件保存する
set expandtab " 入力モードでTabキー押下時に半角スペースを挿入
set shiftwidth=2 " インデント幅
set softtabstop=2 " タブキー押下時に挿入される文字幅を指定
set tabstop=2 " ファイル内にあるタブ文字の表示幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set showmatch " 対応する括弧を強調表示
set nofoldenable " 検索にマッチした行以外を折りたたむ(フォールドする)機能
set title " タイトルを表示
set number " 行番号の表示
nnoremap <Esc><Esc> :nohlsearch<CR><ESC> " Escの2回押しでハイライト消去
syntax on " シンタックスハイライト
set nrformats= " すべての数を10進数として扱う
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる

" Mapping ------------------------------------------------------------------

let mapleader = "\<Space>"

" 上下に空白行を入れる
imap <S-CR> <End><CR>
imap <C-S-CR> <Up><End><CR>
nnoremap <S-CR> mzo<ESC>`z
nnoremap <C-S-CR> mzO<ESC>`z

" カーソル下の単語をすべてハイライト
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" カーソル下の単語をすべて置換
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" x で消去したとき、レジスタに登録しない
nnoremap x "_x

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" jj でノーマルモードへ
inoremap <silent> jj <ESC>

" 検索した単語を画面中央に持っていく
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"----------------------------------------
" Window
"----------------------------------------

" Spilit window
nnoremap s <Nop>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" Move window
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r

" Move focus
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sw <C-w>w

" Resize
nnoremap s= <C-w>=
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" Close
nnoremap sq :<C-u>q<CR>

"----------------------------------------
" Tab
"----------------------------------------

" New Tab
nnoremap st :<C-u>tabnew<CR>

" Move focus
nnoremap sn gt
nnoremap sp gT

" Close
nnoremap sQ :<C-u>bd<CR>

"----------------------------------------
" Buffer
"----------------------------------------

" Move focus
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>

