" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:

" Environment {{{
    " Basics {{{
        set nocompatible        " must be first line
    " }}}

    " Windows Compatible {{{
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('win32') || has('win64')
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
        if exists('+shellslash')
            " Do the same what improved M$ cmd does but in reverse :)
            " Use forward backslashes as directory separator on Windows.
            " If you type backwards slashes, Vim will upgrade them to forward backslashes.
            set shellslash
        endif
    " }}}

    " Basic functions {{{
    function! EnsureDirExists (dir)
        if !isdirectory(a:dir)
            if exists("*mkdir")
                call mkdir(a:dir,'p')
            else
                echo "Please create directory: " . a:dir
            endif
        endif
    endfunction
    " }}}
" }}}

    " Key (re)Mappings {{{
    " Mappings which only work with plugins enabled should be placed in the
    " Plugin section.

    " Hack to make mappings using the Alt or Meta key working {{{
    " http://stackoverflow.com/a/10216459/2239985
        " let c='a'
        " while c <= 'z'
            " exec "set <A-".c.">=\e".c
            " exec "inoremap \e".c." <A-".c.">"
            " let c = nr2char(1+char2nr(c))
        " endw

        " set timeout ttimeoutlen=50
        " " these two work in vim
        " " shrtcut with alt key: press Ctrl-v then Alt-k
        " " ATTENTION: the following two lines should not be
        " " edited under other editors like gedit. ^[k and ^[j will be broken!
        " nnoremap ^[k :set paste<CR>m`O<Esc>``:set nopaste<CR>
        " nnoremap ^[j :set paste<CR>m`o<Esc>``:set nopaste<CR>
    " }}}

    " Overwrite default Vim mappings {{{
        " Function to overwrite build-in commands {{{
            " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
            " function! CommandCabbr(abbreviation, expansion) execute 'cabbr ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
            " endfunction
            " command! -nargs=+ CommandCabbr call CommandCabbr(<f-args>)
        " }}}

        " Use it on itself to define a simpler abbreviation for itself.
        " CommandCabbr s perldo
        " command! s echo "Use perldo"

        " Wrapped lines goes down/up to next row, rather than next line in file.
        " Does this slow down the scrolling in my configuration?
        noremap j gj
        noremap k gk

        " Visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv

        " Use space to toggle folds open/closed
        " Credits for this go to: https://www.youtube.com/watch?v=Yiw2f3m73Fo
        noremap <space> za

        " http://vim.wikia.com/wiki/Highlight_all_search_pattern_matches#Highlight_matches_without_moving
        " let g:highlighting = 0
        " function! Highlighting()
          " if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
            " let g:highlighting = 0
            " return ":silent nohlsearch\<CR>"
          " endif
          " let @/ = '\<'.expand('<cword>').'\>'
          " let g:highlighting = 1
          " return ":silent set hlsearch\<CR>"
        " endfunction
        " nnoremap <silent> <expr> <Space> Highlighting()
        " Replaced by 'https://github.com/t9md/vim-quickhl'
    " }}}

    " Map leader mappings {{{
        let mapleader = ','

        " Save and go to normal mode
        noremap <Leader>s :update<CR>
        inoremap <Leader>s <ESC>:update<CR>l

        " Filetype detact
        noremap <Leader>fd :filetype detect<CR>
        inoremap <Leader>fd <c-o>:filetype detect<CR>

        " Run make, http://stackoverflow.com/a/11590512
        noremap <Leader>fe :silent make\|redraw!\|cc<CR>
        inoremap <Leader>fe <ESC>:silent make\|redraw!\|cc<CR>

        " Open my .vimrc
        noremap <Leader>ff :tabnew $MYVIMRC<CR>
        noremap <Leader>fm :tabnew $HOME/.vimrc.min<CR>

        " Save and exit
        noremap <Leader>x :x<CR>
        inoremap <Leader>x <ESC>:x<CR>
        noremap ϵ :x<cr>
        inoremap ϵ <ESC>:x<cr>
        " Shift+Layer3Mod+x

        " Quick quit command
        noremap <Leader>e :quit<CR>
        noremap ❤ :quit<CR>
        " Shift+Layer3Mod+w

        " Quit all windows
        noremap <Leader>E :quit!<CR>
        " noremap λ :quit!<CR>
        " Shift+Layer3Mod+e

        " Code folding options {{{
            " noremap <leader>f0 :set foldlevel=0<CR>
            " Use zM for this
            noremap <leader>f1 :set foldlevel=1<CR>
            noremap <leader>f2 :set foldlevel=2<CR>
            noremap <leader>f3 :set foldlevel=3<CR>
            noremap <leader>f4 :set foldlevel=4<CR>
            noremap <leader>f5 :set foldlevel=5<CR>
            noremap <leader>f6 :set foldlevel=6<CR>
            noremap <leader>f7 :set foldlevel=7<CR>
            noremap <leader>f8 :set foldlevel=8<CR>
            noremap <leader>f9 :set foldlevel=9<CR>
        " }}}

       " Toggle highlight search
        noremap <silent> <Leader>B :set invhlsearch<CR>
        inoremap <silent> <Leader>B <c-o>:set invhlsearch<CR>
        noremap <silent> <Leader>b :nohlsearch<CR>
        inoremap <silent> <Leader>b <c-o>:nohlsearch<CR>

        " let hlstate=0
        " let lastsearchstring = @/
        " noremap <Leader>b :call Togglehlsearch()<CR>

        " let hlstate=0
        " nnoremap  :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

        " Bind set list
        noremap <Leader>l :set list!<CR>
        inoremap <Leader>l <c-o>:set list!<CR>

        " Insert current full path of the file
        inoremap <Leader>fp <ESC>:put =expand('%:p')<CR>kJA

        " Insert current file name
        " inoremap <Leader>fn <ESC>"%p<CR>g;
        " Just use Ctrl-r%

        " Spellcheck { set spellfile=~/.vim/spell/en.utf-8.add set dictionary+=/usr/share/dict/words
            " English is the default. German is legacy and is to be enabled
            " only as needed.
            if has('win32') || has('win64')
                set spelllang=en_us
            else
                set spelllang=en_us,de_de
            endif
            noremap <Leader>cd :set spell!<CR>
            inoremap <Leader>cd <c-o>:set spell!<CR>
        " }}}

        " easier moving between tabs
        noremap σ :tabprevious<CR>
        inoremap σ <c-o>:tabprevious<CR>
        " Shift+Layer3Mod+h
        noremap τ :tabnext<CR>
        inoremap τ <c-o>:tabnext<CR>
        " Shift+Layer3Mod+l

        " https://superuser.com/questions/277787/vim-map-a-key-combination-while-in-insert-mode
        " <c-tab> did not work.
        " noremap <Tab> :tabn<CR>
        " Does interfere with c-i ?
        " inoremap <Tab> <c-o>:tabn<CR>

        " set the executable bit
        noremap <Leader>y :w!<CR>:!chmod +x "%"<CR>
        inoremap <Leader>y <ESC>:w!<CR>:!chmod +x "%"<CR>

        " noremap <Leader>d :echo strftime("%Y-%m-%d_%H:%M")<CR>

        function! TranslateDateVisual()
            sil! norm! gv"ty
            echo system('date -d @'. @t)
        endfunction

        function! InsertDateVisual()
            sil! norm! gv"ty
            exec "normal! cw".system('date -d @'. @t)
        endfunction

        " Translate the current word (Unix time stamp) to a human readable time.
        noremap <Leader>td :echo system('date -d @'.expand('<cword>'))<CR>
        vmap <Leader>td :call TranslateDateVisual()<CR>

        " Append modeline after last line in buffer.
        " Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
        " files.
        function! AppendModeline()
            let l:modeline = printf("vim: set ts=%d sw=%d tw=%d %set :",
                        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
            call append(line("$"), l:modeline)
            normal '.
            call NERDComment('n', 'Toggle')
        endfunction
        nnoremap <silent> <Leader>am :call AppendModeline()<CR>

        function! SwitchSourceHeader()
            "update!
            if (expand ("%:e") == "cpp")
                find %:t:r.h
            else
                find %:t:r.cpp
            endif
        endfunction

        nmap <Leader>fs :call SwitchSourceHeader()<CR>

        " nnoremap <silent> <Leader>ad :r!date<CR>

        " Copy the hole puffer to primary system clipboard, without the
        " newline at the end …
        " I am using this to write my texts in Vim and copy them in all sorts
        " of text boxes.
        noremap η :normal gg0vG$h"+y<CR>:echo "Copied buffer content to primary clipboard"<CR>
        " Shift+Layer3Mod+c

        noremap <silent> <Leader>tp :split<CR>:resize 6<CR>hh<C-]><c-w><c-k>

        function! AppendFoldMarker(fold)
            if (a:fold == "open")
                silent! substitute#[^*][^/]\zs\s\?$# /* {{{ */#
            else
                silent! substitute#[^*][^/]\zs\s\?$# /* }}} */#
            endif
            echo
            nohlsearch
        endfunction

        nnoremap <Leader>fa :call AppendFoldMarker('open')<cr>
        inoremap <Leader>fa <ESC>:call AppendFoldMarker('open')<cr>
        nnoremap <Leader>fj :call AppendFoldMarker('close')<cr>
        inoremap <Leader>fj <ESC>:call AppendFoldMarker('close')<cr>;

        function! DoPrettyXML()
            " save the filetype so we can restore it later
            let l:origft = &ft
            set ft=
            " delete the xml header if it exists. This will
            " permit us to surround the document with fake tags
            " without creating invalid xml.
            1s/<?xml .*?>//e
            " insert fake tags around the entire document.
            " This will permit us to pretty-format excerpts of
            " XML that may contain multiple top-level elements.
            0put ='<PrettyXML>'
            $put ='</PrettyXML>'
            silent %!xmllint --format -
            " xmllint will insert an <?xml?> header. it's easy enough to delete
            " if you don't want it.
            " delete the fake tags
            2d
            $d
            " restore the 'normal' indentation, which is one extra level
            " too deep due to the extra tags we wrapped around the document.
            silent %<
            " back to home
            1
            " restore the filetype
            exe "set ft=" . l:origft
        endfunction
        command! PrettyXML call DoPrettyXML()

        " http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file#Extended_version
        function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
            let ft=toupper(a:filetype)
            let group='textGroup'.ft
            if exists('b:current_syntax')
                let s:current_syntax=b:current_syntax
                " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
                " do nothing if b:current_syntax is defined.
                unlet b:current_syntax
            endif
            execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
            try
                execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
            catch
            endtry
            if exists('s:current_syntax')
                let b:current_syntax=s:current_syntax
            else
                unlet b:current_syntax
            endif
            execute 'syntax region textSnip'.ft.'
                        \ matchgroup='.a:textSnipHl.'
                        \ start="'.a:start.'" end="'.a:end.'"
                        \ contains=@'.group
        endfunction

        " https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
        function! SynStack()
            if !exists("*synstack")
                return
            endif
            echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
        endfunc

        " https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim
        function! SynGroup()
            let l:s = synID(line('.'), col('.'), 1)
            echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
        endfun

    " }}}

    " Other mappings {{{
        set pastetoggle=♡           " pastetoggle (sane indentation on pastes)
        " Shift+Layer3Mod+a


        " Easier horizontal scrolling
        noremap zl zL
        noremap zh zH

        " Ctrl+a is used by tmux and screen
        noremap <c-s> <c-a>
        noremap <c-a> <Nop>
        " Don‘t use Ctrl+a even if not in tmux.

        " Every unnecessary keystroke that can be saved is good for your health :)
        noremap <silent> <c-j> <c-w>j
        noremap <silent> <c-k> <c-w>k
        noremap <silent> <c-l> <c-w>l
        noremap <silent> <c-h> <c-w>h

        " This should be Shift+Layer3Mod+d but Shift+Layer3Mod+s does not work
        " on openSUSE so we are using Shift+Layer3Mod+s for <c-w>_ and Shift+Layer3Mod+d for :Lookup
        noremap ι <c-w>_
        " Shift+Layer3Mod+s

        " http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
        inoremap <c-u> <c-g>u<c-u>
        inoremap <c-w> <c-g>u<c-w>

        " Shortcuts
        " Change Working Directory to that of the current file
        cmap cwd lcd %:p:h
        cmap cd. lcd %:p:h

        " For when you forget to sudo.. Really Write the file.
        cmap w!! w !sudo tee % >/dev/null

        " I use this so that Ctrl-c also works in the command-line window like Escape.
        " Does not work
        " noremap <c-c> <ESC>
        "
        " inoremap <c-c> <Nop>
        " Use Neo2 Escape because it works everywhere.
        " Disabling because it breaks Cygwin + qNeo2 setup.

        " noremap <c-m> <c-t>
        " Does also remap <return> to <c-t>
        " nnoremap <c-n> <c-]>
        " Put it into ~/.vim/after/plugin/overwrite.vim

        command! -complete=file -nargs=? O tabnew <args>
    " }}}

    " Disabled (because I did not like them) {{{
        " nnoremap <silent> n nzt
        " nnoremap <silent> N Nzb
    " }}}

    " Disabled (mostly because of incompatibilities) {{{
        " The following two lines conflict with moving to top and
        " bottom of the screen
        " noremap <S-H> gT
        " noremap <S-L> gt
        "
        " noremap <c-d> :echo "Use Neo2 movments."<cr>
        " noremap <c-u> :echo "Use Neo2 movments."<cr>

        " Unbind the cursor keys in insert, normal and visual modes.
        " Luckily I do not use them anymore because they are so far away.
        " But there are better ways to send those keycodes.
        " for prefix in ['i', 'n', 'v']
        "     for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        "         exe prefix . "noremap " . key . " <Nop>"
        "     endfor
        " endfor
    " }}}

    " Avoid bad behavior {{{
        " noremap <c-z> :echo "Use Ctrl+a m to create a new window in the same directory"<cr>
        " inoremap <c-z> :echo "Use Ctrl+a m to create a new window in the same directory"<cr>
        " Has many valid use cases.

    " }}}

" General {{{
    set mousehide               " Hide the mouse cursor while typing
    set mouse=a                 " Enable mouse wheel scrolling
    scriptencoding utf-8

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    " set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    " set hidden                          " Allow buffer switching without saving
    set splitbelow                      " Open new splits below (for Gdiff)
    if exists("&fileignorecase")
        set fileignorecase              " Comes in very handy when your are used to ZSH.
    endif
    set ignorecase                      " Comes in very handy when your are used to ZSH.
    set expandtab
    set tags=./tags;/                   " Look in all upper Directorys for tags files
    " Did not work. http://stackoverflow.com/a/741486

    set ttimeoutlen=5
    " http://www.johnhawthorn.com/2012/09/vi-escape-delays/

    set iskeyword+=-
    set iskeyword-=:
    set commentstring=#%s

    " Setting up the directories {{{
        call EnsureDirExists($HOME . '/.cache/vim/swap')
        set directory=~/.cache/vim/swap/
        set writebackup

        " call EnsureDirExists($HOME . '/.vimbackup')
        " set backup                  " Backups are nice ...
        " set backupskip=/tmp/*,crypt,sec,mnt
        " set backupdir=~/.vimbackup,/var/tmp,/tmp,.

        call EnsureDirExists($HOME . '/.cache/vim/view')
        set viewdir=~/.cache/vim/view/

        if has('persistent_undo')
            call EnsureDirExists($HOME . '/.cache/vim/undo')
            set undofile
            set undodir=~/.cache/vim/undo/
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " https://vi.stackexchange.com/a/10029
        if !has('nvim')
            set viminfo+=n~/.cache/vim/viminfo
        else
            " Do nothing here to use the neovim default
            set viminfo+=n~/.cache/vim/main.shada
        endif

        let g:skipview_files = [
            \ '*sec*',
            \ '*crypt*'
            \ ]
    " }}}

    " IncludeExprForSmartGF {{{
    function! IncludeExprForSmartGF(fname)
        " When attempting to open a relative file and it does not yet exist,
        " create it.
        " This function hooks into normal mode commands like gf and create creates
        " the file if it does not yet exist. It is only executed if the file
        " cannot be found by Vim itself.

        " Improved version of https://stackoverflow.com/questions/6158294/create-and-open-for-editing-nonexistent-file-under-the-cursor/6159415#6159415
        " TODO: POST to Stackoverflow.
        let fname = a:fname

        " call system("echo " . fname . " >> /tmp/log")
        " let fname = substitute(fname,'^.*','/tmp/sd','')

        if match(fname, '^/') == -1
            if !filereadable(fname)
                call EnsureDirExists(fnamemodify(fname, ":p:h"))
                call system("touch " . fname)
            endif
        endif

        return fname
    endfunction

    set includeexpr=IncludeExprForSmartGF(v:fname)
    " }}}
" }}}

" Vim UI {{{
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number
    set winminheight=0              " Windows can be 0 line high
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=0                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set foldopen+=search
    set foldmethod=marker
    set nolist
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" }}}

" Settings if used standalone {{{
    if !exists('g:config_section_enable')
        syntax on
        syntax spell toplevel
        highlight clear SpellBad
        highlight SpellBad cterm=underline ctermbg=None
        highlight SpellCap cterm=underline ctermbg=None
        highlight DiffChange ctermbg=Yellow
    endif
" }}}

" GUI Settings {{{
    " GVIM- (here instead of .gvimrc)
    if !exists('g:config_section_enable') || count(g:config_section_enable, 'gui_config')
        if has('gui_running')
            set guioptions-=T           " Remove the toolbar
            set lines=40                " 40 lines of text instead of 24
            if has("gui_gtk2")
                set guifont=Andale\ Mono\ Regular\ 15,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 12
            elseif has("gui_mac")
                set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
            elseif has("gui_win32")
                set guifont=Andale_Mono:h12,Menlo:h12,Consolas:h12,Courier_New:h12
                set encoding=utf-8
            endif
            if has('gui_macvim')
                set transparency=5      " Make the window slightly transparent
            endif
        else
            if &term == 'xterm' || &term == 'screen'
                set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
            endif
            "set term=builtin_ansi       " Make arrow and other keys work
        endif
    endif
" }}}

" M$ Windows specifics {{{
    " Vim on Windows is not able to run my fully blown config with plugins.
    if has('win32') || has('win64')
        if filereadable(expand("~/.config/dotfiles/vim/bundle/outlook/plugin/outlook.vim"))
            source ~/.config/dotfiles/vim/bundle/outlook/plugin/outlook.vim
            let g:outlook_Javascript = '$HOME/.config/dotfiles/vim/bundle/outlook/plugin/outlookvim.js'
        endif
    endif
" }}}

" Machine specific configuration {{{
    if filereadable(expand("~/.vimrc.private"))
        " Synced on trusted systems. On others it can be created and the
        " content will not be synced.
        source ~/.vimrc.private
    endif
    if filereadable(expand("~/.vimrc.local"))
        " Machine specific.
        source ~/.vimrc.local
    endif
" }}}
