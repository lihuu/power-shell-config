choco -v

# 配置

choco config list
choco config get <key>
choco config set <key> <value>

## 代理配置

choco config set proxy http://localhost:1080 # 设置科学上网，加速下载
choco config unset proxy # 取消代理

# 搜索安装

choco find keyword # 搜索
choco list keyword # 同上

choco -? # - 后面是选项参数
choco list keyword -a # 搜索所有版本
choco list keyword -e # 精确匹配 -e 是 --exact 的缩写
choco list keyword --approved-oly # 只搜索通过的认证的包
choco list keyword --version=value # 搜索特定版本的包

choco -h #帮助
choco -y # 默认同意所有操作询问
choco list -l # 只显示本地安装的包
choco list --localonly # 同上

choco install pkgname1 pkgname2 # 安装
choco install pkgname -version 7.22.0 # 安装特定版本的包

# 如何安装特定范围的版本？目前还不支持

choco install pkgname -y # 直接安装，不需要再次确认运行脚本

# 指定目录安装

choco install jdk8 -params 'installdir=c:\\java8'

choco uninstall pkgname # 卸载
choco list -l # 查看版本号
choco outdated # 查看过时的包，可更新的包，最后一个 pinned 选项是说明包是否禁止升级

choco pin add -n=pkgname # 禁 止包升级，在升级所有时特别有用
choco pin add -n=git # 禁止 git 升级
choco pin add -n=git --version 1.2.3 # 禁止某个版本升级
choco pin remove --name git # 从禁止升级列表中移除

choco upgrade pkgname # 更新
choco upgrade --except="pkg1,pk2" # 更新是排除某些包和 pin 功能类似
choco upgrade all # 更新所有
