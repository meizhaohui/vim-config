" 在vim中输入:echo $MYVIMRC 命令可以知道文件存放位置
" :echom 会将打印的信息保存起来,可通过:messages命令查看到输出的消息
" :echo 会打印信息，但不保存
" :help echo 获取命令echo的帮助信息

" 参考:
" 1. vim学习笔记 http://yyq123.github.io/learn-vim/learn-vi-00-00-toc.html (已失效)
" 2. vimscript编程参考 https://www.w3cschool.cn/vim/nckx1pu0.html
" 3. vim-config https://github.com/pegasuswang/vim-config
" 4. 新手如何学习vimrc配置 https://zhuanlan.zhihu.com/p/50242838
" 基本设置 {{{
    " 忽略大小写检索
    set ignorecase
    " 搜索时，智能大小写
    set smartcase
    " 设置高亮搜索匹配
    set hlsearch
    " 边输入边搜索(实时搜索)
    set incsearch
    " 设置退格方式
    " indent 允许在自动缩进上退格
    " eol 允许在换行符上退格
    " start 允许在插入开始的位置上退格
    " 2 同 ":set backspace=indent,eol,start"
    set backspace=2
    " 开启新行时,从当前行复制缩进距离,即自动缩进
    set autoindent
    " 实现C程序的缩进
    set cindent 
    " 在vim执行命令行时，使用tab键自动补充,开启命令补全
    set wildmenu
    " 标尺，在右下角显示当前行号和列号,逗号分隔
    set ruler
    " 在左下角显示当前vim模式
    set showmode
    " 在插入括号时，短暂地跳转到匹配的对应括号,然后跳转回来
    set showmatch
    " 在状态栏显示正在输入的命令
    set showcmd
    " 设置命令行显示高度，默认为1行,此处为2行
    set cmdheight=2
    " 显示行号
    set number
    " 使用相对行号
    set relativenumber
    " bg, 使用深色背景上看起来舒服的颜色,也可以设置为light
    set background=dark
    " 设置tab宽度，与ts等效
    set tabstop=4
    " 当tabstop=8时，输入一次tab会显示4个空格
    " 再输入一次tab时，vim会删除前面的4个空格，并插入一个tab字符
    set softtabstop=4
    " 自动缩进时，缩进长度为4
    set shiftwidth=4
    " 在插入模式下自动将tab替换成tabstop对应的空格
    set expandtab
    " 旧文件可用的字符集
    set fileencodings=utf-8,gbk,gb18030,gk2312
    " 设置vim内部使用的字符编码
    set encoding=utf-8
    " 启动文件类型检查
    filetype on
    " 语法高亮
    syntax on
    " 显示当前光标所在行的横线
    set cursorline
    " 显示当前光标所在列的竖线
    set cursorcolumn
    " 文件未保存时进行提示
    set confirm
    " 总是显示状态栏
    set laststatus=2
    " 如果文件改动，则自动把内容写回文件
    set autowrite
    " 如果发现文件在vim之外被修改，则自动载入
    set autoread
    " 设置自动换行，如果行很长的话，超过窗口宽度的行会回绕，并在下一行继续显示
    set wrap
    " 分屏时，在右侧添加新屏
    set splitright
    " 分屏时，在下方添加新屏
    set splitbelow
    " 是否折叠,设置为关闭
    set foldlevel=20

"  }}}

" 设置键映射前缀
" 设置-减号为前缀
" 注意此处定义时变量名是mapleader，而引用时是<leader>
let mapleader = "-"

" 映射 {
    " 忘记使用sudo打开vim时，使用w!! 强制保存文件
    " allow saving of files as sudo when i forgot to start vim using sudo.
    " cmap w!! w !sudo tee > /dev/null %
    cmap w!! w !sudo sh -c "cat > %"

    " 小写s时，不执行任何操作
    map s <nop>
    " 普通模式下，按大写s保存
    map S :w<CR>
    " 普通模式下，按大写Q退出
    map Q :q<CR>
    " 普通模式下，按大写R重新加载配置,注意，需要先保存配置文件
    map R :w<CR> :source $MYVIMRC<CR> 

    " 插入模式下，按jj快捷键输入Esc退出键
    imap jj <Esc>

    " 在普通模式下，禁用方向键
    " nop 表示 no operation即无操作
    " 正确的移动方式是，退出插入模式，在普通模式下进行移动
    " 在普通模式下使用hjkl进行向左,向下,向上,向右移动
    map <LEFT> <nop>
    map <RIGHT> <nop>
    map <UP> <nop>
    map <DOWN> <nop>
    " 在插入模式下也禁用方向键
    imap <LEFT> <nop>
    imap <RIGHT> <nop>
    imap <UP> <nop>
    imap <DOWN> <nop>
   
    " 按F2插入文件注释信息
    map <F2> :call setcomment()<CR>:10<CR>o

    " 设置进入粘贴模式快捷键F10
    map <F10> :set paste<CR>
    " F9退出粘贴模式
    map <F9> :set nopaste<CR>

    " 通过按9跳转到行末尾，0默认跳转到行首
    map 9 $

    " ctrl + a 选中文本所有内容
    map <silent> <c-a> gg v g$
   
    " 普通模式下，编辑我的.vimrc配置文件
    nnoremap <leader>ev :vsplit $MYVIMRC<CR>

    " 普通模式下，重新加载.vimrc配置文件
    nnoremap <leader>sv :source $MYVIMRC<CR>
    
    " 插入模式下，将该单词转换成大写
    " imap <leader>u <esc>viwu<esc>i

