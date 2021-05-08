#!/bin/env bash
## Author:SuperManito
## Modified:2021-3-22

## ======================================= 项 目 说 明 =====================================================
##                                                                                                        #
## 项目名称：《京东薅羊毛》一键部署 For Linux                                                                #
## 项目用途：通过自动化脚本参与京东商城的各种活动从而获取京豆用于购物抵扣                                       #
##           还可通过某些活动免费领取商品或现金红包                                                          #
##                                                                                                        #
## 适用系统：仅支持 Debian 与 Redhat 发行版和及其衍生发行版                                                  #
## 温馨提示：尽量使用最新的稳定版系统，并且安装语言使用简体中文                                                #
##           如果您使用的是 CentOS 系统且最小化安装，请通过 SSH 的方式进入到终端                               # 
##                                                                                                        #
## ========================================================================================================


## ======================================= 定 义 相 关 变 量 ===============================================
## 安装目录
BASE="/opt/jd"
## 项目分支
JD_BASE_BRANCH="source"
## 项目地址
JD_BASE_URL="https://gitee.com/mjf521/JD_shell.git"
## 活动脚本库私钥
JD_BASE_URL="https://gitee.com/mjf521/JD-FreeFuck.git"
## 活动脚本库私钥
KEY="-----BEGIN OPENSSH PRIVATE KEY-----\n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\n-----END OPENSSH PRIVATE KEY-----"
## ========================================================================================================


## ======================================= 定 义 账 户 Cookie ==============================================
##
COOKIE1='""'
COOKIE2='""'
COOKIE3='""'
COOKIE4='""'
COOKIE5='""'
COOKIE6='""'
##
## 配置京东账户注意事项：
## 1. 将 Cookie部分内容 填入"双引号"内，例 Cookie1='"pt_key=xxxxxx;pt_pin=xxxxxx;"'
## 2. 本项目可同时运行无限个账号，从第7个账户开始需要自行在项目 config.sh 配置文件中定义变量，例如Cookie7=""
## ========================================================================================================


## 定义变量：
## 判定系统是基于 Debian 还是 RedHat
ls /etc | grep redhat-release -qw
if [ $? -eq 0 ]; then
    SYSTEM="RedHat"
else
    SYSTEM="Debian"
fi
## 系统判定变量（系统名称、系统版本、系统版本号）
if [ $SYSTEM = "Debian" ]; then
    SYSTEM_NAME=$(lsb_release -is)
    SYSTEM_VERSION=$(lsb_release -cs)
    SYSTEM_VERSION_NUMBER=$(lsb_release -rs)
elif [ $SYSTEM = "RedHat" ]; then
    SYSTEM_NAME=$(cat /etc/redhat-release | cut -c1-6)
    if [ $SYSTEM_NAME = "CentOS" ]; then
        SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c22-24)
        CENTOS_VERSION=$(cat /etc/redhat-release | cut -c22)
    elif [ $SYSTEM_NAME = "Fedora" ]; then
        SYSTEM_VERSION_NUMBER=$(cat /etc/redhat-release | cut -c16-18)
    fi
fi

## 组合各个函数模块部署项目：
function Installation() {
    ## 根据各部分函数执行结果判定部署结果
    ## 判断环境条件决定是否退出部署脚本
    EnvJudgment
    EnvStructures
    ## 判定Nodejs是否安装成功，否则跳出
    VERIFICATION=$(node -v | cut -c2)
    if [ $VERIFICATION = "1" ]; then
        PrivateKeyInstallation
        ## 判定私钥是否安装成功，否则跳出
        ls /root/.ssh | grep id_rsa -wq
        if [ $? -eq 0 ]; then
            ProjectDeployment
            SetConfig
            PanelJudgment
            UseNotes
        else
            PrivateKeyFailureTips
        fi
    else
        NodejsFailureTips
    fi
}

## 环境判定：
function EnvJudgment() {
    ## 当前用户判定：
    if [ $UID -ne 0 ]; then
        echo -e '\033[31m ------------ Permission no enough, please use user ROOT! ------------ \033[0m'
        exit
    fi
    ## 网络环境判定：
    ping -c 1 www.baidu.com >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "\033[31m ----- Network connection error.Please check the network environment and try again later! ----- \033[0m"
        exit
    fi
}

