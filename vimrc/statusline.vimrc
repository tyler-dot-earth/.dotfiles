" Highlight colors for statusline.
hi statusline guibg=White ctermfg=8 guifg=DarkSlateGray ctermbg=15

" via https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
function! ActiveStatus()
  let statusline=" " " blank space

  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}" " git branch

  let statusline.="%2*" " highlight thing (TODO better explanation)

  let statusline.=" " " blank space
  let statusline.=" " " blank space
  let statusline.="%f" " filename
  let statusline.="@" " just an @ symbol lol
  let statusline.="%l:%c" " line:column numbers.
  let statusline.=" " " blank space

  let statusline.="%{&modified?'+':''}" " show a little icon when modified (but not saved)
  let statusline.="%{&readonly?'':''}" " show a little icon when readonly

  let statusline.="%=" " Right-align shit after this line

  let statusline.="\ %{''!=#&filetype?&filetype:'none'}" " display filetype if present
  let statusline.=" " " blank space
  let statusline.="[buffer#%n]" " buffer #
  let statusline.=" "
  return statusline
endfunction

set laststatus=2 " Always show the statusline
set statusline=%!ActiveStatus()

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
augroup END