"  }


" 文件头注释 { 
    "Set Comment START
    autocmd BufNewFile *.c,*.py,*.go,*.sh exec ":call SetComment()" |normal 10Go
    func SetComment()
        if expand("%:e") == 'c'
            call setline(1, "/*")
            call append(1, ' *      Filename: '.expand("%"))
            call append(2, ' *        Author: zhaohui mei<mzh.whut@gmail.com>')
            call append(3, ' *   Description:      ')
            call append(4, ' *   Create Time: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(5, ' * Last Modified: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(6, ' */')
            call append(7, '')
            call append(8, '')
            call append(9, '')
            call append(10, '')
        elseif expand("%:e") == 'go'
            call setline(1, "/*")
            call append(1, ' *      Filename: '.expand("%"))
            call append(2, ' *        Author: zhaohui mei<mzh.whut@gmail.com>')
            call append(3, ' *   Description:      ')
            call append(4, ' *   Create Time: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(5, ' * Last Modified: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(6, ' */')
            call append(7, 'package main')
            call append(8, '')
            call append(9, 'import "fmt"')
            call append(10, '')
            call append(11, 'func main() {')
            call append(12, '    fmt.println("vim-go")')
            call append(13, '}')
       elseif expand("%:e") == 'py'
            call setline(1, '#!/usr/bin/python3')
            call append(1, '"""')
            call append(2, '#      Filename: '.expand("%"))
            call append(3, '#        Author: zhaohui mei<mzh.whut@gmail.com>')
            call append(4, '#   Description:      ')
            call append(5, '#   Create Time: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(6, '# Last Modified: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(7, '"""')
            call append(8, '')
            call append(9, '')
            call append(10, '')
        elseif expand("%:e") == 'sh'
            call setline(1, '#!/bin/bash')
            call append(1, '##################################################')
            call append(2, '#      Filename: '.expand("%"))
            call append(3, '#        Author: zhaohui mei<mzh.whut@gmail.com>')
            call append(4, '#   Description:      ')
            call append(5, '#   Create Time: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(6, '# Last Modified: '.strftime("%y-%m-%d %h:%m:%s"))
            call append(7, '##################################################')
            call append(8, '')
            call append(9, '')
            call append(10, '')
            endif
    endfunc
    "Set Comment END
" 文件头注释 }


    " SET Last Modified Time START
   func DataInsert()
		if expand("%:e") == 'c' || expand("%:e") == 'go'
			call cursor(6, 1)
			if search ('Last Modified') != 0
				let line = line('.')
				call setline(line, ' * Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
			endif
		elseif expand("%:e") == 'py' || expand("%:e") == 'sh'
			call cursor(7, 1)
			if search ('Last Modified') != 0
				let line = line('.')
				call setline(line, '# Last Modified: '.strftime("%Y-%m-%d %H:%M:%S"))
			endif
		endif
	endfunc
	autocmd FileWritePre,BufWritePre *.c,*.py,*.go,*.sh ks|call DataInsert() |'s
	"SET Last Modified Time END

    " refer:https://blog.csdn.net/qq844352155/article/details/50513072
"  }


" 参考 vim自动加载
" https://yianwillis.github.io/vimcdoc/doc/quickref.html#option-list
" https://www.w3cschool.cn/vim/xenarozt.html
" 检查不同文件类型，设置不同的tab宽度
autocmd filetype c set tabstop=4
autocmd filetype html set tabstop=2
autocmd filetype html set softtabstop=2 |set tabstop=2 |set shiftwidth=2

" 插件设置
call plug#begin()

" initialize plugin system
call plug#end()
