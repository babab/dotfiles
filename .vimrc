"++ Main settings and configuration ------------------------------------------

if has("syntax")
  syntax on
endif
set background=dark

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
  filetype plugin indent on
endif

" Leaders
let mapleader = "\<Space>"
let maplocalleader = "\\"

" Delete trailing whitespace
augroup Filters
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set modeline            " Use modelines if found
set ttymouse=xterm      " So vim doesn't hang inside tmux
set showtabline=1       " Show only if there are at least two tab pages
set scrolloff=10        " Minimal number of lines above and below the cursor.
set colorcolumn=80      " Show a colored column at 80 chars
set hlsearch            " Highlight search pattern
colo vividchalk         " Color scheme by Tim Pope

highlight ColorColumn ctermfg=243 ctermbg=232

" Keep bak and swp files in a dedicated folder
set directory=~/.vim-bak-swp
set backup
set backupdir=~/.vim-bak-swp

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=l  "remove left-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar on split screen

"+----------------------------------------------------------------------------
"++ Keymapping ---------------------------------------------------------------

" Keep things centered
nnoremap n nzz
nnoremap N Nzz
nnoremap } }zz
nnoremap { {zz

" Not used and annoying
nnoremap Q <nop>
nnoremap K <nop>

" Only yank after the cursor instead of the line as a whole
nnoremap Y y$

" Map ; to <Leader> / <Space>
nmap ; <Space>

nnoremap <silent> <Leader>w :confirm w<CR>
nnoremap <silent> <Leader>q :confirm q<CR>

" Fold and unfold with <Leader>f
nnoremap <silent> <Leader>f @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Normal mode mappings
nnoremap <silent> M @q
nnoremap <silent> <F5> :!./%<CR>
nnoremap <silent> <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <Leader>S (V}k:sort<CR>
nnoremap <silent> <Leader>ve :sp $MYVIMRC<CR>
nnoremap <silent> <Leader>vs :source $MYVIMRC<CR>
nnoremap <silent> <Leader>i :setl noai nocin nosi inde=<CR>

" Open TODO file in vimoutliner mode
nnoremap <silent> <Leader>t :sp ~/TODO.otl<CR>

" Wrap line contents in a function
nnoremap <silent> <Leader>pd ^dwx$x
augroup DebuggingMappings
    autocmd!
    autocmd Filetype python nnoremap <silent> <Leader>pp Iprint(<ESC>A)<ESC>
    autocmd Filetype php nnoremap <silent> <Leader>pp Iprint_r(<ESC>A)<ESC>
augroup END

" Use <Return> in VISUAL mode to format text with par
vnoremap <silent> <Return> :!par<CR>


"+----------------------------------------------------------------------------
"++ Better handling of Vim Sessions ------------------------------------------

function! SessionSave()
    mksession! .session.vim
    confirm wall
    echo "Session saved"
endfunction

nnoremap <silent> <Leader>s :call SessionSave()<CR>

"+----------------------------------------------------------------------------
"++ Tabbing/indents function, mapping and filetype settings ------------------

" Quickly set tabstop, shiftwidth and softtabstop for a buffer in one go
function! Settabbing(tabbing)
    if a:tabbing == 'input'
        let tabbing = input("Set number of spaces [current = "
                            \ . &l:tabstop . "]: ")
    else
        let tabbing = a:tabbing
    endif

    if empty(l:tabbing) || l:tabbing < '1'
        return
    endif

    let &l:tabstop = l:tabbing
    let &l:shiftwidth = l:tabbing
    let &l:softtabstop = l:tabbing
endfunction
nnoremap <silent> <Leader>T :call Settabbing('input')<CR>

" Use 4 spaces for tabs by default
" Use 2 spaces when editing html and django template files
" Use 3 spaces when editing reStructuredText files
" Use tabs (tabbing with 4 spaces) when programming in Go
" Use tabs (tabbing with 8 spaces) when editing Makefiles
set expandtab
call Settabbing(4)
augroup Tabbing
    autocmd!
    autocmd Filetype html call Settabbing(2)
    autocmd Filetype htmldjango call Settabbing(2)
    autocmd Filetype jinja call Settabbing(2)
    autocmd Filetype twig call Settabbing(2)
    autocmd FileType rst call Settabbing(3)
    autocmd FileType php call Settabbing(4)
    autocmd BufEnter *.html call Settabbing(2)
    autocmd BufEnter *.tpl call Settabbing(2)
    autocmd FileType make set noexpandtab | call Settabbing(8)
augroup END

"+----------------------------------------------------------------------------
"++ Go Programming -----------------------------------------------------------

" Add $GOROOT to runtimepath
set rtp+=$GOROOT/misc/vim

" Mappings for Go programming
nnoremap <silent> <Leader>gb :!go build %<CR>
nnoremap <silent> <Leader>gr :!go run %<CR>
nnoremap <silent> <Leader>gf :!go fmt %<CR>
nnoremap <silent> <Leader>gd :Godoc<CR>

"+----------------------------------------------------------------------------
"++ PHP Programming ----------------------------------------------------------

" Make setter method
let @s = 'yyppkk~Ipublic function setjkA($jkJxA)jko{jkjo}jkkyypkI$this->jkA = jkJi@jkxi$jkA;jkv>jVkkk>jjjj'

function! PhpGetter()
    " TODO: test if line is empty and has only a single word
    execute "normal! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    call setline('.', substitute(getline("."), '^\$', '', ''))
    execute "normal! YpIreturn $this->A;k^~Ipublic function getA(){j>>o}<<V3k=3joj"
endfunction

command! PhpGetter      call PhpGetter()

"+----------------------------------------------------------------------------
"++ Abbreviations ------------------------------------------------------------

iabbrev ddoctype    <!doctype html>
iabbrev hhtml       html>head>meta[charset=UTF-8]+link+style+title
iabbrev bbody       body>div#container
iabbrev ddiv        <div id=""></div>
iabbrev sspan       <span id=""></span>

"+----------------------------------------------------------------------------
"++ Plugins ------------------------------------------------------------------

" pathogen.vim
call pathogen#infect()

" Tagbar - keybinding
nnoremap <F8> :TagbarToggle<CR>

" Tagbar - Hide PHP Variables
let g:tagbar_type_php  = {
      \ 'ctagstype' : 'php',
      \ 'kinds'     : [
      \ 'i:interfaces',
      \ 'c:classes',
      \ 'd:constant definitions',
      \ 'f:functions',
      \ 'j:javascript functions:1'
      \ ]
      \ }

"+----------------------------------------------------------------------------
"++ Plugin remappings --------------------------------------------------------

nmap <Leader>,, <C-y>,
nmap <Leader>' ysW'

" snipmate - https://github.com/garbas/vim-snipmate
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

"+----------------------------------------------------------------------------
"++ Statusline ---------------------------------------------------------------

set statusline=%<                           " Truncate at the start
set statusline+=%f                          " Relative path to file in buffer
set statusline+=\                           " Whitespace divider
set statusline+=%y                          " [Type of file]
set statusline+=\                           " Whitespace divider
set statusline+=%{tagbar#currenttag('%s()','NOT-IN-TAG')}    " :h tagbar-statusline
set statusline+=\                           " Whitespace divider
set statusline+=[%l/%L]                     " Lineno and total lines
set statusline+=[%c%V]                      " Colno, Virtual colno

"+- vim: fdm=marker fmr="++,"+-:
