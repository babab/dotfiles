" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

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

set showcmd		    " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

set modeline        " Use modelines if found
set ttymouse=xterm  " So vim doesn't hang inside tmux
colo babab          " color scheme based on elflord, slightly altered
                    " see .vim/colors/babab.vim

" Keep bak and swp files in a dedicated folder
set directory=~/.vim-bak-swp
set backup
set backupdir=~/.vim-bak-swp

" Use 4 spaces for tabs by default
set et
set ts=4
set sw=4
set sts=4

" Delete trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
"
" Highlight chars of lines exceeding 78 chars
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>79v', -1)
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Fold and unfold with spacebar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Save folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" gvim options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar

" pathogen.vim
call pathogen#infect()

" Quickly set tabstop, shiftwidth and softtabstop for a buffer in one go
function Settabbing()
    let tabbing = input("Set number of spaces [current = "
                        \ . &tabstop . "]: ")

    " TODO: test if integer
    if empty(l:tabbing) || l:tabbing < '1'
        return
    endif

    let &tabstop = l:tabbing
    let &shiftwidth = l:tabbing
    let &softtabstop = l:tabbing
endfunction

nmap <silent> ;t :call Settabbing()<CR>
