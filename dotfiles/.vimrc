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
set mouse=a             " Support mouse in all modes
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

" Use the_silver_searcher for :grep
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" Traverse tree upwards for 'tags' file
set tags=./tags;/

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

" Easytags - Supress reports on tag updates
let g:easytags_suppress_report = 1

" Easytags - Speed things up
let g:easytags_async = 1
let g:easytags_auto_update = 0

" Use the_silver_searcher or .gitignore for Ctrl-P
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" Config php checkers to adhere to a minimal ruleset which boils down to
" simple linting and finding unused variables/members and commented code
let g:syntastic_php_checkers = ['php', 'phpmd', 'phpcs']
let g:syntastic_php_phpcs_args = '--standard=' . $HOME . '/dotfiles/standards/minimal-phpcs/ruleset.xml'
let g:syntastic_php_phpmd_post_args = $HOME . '/dotfiles/standards/minimal-phpmd/ruleset.xml'

let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_insertion = 1


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

" Fold and unfold with <Leader>f
nnoremap <silent> <Leader>f @=(foldlevel('.')?'za':"\<Space>")<CR>
"vnoremap <Space> zf

" Normal mode mappings
nnoremap <silent> M @q
nnoremap <silent> gV `[v`]
nnoremap <silent> <BS> gg
nnoremap <silent> <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <Leader>S (V}k:sort<CR>
nnoremap <silent> <Leader>ve :sp $MYVIMRC<CR>
nnoremap <silent> <Leader>vs :source $MYVIMRC<CR>
nnoremap <silent> <Leader>i :setl noai nocin nosi inde=<CR>

" Quickly run (selected) (python) code
nnoremap <silent> <Leader>pr :!python %<CR>
nnoremap <silent> <Leader>pi :!bpython -i %<CR>
vnoremap <silent> <Leader>pr :w !python<CR>

" Wrap line contents in a print function
" for Python
nnoremap <silent> <Leader>pp Iprint(<ESC>A)<ESC>
" for Go
nnoremap <silent> <Leader>pg Ifmt.Println(<ESC>A)<ESC>
" Delete outer function
nnoremap <silent> <Leader>pd ^dwx$x

" Open TODO file in vimoutliner mode
nnoremap <silent> <Leader>T :sp ~/TODO.otl<CR>

" Use <Return> in VISUAL mode to format text with par
vnoremap <silent> <Return> :!par<CR>

" Yank / paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Enter visual line mode by tapping Space twice
nmap <Leader><Leader> V

" Make current pane 64 chars wide
nmap <Leader>rr 64<C-W>|

" Make current pane 80 chars wide
nmap <Leader>rw 80<C-W>|

" For the times I'm too slow at releasing the SHIFT key
command! W :w
command! Wq :wq
command! WQ :wq
command! Wall :wall
command! Wqall :wqall
command! Qall :qall

" Browse tabs with Ctrl+H and Ctrl+L
nmap <C-H> gT
nmap <C-L> gt

" Mappings for Go programming
nnoremap <silent> <Leader>gb :!go build %<CR>
nnoremap <silent> <Leader>gr :!go run *.go<CR>
nnoremap <silent> <Leader>gf :!go fmt %<CR>
nnoremap <silent> <Leader>gd :Godoc<CR>

" Open tag definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Open tag definition in a vertical split window
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Mapping compatibility for commonly used commands in spacemacs
" <Space> is my <Leader>
nnoremap <silent> <Leader>w <C-W>

"+----------------------------------------------------------------------------
"++ Plugin mappings ----------------------------------------------------------

nmap <Leader>,, <C-y>,h
nmap <Leader>' ysW'

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nnoremap <Leader>o :NERDTreeToggle<CR>

" Configuration for UltiSnips
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

"+----------------------------------------------------------------------------
"++ Better handling of Vim Sessions ------------------------------------------

function! SessionSave()
    mksession! /tmp/$USER.session.vim
    echo "Session saved"
endfunction

nnoremap <silent> <Leader>ss :call SessionSave()<CR>
nnoremap <silent> <Leader>sq :call SessionSave()<CR>:confirm qall<CR>

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
nnoremap <silent> <Leader>t :call Settabbing('input')<CR>

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
    autocmd Filetype yaml call Settabbing(2)
    autocmd Filetype typescript call Settabbing(2)
    autocmd Filetype lua call Settabbing(2)
    autocmd BufEnter *.html call Settabbing(2)
    autocmd BufEnter *.tpl call Settabbing(2)
    autocmd FileType make set noexpandtab | call Settabbing(8)
    autocmd FileType godot set noexpandtab | call Settabbing(4)
    autocmd FileType go set noexpandtab | call Settabbing(4)
augroup END

"+----------------------------------------------------------------------------
"++ Go Programming -----------------------------------------------------------

" Add $GOROOT to runtimepath
set rtp+=$GOROOT/misc/vim

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

" Python
iabbrev def def name(self):'''documentation'''pass

" PHP
iabbrev ddoctype    <!doctype html>html>head>meta[charset=UTF-8]+link+style+title
iabbrev pphp        <?php
iabbrev pif         if () {}
iabbrev pelse       else {}
iabbrev pelseif     elseif () {}
iabbrev pswitch     switch () {case '':    break;default:}
iabbrev pfor        foreach ($var as $key => $value) {}
iabbrev ppublic     public function func($args) {}
iabbrev pprotected  protected function Func($args) {}
iabbrev pprivate    private function _func($args) {}

" Go
iabbrev iferr       if err != nil {return err}
iabbrev ifhttperr   if err != nil {http.Error(w, err.Error(), http.StatusInternalServerError)}

" Typescript

iabbrev tsimport    import { } from '';
iabbrev tscimport    import { Observable } from '@angular/core';
iabbrev tsfimport    import { NgForm } from '@angular/forms';

"+----------------------------------------------------------------------------
"++ Prevent replacing paste buffer on paste ----------------------------------

function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

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
