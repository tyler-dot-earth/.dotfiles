" NERDTree: file browser sidebar.
" Just type execute `:NERDTree`
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " On-demand loading

" Minimal NERDTree UI
let NERDTreeMinimalUI=1

" Show hidden files by default
let NERDTreeShowHidden=1

" Icons in NERDTree
Plug 'ryanoasis/vim-devicons' " Needs to happen after nerdtree stuff.
" Prerequisite: you must use a patched font;
" see https://github.com/ryanoasis/vim-devicons#installation

" Adjust square brackets around devicons in NERDTree
" https://github.com/ryanoasis/vim-devicons/wiki/FAQ-&-Troubleshooting#square-brackets-around-icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1
