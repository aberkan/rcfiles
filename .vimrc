cd "~/khan/webapp"

set nocompatible              " be iMproved, required
filetype off                  " required

set clipboard=unnamed

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'


Plugin 'vim-syntastic/syntastic'
Plugin 'flowtype/vim-flow'

Plugin 'tmhedberg/SimpylFold'

Plugin 'kien/ctrlp.vim'
Plugin 'udalov/kotlin-vim'

Plugin 'fatih/vim-go'

Plugin 'github/copilot.vim'

" All of your Plugins must be added before the following line
call vundle#end()

" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cc,cpp AutoFormatBuffer clang-format
  " autocmd FileType proto AutoFormatBuffer clang-format
  " autocmd FileType javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  " autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

autocmd BufReadPost *
   \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
   \ |   exe "normal! g`\""
   \ | endif

autocmd BufWritePre * %s/\s\+$//e

autocmd BufNewFile,BufRead PR_EDITMSG+*.save setlocal filetype=prmessage
set fo+=t

ab sR suite.Require()
ab pfz fmt.Printf("FOO %v\n",
ab erer if err != nil {return err}
ab erern if err != nil {return nil, err}
ab erernn if err != nil {return nil, nil, err}
ab erernnn if err != nil {return nil, nil, nil, err}
ab ssp services/progress

set mouse=a
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
set incsearch

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set backupdir=~/.backup//
set directory=~/.swapdir//
let g:ycm_extra_conf_globlist = ['~/code/*']

set guifont=DejaVuSansMono:h18
set ruler
set scrolloff=5
set mousefocus

set diffopt+=internal,algorithm:patience
set nrformats=hex,bin,alpha

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <c-z> :redraw!<CR>
set hls
if has("gui_running")
    nnoremap <esc> :nohlsearch<esc>
endif

nnoremap <c-q> ggoo<esc>:.!date<CR>o<esc>28a=<esc>o<esc>

nnoremap <Leader>t :vsp %<_test.go
nnoremap <Leader>j :%!python -m json.tool
nnoremap <Leader>g :let @+ = 'https://github.com/Khan/webapp/blob/' . trim(system("git rev-parse --short HEAD")) . '/' .  @% . '#L' . line(".")

set bg=light
set foldlevel=9

set tags=~/khan/webapp/tags

cabbr <expr> %% expand('%:p:h')

let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = '--config third_party/khan-linter-src/eslintrc'
let g:syntastic_always_populate_loc_list = 1

" CtrlP {{{

let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v[\/](bower_components|node_modules|coverage|false|\.build|\.tmp|dist|docs|project|target|genfiles|kake|third_party)$'
 \ }

" Allows indexing of more files
let g:ctrlp_max_depth = 40
let g:ctrlp_match_window = 'results:20'

" Shows the hidden dot files
let g:ctrlp_show_hidden = 0

" }}}
