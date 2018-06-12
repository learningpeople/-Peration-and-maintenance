#!/usr/bin/env bash
#IDC Internet Data Center 互联网数据中心，服务器机柜机房带宽托管租用管理和
#ISP Internet Service Provider 互联网服务提供商， 互联网的接入业务，信息
#ICP Internet Content Provider 互联网内容提供商， 向广大用户综合提供互联网信息业务和增值业务的电信运营商。根据中华人民共和国国务院令第292号《互联网信息服务管理办法》规定，国家对提供互联网信息服务的ICP实行许可证制度。
#CDN Content Delivery Network 内容分发网络,广泛采用各种缓存服务器，将这些缓存服务器分布到用户访问相对集中的地区或网络中，在用户访问网站时，利用全局负载技术将用户的访问指向距离最近的工作正常的缓存服务器上，由缓存服务器直接响应用户请求。依靠部署在各地的边缘服务器，通过中心平台的负载均衡、内容分发、调度等功能模块，使用户就近获取所需内容，降低网络拥塞，提高用户访问响应速度和命中率。
#LVS Linux Virtual Server Linux虚拟服务器，是一个虚拟的服务器集群系统。LVS集群采用IP负载均衡技术和基于内容请求分发技术。
#CGI Common Gateway Interface 通用网关接口。允许Web服务器执行外部程序，并将它们的输出发送给Web浏览器，CGI将Web的一组简单的静态超媒体文档变成一个完整的新的交互式媒体。
#GSLB Global Server Load Balance 全局负载均衡，作为 CDN 系统架构中最核心的部分，负责流量调度.基于DNS的GSLB 绝大部分使用负载均衡技术的应用都通过域名来访问目的主机，在用户发出任何应用连接请求时，首先必须通过DNS请求获得服务器的IP地址，基于DNS的GSLB正是在返回DNS解析结果的过程中进行智能决策，给用户返回一个最佳的服务IP。
#BOSS Business & Operation Support System，BOSS，是业务运营支撑系统。通常所说的BOSS分为四个部分：计费及结算系统、营业与账务系统、客户服务系统和决策支持系统。BOSS从业务层面来看就是一个框架，来承载业务系统、CRM系统、计费系统。


#环境变量 env |printf env  OLDPWD-----cd -
#本地变量 diner='123',env|grep "diner"(查看环境变量)  set|grep 'diner'(产看当前进程的所有变量,环境变量和本地变量)
#export diner 本地变为环境变量|export diner='123'
#unset diner 删除环境变量
#echo $diner 取环境变量


# *   匹配0个或多个任意字符
# ?   匹配一个任意字符
# [若干字符]  匹配方括号中任意一个字符的一次出现

#命令代换 `或 $()
#date ===》DATE=$(date)或DATE=`date`,echo DATE
#算数带换
#VAR = 45,echo $(($VAR+3))
#$[base#n],其中base表示进制,n按照base进制解释，后面再有运算数，按十进制解释。
#echo $[2#10+11]
#echo $[8#10+11]
#echo $[10#10+11]


#双引号和单引号
#被双引号用括住的内容，将被视为单一字串。它防止通配符扩展，但允许变量扩展。这点与单引号的处理方式不同
#单引号用于保持引号内所有字符的字面值，即使引号内的\和回车也不例外，但是字符串中不能出现单引号。


#条件测试：test或 [
#命令test或[可以测试一个条件是否成立，如果测试结果为真，则该命令的Exit Status为0，如果测试结果为假，则命令的Exit Status为1（注意与C语言的逻辑表示正好相反）
echo $$
var=2
test $var
echo $?

test $var -gt 5
echo $?

test $var -lt 5
echo $?
#$var、-gt、5、]是[命令的四个参数，它们之间必须用空格隔开。命令test或[的参数形式是相同的，只不过test命令不需要]参数。
[ $var -gt 1 ]
echo $?


