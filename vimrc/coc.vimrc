" Conquerer of Completion provides inline hints for ESLint, Flow, etc.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Automatically install and update extensions
let g:coc_global_extensions = ['coc-json', 'coc-tsserver']

" Conditionally install prettier extension
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Conditionally install ESLint extension
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" SHIFT-K show Coc docs popover
nnoremap <silent> K :call CocAction('doHover')<CR>

" Automatic popover for diagnostic or docs when hovering
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction
function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction
autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" Go to definition
nmap <silent> gd <Plug>(coc-definition)
" Go to type definition
nmap <silent> gy <Plug>(coc-type-definition)
" Go to type references
nmap <silent> gr <Plug>(coc-references)
" Go to previous error/warning
nmap <silent> [g <Plug>(coc-diagnostic-prev)
" Go to next error/warning
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" View all errors/warnings
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" Code actions (eg automated fixes for an issue)
nmap <leader>do <Plug>(coc-codeaction)

" List symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Rename symbol
nmap <leader>rn <Plug>(coc-rename)
