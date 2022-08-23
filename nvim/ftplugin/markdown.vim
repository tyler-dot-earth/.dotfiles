"" Markdown-specific stuff

" Wrap lines, use tabs
autocmd FileType markdown setlocal wrap

" Navigate wrapped lines as if they were unwrapped
autocmd FileType markdown noremap <buffer> j gj
autocmd FileType markdown noremap <buffer> k gk

" Open markdown preview in web browser
nnoremap <LocalLeader>p :MarkdownPreview<cr>
