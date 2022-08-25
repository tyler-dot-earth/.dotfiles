"" Markdown-specific stuff

" Wrap lines
set wrap

" Only breakline at `breakat` characters (to prevent mid-word breaks)
set linebreak

" Navigate wrapped lines as if they were unwrapped
noremap <buffer> j gj
noremap <buffer> k gk

" Open markdown preview in web browser
nnoremap <LocalLeader>p :MarkdownPreview<cr>
