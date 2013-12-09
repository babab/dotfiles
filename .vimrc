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

" Delete trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set modeline            " Use modelines if found
set ttymouse=xterm      " So vim doesn't hang inside tmux
set showtabline=0       " Don't need to ever show a tabline
set scrolloff=10        " Minimal number of lines above and below the cursor.
colo vividchalk         " Color scheme by Tim Pope

" Highlight chars of lines exceeding 79 chars
highlight ColorColumn ctermbg=darkgrey
call matchadd('ColorColumn', '\%80v', 100)


" Keep bak and swp files in a dedicated folder
set directory=~/.vim-bak-swp
set backup
set backupdir=~/.vim-bak-swp

"+----------------------------------------------------------------------------
"++ gVim GUI options ---------------------------------------------------------

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=l  "remove left-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar on split screen

"+----------------------------------------------------------------------------
"++ Remappings / overrides of normal mode commands  --------------------------

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

"+----------------------------------------------------------------------------
"++ Convenience mappings -----------------------------------------------------

" Write and quit auto-return
nmap <silent> :W :w<CR>
nmap <silent> :Q :wq<CR>

" Fold and unfold with spacebar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Mapping for changing to PWD of file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

nmap <silent> m @q
nmap <silent> ;pd ^dwx$x
nmap <silent> ;pp Iprint(<ESC>A)<ESC>
nmap <silent> ;S (V}k:!sort<CR>
nmap <silent> <F5> :!./%<CR>
vmap <silent> <F9> :!par<CR>

"+----------------------------------------------------------------------------
"++ Mappings for saving all buffers and writing a vim session file -----------

function SessionSave()
    mksession! .session.vim
    confirm wall
    echo "Session saved"
endfunction

nmap <silent> ;s :call SessionSave()<CR>
nmap <silent> ;w :confirm wall<CR>
nmap <silent> ;q :confirm wqall<CR>
imap <silent> <M-M> <C-R>=<ESC><CR>

"+----------------------------------------------------------------------------
"++ Tabbing/indents function, mapping and filetype settings ------------------

" Quickly set tabstop, shiftwidth and softtabstop for a buffer in one go
function Settabbing(tabbing)
    if a:tabbing == 'input'
        let tabbing = input("Set number of spaces [current = "
                            \ . &tabstop . "]: ")
    else
        let tabbing = a:tabbing
    endif

    " TODO: test if integer
    if empty(l:tabbing) || l:tabbing < '1'
        return
    endif

    let &tabstop = l:tabbing
    let &shiftwidth = l:tabbing
    let &softtabstop = l:tabbing
endfunction
nmap <silent> ;t :call Settabbing('input')<CR>

" Use 4 spaces for tabs by default
" Use 2 spaces when editing html and tmpl files
" Use 3 spaces when editing reStructuredText files
" Use tabs (tabbing with 4 spaces) when programming in Go
" Use tabs (tabbing with 8 spaces) when editing Makefiles
set expandtab
call Settabbing(4)
augroup Tabbing
    autocmd BufEnter *.html call Settabbing(2)
    autocmd BufEnter *.tmpl call Settabbing(2)
    autocmd BufEnter *.rst call Settabbing(3)
    autocmd BufEnter *.go set noexpandtab | call Settabbing(4)
    autocmd BufEnter Makefile set noexpandtab | call Settabbing(8)
augroup END

"+----------------------------------------------------------------------------
"++ Go Programming -----------------------------------------------------------

" Add $GOROOT to runtimepath
set rtp+=$GOROOT/misc/vim

" Mappings for Go programming
nmap <silent> ;gb :!go build %<CR>
nmap <silent> ;gr :!go run %<CR>
nmap <silent> ;gg ;gr
nmap <silent> ;gf :!go fmt %<CR>
nmap <silent> ;gd :Godoc<CR>

"+----------------------------------------------------------------------------
"++ Plugins ------------------------------------------------------------------

" pathogen.vim
call pathogen#infect()

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" VimOrganizer settings and loading
let g:ft_ignore_pat = '\.org'
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org call org#SetOrgFileType()

"+- vim: fdm=marker fmr="++,"+-:
