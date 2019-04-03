set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set guioptions+=a
set clipboard=unnamed,autoselect
syntax on

set number
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
set ambiwidth=double
nnoremap j gj
nnoremap k gk

set expandtab
set tabstop=2
set shiftwidth=2

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap <silent> jj <ESC>

" neobundle
if has('vim_starting')
  " 初回起動時のみruntimepathにNeoBundleのパスを指定
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " NeoBundleが未インストールならclone
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install NeoBundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" インストールするvimプラグインは以下に記述
" Neobundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Yggdroot/indentLine'
" NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'felipesousa/rupza'
NeoBundle 'w0rp/ale'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'Townk/vim-autoclose'
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
endif
NeoBundleLazy 'mattn/emmet-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['html','js', 'jsx', 'vue', 'xml', 'css', 'scss'],
      \   'commands' : ['<Plug>ZenCodingExpandNormal']
      \ }}
call neobundle#end()

" unite
let g:unite_enable_start_insert = 1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q

" neocomplete, neosnippet
if neobundle#is_installed('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#enable_auto_delimiter = 1
  let g:neocomplete#auto_completion_start_length = 1
  inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

  imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
  imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

" ale
" 保存時のみ実行
let g:ale_lint_on_text_changed = 0
" 表示関係
let g:ale_sign_error = ''
let g:ale_sign_warning =  ''
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
" Ctrl + jで次の指摘、Ctrl + kで前の指摘に移動
nmap <silent><C-j> <Plug>(ale_next_wrap)
nmap <silent><C-k> <Plug>(ale_previous_wrap)

" airline
let g:airline_theme = 'wombat'
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline_section_c = '%t'
let g:airline_section_x = '%{&filetype}'
let g:airline_section_z = '%31:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#defualt#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1

" emmet-vim
let g:user_emmet_complete_tag = 1
let g:user_emmet_settings = {
      \ 'lang' : 'ja',
      \ 'html' : {
      \   'indentation' : '  '
      \ }}

" rupza
colorscheme rupza

" ファイルタイプ別のvimプラグイン/インデントを有効に
filetype plugin indent on

" 未インストールのvimプラグインがあるならインストールするか尋ねる
NeoBundleCheck
