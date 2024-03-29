-call plug#begin('~/.vim/plugged')

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" UI
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Markdown
Plug 'rhysd/vim-gfm-syntax'
Plug 'chmp/mdnav'

" Writing code
"" Javascript
Plug 'pangloss/vim-javascript'
" Plug 'Quramy/vim-js-pretty-template'
" Plug 'moll/vim-node'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }

"" GLSL
 Plug 'tikhomirov/vim-glsl'
"" Rust
" Plug 'rust-lang/rust.vim'

Plug 'JuliaEditorSupport/julia-vim'

" Utilities
Plug 'guns/xterm-color-table.vim'
Plug 'tpope/vim-commentary'
Plug 'pbrisbin/vim-mkdir'
Plug 'w0rp/ale'

call plug#end()

filetype off                  " required!
filetype indent on
filetype plugin indent on

syntax enable
set t_Co=256

" colorscheme solarized
set background=light

" call jspretmpl#register_tag('html', 'html')
" call jspretmpl#register_tag('css', 'css')
" autocmd FileType javascript JsPreTmpl html

if has('gui_running')
  set guifont=Fira\ Mono:h12
  colorscheme solarized
  set background=light
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
endif

set ttyfast
set lazyredraw
set showtabline=2
set laststatus=2
set cursorline

set nonumber
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set showcmd
set wildmenu
" set showmatch
set incsearch
set hlsearch
" set matchtime=1
set smartindent
set nowrap
set noerrorbells         " don't beep
set shell=bash
set hidden               " don't complain about unsaved buffers
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Update gutter quicker
set updatetime=250
let g:gitgutter_eager = 0

set mouse=a "lord forgive me

" make netrw look ok
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" status line design
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

let mapleader = "\<Space>"

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" REMAPPINGS

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>so :source ~/.vimrc<cr>

vnoremap <leader>y "+y

" close buffer without destroying layout
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Console log word under cursor
nnoremap <leader>l yiWo console.log(<esc>pa)<esc>=l

" Cycle buffers
:nnoremap <S-l> :bnext!<CR>
:nnoremap <S-h> :bprevious!<CR>

" Remove trailing whitespaces
nnoremap <silent> <Leader><BS> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let@/=_s<Bar>:nohl<CR>:w<CR>

" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>

" When copying and pasting - move to end of selection
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

noremap <leader>j 15j
noremap <leader>k 15k

" AUTOCOMMANDS

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\" " |
      \ endif

autocmd BufNewFile,BufRead *.json set ft=javascript

" PLUGINS
nnoremap <silent> <leader>f :FZF<cr>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " let g:gitgutter_grep_command = 'ag'
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Ale
let g:ale_fixers = {'javascript': ['']}
let g:ale_linters = {'javascript': ['standard']}
let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'never' " Only lint when text is saved.
let g:ale_set_highlights = 1

" wrap text in markdown
au BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'sh', 'html', 'vim', 'json']
let g:gfm_syntax_emoji_conceal = 1

" markdown crap
function! SwitchStatus()
  let current_line = getline('.')
  if match(current_line, '^\s*[*\-+] \[ \]') >= 0
    call setline('.', substitute(current_line, '^\(\s*[*\-+]\) \[ \]', '\1 [x]', ''))
    return
  endif
  if match(current_line, '^\s*[*\-+] \[x\]') >= 0
    call setline('.', substitute(current_line, '^\(\s*[*\-+]\) \[x\]', '\1 [ ]', ''))
    return
  endif
endfunction

map <leader>x :call SwitchStatus()<cr>