#[ -d DIR ]              如果DIR存在并且是一个目录则为真
#[ -f FILE ]             如果FILE存在且是一个普通文件则为真
#[ -z STRING ]           如果STRING的长度为零则为真
#[ -n STRING ]           如果STRING的长度非零则为真
#[ STRING1 = STRING2 ]   如果两个字符串相同则为真
#[ STRING1 != STRING2 ]  如果字符串不相同则为真
#[ ARG1 OP ARG2 ]        ARG1和ARG2应该是整数或者取值为整数的变量，OP是-eq（等于）-ne（不等于）-lt（小于）-le（小于等于）-gt（大于）-ge（大于等于）之中的一个

s1=hello
s2=
[ $s1=$2 ]
echo $?

[ "$s1"="$s2" ]
echo $?
#s2被Shell展开为空，会造成测试条件的语法错误，作为一种好的Shell编程习惯，应该总是把变量取值放在双引号之中

#if/then/elif/else/fi
#&&和||语法

if [ -f ~/.bashrc ];then
    echo "~/. bashrc is a file"
else
    echo "~/. bashrc is not a file"
fi
#:是一个特殊的命令，称为空命令，该命令不做任何事，但Exit Status总是真。
if :; then echo "always true"; fi

echo "Is it morning?plase answer me:"
read YES_OR_NO
#注意对变量的引用要用双引号
if [ "$YES_OR_NO" = "yes" ];then
    echo "good morning!"
elif [ "$YES_OR_NO" = "no" ];then
    echo "good afternoon!"
else
    echo "sorry, $YES_OR_NO not recognized.enter yse or no."
    exit 1
fi
#exit 0
echo "Is it morning?plase answer me:"
read YES_OR_NO
case "$YES_OR_NO" in
yes|y|Yes|YES)
    echo "good morning!";;
[nN]*)
    echo "good afternoon!";;
*)
    echo "sorry, $YES_OR_NO not recognized.enter yse or no."
    exit 1;;
esac
#exit 0

#使用case语句的例子可以在系统服务的脚本目录/etc/init.d中找到。这个目录下的脚本大多具有这种形式（以/etc/init.d/nfs-kernel-server为例）：
#
#    case "$1" in
#        start)
#            ...
#        ;;
#        stop)
#            ...
#        ;;
#        reload | force-reload)
#            ...
#        ;;
#        restart)
#        ...
#        *)
#            log_success_msg "Usage: nfs-kernel-server {start|stop|status|reload|force-reload|restart}"
#            exit 1
#        ;;
#    esac
#$1是一个特殊变量，在执行脚本时自动取值为第一个命令行参数，也就是start，所以进入start)分支执行相关的命令。同理，命令行参数指定为stop、reload或restart可以进入其它分支执行停止服务、重新加载配置文件或重新启动服务的相关命令


#FRUIT是一个循环变量，第一次循环$FRUIT的取值是apple，第二次取值是banana，第三次取值是pear。
for FRUIT in apple pear banana; do
    echo "I like $FRUIT"
done
#要将当前目录下的chap0、chap1、chap2等文件名改为chap0~、chap1~、chap2~等（按惯例，末尾有~字符的文件名表示临时文件），这个命令可以这样写：
for FILENAME in chap?;do mv $FILENAME $FILENAME~; done


echo "Enter password:"
read TRY
while [ "$TRY" != "yes" ]; do
    echo "sorry,try again"
    read TRY
done

counter=1  #这里的1 是字符串不是数字
while [ "$counter" -lt 5 ]; do
    echo "Here we go again"
# 注意变量等号两边没有空格，否则无法识别
    counter=$(($counter+1))
done
#Shell还有until循环，类似C语言的do...while循环。
#
#break和continue
#break[n]可以指定跳出几层循环，continue跳过本次循环步，没跳出整个循环。
#
#break跳出，continue跳过

# 位置参数和特殊变量



