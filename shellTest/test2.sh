#!/usr/bin/env bash
#函数
#注意函数体的左花括号'{'和后面的命令之间必须有空格或换行，如果将最后一条命令和右花括号'}'写在同一行，命令末尾必须有;号。
fun()
{
    echo "hello"
    echo $0 #返回整个程序名
    echo $1
    echo $2
    echo $3
    echo "hello"
}
echo "start-------"
fun
echo "end---------"
echo

echo "start-------"
fun aa bb 11
echo "end---------"


#Shell脚本的调试方法

#-n
#读一遍脚本中的命令但不执行，用于检查脚本中的语法错误

#-v
#一边执行脚本，一边将执行过的脚本命令打印到标准错误输出

#-x
#提供跟踪执行信息，将执行的每一条命令和结果依次打印出来
#
#使用这些选项有三种方法，一是在命令行提供参数
#
#    $ sh -x ./script.sh
#二是在脚本开头提供参数
#
#    #! /bin/sh -x
#第三种方法是在脚本中用set命令启用或禁用参数
#
#    #! /bin/sh
#    if [ -z "$1" ]; then
#      set -x
#      echo "ERROR: Insufficient Args."
#      exit 1
#      set +x
#    fi
#set -x和set +x分别表示启用和禁用-x参数，这样可以只对脚本中的某一段进行跟踪调试

#正则表达式

#字符类
#字符  含义               举例
#.   匹配任意一个字符          abc.可以匹配abcd、abc9等
#[]  匹配括号中的任意一个字符  [abc]d可以匹配ad、bd或cd
#-   在[]括号内表示字符范围    [0-9a-fA-F]可以匹配一位十六进制数字
#^   位于[]括号内的开头，匹配除括号中的字符之外的任意一个字符  [^xy]匹配除xy之外的任一字符，因此[^xy]1可以匹配a1、b1但不匹配x1、y1
#
#[[:xxx:]]   grep工具预定义的一些命名字符类   [[:alpha:]]匹配一个字母，[[:digit:]]匹配一个数字

#数量限定符
#字符  含义                             举例
#?   紧跟在它前面的单元应匹配零次或一次    [0-9]?\.[0-9]匹配0.0、2.3、.5等，由于.在正则表达式中是一个特殊字符，所以需要用\转义一下，取字面值
#+   紧跟在它前面的单元应匹配一次或多次    [a-zA-Z0-9_.-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z0-9_.-]+匹配email地址
#*   紧跟在它前面的单元应匹配零次或多次    [0-9][0-9]*匹配至少一位数字，等价于[0-9]+，[a-zA-Z_]+[a-zA-Z_0-9]*匹配C语言的标识符
#{N} 紧跟在它前面的单元应精确匹配N次       [1-9][0-9]{2}匹配从100到999的整数
#{N,}  紧跟在它前面的单元应匹配至少N次     [1-9][0-9]{2,}匹配三位以上（含三位）的整数
#{,M}  紧跟在它前面的单元应匹配最多M次     [0-9]{,1}相当于[0-9]?
#{N,M} 紧跟在它前面的单元应匹配至少N次，最多M次   [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}匹配IP地址

#位置限定符
#    字符  含义                举例
#    ^   匹配行首的位置        ^Content匹配位于一行开头的Content
#    $   匹配行末的位置        ;$匹配位于一行结尾的;号，^$匹配空行
#    \<  匹配单词开头的位置    \<th匹配... this，但不匹配ethernet、tenth
#    \>  匹配单词结尾的位置    p\>匹配leap ...，但不匹配parent、sleepy
#    \b  匹配单词开头或结尾的位置     \bat\b匹配... at ...，但不匹配cat、atexit、batch
#    \B  匹配非单词开头和结尾的位置   \Bat\B匹配battery，但不匹配... attend、hat ...

