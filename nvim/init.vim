" Pre-plugin dependencies
"" For wilder.nvim
function! UpdateRemotePlugins(...)
	" Needed to refresh runtime files
	let &rtp=&rtp
	UpdateRemotePlugins
endfunction

" Plugin manager: vim-plug
call plug#begin()
" --------------------------------------
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" --------------------------------------

" --------------------------------------
" PLUGINS ------------------------------
" --------------------------------------

" Co-pilot to do my work for me
Plug 'github/copilot.vim'

" Theme: Dracula
Plug 'dracula/vim'

" Theme: Oceanic Next
Plug 'mhartington/oceanic-next'

" Theme: Nightfox
Plug 'EdenEast/nightfox.nvim'

" Theme: zephyr
Plug 'glepnir/zephyr-nvim'

" Theme: Catppuccin
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Fzf to navigate files fuzzily
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Conquerer of Completion provides inline hints for ESLint, Flow, etc.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" CoC extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
" Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'pantharshit00/coc-prisma', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
"" NOTE: ^ snippets requires pythonx support in vim. check :checkhealth

" File browser via :NERDTree
Plug 'scrooloose/nerdtree'

" Jump anywhere in the file.
" eg: gw <- this will let you jump to any word
Plug 'phaazon/hop.nvim'

" Add Prisma support
Plug 'pantharshit00/vim-prisma'

" Statusline/statusbar + winbar
Plug 'feline-nvim/feline.nvim'

" Dev icons (requires patched font)
Plug 'kyazdani42/nvim-web-devicons'

" Git integration for buffers
Plug 'lewis6991/gitsigns.nvim'

" Fancy, configurable notification manager
Plug 'rcarriga/nvim-notify'
" TODO evaluate whether this ^ is worth keeping

" Comment stuff out.
Plug 'numToStr/Comment.nvim'
" # NORMAL mode
"   `gcc` - Toggles the current line using linewise comment
"   `gbc` - Toggles the current line using blockwise comment
"   `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
"   `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
"   `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
"   `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
" # VISUAL mode
"   `gc` - Toggles the region using linewise comment
"   `gb` - Toggles the region using blockwise comment
" # Extra mappings
"   `gco` - Insert comment to the next line and enters INSERT mode
"   `gcO` - Insert comment to the previous line and enters INSERT mode
"   `gcA` - Insert comment to end of the current line and enters INSERT mode

" Treesitter highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" ... don't forget to install language parsers like, eg:
" :TSInstall typescript tsx javascript json json5 css html markdown yaml
" Treesitter-based context as you scroll through code
Plug 'nvim-treesitter/nvim-treesitter-context'
" Treesitter-based local code dimming
Plug 'folke/twilight.nvim'
" Treesitter-based contextual comments (eg do {/* these */} in jsx depending
" on cursor location)
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
" Treesitter-based autoclose and autorename HTML tags
Plug 'windwp/nvim-ts-autotag'
" Treesitter-based rainbow parenthesis
Plug 'p00f/nvim-ts-rainbow'


" Opens the current buffer in a new full-screen floating window,
" doesn't mess with existing window layouts / splits.
" Use via :Zen (alias of the real command, :TZAtaraxis)
Plug 'Pocco81/true-zen.nvim'

" Substitute variants (like case differences),
" eg: :%s/foo/bar/g
" eg: (visual selection) Subvert/foo/bar/g
" ... would replace all foo/Foo/FOO with bar/Bar/BAR
" It can do a lot more though, but that's 99% of what i do with it.
Plug 'tpope/vim-abolish'

" Guide lines for indents
Plug 'lukas-reineke/indent-blankline.nvim'

" Highlight arguments' definitions and usages
Plug 'm-demare/hlargs.nvim'

" Opens a popup with suggestions to help you complete a key binding
" (tl;dr key mappings helper)
Plug 'folke/which-key.nvim'

" A cooler version of the :wildmenu (the command menu, via colon key)
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }


" Initialize plugin system
call plug#end()

" --------------------------------------
" MISC ---------------------------------
" --------------------------------------
set relativenumber " Relative line numbers on left
set number " Current line number on left
set cursorline " Highlight current row
set cursorline cursorcolumn " Highlight current column
set noexpandtab " Don't turn tabs to space
set tabstop=2 " how many columns a tab counts for
set shiftwidth=2 " how many columns text is indented with the reindent operations
set termguicolors " Required by feline, i guess?
set nowrap " Don't line wrap
set splitbelow " Preferred split direction
set splitright " Preferred vsplit direction
set scrolloff=5 " Always keep N number of lines from edge of screen
set mouse=a " enable mouse support in (a)ll modes
set timeoutlen=500

" Special line characters
set list
set listchars=tab:⣿⣿,eol:↵,trail:·,precedes:⦚,extends:⦚,nbsp:⎵
" misc fun symbols: 🡆 🠶 🠊 ⮞ ⮚ ▶ ⎵ ⣿ ⠉ ⠈ ░ ▒ ▓ ► ◄ ↵ · ◣ ◢ ◥ ◤ ◐ ◑ ⯺  ⯼ ☉ ⁞ ⦙ ┊ ⦚ ×
set showbreak=↪\

" Leader key is space (instead of default \)
" let mapleader = "\<Space>"

" --------------------------------------
" various configurations to avoid cluttering the main file
" --------------------------------------
source $HOME/.dotfiles/nvim/coc.vim
source $HOME/.dotfiles/nvim/fzf-ctrlp-etc.vim
source $HOME/.dotfiles/nvim/zen.vim
source $HOME/.dotfiles/nvim/treesitter-stuff.vim
source $HOME/.dotfiles/nvim/twilight-dimming-etc.vim
source $HOME/.dotfiles/nvim/winbar-statusbar.vim
source $HOME/.dotfiles/nvim/git.vim
source $HOME/.dotfiles/nvim/movement.vim
source $HOME/.dotfiles/nvim/education.vim
source $HOME/.dotfiles/nvim/wildmenu-commandbar-etc.vim

" Set catppuccin after sourcing the look-and-feel
source $HOME/.dotfiles/nvim/theme-look-feel-etc.vim
let g:catppuccin_flavour = "frappe" " latte, frappe, macchiato, mocha
colorscheme catppuccin
" Misc color tweaks after colorscheme is set
"" Transparent background (use terminal emulator opacity)
hi Normal guibg=NONE ctermbg=NONE
"" Floating window stuff
hi FloatBorder guifg=white
hi NormalFloat guibg=black

" --------------------------------------
" TODO ---------------------------------
" --------------------------------------

"" Markdown-specific stuff
" Wrap lines, use tabs
autocmd FileType markdown setlocal wrap noexpandtab tabstop=2 softtabstop=2 shiftwidth=2
" Navigate wrapped lines as if they were unwrapped
autocmd FileType markdown noremap <buffer> j gj
autocmd FileType markdown noremap <buffer> k gk
""" ^ Would these be better as ftplugins?


" Always use the current buffer's directory as the relative location for
" commands and such. Mostly so I can :NERDTree and :sp/vsp anywhere.
autocmd BufEnter * silent! lcd %:p:h
