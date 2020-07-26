@echo off
rem 后续命令使用的是：UTF-8编码 支持中文输出
chcp 65001
:loop
set /p option=0,develop mode; 1,提交 2,提交并推送 3,git初始化 4,添加远程仓库 5,查看版本 6，版本恢复   :
if "%option%"=="0" goto develop
if "%option%"=="1" goto add&commit
if "%option%"=="2" goto push
if "%option%"=="3" goto init
if "%option%"=="4" goto add_remote
if "%option%"=="5" goto rev-parse
if "%option%"=="6" goto recover

:develop
start cmd
exit

:init
set /p message=输入英文备注：
git init
git add .
git commit -m "%message%"
goto loop

:add&commit
set /p message=输入英文备注：
git add .
git commit -m "%message%"
goto loop

:push
set /p message=输入英文备注：
git add .
git commit -m "%message%"
set /p remote_rep=远程仓库(默认origin):
if "%remote_rep%"=="" set remote_rep=origin
echo 远程仓库:%remote_rep%

set /p branch=本地分支(默认master):
if "%branch%"=="" set branch=master
echo 本地分支:%branch%

git push -u %remote_rep% %branch%
goto loop

:add_remote
set /p remote_rep=远程仓库(默认origin):
if "%remote_rep%"=="" set remote_rep=origin
echo %remote_rep%
set /p ssh=远程仓库ssh:
echo %ssh%
git remote add %remote_rep% %ssh%

goto loop

:rev-parse
echo 当前分支：
git branch
echo 当前版本号：
git rev-parse HEAD
echo ----历史版本----
git log
echo ----提交记录----
git reflog
goto loop

:recover
set /p rev-parse=输入版本号：
git reset --hard %rev-parse%

goto loop