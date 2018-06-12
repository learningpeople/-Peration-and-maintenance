#!/usr/bin/env bash
echo "求2个数之和"
#echo "输入一个值"
#read a1
#效果同上
read -p "输入一个值" a1
#等同于$a1=值
echo "再输入一个值"
read a2
#read -p "再输入一个值:" a2
#shell等号两端不能有空格
a3=$(($a1+$a2))
#或者用 a3=$[$a1+$a2]或 a3=$[a1+a2] 或 a3=$((a1+a2)) 效果相同
echo "result is:$a3"
#当程序完成时用exit 正常退出,
#exit 0

echo "计算1-100的和"
sum=0
i=1
#shell中没有<=,可以用-lt替代
while [ $i -lt 100 ];do
    sum=$[sum+i]
    i=$[i+1]
done
echo $sum
#当程序完成时用exit 正常退出,
#exit 0

echo "将一目录下所有的文件的扩展名改为.c"
for file in /home/sa/workspaces/MYPY/运维/*.py;do
#从右向左匹配 ：% 和 %% 操作符的示例
# % 属于非贪婪操作符，他是从左右向左匹配最短结果；%% 属于贪婪操作符，会从右向左匹配符合条件的最长字符串。
#从左向右匹配：# 和 ## 操作符示例
# 跟 % 一样，# 也有贪婪操作符 ## 。
    mv $file ${file%%.*}.c
done
#当程序完成时用exit 正常退出,否则进程会一直存在
#exit 0
echo "编译当前目录下的所有.c文件："
for file in *.c;do
    echo $file;
# $(basename $file .c) 即不要$file的后缀.c 取其基础名称
    gcc -o $(basename $file .c) $file;
    sleep2;
done

echo "打印sa可以使用可执行文件数，处理结果: root's bins: 2306"
#ls -l
echo "root's bins: $(find ~ -type f -user sa|ls -l |sed '/-..x/p|wc -l')"
#echo "打印当前sshd的端口和进程id，处理结果: sshd Port&&pid: 22 5412"
#sudo netstat -apn |grep sshd|sed -n 's/.*:::\([0-9]{2}) .* ([0-9]{2,4})/sshd\1 \2/p'
echo "输出本机创建20000个目录所用的时间，处理结果:

real    0m3.367s
user    0m0.066s
sys     0m1.925s"
#time() shell自带方法
time(
    for i in{1.,20};do
        mkdir /tmp/nn$i
    done
)



