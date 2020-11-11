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
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()


""""""""""
"  undo  "
""""""""""
if empty(glob('~/.vim/undo'))
  silent !mkdir -p ~/.vim/undo
endif
if empty(glob('~/.vim/swp'))
  silent !mkdir -p ~/.vim/swp
endif
if empty(glob('~/.vim/backup'))
  silent !mkdir -p ~/.vim/backup
endif
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
nnoremap <leader>s :set spell! spelllang=en_us<CR>


""""""""""""""""
"  navigation  "
""""""""""""""""
set scrolloff=10
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


""""""""""""""
"  prettier  "
""""""""""""""
let g:prettier#autoformat=0
autocmd BufWritePre
  \ *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.mdx,*.vue,*.yaml,*.html
  \ PrettierAsync


"""""""""""
"  netrw  "
"""""""""""
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=-38

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

  " set hidden / prevent yank registers getting emptied on netrw navigation
  autocmd BufWinEnter * set hidden
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


"""""""""""""""
"  filetypes  "
"""""""""""""""
augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md,*.mdx set filetype=markdown
  autocmd BufRead,BufNewFile .{prettier,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile zshrc.local,*/zsh/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim

  " Enable spellchecking for Markdown
  " autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  " autocmd BufRead,BufNewFile *.md,*.mdx setlocal textwidth=80
  autocmd BufRead,BufNewFile *.md,*.mdx setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
  " autocmd BufRead,BufNewFile *.md,*.mdx let b:softwrap=1
  " autocmd BufRead,BufNewFile *.md,*.mdx set columns=80
  " au BufRead,BufNewFile *.txt,*.tex set wrap linebreak nolist textwidth=0 wrapmargin=0
  " autocmd BufRead,BufNewFile *.md setlocal formatoptions+=a
augroup END
