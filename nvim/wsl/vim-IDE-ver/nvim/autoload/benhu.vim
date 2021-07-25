
function! benhu#BenHuFn1()
  echo 'form benhu11111'
endfunction


" take from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/autoload/tj.vim
function! benhu#jump_direction(letter)
  let jump_count = v:count

"  For wrapped lines, does gj/gk
  if jump_count == 0
    call execute(printf('normal! g%s', a:letter))
    return
  endif

"  For large jumps, adds a spot on the jump list
  if jump_count > 5
    call execute("normal! m'")
  endif

  call execute(printf('normal! %d%s', jump_count, a:letter))
endfunction
