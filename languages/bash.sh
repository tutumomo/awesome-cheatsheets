##############################################################################
# BASH CHEATSHEET (中文速查表)  -  by skywind (created on 2018/02/14)
# Version: 47, Last Modified: 2019/09/24 17:58
# https://github.com/skywind3000/awesome-cheatsheets
##############################################################################


##############################################################################
# 常用快捷鍵（默認使用 Emacs 鍵位）
##############################################################################

CTRL+A              # 移動到行首，同 <Home>
CTRL+B              # 向後移動，同 <Left>
CTRL+C              # 結束當前命令
CTRL+D              # 刪除光標前的字符，同 <Delete> ，或者沒有內容時，退出會話
CTRL+E              # 移動到行末，同 <End>
CTRL+F              # 向前移動，同 <Right>
CTRL+G              # 退出當前編輯（比如正在 CTRL+R 搜索歷史時）
CTRL+H              # 刪除光標左邊的字符，同 <Backspace>
CTRL+K              # 刪除光標位置到行末的內容
CTRL+L              # 清屏並重新顯示
CTRL+N              # 移動到命令歷史的下一行，同 <Down>
CTRL+O              # 類似回車，但是會顯示下一行歷史
CTRL+P              # 移動到命令歷史的上一行，同 <Up>
CTRL+R              # 歷史命令反向搜索，使用 CTRL+G 退出搜索
CTRL+S              # 歷史命令正向搜索，使用 CTRL+G 退出搜索
CTRL+T              # 交換前後兩個字符
CTRL+U              # 刪除字符到行首
CTRL+V              # 輸入字符字面量，先按 CTRL+V 再按任意鍵
CTRL+W              # 刪除光標左邊的一個單詞
CTRL+X              # 列出可能的補全
CTRL+Y              # 粘貼前面 CTRL+u/k/w 刪除過的內容
CTRL+Z              # 暫停前台進程返回 bash，需要時可用 fg 將其切換回前台
CTRL+_              # 撤銷（undo），有的終端將 CTRL+_ 映射為 CTRL+/ 或 CTRL+7

ALT+b               # 向後（左邊）移動一個單詞
ALT+d               # 刪除光標後（右邊）一個單詞
ALT+f               # 向前（右邊）移動一個單詞
ALT+t               # 交換字符
ALT+BACKSPACE       # 刪除光標前面一個單詞，類似 CTRL+W，但不影響剪貼板

CTRL+X CTRL+X       # 連續按兩次 CTRL+X，光標在當前位置和行首來回跳轉 
CTRL+X CTRL+E       # 用你指定的編輯器，編輯當前命令


##############################################################################
# BASH 基本操作
##############################################################################

exit                # 退出當前登陸
env                 # 顯示環境變量
echo $SHELL         # 顯示你在使用什麼 SHELL

bash                # 使用 bash，用 exit 返回
which bash          # 搜索 $PATH，查找哪個程序對應命令 bash
whereis bash        # 搜索可執行，頭文件和幫助信息的位置，使用系統內建數據庫
whatis bash         # 查看某個命令的解釋，一句話告訴你這是幹什麼的

clear               # 清初屏幕內容
reset               # 重置終端（當你不小心 cat 了一個二進制，終端狀態亂掉時使用）


##############################################################################
# 目錄操作
##############################################################################

cd                  # 返回自己 $HOME 目錄
cd {dirname}        # 進入目錄
pwd                 # 顯示當前所在目錄
mkdir {dirname}     # 創建目錄
mkdir -p {dirname}  # 遞歸創建目錄
pushd {dirname}     # 目錄壓棧並進入新目錄
popd                # 彈出並進入棧頂的目錄
dirs -v             # 列出當前目錄棧
cd -                # 回到之前的目錄
cd -{N}             # 切換到目錄棧中的第 N個目錄，比如 cd -2 將切換到第二個


##############################################################################
# 文件操作
##############################################################################

ls                  # 顯示當前目錄內容，後面可接目錄名：ls {dir} 顯示指定目錄
ls -l               # 列表方式顯示目錄內容，包括文件日期，大小，權限等信息
ls -1               # 列表方式顯示目錄內容，只顯示文件名稱，減號後面是數字 1
ls -a               # 顯示所有文件和目錄，包括隱藏文件（.開頭的文件/目錄名）
ln -s {fn} {link}   # 給指定文件創建一個軟鏈接
cp {src} {dest}     # 拷貝文件，cp -r dir1 dir2 可以遞歸拷貝（目錄）
rm {fn}             # 刪除文件，rm -r 遞歸刪除目錄，rm -f 強制刪除
mv {src} {dest}     # 移動文件，如果 dest 是目錄，則移動，是文件名則覆蓋
touch {fn}          # 創建或者更新一下制定文件
cat {fn}            # 輸出文件原始內容
any_cmd > {fn}      # 執行任意命令並將標準輸出重定向到指定文件
more {fn}           # 逐屏顯示某文件內容，空格翻頁，q 退出
less {fn}           # 更高級點的 more，更多操作，q 退出
head {fn}           # 顯示文件頭部數行，可用 head -3 abc.txt 顯示頭三行
tail {fn}           # 顯示文件尾部數行，可用 tail -3 abc.txt 顯示尾部三行
tail -f {fn}        # 持續顯示文件尾部數據，可用於監控日誌
nano {fn}           # 使用 nano 編輯器編輯文件
vim {fn}            # 使用 vim 編輯文件
diff {f1} {f2}      # 比較兩個文件的內容
wc {fn}             # 統計文件有多少行，多少個單詞
chmod 644 {fn}      # 修改文件權限為 644，可以接 -R 對目錄循環改權限
chgrp group {fn}    # 修改文件所屬的用戶組
chown user1 {fn}    # 修改文件所有人為 user1, chown user1:group1 fn 可以修改組
file {fn}           # 檢測文件的類型和編碼
basename {fn}       # 查看文件的名字（不包括路徑）
dirname {fn}        # 查看文件的路徑（不包括名字）
grep {pat} {fn}     # 在文件中查找出現過 pat 的內容
grep -r {pat} .     # 在當前目錄下遞歸查找所有出現過 pat 的文件內容
stat {fn}           # 顯示文件的詳細信息