## 环境搭建：
function EnvStructures() {
    Welcome
    ## CentOS 启用仓库
    if [ $SYSTEM_NAME = "CentOS" ]; then
        ## 安装扩展 EPEL 源
        yum install -y epel-release
        ## CentOS 8启用 PowerTools 仓库
        if [ $CENTOS_VERSION == "8" ]; then
            sed -i "s/enabled=0/enabled=1/g" /etc/yum.repos.d/*PowerTools.repo
        fi
        ## 重新建立缓存
        yum makecache
    fi

    ## 修改系统时区：
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime >/dev/null 2>&1
    timedatectl set-timezone "Asia/Shanghai" >/dev/null 2>&1
    ## 放行控制面板需要用到的端口
    firewall-cmd --zone=public --add-port=5678/tcp --permanent >/dev/null 2>&1
    systemctl reload firewalld >/dev/null 2>&1

    ## 基于 Debian 发行版和及其衍生发行版的软件包安装
    if [ $SYSTEM = "Debian" ]; then
        ## 更新软件源，列出索引
        apt update
        ## 卸载 Nodejs 旧版本，从而确保安装新版本
        apt remove -y nodejs npm >/dev/null 2>&1
        rm -rf /etc/apt/sources.list.d/nodesource.list
        ## 安装需要的软件包
        apt install -y wget curl net-tools openssh-server git perl moreutils
        ## 安装 Nodejs 与 npm
        curl -sL https://deb.nodesource.com/setup_14.x | bash -
        DownloadTip
        apt install -y nodejs
        apt autoremove -y
    ## 基于 RedHat 发行版和及其衍生发行版的软件包安装
    elif [ $SYSTEM = "RedHat" ]; then
        ## 更新软件源，建立本地缓存
        yum makecache
        ## 卸载 Nodejs 旧版本，从而确保安装新版本
        yum remove -y nodejs npm >/dev/null 2>&1
        rm -rf /etc/yum.repos.d/nodesource-*.repo
        ## 安装需要的软件包
        yum install -y wget curl net-tools openssh-server git perl moreutils
        ## 安装 Nodejs 与 npm
        curl -sL https://rpm.nodesource.com/setup_14.x | bash -
        DownloadTip
        yum install -y nodejs
        yum autoremove -y
    fi
}

## 部署私钥：
function PrivateKeyInstallation() {
    mkdir -p /root/.ssh
    ## 检测当前用户是否存在私钥，如存在执行备份操作
    ls /root/.ssh | grep id_rsa.bak -wq
    if [ $? -eq 0 ]; then
        rm -rf /root/.ssh/id_rsa
        echo -e ''
        echo -e "\033[32m检测到已备份的私钥，跳过备份操作...... \033[0m"
        echo -e ''
        sleep 2s
    else
        mv /root/.ssh/id_rsa /root/.ssh/id_rsa.bak >/dev/null 2>&1
    fi
    ## 检测当前用户是否存在公钥，如存在执行备份操作
    ls /root/.ssh | grep id_rsa.pub.bak -wq
    if [ $? -eq 0 ]; then
        rm -rf /root/.ssh/id_rsa.pub
        echo -e ''
        echo -e "\033[32m检测到已备份的公钥，跳过备份操作...... \033[0m"
        echo -e ''
        sleep 2s
    else
        mv /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub.bak >/dev/null 2>&1
    fi
    ## 安装私钥
    chmod 700 /root/.ssh
    echo -e $KEY >/root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
    ssh-keyscan gitee.com >/root/.ssh/known_hosts
}

## 项目部署：
function ProjectDeployment() {
    ## 卸载旧版本
    rm -rf $BASE
    rm -rf /usr/local/bin/jd
    rm -rf /usr/local/bin/git_pull
    rm -rf /usr/local/bin/rm_log
    rm -rf /usr/local/bin/export_sharecodes
    rm -rf /usr/local/bin/run_all
    ## 克隆项目
    git clone -b $JD_BASE_BRANCH $JD_BASE_URL $BASE
    ## 创建目录
    mkdir $BASE/config
    mkdir $BASE/log
    ## 根据安装目录配置定时任务
    sed -i "s#BASE#$BASE#g" $BASE/sample/computer.list.sample
    ## 创建项目配置文件与定时任务配置文件
    cp $BASE/sample/config.sh.sample $BASE/config/config.sh
    cp $BASE/sample/computer.list.sample $BASE/config/crontab.list
    ## 切换 npm 官方源为淘宝源
    npm config set registry http://registry.npm.taobao.org
    ## 安装控制面板功能
    cp $BASE/sample/auth.json $BASE/config/auth.json
    cd $BASE/panel
    npm install || npm install --registry=https://registry.npm.taobao.org
    npm install -g pm2
    pm2 start ecosystem.config.js
    ## 拉取活动脚本
    bash $BASE/git_pull.sh
    bash $BASE/git_pull.sh >/dev/null 2>&1
    ## 创建软链接
    ln -sf $BASE/jd.sh /usr/local/bin/jd
    ln -sf $BASE/git_pull.sh /usr/local/bin/git_pull
    ln -sf $BASE/rm_log.sh /usr/local/bin/rm_log
    ln -sf $BASE/export_sharecodes.sh /usr/local/bin/export_sharecodes
    ln -sf /opt/jd/run_all.sh /usr/local/bin/run_all
    ## 定义全局变量
    echo "export JD_DIR=$BASE" >>/etc/profile
    source /etc/profile
}

## 更改配置文件：
function SetConfig() {
    sed -i "30c Cookie1=$COOKIE1" $BASE/config/config.sh
    sed -i "31c Cookie2=$COOKIE2" $BASE/config/config.sh
    sed -i "32c Cookie3=$COOKIE3" $BASE/config/config.sh
    sed -i "33c Cookie4=$COOKIE4" $BASE/config/config.sh
    sed -i "34c Cookie5=$COOKIE5" $BASE/config/config.sh
    sed -i "35c Cookie6=$COOKIE6" $BASE/config/config.sh
}

## 判定控制面板安装结果：
function PanelJudgment() {
    netstat -tunlp | grep 5678 -wq
    PanelTestA=$?
    curl -sSL 127.0.0.1:5678 | grep "京东薅羊毛控制面板" -wq
    PanelTestB=$?
    if [ ${PanelTestA} -eq 0 ] || [ ${PanelTestB} -eq 0 ]; then
        PanelUseNotes
    else
        echo -e ''
        echo -e "\033[31m ------------------- 控制面板安装失败 ------------------- \033[0m"
    fi
}

## 欢迎语：
function Welcome() {
    echo -e ''
    echo -e '+---------------------------------------------------+'
    echo -e '|                                                   |'
    echo -e '|   =============================================   |'
    echo -e '|                                                   |'
    echo -e '|      欢迎使用《京东薅羊毛》一键部署 For Linux     |'
    echo -e '|                                                   |'
    echo -e '|   =============================================   |'
    echo -e '|                                                   |'
    echo -e '+---------------------------------------------------+'
    echo -e ''
    echo -e '#####################################################'
    echo -e ''
    echo -e "      当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER"
    echo -e "      当前系统时间  $(date +%Y-%m-%d) $(date +%H:%M)"
    echo -e ''
    echo -e '#####################################################'
    echo -e ''
    sleep 3s
}

## 下载提示：
function DownloadTip() {
    echo -e "\033[32m +----------------- 开 始 下 载 并 安 装 Nodejs -----------------+ \033[0m"
    echo -e "\033[32m |                                                               | \033[0m"
    echo -e "\033[32m |   因 Nodesource 无国内源，下载网速可能过慢请您耐心等候......  | \033[0m"
    echo -e "\033[32m |                                                               | \033[0m"
    echo -e "\033[32m +---------------------------------------------------------------+ \033[0m"
    echo -e ''
    echo -e ''
}

## 失败原因提示：
function PrivateKeyFailureTips() {
    echo -e ''
    echo -e "\033[31m -------------- 私钥安装失败，退出部署脚本 -------------- \033[0m"
    echo -e "\033[31m 原因：1. 在 /root/.ssh 目录下没有检测到私钥文件 \033[0m"
    echo -e "\033[31m      2. 可能由于 /root/.ssh 目录创建失败导致 \033[0m"
    echo -e "\033[31m      3. 权限不足的问题 \033[0m"
    exit
}
function NodejsFailureTips() {
    echo -e ''
    echo -e "\033[31m -------------- Nodejs安装失败，退出部署脚本 -------------- \033[0m"
    echo -e "\033[31m 原因：1. 由于网络环境导致软件包下载失败 \033[0m"
    echo -e "\033[31m      2. 您使用的 Linux 发行版可能不受本项目支持 \033[0m"
    exit
}

## 控制面板使用需知：
function PanelUseNotes() {
    echo -e ''
    echo -e "\033[32m +--------- 控 制 面 板 安 装 成 功 并 已 启 动 ---------+ \033[0m"
    echo -e "\033[32m |                                                       | \033[0m"
    echo -e "\033[32m |      本地访问：http://127.0.0.1:5678                  | \033[0m"
    echo -e "\033[32m |                                                       | \033[0m"
    echo -e "\033[32m |      外部访问：http://内部或外部IP地址:5678           | \033[0m"
    echo -e "\033[32m |                                                       | \033[0m"
    echo -e "\033[32m |      初始用户名：useradmin  初始密码：supermanito     | \033[0m"
    echo -e "\033[32m |                                                       | \033[0m"
    echo -e "\033[32m |      控制面板默认开机自启，如若失效请自行重启         | \033[0m"
    echo -e "\033[32m |                                                       | \033[0m"
    echo -e "\033[32m |      关于更多使用帮助请通过《使用与更新》教程获取     | \033[0m"
    echo -e "\033[32m |                                                       | \033[0m"
    echo -e "\033[32m +-------------------------------------------------------+ \033[0m"
    echo -e ''
    sleep 3s
}

## 项目使用需知：
function UseNotes() {
    echo -e ''
    echo -e "\033[32m --------------------------- 一键部署成功，请执行 bash run_all.sh 命令开始您的薅羊毛行为 --------------------------- \033[0m"
    echo -e ''
    echo -e "\033[32m +=================================================================================================================+ \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 定义：run-all.sh 为一键执行所有活动脚本，git_pull.sh 为一键更新脚本                                             | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       如果想要执行特定活动脚本，请通过命令 bash jd.sh 查看教程                                                  | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m | 注意：1. 该项目文件以及一键脚本的安装目录为$BASE                                                              | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       2. 为了保证脚本的正常运行，请不要更改任何组件的位置以避免出现未知的错误                                   | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       3. 手动执行 run_all.sh 脚本后无需守在电脑旁，会自动在最后运行挂机活动脚本                                 | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    if [ $SYSTEM = "Debian" ]; then
        echo -e "\033[32m |       4. 执行 run_all 脚本期间如果卡住，可按回车键尝试或通过命令 Ctrl + Z 跳过继续执行剩余活动脚本              | \033[0m"
    elif [ $SYSTEM = "RedHat" ]; then
        echo -e "\033[32m |       4. 执行 run_all 脚本期间如果卡住，可按回车键尝试或通过命令 Ctrl + C 跳过继续执行剩余活动脚本              | \033[0m"
    fi
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       5. 由于京东活动一直变化可能会出现无法参加活动、报错等正常现象，可手动更新活动脚本                         | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       6. 如果需要更新活动脚本，请执行 bash git_pull.sh 命令一键更新即可，它会同步更新 run_all.sh 脚本           | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       7. 除手动运行活动脚本外该项目还会通过定时的方式全天候自动运行活动脚本，具体运行记录可通过日志查看         | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       8. 该项目已默认配置好 Crontab 定时任务，定时配置文件 crontab.list 会通过活动脚本的更新而同步更新          | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       9. 之前填入的 Cookie 部分内容具有一定的时效性，若提示失效请根据教程重新获取并通过命令手动更新             | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m |       10. 我不是活动脚本的开发者，但后续使用遇到任何问题都可访问本项目寻求帮助，制作不易，理解万岁              | \033[0m"
    echo -e "\033[32m |                                                                                                                 | \033[0m"
    echo -e "\033[32m +=================================================================================================================+ \033[0m"
    echo -e ''
    echo -e "\033[32m --------------------------- 更多帮助请访问   https://github.com/1314mjf521/JD-FreeFuck --------------------------- \033[0m"
    echo -e "\033[32m --------------------------- Github & Gitee   https://gitee.com/mjf521/JD-FreeFuck  --------------------------- \033[0m"
    echo -e "\033[32m -------------如果大家觉得好用请之脚本页面进行赞赏 https://gitee.com/mjf521/JD-FreeFuck/tree/main/help ------------ \033[0m"
    echo -e ''
}

## 执行相关函数开始部署
Installation
