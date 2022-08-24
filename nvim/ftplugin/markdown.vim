"" Markdown-specific stuff

" Wrap lines, use tabs
set wrap

" Navigate wrapped lines as if they were unwrapped
noremap <buffer> j gj
noremap <buffer> k gk

" Open markdown preview in web browser
nnoremap <LocalLeader>p :MarkdownPreview<cr>