##############################################################################
# 用戶管理
##############################################################################

whoami              # 顯示我的用戶名
who                 # 顯示已登陸用戶信息，w / who / users 內容略有不同
w                   # 顯示已登陸用戶信息，w / who / users 內容略有不同
users               # 顯示已登陸用戶信息，w / who / users 內容略有不同
passwd              # 修改密碼，passwd {user} 可以用於 root 修改別人密碼
finger {user}       # 顯示某用戶信息，包括 id, 名字, 登陸狀態等
adduser {user}      # 添加用戶
deluser {user}      # 刪除用戶
w                   # 查看誰在線
su                  # 切換到 root 用戶
su -                # 切換到 root 用戶並登陸（執行登陸腳本）
su {user}           # 切換到某用戶
su -{user}          # 切換到某用戶並登陸（執行登陸腳本）
id {user}           # 查看用戶的 uid，gid 以及所屬其他用戶組
id -u {user}        # 打印用戶 uid
id -g {user}        # 打印用戶 gid
write {user}        # 向某用戶發送一句消息
last                # 顯示最近用戶登陸列表
last {user}         # 顯示登陸記錄
lastb               # 顯示失敗登陸記錄
lastlog             # 顯示所有用戶的最近登陸記錄
sudo {command}      # 以 root 權限執行某命令


##############################################################################
# 進程管理
##############################################################################

ps                        # 查看當前會話進程
ps ax                     # 查看所有進程，類似 ps -e
ps aux                    # 查看所有進程詳細信息，類似 ps -ef
ps auxww                  # 查看所有進程，並且顯示進程的完整啟動命令
ps -u {user}              # 查看某用戶進程
ps axjf                   # 列出進程樹
ps xjf -u {user}          # 列出某用戶的進程樹
ps -eo pid,user,command   # 按用戶指定的格式查看進程
ps aux | grep httpd       # 查看名為 httpd 的所有進程
ps --ppid {pid}           # 查看父進程為 pid 的所有進程
pstree                    # 樹形列出所有進程，pstree 默認一般不帶，需安裝
pstree {user}             # 進程樹列出某用戶的進程
pstree -u                 # 樹形列出所有進程以及所屬用戶
pgrep {procname}          # 搜索名字匹配的進程的 pid，比如 pgrep apache2

kill {pid}                # 結束進程
kill -9 {pid}             # 強制結束進程，9/SIGKILL 是強制不可捕獲結束信號
kill -KILL {pid}          # 強制執行進程，kill -9 的另外一種寫法
kill -l                   # 查看所有信號
kill -l TERM              # 查看 TERM 信號的編號
killall {procname}        # 按名稱結束所有進程
pkill {procname}          # 按名稱結束進程，除名稱外還可以有其他參數

top                       # 查看最活躍的進程
top -u {user}             # 查看某用戶最活躍的進程

any_command &             # 在後台運行某命令，也可用 CTRL+Z 將當前進程掛到後台
jobs                      # 查看所有後台進程（jobs）
bg                        # 查看後台進程，並切換過去
fg                        # 切換後台進程到前台
fg {job}                  # 切換特定後台進程到前台

trap cmd sig1 sig2        # 在腳本中設置信號處理命令
trap "" sig1 sig2         # 在腳本中屏蔽某信號
trap - sig1 sig2          # 恢復默認信號處理行為

nohup {command}           # 長期運行某程序，在你退出登陸都保持它運行
nohup {command} &         # 在後台長期運行某程序
disown {PID|JID}          # 將進程從後台任務列表（jobs）移除

wait                      # 等待所有後台進程任務結束


##############################################################################
# 常用命令：SSH / 系統信息 / 網絡
##############################################################################

ssh user@host             # 以用戶 user 登陸到遠程主機 host
ssh -p {port} user@host   # 指定端口登陸主機
ssh-copy-id user@host     # 拷貝你的 ssh key 到遠程主機，避免重複輸入密碼
scp {fn} user@host:path   # 拷貝文件到遠程主機
scp user@host:path dest   # 從遠程主機拷貝文件回來
scp -P {port} ...         # 指定端口遠程拷貝文件

