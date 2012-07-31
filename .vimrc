call pathogen#runtime_append_all_bundles()
syntax on
filetype plugin indent on

set list
set listchars=tab:>-

set helplang=ja
set number
set hidden
set wildmenu
set hlsearch
set backspace=indent,eol,start
set autoindent
set laststatus=2

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

let autodate_format="%Y/%m/%d %H:%M:%S"
let autodate_keyword_pre="$Last Update: "
let autodate_keyword_post=" ."

"inoremap <Tab> <C-o>==

scriptencoding utf-8

autocmd FileType python let g:pydiction_location = '~/.vim/pydiction/complete-dict'

autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl expandtab tabstop=4 shiftwidth=4 softtabstop=4

map mp :!pep8 %<cr>

" Execute python script C-P
 function! s:ExecPy()
     exe "!" . &ft . " %"
     :endfunction
     command! Exec call <SID>ExecPy()
     autocmd FileType python map <silent> <C-P> :call <SID>ExecPy()<CR>

""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

runtime bundles/tplugin_vim/macros/tplugin.vim

nmap <Leader>n :NERDTreeToggle<CR>

" create directory automatically
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

" colorscheme desert256
set background=dark

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#121212 ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=235

"" let g:indent_guides_enable_on_vim_startup = 1

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

" 保存時にtabを4スペースに変換する
" autocmd BufWritePre * :%s/\t/    /ge

" filetype plugin on
let g:JSLintHighlightErrorLine = 0

map js :JSLintUpdate<cr>
" GDO プロジェクト用rsync
map ss :!./syncgdo<cr>

set foldmethod=indent