#其它特殊字符
#
#字符  含义                                              举例
#\    转义字符，普通字符转义为特殊字符，特殊字符转义为普通字符   普通字符<写成\<表示单词开头的位置，特殊字符.写成\.以及\写成\\就当作普通字符来匹配
#()   将正则表达式的一部分括起来组成一个单元，可以对整个单元使用数量限定符    ([0-9]{1,3}\.){3}[0-9]{1,3}匹配IP地址
#|    连接两个子表达式，表示或的关系     n(o|either)匹配no或neither

#grep 有扩展正则和基本正则
#grep而不是egrep，并且不加-E参数，则应该遵照Basic规范来写正则表达式。字符?+{}|()应解释为普通字符，要表示上述特殊含义则需要加\转义
#反之为扩展正则不需要对字符?+{}|()进行转义
echo "-E 将范本样式为延伸的普通表示法来使用，意味着使用能使用扩展正则表达式。"
grep -E "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/output.csv| head
echo '------------'
grep "\([0-9]\{1,4\}\-\)\{2\}[0-9]\{1,4\}"  ~/output.csv|head
echo '------------'
egrep "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/output.csv| head

#shell编辑常用的工具 grep find awk sed xargs
#grep 文本搜索工具，它能使用正则表达式搜索文本，并把匹 配的行打印出来。
#grep家族包括grep、egrep和fgrep。
#egrep是grep的扩展，支持更多的re元字符，
#fgrep就是fixed grep或fast grep，它们把所有的字母都看作单词，也就是说，正则表达式中的元字符表示回其自身的字面意义，不再特殊。
#linux使用GNU版本的grep。它功能更强，可以通过-G、-E、-F命令行选项来使用egrep和fgrep的功能。
echo
echo "-n：显示匹配行及 行号。"
egrep -n "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/output.csv| head -n 5
echo
echo "-i：不区分大小写。"
egrep -i -n "[a-z]{2}" ~/*| head -n 5
echo
echo "-y 此参数效果跟“-i”相同。"
egrep -y -n "[a-z]{2}" ~/*| head -n 5
echo
echo " -v：显示不包含匹配文本的所有行。"
egrep -v -n "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/output.csv| head -n 5
echo
echo "-w 只显示全字符合的列。"
egrep -w -n -i "[a-z]{2}" ~/*.csv| head -n 5
echo
echo "-x 显示与指定模式精确匹配而不含其他字符的行。。"
egrep -x -n -i "[a-z]{2}" ~/*| head -n 5
echo
echo "-o 只输出文件中匹配到的部分。"
egrep -w -n -i -o "[a-z]{2}" ~/*.csv| head -n 5
echo
echo "-q 不显示任何信息。"
egrep -w -n -i -o -q "[a-z]{2}" ~/*.csv| head -n 5
echo
echo "-d<进行动作> 当指定要查找的是目录而非文件时，必须使用这项参数，否则grep命令将回报信息并停止动作"
echo "-d read(读取)，读取目录下的所有文档和文件夹，也就是说此资料夹会被视为一般的档案，返回符合条件的文件和文件夹。非递归"
egrep -d "[a-z]{2}" ~/*
egrep -d read -w "[a-z]{2}" ~/* | head -n 5
echo "-d skip(略过)，仅读取目录下的文档，忽略文件夹，返回符合条件的文件，非递归"
egrep -d skip -w "[a-z]{2}" ~/* | head -n 5
echo "-d recurse(递归)，grep会去读取资料夹下所有的档案,此相当於-r 参数。"
egrep -d recurse "[a-z]{2}" ~/* | head -n 5
echo
echo "-R/-r 此参数的效果和指定“-d recurse”参数相同。"
egrep -r "[a-z]{2}" ~/* | head -n 5
echo
echo "-f<范本文件> 指定范本文件，其内容有一个或多个范本样式即固定字符串(非正则字符串)，让grep查找符合范本条件的文件内容，格式为每一列的范本样式。"
grep -d skip -f ~/ab.txt ~/*.csv | head -n 5
echo "-----------------"
grep -d skip -f ~/aa.txt ~/output.csv   #返回output.csv中与aa.txt重叠的内容
echo "-----------------"
grep -d skip -v -f ~/aa.txt ~/output.csv |head -n 5   #返回output.csv中非重叠的内容
echo
echo "-F 过滤固定字符串(非正则字符串) 与grep配合使用"
grep -d skip -F "ab" ~/*| head -n 5
echo
echo "-s：不显示不存在或无匹配文本的错误信息"
egrep -s "[a-z]{2}" ~/123.csv|head
echo
echo "-l 查询多文件时指数出包含匹配字符的文件名"
egrep -l "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/*.csv| head -n 5
echo
echo "-L 列出文件内容不符合指定的范本样式的文件名称和文件夹名称。"
egrep -L -s "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/*| head -n 5
echo
echo "-h：查询多文件时不显示文件名。默认查找多文件时显示文件名"
egrep -h -i -n "[a-z]{2}" ~/*.csv| head -n 5
echo
echo "-H 在显示符合范本样式的那一列之前，标示该列的文件名称。"
egrep -H -i -n "[a-z]{2}" ~/*.csv| head -n 5
echo
echo "-c 计算符合范本样式的列数"
egrep -c "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/*.csv
echo
echo "-C<显示列数>或-<显示列数>  过滤文件对应列符合范本样式的内容，返回的内容除了显示符合范本样式的那一列之外，并显示该列之前后的内容"
egrep -C 2 "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/aa.txt
echo
echo "-a 不要忽略二进制数据。
      -A<显示列数> 除了显示对应列符合范本样式的那一行之外，并显示该行之后的内容"
egrep -A 2 "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/aa.txt
echo
echo "-b 仅显示符合范本样式的那一行以及该行之前的内容。"
egrep -b "([0-9]{1,4}\-){2}[0-9]{1,4}\," ~/aa.txt
echo
echo "-G 将范本样式视为普通的表示法来使用。过滤固定字符串(非正则字符串) "
grep -G "2017" ~/aa.txt

#find命令的一般形式为:find pathname -options [-print -exec -ok ...]
#find命令的参数；
#pathname: find命令所查找的目录路径。例如用.来表示当前目录，用/来表示系统根目录，递归查找。
#-print： find命令将匹配的文件输出到标准输出。
#-exec： find命令对匹配的文件执行该参数所给出的shell命令。相应命令的形式为'command' {  } \;，注意{   }和\；之间的空格。
#-ok： 和-exec的作用相同，只不过以一种更为安全的模式来执行该参数所给出的shell命令，在执行每一个命令之前，都会给出提示，让用户来确定是否执行。
#
#find命令选项
#-name   按照文件名查找文件。
#-type   查找某一类型的文件，诸如：
#    b - 块设备文件。
#    d - 目录。
#    c - 字符设备文件。
#    p - 管道文件。
#    l - 符号链接文件。
#    f - 普通文件。
#-size n：[c] 查找文件长度为n块的文件，带有c时表示文件长度以字节计.
#-follow  如果find命令遇到符号链接文件，就跟踪至链接所指向的文件。
#-perm   按照文件权限来查找文件。
#-prune  使用这一选项可以使find命令不在当前指定的目录中查找，如果同时使用-depth选项，那么-prune将被find命令忽略。
#-depth   在查找文件时，首先查找当前目录中的文件，然后再在其子目录中查找。
#-user   按照文件属主来查找文件。
#-group  按照文件所属的组来查找文件。
#-mtime -n +n 按照文件的更改时间来查找文件，-n表示文件更改时间距现在n天以内，+n表示文件更改时间距现在n天以前。find命令还有-atime和-ctime 选项，但它们都和-m time选项.
#    -amin n   查找系统中最后N分钟访问的文件
#    -atime n  查找系统中最后n*24小时访问的文件
#    -cmin n   查找系统中最后N分钟被改变文件状态的文件
#    -ctime n  查找系统中最后n*24小时被改变文件状态的文件
#    -mmin n   查找系统中最后N分钟被改变文件数据的文件
#    -mtime n  查找系统中最后n*24小时被改变文件数据的文件
#-nogroup 查找无有效所属组的文件，即该文件所属的组在/etc/groups中不存在。
#-nouser 查找无有效属主的文件，即该文件的属主在/etc/passwd中不存在。
#-newer file1 ! file2 查找更改时间比文件file1新但比文件file2旧的文件。
#-fstype  查找位于某一类型文件系统中的文件，这些文件系统类型通常可以在配置文件/etc/fstab中找到，该配置文件中包含了本系统中有关文件系统的信息。
#-mount   在查找文件时不跨越文件系统mount点。

使用exec或ok来执行shell命令
echo "为了用ls -l命令列出所匹配到的文件"
find . -type f -exec ls -l {} \;
echo
echo "在/logs目录中查找更改时间在5日以前的文件并删除它们"
#find logs -type f -mtime +5 -exec rm {} \;
#建议在真正执行rm命令删除文件之前，最好先用ls命令看一下，确认它们是所要删除的文件。
find . -type f -mtime +5 -exec ls -l {} \;
echo "匹配所有文件名为“ passwd*”的文件，例如passwd、passwd.old、passwd.bak，然后执行grep命令看看在这些文件中是否存在一个root用户。"
find ~ -name "passwd*" -ok grep "root" {} \;
echo
#-print：假设find指令的回传值为Ture，就将文件或目录名称列出到标准输出。格式为每列一个名称，每个名称前皆有“./”字符串；
#-print0：假设find指令的回传值为Ture，就将文件或目录名称列出到标准输出。格式为全部的名称皆在同一行；
#-printf<输出格式>：假设find指令的回传值为Ture，就将文件或目录名称列出到标准输出。格式可以自行指定；
find ~ -name "[a-z][a-z][0-9][0-9].txt" -print
echo
echo "在/home目录下查找文件，但不希望在/home/sa目录下查找.用-prune选项来指出需要忽略的目录。在使用-prune选项时要当心，因为如果你同时使用了-depth选项，那么-prune选项就会被find命令忽略。"
find /home -path "/home/sa" -prune -o -print |head -n 10
echo
echo "要在/home/itcast目录下查找避开多个文件夹,注意(前的\,注意(后的空格。"
find /home \( -path /home/sa/workspaces -o -path /home/sa/anaconda \) -prune -o -print |head -n 10
#使用user和nouser选项

echo "按文件属主查找文件，如在$HOME 目录中查找文件属主为sa的文件，可以用："
find ~ -user sa -print |head -n 10
echo "在/etc目录下查找文件属主为uucp的文件："
find ~ -user root -print |head -n 10
#为了查找属主帐户已经被删除的文件，可以使用-nouser选项。这样就能够找到那些属主在/etc/passwd文件中没有有效帐户的文件。在使用-nouser选项时，不必给出用户名； find命令能够为你完成相应的工作。
echo "例如，希望在/home目录下查找所有的这类文件，可以用："
find /home -nouser -print |head -n 10
echo
#使用group和nogroup选项
echo "就像user和nouser选项一样，针对文件所属于的用户组， find命令也具有同样的选项，为了在/apps目录下查找属于itcast用户组的文件，可以用："
find ~ -group sa -print |head -n 10
echo "要查找没有有效所属用户组的所有文件，可以使用nogroup选项。下面的find命令从文件系统的根目录处查找这样的文件"
find ~ -nogroup -print
echo
#按照更改时间或访问时间等查找文件

#如果希望按照更改时间来查找文件，可以使用mtime,atime或ctime选项。如果系统突然没有可用空间了，很有可能某一个文件的长度在此期间增长迅速，这时就可以用mtime选项来查找这样的文件。

#用减号-来限定更改时间在距今n日以内的文件，而用加号+来限定更改时间在距今n日以前的文件。

echo "希望在系统根目录下查找更改时间在5日以内的文件，可以用："
find ~ -mtime -5 -print |head -n 10
echo "为了在/var/adm目录下查找更改时间在3日以前的文件，可以用："
find ~ -mtime +3 -print |head -n 10
#查找比某个文件新或旧的文件

#如果希望查找更改时间比某个文件新但比另一个文件旧的所有文件，可以使用-newer选项。它的一般形式为：

#newest_file_name ! oldest_file_name

#其中，！是逻辑非符号。
echo
#使用type选项
echo "在$HOME 目录下查找所有的目录，可以用："
find . -type d -print
echo "在当前目录下查找除目录以外的所有类型的文件，可以用："
find . ! -type d -print
echo "在$HOME 目录下查找所有的符号链接文件，可以用"
find ~ -type l -print |head -n 10
echo
#使用size选项
#可以按照文件长度来查找文件，这里所指的文件长度既可以用块（block）来计量，也可以用字节来计量。以字节计量文件长度的表达形式为N c；以块计量文件长度只用数字表示即可。

echo "在按照文件长度查找文件时，一般使用这种以字节表示的文件长度，在查看文件系统的大小，因为这时使用块来计量更容易转换。 在当前目录下查找文件长度大于1 M字节的文件："
find . -size +1000000c -print |head -n 10
echo "在/home/sa目录下查找文件长度恰好为100字节的文件："
find /home/sa -size 100c -print |head -n 10
echo "在当前目录下查找长度超过10块的文件（一块等于512字节）："
find . -size +10 -print
echo
#使用depth选项
#在使用find命令时，可能希望先匹配所有的文件，再在子目录中查找。使用depth选项就可以使find命令这样做。这样做的一个原因就是，当在使用find命令向磁带上备份文件系统时，希望首先备份所有的文件，其次再备份子目录中的文件。
echo "在下面的例子中， find命令从文件系统的根目录开始，查找一个名为CON.FILE的文件。它将首先匹配所有的文件然后再进入子目录中查找。"
find ~ -name "CON.FILE" -depth -print
echo
#使用mount选项
#在当前的文件系统中查找文件（不进入其他文件系统），可以使用find命令的mount选项。

echo "从当前目录开始查找位于本文件系统中文件名以XC结尾的文件："
find . -name "*.XC" -mount -print
echo "将最近10天被修改过的所有文件复制到/backup"
find . -mtime 10 -daystart -exec cp -a {} /backup \;
#xargs
#在使用find命令的-exec选项处理匹配到的文件时， find命令将所有匹配到的文件一起传递给exec执行。但有些系统对能够传递给exec的命令长度有限制，这样在find命令运行几分钟之后，就会出现 溢出错误。错误信息通常是“参数列太长”或“参数列溢出”。这就是xargs命令的用处所在，特别是与find命令一起使用。
#find命令把匹配到的文件传递给xargs命令，而xargs命令每次只获取一部分文件而不是全部，不像-exec选项那样。这样它可以先处理最先获取的一部分文件，然后是下一批，并如此继续下去。
echo "查找系统中的每一个普通文件，然后使用xargs命令来测试它们分别属于哪类文 件"
find . -type f -print | xargs file
#在当前目录下的所有普通文件中搜索hello这个词：
find . -name \* -type f -print | xargs grep "hello"
#注意，在上面的例子中， \用来取消find命令中的*在shell中的特殊含义。
#
#find命令配合使用exec和xargs可以使用户对所匹配到的文件执行几乎所有的命令。

#sed意为流编辑器（Stream Editor）

#sed命令行的基本格式为
#
#sed option 'script' file1 file2 ...
#sed option -f scriptfile file1 file2 ...
#选项含义：
#
#--version            显示sed版本。
#--help               显示帮助文档。
#-n,--quiet,--silent  静默输出，默认情况下，sed程序在所有的脚本指令执行完毕后，将自动打印模式空间中的内容，这些选项可以屏蔽自动打印。
#-e script
#-f script-file,
#--file=script-file   从文件中读取脚本指令，对编写自动脚本程序来说很棒！
#-i,--in-place        直接修改源文件，经过脚本指令处理后的内容将被输出至源文件（源文件被修改）慎用！
#-l N, --line-length=N 该选项指定l指令可以输出的行长度，l指令用于输出非打印字符。
#--posix             禁用GNU sed扩展功能。
#-r, --regexp-extended  在脚本指令中使用扩展正则表达式
#-s, --separate      默认情况下，sed将把命令行指定的多个文件名作为一个长的连续的输入流。而GNU sed则允许把他们当作单独的文件，这样如正则表达式则不进行跨文件匹配。
#-u, --unbuffered    最低限度的缓存输入与输出。
#
#脚本指令（即对文件内容做的操作）

#a,append        追加
#i,insert        插入
#d,delete        删除
#s,substitution  替换
sed "2a itcast" ./a.txt     #在输出testfile内容的第二行后添加"itcast"。
sed "2,3d" ./b.txt
#
#sed处理的文件既可以由标准输入重定向得到，也可以当命令行参数传入，命令行参数可以一次传入多个文件，sed会依次处理。sed的编辑命令可以直接当命令行参数传入，也可以写成一个脚本文件然后用-f参数指定，编辑命令的格式为
#pattern 模式
#/pattern/p  打印匹配pattern的行
#/pattern/d  删除匹配pattern的行
#/pattern/s/pattern1/pattern2/   查找符合pattern的行，将该行第一个匹配pattern1的字符串替换为pattern2
#/pattern/s/pattern1/pattern2/g  查找符合pattern的行，将该行所有匹配pattern1的字符串替换为pattern2

#打印其中包含abc的行
sed '/abc/p' ./a.txt
#只想要输出结果，应加上 -n 其用法相当与grep
sed -n '/abc.p' ./a.txt
#删除含有anc的行
sed '/abc/d' ./a.txt
#注意sed命令不会修改原文件，删除命令只表示某些行不打印输出，而不是从原文件中删去

#使用查找替换命令时，可以把匹配pattern1的字符串复制到pattern2中
#pattern2中的&表示原文件的当前行中与pattern1想匹配的字符串
sed 's/bc/-&-' ./a.txt
#pattern2中的\1表示与pattern1中的第一个（）括号想匹配的内容，\2表示与pattern1中的第二个()括号想匹配的内容。
#sed默认使用正则表达式规范，如果指定了 -r选项则使用Extented扩展规范，那么（）括号就不用转义了
sed 's/\([0-9])\\([0-9])\/-\1-~\2~/' ./b.txt
sed -r 's/([0-9])([0-9])/-\1-~\2~/' ./b.txt
#使用;分号隔开指令
sed 's/yes/no/;s/static/dhcp/' ./b.txt
#使用-e选项,允许多个脚本指令被执行。
sed -e 's/yes/no/' -e 's/static/dhcp/' ./b.txt

#如果testfile的内容是
#<html><head><title>Hello World</title></head>
#<body>Welcome to the world of regexp!</body></html>
#现在要去掉所有的HTML 标签，是输出结果为Hello World  Welcome to the world of regexp!
#sed匹配默认是贪婪匹配，需准确匹配参数类型 sed 's/<.*>//g' testfile 会匹配所有
#因为这一行开头是<，中间是若干个任意字符，末尾是>
sed -r 's/<[/ a-z]*>//g' ./b.txt
sed -r 's/<[^>]*>//g' ./b.txt
echo '在文件部分结尾添加123'
# sed /pattern/s/pattern1/pattern2/g  查找符合pattern的行，将该行所有匹配pattern1的字符串替换为pattern2
sudo sed -i '/BI_role_login/ s/$/\|MAC\{123454657\}/g' bidata-rsync/2018-02-27-11-50-01-9162_2423062521.log |grep BI_role_login

#sed以行为单位处理文件，awk比sed强的地方在于不仅能以行为单位还能以列为单位处理文件。
