let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ ]
      " \ { 'type': 'sessions',  'header': ['   Sessions']       },
      " \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      " \ { 'type': 'commands',  'header': ['   Commands']       },



let g:startify_custom_header = [
      \ '#     #                         #######              ',
      \ '#     #   ##   #    # ######    #       #    # #    #',
      \ '#     #  #  #  #    # #         #       #    # ##   #',
      \ '####### #    # #    # #####     #####   #    # # #  #',
      \ '#     # ###### #    # #         #       #    # #  # #',
      \ '#     # #    #  #  #  #         #       #    # #   ##',
      \ '#     # #    #   ##   ######    #        ####  #    #',
      \ ]

" let s:footer = ['ddd'|cowsay]


" let g:startify_custom_footer = s:footer

" let g:startify_custom_footer =  startify#pad(split(system('~/projects/advice/art-of-cli.sh'), '\n'))
" let g:startify_custom_footer =  startify#pad(split(system('~/projects/advice/art-of-cli.sh'), '\n'))




" function! s:center(lines) abort
  " let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  " let centered_lines = map(copy(a:lines),
        " \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  " return centered_lines
" endfunction


" let s:footer = [
      " \ '                     +-------------------------------------------+',
      " \ '                     |            ThinkVim ^_^                   |',
      " \ '                     |    Talk is cheap Show me the code         |',
      " \ '                     |                                           |',
      " \ '                     |            GitHub:taigacute               |',
      " \ '                     +-------------------------------------------+',
      " \ ]

