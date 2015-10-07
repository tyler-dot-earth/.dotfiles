set nocompatible " be iMproved
filetype off " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" My Bundles:
" original repos on github
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/emmet-vim'
Plugin 'msanders/snipmate.vim'
Plugin 'vim-scripts/ScrollColors'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'groenewege/vim-less'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/matchit.zip'
Plugin 'othree/html5.vim'
Plugin 'skammer/vim-css-color'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'tomtom/tcomment_vim.git'
Plugin 'digitaltoad/vim-jade'
Plugin 'jamessan/vim-gnupg'
Plugin 'slim-template/vim-slim'
Plugin 'wavded/vim-stylus'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'kien/ctrlp.vim'
Plugin 'brettof86/vim-swigjs'
Plugin 'airblade/vim-gitgutter'
Plugin 'kchmck/vim-coffee-script'
"Plugin 'othree/yajs.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'vim-scripts/AutoComplPop'

" Plugin 'vim-scripts/L9' " Dependency for FuzzyFinder
" Plugin 'vim-scripts/FuzzyFinder'

call vundle#end()

filetype plugin on

filetype plugin indent on     " required!

colorscheme molokai

set expandtab
set tabstop=2
set shiftwidth=2
set nowrap
set autoindent
set relativenumber
set number " in combination with relativenumber, we get 'hybrid mode' that has the current linenumber on your current row position (instead of the default '0')
set cursorline
set cursorline cursorcolumn
set ruler

" No toolbar if in gvim
set guioptions-=T  "remove toolbar
set t_Co=256 " more colors
set visualbell!
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Hack\ 11
  elseif has("gui_macvim")
    set guifont=Hack:h11
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" Disable visual bell
set visualbell!

" GVIM: File name in tab only
set guitablabel=%M%t

" Set <leader> back to default
let mapleader = "\\"

" Set auto complete (default ctrl x ctrl o) to ctrl space
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" No bell for macvim
set vb
set t_vb=

" less css syntax highlighting
syntax on
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.styl set filetype=stylus

" set tpl (bottle template files) to HTML filetype for syntax highlighting
au BufNewFile,BufRead *.tpl set filetype=html

" Stop ^w for removing underscores
"set iskeyword-=_

" Add - for autocompletes and such
set iskeyword+=-

" Special line characters
set list
set listchars=tab:→\ ,eol:\↵

" Start NERDTree on VIM start
"autocmd VimEnter * NERDTree

" Show line numbers in NERDTree
let NERDTreeShowLineNumbers=1

" The following will put the cursor on the code window instead of NERDTree
autocmd VimEnter * wincmd p

" Auto change the directory to the current file I'm working on
autocmd BufEnter * lcd %:p:h

" Make tab character gray
highlight SpecialKey ctermfg=8

" Two-space tabs in particular file types
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType jade setlocal shiftwidth=2 tabstop=2 noexpandtab
autocmd FileType stylus setlocal shiftwidth=2 tabstop=2 noexpandtab

" Multi-file sp
function! Sp(...)
  if(a:0 == 0)
    sp
  else
    let i = a:0
    while(i > 0)
      execute 'let file = a:' . i
      execute 'sp ' . file
      let i = i - 1
    endwhile
  endif
endfunction
com! -nargs=* -complete=file Sp call Sp(<f-args>)
cab sp Sp

" Enable syntax? TODO: investigate necessity.
syntax enable

" Set window transparency
" set transparency=8

" Required for matchit.vim
runtime macros/matchit.vim

" Aliases
"" :Tabnew -> :tabnew
cnoreabbrev <expr> Tabnew ((getcmdtype() is# ':' && getcmdline() is# 'Tabnew')?('tabnew'):('Tabnew'))

" set shell for gitgutter
set shell=/bin/zsh

" Increase gitgutter max sign count
let g:gitgutter_max_signs = 500

" Enable JSX in .js files
let g:jsx_ext_required = 0