uname -a                  # 查看內核版本等信息
man {help}                # 查看幫助
man -k {keyword}          # 查看哪些幫助文檔裡包含了該關鍵字
info {help}               # 查看 info pages，比 man 更強的幫助系統
uptime                    # 查看系統啟動時間
date                      # 顯示日期
cal                       # 顯示日曆
vmstat                    # 顯示內存和 CPU 使用情況
vmstat 10                 # 每 10 秒打印一行內存和 CPU情況，CTRL+C 退出
free                      # 顯示內存和交換區使用情況
df                        # 顯示磁盤使用情況
du                        # 顯示當前目錄佔用，du . --max-depth=2 可以指定深度
du -h                     # 顯示當前目錄佔用，-h 以方便閱讀的格式輸出 (K/M/G)
uname                     # 顯示系統版本號
hostname                  # 顯示主機名稱
showkey -a                # 查看終端發送的按鍵編碼

ping {host}               # ping 遠程主機並顯示結果，CTRL+C 退出
ping -c N {host}          # ping 遠程主機 N 次
traceroute {host}         # 偵測路由連通情況
mtr {host}                # 高級版本 traceroute
host {domain}             # DNS 查詢，{domain} 前面可加 -a 查看詳細信息
whois {domain}            # 取得域名 whois 信息
dig {domain}              # 取得域名 dns 信息
route -n                  # 查看路由表
netstat -a                # 列出所有端口
netstat -an               # 查看所有連接信息，不解析域名
netstat -anp              # 查看所有連接信息，包含進程信息（需要 sudo）
netstat -l                # 查看所有監聽的端口
netstat -t                # 查看所有 TCP 鏈接
netstat -lntu             # 顯示所有正在監聽的 TCP 和 UDP 信息
netstat -lntup            # 顯示所有正在監聽的 socket 及進程信息
netstat -i                # 顯示網卡信息
netstat -rn               # 顯示當前系統路由表，同 route -n
ss -an                    # 比 netstat -an 更快速更詳細
ss -s                     # 統計 TCP 的 established, wait 等

wget {url}                # 下載文件，可加 --no-check-certificate 忽略 ssl 驗證
wget -qO- {url}           # 下載文件並輸出到標準輸出（不保存）
curl -sL {url}            # 同 wget -qO- {url} 沒有 wget 的時候使用

sz {file}                 # 發送文件到終端，zmodem 協議
rz                        # 接收終端發送過來的文件


##############################################################################
# 變量操作
##############################################################################

varname=value             # 定義變量
varname=value command     # 定義子進程變量並執行子進程
echo $varname             # 查看變量內容
echo $$                   # 查看當前 shell 的進程號
echo $!                   # 查看最近調用的後台任務進程號
echo $?                   # 查看最近一條命令的返回碼
export VARNAME=value      # 設置環境變量（將會影響到子進程）

array[0]=valA             # 定義數組
array[1]=valB
array[2]=valC
array=([0]=valA [1]=valB [2]=valC)   # 另一種方式
array=(valA valB valC)               # 另一種方式

