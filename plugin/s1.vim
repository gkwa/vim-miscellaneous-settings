""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:is_windows = has('win16') || has('win32') || has('win64')

" flash screen instead of sounding a beep
set visualbell

set relativenumber
set nostartofline
set tabstop=2
set shiftwidth=2
set expandtab
set nobackup
set noswapfile
set nowrap

" ignore case
set ic

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

set wildmenu

set hidden

" show numbered lines
set number
syntax on

filetype plugin indent on

" pretty print json
nmap =j :%!python -m json.tool<CR>

nnoremap <silent> <Leader><Leader> :Files <C-R>=expand('%:h')<CR><CR>

" save open buffer list and re-open on next vim run
:exec 'set viminfo=%,' . &viminfo

" https://hashrocket.com/blog/posts/8-great-vim-mappings
set pastetoggle=<leader>z

" show help in single window
nnoremap <leader>ho :h \| only<CR>

" https://stackoverflow.com/a/26431632/1495086
" show help in single window
" use: H: {subject}
command! -nargs=1 -complete=help H :enew | :set buftype=help | :h <args>

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" set workng directory to directory of current buffer
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>cd <c-^>:pwd<cr>

" https://stackoverflow.com/a/954336/1495086
" :h filename-modifiers
nmap cp :let @" = expand("%")

" http://vim.wikia.com/wiki/Open_the_directory_for_the_current_file_in_Windows
" Open windows explorer on directory for current file
map <C-e> :silent !explorer %:p:h:gs?\/?\\\\\\?<CR>

if s:is_windows
  " https://github.com/todashuta/.dotfiles/blob/9c08b42823936b9ab8b6c84fb376696c53e15349/.vimrc#L2246
  command! -bang -complete=file -nargs=? Cmd
        \ execute 'silent !start cmd.exe /k cd' (<q-args> != ''
        \   ? <q-args> : (<bang>0 ? expand('%:p:h') : getcwd()))
  map ,sh :PowerShell<cr>
  "  map ,sh :!start cmd /k cd %:p:h<CR>
  "  this breaks Ex somehow
  "  command! -bang -complete=file -nargs=? Explorer
  "        \ execute printf('silent !start explorer.exe "%s"', tr((<q-args> != ''
  "        \   ? <q-args> : (<bang>0 ? expand('%:p:h') : getcwd())), '/', '\'))
  command! -bang -complete=file -nargs=? PowerShell
        \ execute printf('silent !start powershell.exe -NoExit -Command "cd ''%s''"',
        \   (<q-args> != '' ? <q-args> : (<bang>0 ? expand('%:p:h') : getcwd())))
else
  " vim-dispatch provids :Start
  map ,sh :Start<CR>
endif

" save and source vim file
nnoremap <leader>sv :w \| :source %<CR>

"http://vim.wikia.com/wiki/Short_mappings_for_common_tasks
"For quick recordings just type qq to start recording, then q to stop. You
"don't have to worry about the name this way (you just named the recording
"'q'). Now, to play back the recording you just type Q.
nnoremap Q @q

" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
" As you all may know with 'o' or 'O' you can insert a new line after/before
" the current line. But both commands enter the insert mode, which may
" sometimes not be what you want. I put this in my vimrc-file to insert a
" new-line after the current line by pressing Enter (Shift-Enter for inserting
" a line before the current line):
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" https://bbkane.github.io/2016/12/18/Vim-Color-Schemes.html
if has('termguicolors') && has('win32')
  set termguicolors
endif

" Allow netrw to remove non-empty local directories
" https://gist.github.com/KevinSjoberg/5068370
let g:netrw_localrmdir='rm -r'


" http://vim.wikia.com/wiki/Open_file_under_cursor
" On Windows, the default 'isfname' includes a colon. If you do not use
" drive letters to identify files, you could remove the colon with the
" command:
set isfname-=:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://howivim.com/2016/damian-conway/

nmap <silent> <BS> :nohlsearch<CR>

set autowrite
if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.vimundo
    set undofile
endif

"====[ Make the 81st column stand out ]====================
" https://github.com/ninrod/damian_conway_oscon_2013_tarball/tree/2c22b94f35348b2cf56337cecd412e6f701fa2db#damian-conways-more-instantly-better-vim-oscon-2013-talk
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/<C-R>"<CR>

" Edit yaml without indent
" https://stackoverflow.com/a/37488992/1495086
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
