"""""""""""""""""""""""""""""""""""""
""""""""PLUGIN SETUP SECTION"""""""""
"""""""""""""""""""""""""""""""""""""

" Automatically install Plug if Vim starts without it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Directory for plugins.
" > avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" NERDTree: file browser sidebar. Just type execute `:NERDTree`
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " On-demand loading

" Comment stuff out. Just execute `gcc` (or `gc` + motion).
Plug 'tpope/vim-commentary'

" Work with variants of words,
" like: `:%Subvert/facilit{y,ies}/building{,s}/g`
Plug 'tpope/vim-abolish'

" Git in vim.
Plug 'tpope/vim-fugitive'

" Navigate files by filename, just execute `CTRL-P`
" Plug 'ctrlpvim/ctrlp.vim'

" Theme 'Oceanic Next'
Plug 'mhartington/oceanic-next'

" Shows whether a line has been modified (per VCS like git)
Plug 'mhinz/vim-signify'

" Navigate files fuzzily with fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Icons in NERDTree
Plug 'ryanoasis/vim-devicons' " Needs to happen after nerdtree stuff.

" Javascript syntax stuff
Plug 'pangloss/vim-javascript'

" JSX syntax stuff
Plug 'mxw/vim-jsx'

" Multiple cursors! Highlight a word, hit CTRL N to highlight/modify multiple words.
Plug 'terryma/vim-multiple-cursors'

" Code completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

" Indent guides (bars representing indentations, kinda like cursorline but for
" all whitespace)
Plug 'nathanaelkane/vim-indent-guides', { 'on':  'IndentGuidesToggle' } " On-demand loading

" Visualize undos from vim's undo branches via :UndotreeToggle
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" Emmet for vim. Turn css selectors into longform HTML via CTRL-Y.
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""
"""""""""""MISC SETTINGS"""""""""""""
"""""""""""""""""""""""""""""""""""""

set autoindent " Minimal automatic indenting for any filetype.
set backspace=indent,eol,start " Proper backspace behavior.
set hidden " Possibility to have more than one unsaved buffers.
set incsearch " Incremental search, hit '<CR>' to stop.
set ruler " Shows the current line number at the bottom right of the screen.
set wildmenu " Great command-line completion, use '<Tab>' to move around and '<CR>' to validate.
set relativenumber " Relative line numbers on left.
set number " in combination with relativenumber, we get 'hybrid mode' that has the current linenumber on your current row position (instead of the default '0')
set cursorline " Highlight current row
set cursorline cursorcolumn " Highlight current column
set nowrap " Don't line wrap
set foldmethod=indent " When folding, base it on line indentation
set noexpandtab " Don't turn tabs to space
set tabstop=2 " how many columns a tab counts for
set shiftwidth=2 " how many columns text is indented with the reindent operations
set scrolloff=2 " Always keep N number of lines from edge
set conceallevel=3 " Special characters use this to conceal multiple characters (i.e. ==> to arrow)

" Enabling filetype support provides filetype-specific indenting, syntax
" highlighting, omni-completion and other useful settings.
filetype plugin indent on
syntax on

" 'matchit.vim' is built-in so let's enable it!
" Hit '%' on 'if' to jump to 'else'.
runtime macros/matchit.vim

" General colorscheme (theme)
colorscheme OceanicNext

" Options for 'GUI Vim'
if has("gui_running")
  set guioptions-=T  " Remove toolbar
  set visualbell! " No visual bell (flash)
  set guifont=Fira\ Code\ Nerd\ Font\ Medium\ 12
endif

" Hide stuff from Ctrl P
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/dist/*,*/node_modules/*,*/bower_components/*,*/dist_server/*

" Special line characters
set list
set listchars=tab:→·,eol:↵,trail:·,precedes:←,extends:→
set showbreak=↪\

" Auto change the directory to the current file I'm working on
autocmd BufEnter * lcd %:p:h

" Allow mouse use in vim (💀)
if has('mouse')
  set mouse=a
endif

"""""""""""""""""""""""""""""""""""""
"""""""""""""""ALIASES"""""""""""""""
"""""""""""""""""""""""""""""""""""""

" :Tabnew -> :tabnew
cnoreabbrev <expr> Tabnew ((getcmdtype() is# ':' && getcmdline() is# 'Tabnew')?('tabnew'):('Tabnew'))


"""""""""""""""""""""""""""""""""""""
"""""""""""PLUGIN SETTINGS"""""""""""
"""""""""""""""""""""""""""""""""""""

""""""""""" NERDTree """"""""""""""""

" Minimal NERDTree UI
let NERDTreeMinimalUI=1

" Show hidden files by default
let NERDTreeShowHidden=1

" Adjust square brackets around devicons in NERDTree
" https://github.com/ryanoasis/vim-devicons/wiki/FAQ-&-Troubleshooting#square-brackets-around-icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1


""""""""""""" Tern """"""""""""""""""
" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0

" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0



""""""""""" fzf + ripgrep """""""""""
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find
  \ call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \                    fzf#vim#with_preview(),
  \                    <bang>0)

" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Open files, split in window.
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" Open fzf to search files via CTRL P
nnoremap <c-p> :FZF<cr>


"""""""""""""""""""""""""""""""""""""
"""""""""""STATUSLINE SETUP""""""""""
"""""""""""""""""""""""""""""""""""""

" via https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
function! ActiveStatus()
  let statusline=" "
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%=" " Right-align shit after this line
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  return statusline
endfunction

set laststatus=2
set statusline=%!ActiveStatus()

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
augroup END
