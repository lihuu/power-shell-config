## powershell 脚本环境设置

### 设置执行的规则

https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### 执行规则说明

##### RemoteSigned

- windows 服务器版系统默认的执行规则
- 脚本可以执行
- 远程下载的脚本需要验证签名才能执行
- 本地的脚本不用验证签名

##### AllSigned

- 脚本可以执行
- 远程和本地的脚本都需要验证可信发布者的签名

##### ByPass

##### Default

##### Restricted

- windows 客户版系统中默认的执行规则
- 允许执行命令，但是不允许执行 powershell 脚本
- 禁止任何的脚本执行，包括 `.ps1xml`,`.psm1`,`.ps1`格式的文件。

##### Undefined
