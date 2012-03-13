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

" Use 4 spaces for tabs by default
set et
set ts=4
set sw=4
set sts=4

" Delete trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"" Indent folding with manual folds
" set foldcolumn=4
" set foldlevel=3
" augroup vimrc
    " au BufReadPre * setlocal foldmethod=indent
    " au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

" Fold and unfold with spacebar
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Save folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" pathogen.vim
call pathogen#infect()
