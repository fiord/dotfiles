if &compatible
  set nocompatible               " Be iMproved
endif

augroup MyAutoCmd
  autocmd!
augroup END

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
set runtimepath+=~/.vim/
runtime! userautoload/init/*.vim
runtime! userautoload/dein/*.vim

let s:dein_dir = expand('~/.vim/dein')
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
	endif
	execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#load_toml('~/.vim/userautoload/dein/plugins.toml', {'lazy': 0})
	call dein#load_toml('~/.vim/userautoload/dein/lazy.toml', {'lazy': 1})
  " color theme
  " call dein#add('tomasr/molokai')
  call dein#add('felipesousa/rupza')

	call dein#end()
	call dein#save_state()

  " color theme settings
  colorscheme rupza
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

