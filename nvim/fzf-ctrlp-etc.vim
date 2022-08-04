" fzf + ripgrep
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search
" --color: Search color options
"
" fzf#vim#grep(command, with_column, [options], [fullscreen])

" Use fzf to search vim buffers via ; (semicolon key)
nmap ; :Buffers<CR>

" Search git filesnames (i.e. git ls-files)
command! -bang -nargs=* GitFiles
  \ call fzf#vim#gitfiles(
    \ '.',
    \ fzf#vim#with_preview('right:50%')
  \ )

" Search git file content (i.e. git grep)
command! -bang -nargs=* GitGrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --no-heading --glob="!package-lock.json" --glob="!.git/*" --color=always --ignore-case '.shellescape(<q-args>),
  \   1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Ripgrep to search contents of all files.
" :Rg  - Start fzf with hidden preview window that can be enabled with "?" key
" :Rg! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>),
  \   1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Open files, split in window.
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" Open fzf to search files via CTRL P
nnoremap <c-p> :GitFiles<cr>
