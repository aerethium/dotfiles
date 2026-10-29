" Official 42 school standard header script format
let s:asciiart = [
\ "        :::      ::::::::",
\ "      :+:      :+:    :+:",
\ "    +:+ +:+         +:+  ",
\ "  +#+  +:+       +#+     ",
\ "+#+#+#+#+#+   +#+        ",
\ "     #+#    #+#          ",
\ "    ###   ########.fr    "
\]
let s:start = '/*'
let s:end = '*/'
let s:fill = '*'
let s:length = 80
let s:margin = 3
let s:types = {
\ '\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.tpp$\|\.ipp$\|\.cxx$\|\.go$\|\.rs$\|\.php$\|\.java$\|\.kt$\|\.kts$\|\.css$\|\.scss$': ['/*', '*/', '*'],
\ '\.htm$\|\.html$\|\.xml$': ['<!--', '-->', '*'],
\ '\.js$\|\.ts$': ['//', '//', '*'],
\ '\.tex$': ['%', '%', '*'],
\ '\.sh$\|\.py$\|\.pl$\|\.rb$\|\.rake$\|Makefile\|\.mk$\|\.awk$\|\.sed$\|\.yaml$\|\.yml$\|\.ini$\|\.toml$\|DockerFile\|\.dockerfile$': ['#', '#', '#']
\}
function! s:getline(n)
  return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
endfunction
function! s:getuser()
  let l:user = exists('g:user42') ? g:user42 : $USER
  if empty(l:user)
    let l:user = 'marvin'
  endif
  return l:user
endfunction
function! s:getmail()
  let l:mail = exists('g:mail42') ? g:mail42 : $MAIL
  if empty(l:mail)
    let l:mail = 'marvin@42.fr'
  endif
  return l:mail
endfunction
function! s:getdate()
  return strftime("%Y/%m/%d %H:%M:%S")
endfunction
function! s:textline(left, right)
  let l:left = substitute(a:left, '\t', repeat(' ', &tabstop), 'g')
  let l:right = substitute(a:right, '\t', repeat(' ', &tabstop), 'g')
  let l:len = s:length - strlen(s:start) - strlen(s:end) - s:margin * 2
  let l:spaces = l:len - strlen(l:left) - strlen(l:right)
  return s:start . repeat(' ', s:margin) . l:left . repeat(' ', l:spaces) . l:right . repeat(' ', s:margin) . s:end
endfunction
function! s:domargin(line)
  return s:start . repeat(' ', s:margin) . a:line . repeat(' ', s:length - strlen(s:start) - strlen(s:end) - s:margin - strlen(a:line)) . s:end
endfunction
function! s:header()
  let l:file = expand('%:t')
  let l:user = s:getuser()
  let l:mail = s:getmail()
  let l:date = s:getdate()

  if empty(l:file)
    let l:file = 'unnamed'
  endif
  call append(0, s:getline(1))
  call append(1, s:textline('', ''))
  call append(2, s:textline('', s:asciiart[0]))
  call append(3, s:textline(l:file, s:asciiart[1]))
  call append(4, s:textline('', s:asciiart[2]))
  call append(5, s:textline('By: ' . l:user . ' <' . l:mail . '>', s:asciiart[3]))
  call append(6, s:textline('', s:asciiart[4]))
  call append(7, s:textline('Created: ' . l:date . ' by ' . l:user, s:asciiart[5]))
  call append(8, s:textline('Updated: ' . l:date . ' by ' . l:user, s:asciiart[6]))
  call append(9, s:textline('', ''))
  call append(10, s:getline(9))
endfunction
function! s:update()
  if getline(11) == s:getline(9)
    let l:user = s:getuser()
    let l:date = s:getdate()
    call setline(9, s:textline('Updated: ' . l:date . ' by ' . l:user, s:asciiart[6]))
  endif
endfunction
function! s:stdheader()
  let l:ext = expand('%:e')
  let l:file = expand('%:t')

  for [l:pattern, l:cfg] in items(s:types)
    if expand('%') =~ l:pattern
      let s:start = l:cfg[0]
      let s:end = l:cfg[1]
      let s:fill = l:cfg[2]
      call s:header()
      return
    endif
  endfor
  call s:header()
endfunction
command! Stdheader call s:stdheader()
autocmd BufWritePre * call s:update()
nmap <F1> :Stdheader<CR>
