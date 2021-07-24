" WSL yank support, for some reason, re4388 user don't need this
" but in ben user, it need this.. 
" I think ben is also in sudo group..
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
