"""""""""""""
"  general  "
"""""""""""""
set encoding=utf-8
set autowrite
set modelines=0   " Disable modelines as a security precaution
set nomodeline

"""""""""""""
"  plugins  "
"""""""""""""
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'branch': 'release/1.x' }
call plug#end()


""""""""""
"  undo  "
""""""""""
set undofile
set undodir=~/.vim/undo/
set directory=~/.vim/swp/
set backupdir=~/.vim/backup/


"""""""""""""""""""""""""""""""""""
"  tabs, lines, and chars, oh my  "
"""""""""""""""""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set textwidth=80
set colorcolumn=+1
set nowrap
set nojoinspaces
set list listchars=tab:»·,trail:·,nbsp:·


""""""""""""
"  search  "
""""""""""""
set incsearch
set hlsearch
set ignorecase
set smartcase


""""""""""""""
"  mappings  "
""""""""""""""
let mapleader=","
" From plugins:
" https://github.com/tpope/vim-sensible
" nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" https://github.com/tpope/vim-commentary
" xmap gc  <Plug>Commentary
" nmap gc  <Plug>Commentary
" omap gc  <Plug>Commentary
" nmap gcc <Plug>CommentaryLine
" ----
" Overrides & remaps:
nnoremap <silent> <leader><tab> :call ToggleNetrw()<CR>
nnoremap <silent> <leader>n :set number!<CR>
nnoremap <silent> <leader>. :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><leader>,
nmap <silent> <leader>/ gcc
vmap <silent> <leader>/ gc
" Fixes gx netrw url opening
" https://github.com/vim/vim/issues/4738#issuecomment-521506447
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>
" Switch between the last two files
nnoremap <leader><leader> <C-^>


""""""""""""""""
"  naviagtion  "
""""""""""""""""
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


""""""""""""""
"  prettier  "
""""""""""""""
let g:prettier#autoformat=0
autocmd BufWritePre
  \ *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html
  \ PrettierAsync


"""""""""""
"  netrw  "
"""""""""""
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=-38
" set hidden / prevent yank registers getting emptied on netrw navigation
au BufWinEnter * set hidden
" Toggle explore with leader tab
function! ToggleNetrw()
  let i = bufnr("$")
  let wasOpen = 0
  while (i >= 1)
    if (getbufvar(i, "&filetype") == "netrw")
      silent exe "bwipeout " . i
      let wasOpen = 1
    endif
    let i-=1
  endwhile
  if !wasOpen
    silent Vexplore
  endif
endfunction
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * if argc() == 0 | :call ToggleNetrw() | endif
augroup END


"""""""""
"  zen  "
"""""""""
function! Zen() abort
  set         vb t_vb=
  set         laststatus=0
  set         laststatus=0 
  set         foldcolumn=12
  highlight   FoldColumn  ctermbg=0
  highlight   LineNr      ctermfg=8   ctermbg=0
  highlight   NonText     ctermfg=0
endfunction

augroup Zen
  autocmd!
  autocmd ColorScheme * call Zen()
augroup END

colorscheme dim
