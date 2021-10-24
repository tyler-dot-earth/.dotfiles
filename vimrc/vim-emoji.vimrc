" Plug 'junegunn/vim-emoji'

" Emoji completion
" set completefunc=emoji#complete

" Append Emoji list to current buffer
" for e in emoji#list()
"   call append(line('$'), printf('%s (%s)', emoji#for(e), e))
" endfor

" Replace :emoji_name: into Emojis
" %s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