${array[i]}               # 取得數組中的元素
${#array[@]}              # 取得數組的長度
${#array[i]}              # 取得數組中某個變量的長度

declare -a                # 查看所有數組
declare -f                # 查看所有函數
declare -F                # 查看所有函數，僅顯示函數名
declare -i                # 查看所有整數
declare -r                # 查看所有只讀變量
declare -x                # 查看所有被導出成環境變量的東西
declare -p varname        # 輸出變量是怎麼定義的（類型+值）

${varname:-word}          # 如果變量不為空則返回變量，否則返回 word
${varname:=word}          # 如果變量不為空則返回變量，否則賦值成 word 並返回
${varname:?message}       # 如果變量不為空則返回變量，否則打印錯誤信息並退出
${varname:+word}          # 如果變量不為空則返回 word，否則返回 null
${varname:offset:len}     # 取得字符串的子字符串

${variable#pattern}       # 如果變量頭部匹配 pattern，則刪除最小匹配部分返回剩下的
${variable##pattern}      # 如果變量頭部匹配 pattern，則刪除最大匹配部分返回剩下的
${variable%pattern}       # 如果變量尾部匹配 pattern，則刪除最小匹配部分返回剩下的
${variable%%pattern}      # 如果變量尾部匹配 pattern，則刪除最大匹配部分返回剩下的
${variable/pattern/str}   # 將變量中第一個匹配 pattern 的替換成 str，並返回
${variable//pattern/str}  # 將變量中所有匹配 pattern 的地方替換成 str 並返回

${#varname}               # 返回字符串長度

*(patternlist)            # 零次或者多次匹配
+(patternlist)            # 一次或者多次匹配
?(patternlist)            # 零次或者一次匹配
@(patternlist)            # 單詞匹配
!(patternlist)            # 不匹配

array=($text)             # 按空格分隔 text 成數組，並賦值給變量
IFS="/" array=($text)     # 按斜桿分隔字符串 text 成數組，並賦值給變量
text="${array[*]}"        # 用空格鏈接數組並賦值給變量
text=$(IFS=/; echo "${array[*]}")  # 用斜槓鏈接數組並賦值給變量

A=( foo bar "a  b c" 42 ) # 數組定義
B=("${A[@]:1:2}")         # 數組切片：B=( bar "a  b c" )
C=("${A[@]:1}")           # 數組切片：C=( bar "a  b c" 42 )
echo "${B[@]}"            # bar a  b c
echo "${B[1]}"            # a  b c
echo "${C[@]}"            # bar a  b c 42
echo "${C[@]: -2:2}"      # a  b c 42  減號前的空格是必須的

$(UNIX command)           # 運行命令，並將標準輸出內容捕獲並返回
varname=$(id -u user)     # 將用戶名為 user 的 uid 賦值給 varname 變量

num=$(expr 1 + 2)         # 兼容 posix sh 的計算，使用 expr 命令計算結果
num=$(expr $num + 1)      # 數字自增
expr 2 \* \( 2 + 3 \)     # 兼容 posix sh 的複雜計算，輸出 10

num=$((1 + 2))            # 計算 1+2 賦值給 num，使用 bash 獨有的 $((..)) 計算
num=$(($num + 1))         # 變量遞增
num=$((num + 1))          # 變量遞增，雙括號內的 $ 可以省略
num=$((1 + (2 + 3) * 2))  # 複雜計算


##############################################################################
# 事件指示符
##############################################################################

!!                  # 上一條命令
!^                  # 上一條命令的第一個單詞
!:n                 # 上一條命令的第n個單詞
!:n-$               # 上一條命令的第n個單詞到最後一個單詞
!$                  # 上一條命令的最後一個單詞
!-n:$               # 上n條命令的最後一個單詞
!string             # 最近一條包含string的命令
!^string1^string2   # 最近一條包含string1的命令, 快速替換string1為string2
!#                  # 本條命令之前所有的輸入內容
!#:n                # 本條命令之前的第n個單詞, 快速備份cp /etc/passwd !#:1.bak


##############################################################################
# 函數
##############################################################################

# 定義一個新函數
function myfunc() {
    # $1 代表第一個參數，$N 代表第 N 個參數
    # $# 代表參數個數
    # $0 代表被調用者自身的名字
    # $@ 代表所有參數，類型是個數組，想傳遞所有參數給其他命令用 cmd "$@" 
    # $* 空格鏈接起來的所有參數，類型是字符串
    {shell commands ...}
}

myfunc                    # 調用函數 myfunc 
myfunc arg1 arg2 arg3     # 帶參數的函數調用
myfunc "$@"               # 將所有參數傳遞給函數
myfunc "${array[@]}"      # 將一個數組當作多個參數傳遞給函數
shift                     # 參數左移

unset -f myfunc           # 刪除函數
declare -f                # 列出函數定義


##############################################################################
# 條件判斷（兼容 posix sh 的條件判斷）：man test
##############################################################################

statement1 && statement2  # and 操作符
statement1 || statement2  # or 操作符

exp1 -a exp2              # exp1 和 exp2 同時為真時返回真（POSIX XSI擴展）
exp1 -o exp2              # exp1 和 exp2 有一個為真就返回真（POSIX XSI擴展）
( expression )            # 如果 expression 為真時返回真，輸入注意括號前反斜桿
! expression              # 如果 expression 為假那返回真

str1 = str2               # 判斷字符串相等，如 [ "$x" = "$y" ] && echo yes
str1 != str2              # 判斷字符串不等，如 [ "$x" != "$y" ] && echo yes
str1 < str2               # 字符串小於，如 [ "$x" \< "$y" ] && echo yes
str2 > str2               # 字符串大於，注意 < 或 > 是字面量，輸入時要加反斜桿
-n str1                   # 判斷字符串不為空（長度大於零）
-z str1                   # 判斷字符串為空（長度等於零）

-a file                   # 判斷文件存在，如 [ -a /tmp/abc ] && echo "exists"
-d file                   # 判斷文件存在，且該文件是一個目錄
-e file                   # 判斷文件存在，和 -a 等價
-f file                   # 判斷文件存在，且該文件是一個普通文件（非目錄等）
-r file                   # 判斷文件存在，且可讀
-s file                   # 判斷文件存在，且尺寸大於0
-w file                   # 判斷文件存在，且可寫
-x file                   # 判斷文件存在，且執行
-N file                   # 文件上次修改過後還沒有讀取過
-O file                   # 文件存在且屬於當前用戶
-G file                   # 文件存在且匹配你的用戶組
file1 -nt file2           # 文件1 比 文件2 新
file1 -ot file2           # 文件1 比 文件2 舊

num1 -eq num2             # 數字判斷：num1 == num2
num1 -ne num2             # 數字判斷：num1 != num2
num1 -lt num2             # 數字判斷：num1 < num2
num1 -le num2             # 數字判斷：num1 <= num2
num1 -gt num2             # 數字判斷：num1 > num2
num1 -ge num2             # 數字判斷：num1 >= num2


##############################################################################
# 分支控制：if 和經典 test，兼容 posix sh 的條件判斷語句
##############################################################################

test {expression}         # 判斷條件為真的話 test 程序返回0 否則非零
[ expression ]            # 判斷條件為真的話返回0 否則非零

test "abc" = "def"        # 查看返回值 echo $? 顯示 1，因為條件為假
test "abc" != "def"       # 查看返回值 echo $? 顯示 0，因為條件為真

test -a /tmp; echo $?     # 調用 test 判斷 /tmp 是否存在，並打印 test 的返回值
[ -a /tmp ]; echo $?      # 和上面完全等價，/tmp 肯定是存在的，所以輸出是 0

test cond && cmd1         # 判斷條件為真時執行 cmd1
[ cond ] && cmd1          # 和上面完全等價
[ cond ] && cmd1 || cmd2  # 條件為真執行 cmd1 否則執行 cmd2

# 判斷 /etc/passwd 文件是否存在
# 經典的 if 語句就是判斷後面的命令返回值為0的話，認為條件為真，否則為假
if test -e /etc/passwd; then
    echo "alright it exists ... "
else
    echo "it doesn't exist ... "
fi

# 和上面完全等價，[ 是個和 test 一樣的可執行程序，但最後一個參數必須為 ]
# 這個名字為 "[" 的可執行程序一般就在 /bin 或 /usr/bin 下面，比 test 優雅些
if [ -e /etc/passwd ]; then   
    echo "alright it exists ... "
else
    echo "it doesn't exist ... "
fi

# 和上面兩個完全等價，其實到 bash 時代 [ 已經是內部命令了，用 enable 可以看到
[ -e /etc/passwd ] && echo "alright it exists" || echo "it doesn't exist"

# 判斷變量的值
if [ "$varname" = "foo" ]; then
    echo "this is foo"
elif [ "$varname" = "bar" ]; then
    echo "this is bar"
else
    echo "neither"
fi

# 複雜條件判斷，注意 || 和 && 是完全兼容 POSIX 的推薦寫法
if [ $x -gt 10 ] && [ $x -lt 20 ]; then
    echo "yes, between 10 and 20"
fi

# 可以用 && 命令連接符來做和上面完全等價的事情
[ $x -gt 10 ] && [ $x -lt 20 ] && echo "yes, between 10 and 20"

# 小括號和 -a -o 是 POSIX XSI 擴展寫法，小括號是字面量，輸入時前面要加反斜桿
if [ \( $x -gt 10 \) -a \( $x -lt 20 \) ]; then
    echo "yes, between 10 and 20"
fi

# 同樣可以用 && 命令連接符來做和上面完全等價的事情
[ \( $x -gt 10 \) -a \( $x -lt 20 \) ] && echo "yes, between 10 and 20"


# 判斷程序存在的話就執行
[ -x /bin/ls ] && /bin/ls -l

# 如果不考慮兼容 posix sh 和 dash 這些的話，可用 bash 獨有的 ((..)) 和 [[..]]:
https://www.ibm.com/developerworks/library/l-bash-test/index.html


##############################################################################
# 流程控制：while / for / case / until 
##############################################################################

# while 循環
while condition; do
    statements
done

i=1
while [ $i -le 10 ]; do
    echo $i; 
    i=$(expr $i + 1)
done

# for 循環：上面的 while 語句等價
for i in {1..10}; do
    echo $i
done

for name [in list]; do
    statements
done

# for 列舉某目錄下面的所有文件
for f in /home/*; do 
    echo $f
done

# bash 獨有的 (( .. )) 語句，更接近 C 語言，但是不兼容 posix sh
for (( initialisation ; ending condition ; update )); do
    statements
done

# 和上面的寫法等價
for ((i = 0; i < 10; i++)); do echo $i; done

# case 判斷
case expression in 
    pattern1 )
        statements ;;
    pattern2 )
        statements ;;
    * )
        otherwise ;;
esac

# until 語句
until condition; do
    statements
done

# select 語句
select name [in list]; do
  statements that can use $name
done


##############################################################################
# 命令處理
##############################################################################

command ls                         # 忽略 alias 直接執行程序或者內建命令 ls
builtin cd                         # 忽略 alias 直接運行內建的 cd 命令
enable                             # 列出所有 bash 內置命令，或禁止某命令
help {builtin_command}             # 查看內置命令的幫助（僅限 bash 內置命令）

eval $script                       # 對 script 變量中的字符串求值（執行）


##############################################################################
# 輸出/輸入 重定向
##############################################################################

cmd1 | cmd2                        # 管道，cmd1 的標準輸出接到 cmd2 的標準輸入
< file                             # 將文件內容重定向為命令的標準輸入
> file                             # 將命令的標準輸出重定向到文件，會覆蓋文件
>> file                            # 將命令的標準輸出重定向到文件，追加不覆蓋
>| file                            # 強制輸出到文件，即便設置過：set -o noclobber
n>| file                           # 強制將文件描述符 n的輸出重定向到文件
<> file                            # 同時使用該文件作為標準輸入和標準輸出
n<> file                           # 同時使用文件作為文件描述符 n 的輸出和輸入
n> file                            # 重定向文件描述符 n 的輸出到文件
n< file                            # 重定向文件描述符 n 的輸入為文件內容
n>&                                # 將標準輸出 dup/合併 到文件描述符 n
n<&                                # 將標準輸入 dump/合併 定向為描述符 n
n>&m                               # 文件描述符 n 被作為描述符 m 的副本，輸出用
n<&m                               # 文件描述符 n 被作為描述符 m 的副本，輸入用
&>file                             # 將標準輸出和標準錯誤重定向到文件
<&-                                # 關閉標準輸入
>&-                                # 關閉標準輸出
n>&-                               # 關閉作為輸出的文件描述符 n
n<&-                               # 關閉作為輸入的文件描述符 n
diff <(cmd1) <(cmd2)               # 比較兩個命令的輸出


##############################################################################
# 文本處理 - cut
##############################################################################

cut -c 1-16                        # 截取每行頭16個字符
cut -c 1-16 file                   # 截取指定文件中每行頭 16個字符
cut -c3-                           # 截取每行從第三個字符開始到行末的內容
cut -d':' -f5                      # 截取用冒號分隔的第五列內容
cut -d';' -f2,10                   # 截取用分號分隔的第二和第十列內容
cut -d' ' -f3-7                    # 截取空格分隔的三到七列
echo "hello" | cut -c1-3           # 顯示 hel
echo "hello sir" | cut -d' ' -f2   # 顯示 sir
ps | tr -s " " | cut -d " " -f 2,3,4  # cut 搭配 tr 壓縮字符


##############################################################################
# 文本處理 - awk / sed 
##############################################################################

awk '{print $5}' file              # 打印文件中以空格分隔的第五列
awk -F ',' '{print $5}' file       # 打印文件中以逗號分隔的第五列
awk '/str/ {print $2}' file        # 打印文件中包含 str 的所有行的第二列
awk -F ',' '{print $NF}' file      # 打印逗號分隔的文件中的每行最後一列 
awk '{s+=$1} END {print s}' file   # 計算所有第一列的合
awk 'NR%3==1' file                 # 從第一行開始，每隔三行打印一行

sed 's/find/replace/' file         # 替換文件中首次出現的字符串並輸出結果 
sed '10s/find/replace/' file       # 替換文件第 10 行內容
sed '10,20s/find/replace/' file    # 替換文件中 10-20 行內容
sed -r 's/regex/replace/g' file    # 替換文件中所有出現的字符串
sed -i 's/find/replace/g' file     # 替換文件中所有出現的字符並且覆蓋文件
sed -i '/find/i\newline' file      # 在文件的匹配文本前插入行
sed -i '/find/a\newline' file      # 在文件的匹配文本後插入行
sed '/line/s/find/replace/' file   # 先搜索行特徵再執行替換
sed -e 's/f/r/' -e 's/f/r' file    # 執行多次替換
sed 's#find#replace#' file         # 使用 # 替換 / 來避免 pattern 中有斜桿
sed -i -r 's/^\s+//g' file         # 刪除文件每行頭部空格
sed '/^$/d' file                   # 刪除文件空行並打印
sed -i 's/\s\+$//' file            # 刪除文件每行末尾多餘空格
sed -n '2p' file                   # 打印文件第二行
sed -n '2,5p' file                 # 打印文件第二到第五行


##############################################################################
# 排序 - sort
##############################################################################

sort file                          # 排序文件
sort -r file                       # 反向排序（降序）
sort -n file                       # 使用數字而不是字符串進行比較
sort -t: -k 3n /etc/passwd         # 按 passwd 文件的第三列進行排序
sort -u file                       # 去重排序
sort -h file                       # 支持 K/M/G 等量級符號，可與 du 結合使用


##############################################################################
# 快速跳轉 - https://github.com/rupa/z
##############################################################################

source /path/to/z.sh               # .bashrc 中初始化 z.sh
z                                  # 列出所有歷史路徑以及他們的權重
z foo                              # 跳到歷史路徑中匹配 foo 的權重最大的目錄
z foo bar                          # 跳到歷史路徑中匹配 foo 和 bar 權重最大的目錄
z -l foo                           # 列出所有歷史路徑中匹配 foo 的目錄及權重
z -r foo                           # 按照最高訪問次數優先進行匹配跳轉
z -t foo                           # 按照最近訪問優先進行匹配跳轉


##############################################################################
# 鍵盤綁定
##############################################################################

bind '"\eh":"\C-b"'                # 綁定 ALT+h 為光標左移，同 CTRL+b / <Left>
bind '"\el":"\C-f"'                # 綁定 ALT+l 為光標右移，同 CTRL+f / <Right>
bind '"\ej":"\C-n"'                # 綁定 ALT+j 為下條歷史，同 CTRL+n / <Down>
bind '"\ek":"\C-p"'                # 綁定 ALT+k 為上條歷史，同 CTRL+p / <Up>
bind '"\eH":"\eb"'                 # 綁定 ALT+H 為光標左移一個單詞，同 ALT-b 
bind '"\eL":"\ef"'                 # 綁定 ALT+L 為光標右移一個單詞，同 ALT-f 
bind '"\eJ":"\C-a"'                # 綁定 ALT+J 為移動到行首，同 CTRL+a / <Home>
bind '"\eK":"\C-e"'                # 綁定 ALT+K 為移動到行末，同 CTRL+e / <End>
bind '"\e;":"ls -l\n"'             # 綁定 ALT+; 為執行 ls -l 命令


##############################################################################
# 網絡管理：ip / ifconfig / nmap ...
##############################################################################

ip a                               # 顯示所有網絡地址，同 ip address
ip a show eth1                     # 顯示網卡 IP 地址
ip a add 172.16.1.23/24 dev eth1   # 添加網卡 IP 地址
ip a del 172.16.1.23/24 dev eth1   # 刪除網卡 IP 地址
ip link show dev eth0              # 顯示網卡設備屬性
ip link set eth1 up                # 激活網卡
ip link set eth1 down              # 關閉網卡
ip link set eth1 address {mac}     # 修改 MAC 地址
ip neighbour                       # 查看 ARP 緩存
ip route                           # 查看路由表
ip route add 10.1.0.0/24 via 10.0.0.253 dev eth0    # 添加靜態路由
ip route del 10.1.0.0/24           # 刪除靜態路由

ifconfig                           # 顯示所有網卡和接口信息
ifconfig -a                        # 顯示所有網卡（包括開機沒啟動的）信息
ifconfig eth0                      # 指定設備顯示信息
ifconfig eth0 up                   # 激活網卡
ifconfig eth0 down                 # 關閉網卡
ifconfig eth0 192.168.120.56       # 給網卡配置 IP 地址
ifconfig eth0 10.0.0.8 netmask 255.255.255.0 up     # 配置 IP 並啟動
ifconfig eth0 hw ether 00:aa:bb:cc:dd:ee            # 修改 MAC 地址

nmap 10.0.0.12                     # 掃瞄主機 1-1000 端口
nmap -p 1024-65535 10.0.0.12       # 掃瞄給定端口
nmap 10.0.0.0/24                   # 給定網段掃瞄局域網內所有主機
nmap -O -sV 10.0.0.12              # 探測主機服務和操作系統版本


##############################################################################
# 有趣的命令
##############################################################################

man hier                           # 查看文件系統的結構和含義
man test                           # 查看 posix sh 的條件判斷幫助
man ascii                          # 顯示 ascii 表
getconf LONG_BIT                   # 查看系統是 32 位還是 64 位
bind -P                            # 列出所有 bash 的快捷鍵
mount | column -t                  # 漂亮的列出當前加載的文件系統
curl ip.cn                         # 取得外網 ip 地址和服務商信息
disown -a && exit                  # 關閉所有後台任務並退出
cat /etc/issue                     # 查看 Linux 發行版信息
lsof -i port:80                    # 哪個程序在使用 80 端口？
showkey -a                         # 取得按鍵的 ASCII 碼
svn diff | view -                  # 使用 Vim 來顯示帶色彩的 diff 輸出
mv filename.{old,new}              # 快速文件改名
time read                          # 使用 CTRL-D 停止，最簡單的計時功能
cp file.txt{,.bak}                 # 快速備份文件
sudo touch /forcefsck              # 強制在下次重啟時掃瞄磁盤
find ~ -mmin 60 -type f            # 查找 $HOME 目錄中，60 分鐘內修改過的文件
curl wttr.in/~beijing              # 查看北京的天氣預報
echo ${SSH_CLIENT%% *}             # 取得你是從什麼 IP 鏈接到當前主機上的
echo $[RANDOM%X+1]                 # 取得 1 到 X 之間的隨機數
bind -x '"\C-l":ls -l'             # 設置 CTRL+l 為執行 ls -l 命令
find / -type f -size +5M           # 查找大於 5M 的文件
chmod --reference f1 f2            # 將 f2 的權限設置成 f1 一模一樣的
curl -L cheat.sh                   # 速查表大全


##############################################################################
# 常用技巧
##############################################################################

# 列出最常使用的命令
history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head

# 列出所有網絡狀態：ESTABLISHED / TIME_WAIT / FIN_WAIT1 / FIN_WAIT2 
netstat -n | awk '/^tcp/ {++tt[$NF]} END {for (a in tt) print a, tt[a]}'

# 通過 SSH 來 mount 文件系統
sshfs name@server:/path/to/folder /path/to/mount/point

# 顯示前十個運行的進程並按內存使用量排序
ps aux | sort -nk +4 | tail

# 在右上角顯示時鐘
while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done&

# 從網絡上的壓縮文件中解出一個文件來，並避免保存中間文件
wget -qO - "http://www.tarball.com/tarball.gz" | tar zxvf -

# 性能測試：測試處理器性能
python -c "import test.pystone;print(test.pystone.pystones())"

# 性能測試：測試內存帶寬
dd if=/dev/zero of=/dev/null bs=1M count=32768

# Linux 下掛載一個 iso 文件
mount /path/to/file.iso /mnt/cdrom -oloop

# 通過主機 A 直接 ssh 到主機 B
ssh -t hostA ssh hostB

# 下載一個網站的所有圖片
wget -r -l1 --no-parent -nH -nd -P/tmp -A".gif,.jpg" http://example.com/images

# 快速創建項目目錄
mkdir -p work/{project1,project2}/{src,bin,bak}

# 按日期範圍查找文件
find . -type f -newermt "2010-01-01" ! -newermt "2010-06-01"

# 顯示當前正在使用網絡的進程
lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2

# Vim 中保存一個沒有權限的文件
:w !sudo tee > /dev/null %

# 在 .bashrc / .bash_profile 中加載另外一個文件（比如你保存在 github 上的配置）
source ~/github/profiles/my_bash_init.sh

# 反向代理：將外網主機（202.115.8.1）端口（8443）轉發到內網主機 192.168.1.2:443
ssh -CqTnN -R 0.0.0.0:8443:192.168.1.2:443  user@202.115.8.1

# 正向代理：將本地主機的 8443 端口，通過 192.168.1.3 轉發到 192.168.1.2:443 
ssh -CqTnN -L 0.0.0.0:8443:192.168.1.2:443  user@192.168.1.3

# socks5 代理：把本地 1080 端口的 socks5 的代理請求通過遠程主機轉發出去
ssh -CqTnN -D localhost:1080  user@202.115.8.1

# 終端下正確設置 ALT 鍵和 BackSpace 鍵
http://www.skywind.me/blog/archives/2021


##############################################################################
# 有用的函數
##############################################################################

# 自動解壓：判斷文件後綴名並調用相應解壓命令
function q-extract() {
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2)   tar -xvjf $1    ;;
        *.tar.gz)    tar -xvzf $1    ;;
        *.tar.xz)    tar -xvJf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       rar x $1       ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar -xvf $1     ;;
        *.tbz2)      tar -xvjf $1    ;;
        *.tgz)       tar -xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# 自動壓縮：判斷後綴名並調用相應壓縮程序
function q-compress() {
    if [ -n "$1" ] ; then
        FILE=$1
        case $FILE in
        *.tar) shift && tar -cf $FILE $* ;;
        *.tar.bz2) shift && tar -cjf $FILE $* ;;
        *.tar.xz) shift && tar -cJf $FILE $* ;;
        *.tar.gz) shift && tar -czf $FILE $* ;;
        *.tgz) shift && tar -czf $FILE $* ;;
        *.zip) shift && zip $FILE $* ;;
        *.rar) shift && rar $FILE $* ;;
        esac
    else
        echo "usage: q-compress <foo.tar.gz> ./foo ./bar"
    fi
}

# 漂亮的帶語法高亮的 color cat ，需要先 pip install pygments
function ccat() {
    local style="monokai"
    if [ $# -eq 0 ]; then
        pygmentize -P style=$style -P tabsize=4 -f terminal256 -g
    else
        for NAME in $@; do
            pygmentize -P style=$style -P tabsize=4 -f terminal256 -g "$NAME"
        done
    fi
}


##############################################################################
# 好玩的配置
##############################################################################

# 放到你的 ~/.bashrc 配置文件中，給 man 增加漂亮的色彩高亮
export LESS_TERMCAP_mb=$'\E[1m\E[32m'
export LESS_TERMCAP_mh=$'\E[2m'
export LESS_TERMCAP_mr=$'\E[7m'
export LESS_TERMCAP_md=$'\E[1m\E[36m'
export LESS_TERMCAP_ZW=""
export LESS_TERMCAP_us=$'\E[4m\E[1m\E[37m'
export LESS_TERMCAP_me=$'\E(B\E[m'
export LESS_TERMCAP_ue=$'\E[24m\E(B\E[m'
export LESS_TERMCAP_ZO=""
export LESS_TERMCAP_ZN=""
export LESS_TERMCAP_se=$'\E[27m\E(B\E[m'
export LESS_TERMCAP_ZV=""
export LESS_TERMCAP_so=$'\E[1m\E[33m\E[44m'

# ALT+hjkl/HJKL 快速移動光標，將下面內容添加到 ~/.inputrc 中可作用所有工具，
# 包括 bash/zsh/python/lua 等使用 readline 的工具，幫助見：info rluserman
"\eh": backward-char
"\el": forward-char
"\ej": next-history
"\ek": previous-history
"\eH": backward-word
"\eL": forward-word
"\eJ": beginning-of-line
"\eK": end-of-line


##############################################################################
# References
##############################################################################

https://github.com/Idnan/bash-guide
http://www.linuxstall.com/linux-command-line-tips-that-every-linux-user-should-know/
https://ss64.com/bash/syntax-keyboard.html
http://wiki.bash-hackers.org/commands/classictest
https://www.ibm.com/developerworks/library/l-bash-test/index.html
https://www.cyberciti.biz/faq/bash-loop-over-file/
https://linuxconfig.org/bash-scripting-tutorial
https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh
https://devhints.io/bash
https://github.com/jlevy/the-art-of-command-line
https://yq.aliyun.com/articles/68541

# vim: set ts=4 sw=4 tw=0 et :