#常用的位置参数和特殊变量
#
#$0  相当于C语言main函数的argv[0]
#$1、$2...    这些称为位置参数（Positional Parameter），相当于C语言main函数的argv[1]、argv[2]...
#$#  表示参数个数 相当于C语言main函数的argc - 1，注意这里的#后面不表示注释
#$@  表示参数列表"$1" "$2" ...，例如可以用在for循环中的in后面。
#$*  表示参数列表"$1" "$2" ...，同上
#$?  上一条命令的Exit Status
#$$  当前进程号（ps -aus所有进程）

#位置参数可以用shift命令左移。比如shift 3表示原来的$4现在变成$1，原来的$5现在变成$2等等，原来的$1、$2、$3丢弃，$0不移动。不带参数的shift命令相当于shift 1。例如：
echo "The program $0 is now running"
echo "The first parameter is $1"
echo "The second parameter is $2"
echo "The parameter list is $@"
shift
echo "The first parameter is $1"
echo "The second parameter is $2"
echo "The parameter list is $@"

#echo
#echo显示文本行或变量，或者把字符串输入到文件。

#echo [option] string
#-e 解析转义字符
#-n 不回车换行。默认情况echo回显的内容后面跟一个回车换行。
echo "hello\n\n"
echo -e "hello\n\n"
echo  "hello"
echo -n "hello"

#管道|
#可以通过管道把一个命令的输出传递给另一个命令做输入。管道用竖线表示。

#cat myfile | more
#ls -l | grep "myfile"
#df -k | awk '{print $1}' | grep -v "文件系统"
#df -k 查看磁盘空间，找到第一列，去除“文件系统”，并输出

#tee
#tee命令把结果输出到标准输出，另一个副本输出到相应文件
#ls -l |tee a.txt
#cat a.txt

#文件重定向
#命令的结果可以通过“%>”的形式来定向输出，%表示文件描述符：1为标准输出stdout、2为标准错误stderr。系统默认%值是1，也就是“1>”，而1>可以简写为>，也就是默认为>。stdout的默认目标是终端，stderr的默认目标为也是终端。
#cmd > file             把标准输出重定向到新文件中 等价于cmd 1>file 即将cmd的标准输出重定向到file
#cmd >> file            追加 等价于cmd 1>>file
#cmd > file 2>&1        等价于cmd 1> file 2>&1 即将cmd的句柄1（stdout）重定向到file 然后将cmd的句柄 2（即 STDERR 标准出错）重定向到句柄 1（即 STDOUT 标准输出）所指向的file里
#cmd >> file 2>&1       等价于cmd 1>>file 2>$1
#cmd < file1 > file2    输入输出都定向到文件里
#cmd < &fd              把文件描述符fd作为标准输入
#cmd > &fd              把文件描述符fd作为标准输出
#cmd < &-               关闭标准输入
#ls  -l > b.txt
#cat程序 --->文件描述符（0,1,2）--->c语言库（stdin，stdout，stderr） --->键盘鼠标

#open 打开一个文件时a+是在文件的末尾添加，w+会覆盖原有内容，a+和w+如果文件不存在可以创建文件，r+如果文件不存在不能创建文件
#/dev/null 是linux的黑洞，任何你不想看到的东西都可以重定向到这里 ls -l > /dev/null

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

echo "start-------"
fun aa bb 11
echo "end---------"


is_directory()
{
  DIR_NAME=$1
  if [ ! -d $DIR_NAME ]; then
    return 1
  else
    return 0
  fi
}
#$@  表示参数列表"$1" "$2" ...，例如可以用在for循环中的in后面。
for DIR in "$@"; do
  if is_directory "$DIR"
#  : 空语句，不做任何操作
  then :
  else
    echo "$DIR doesn't exist. Creating it now..."
    mkdir $DIR > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "Cannot create directory $DIR"
      exit 1
    fi
  fi
done
