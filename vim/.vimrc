let data_dir = has('nvim') ? stdpath('data') . '/site' : (has('win32') ? expand('~/vimfiles') : '~/.vim')
let s:jetpack_file = data_dir . '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
if !filereadable(s:jetpack_file)
  silent execute '!curl -fLo '.data_dir.'/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim'
endif

packadd vim-jetpack
call jetpack#begin()
call jetpack#add('tani/vim-jetpack')
call jetpack#add('joshdick/onedark.vim')
call jetpack#add('cohama/lexima.vim')
call jetpack#add('machakann/vim-sandwich')
call jetpack#add('prabirshrestha/async.vim')
call jetpack#add('prabirshrestha/asyncomplete.vim')
call jetpack#add('prabirshrestha/asyncomplete-buffer.vim')
call jetpack#add('prabirshrestha/asyncomplete-file.vim')
call jetpack#add('keremc/asyncomplete-clang.vim')
call jetpack#add('akaimo/asyncomplete-around.vim')
call jetpack#add('MarcWeber/vim-addon-mw-utils')
call jetpack#add('tomtom/tlib_vim')
"Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'
call jetpack#add('yuma140902/vim-vsnip')
call jetpack#add('hrsh7th/vim-vsnip-integ')
call jetpack#add('rafamadriz/friendly-snippets')
call jetpack#add('ctrlpvim/ctrlp.vim')
call jetpack#add('yuma140902/ctrlp-grep')
call jetpack#add('tpope/vim-vinegar')
call jetpack#add('thinca/vim-qfreplace')
call jetpack#add('itchyny/vim-qfedit')
call jetpack#end()

syntax on
filetype plugin indent on
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
set laststatus=2
set listchars=tab:>\ ,trail:-,nbsp:+,eol:$
set ruler
set showcmd
set cursorline

set number

set mouse=a
set noexpandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set autoindent
set cindent
set smarttab

set scrolloff=3

set smartcase
set wrapscan
set incsearch
set hlsearch
set ignorecase

if (has("termguicolors"))
    set termguicolors
endif
colorscheme onedark

nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
nnoremap <C-h> :tabprev<CR>
nnoremap <C-l> :tabnext<CR>
tnoremap <C-h> <C-\><C-n>:tabprev<CR>
tnoremap <C-l> <C-\><C-n>:tabnext<CR>
nnoremap <space>to :term ++curwin<CR>
nnoremap <space>tt :tab ter<CR>

" asyncomplete.vim
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <c-space> <Plug>(asyncomplete_force_refresh)
" For Vim 8 (<c-@> corresponds to <c-space>):
" imap <c-@> <Plug>(asyncomplete_force_refresh)

" quickfix windowを自動で開く
augroup auto_cwindow
  autocmd!
  au QuickFixCmdPost * nested cwindow
augroup END


let g:asyncomplete_auto_popup = 1

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noselect,preview
" auto close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:asyncomplete_around_range = 50

function! s:sort_by_priority_preprocessor(options, matches) abort
  let l:items = []
  for [l:source_name, l:matches] in items(a:matches)
        for l:item in l:matches['items']
          if stridx(l:item['word'], a:options['base']) == 0
                let l:item['priority'] =
                        \ get(asyncomplete#get_source_info(l:source_name),'priority',0)
                call add(l:items, l:item)
          endif
        endfor
  endfor

  let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})

  call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

let g:asyncomplete_preprocessor = [function('s:sort_by_priority_preprocessor')]

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#around#get_source_options({
    \ 'name': 'around',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#around#completor'),
    \ }))

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \  'priority': 10
    \ }))
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#clang#get_source_options({
    \     'config': {
    \         'clang_args': {
    \             'default': ['-I/usr/include']
    \         }
    \     },
    \     'priority': 30
    \ }))
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 20,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" vim-snipmate
"let g:snipMate = {'snippet_version': 1}
"imap <C-j> <Plug>snipMateNextOrTrigger
"smap <C-j> <Plug>snipMateNextOrTrigger
"imap <C-k> <Plug>snipMateBack
"smap <C-k> <Plug>snipMateBack
"imap <C-r> <Plug>snipMateShow
"smap <C-r> <Plug>snipMateShow
"vmap <C-j> <Plug>snipMateVisual

" vim-vsnip
imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
imap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-k>'

" CtrlP
nnoremap <space>ff :CtrlPMixed<CR>
nnoremap <space>fr :CtrlPGrep<CR>
