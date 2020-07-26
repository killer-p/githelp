@echo off
rem 后续命令使用的是：UTF-8编码 支持中文输出
chcp 65001

rem 使用的文本编辑器目录地址
set editor_path=D:\notepad++
rem 当前仓库目录地址
set rep_path=%CD%


:loop
echo ------------------------------------------菜单--------------------------------------------
set /p option=0,编辑readme 1,提交 2,推送至远程仓库 3,git初始化 4，仓库与版本控制   :

if "%option%"=="0" goto readme
if "%option%"=="1" goto add&commit
if "%option%"=="2" goto push
if "%option%"=="3" goto initmodule
if "%option%"=="4" goto versionmodule



rem 切换到文本编辑器的目录并用编辑器打开仓库的readme 再将当前目录切换回仓库目录
:readme
echo readme
cd %editor_path%
start notepad++.exe %rep_path%\readme.md 
cd %rep_path%
goto loop

rem 初始化一个git仓库 并提交
:init
echo init
set /p message=输入英文备注：
git init
git add .
git commit -m "%message%"
goto loop

rem 添加并提交一个版本
:add&commit
echo add&commit
set /p message=输入英文备注：
git add .
git commit -m "%message%"
goto loop

rem 初始化模块
:initmodule
echo initmodule
echo --------------------------------------初始化菜单----------------------------------------
set /p option_i= 0,返回 1，初始化仓库 2,用户初始化  :

if "%option_i%"=="0" goto loop
if "%option_i%"=="1" goto init
if "%option_i%"=="2" goto user_init



rem 版本控制模块
:versionmodule
echo versionmodule
echo --------------------------------------仓库与版本控制菜单----------------------------------------
set /p option_v= 0,返回 1，版本信息 2,版本恢复 3，查看远程仓库 4，关联远程仓库 5，取关远程仓库:

if "%option_v%"=="0" goto loop
if "%option_v%"=="1" goto rev-parse
if "%option_v%"=="2" goto recover
if "%option_v%"=="3" goto show_remote_rep
if "%option_v%"=="4" goto add_remote_rep
if "%option_v%"=="5" goto delete_remote_rep

rem 推送到远程仓库 必须先关联远程仓库 支持默认
:push
echo push
set /p remote_rep=远程仓库(默认origin):
if "%remote_rep%"=="" set remote_rep=origin
echo 远程仓库:%remote_rep%

set /p branch=本地分支(默认master):
if "%branch%"=="" set branch=master
echo 本地分支:%branch%

git push -u %remote_rep% %branch%
goto loop

rem 显示远程仓库
:show_remote_rep
echo show_remote_rep
echo 远程仓库名称 ssh地址
git remote -v

goto loop


rem 添加远程仓库 需要shh地址
:add_remote_rep
echo add_remote
set /p remote_rep=远程仓库(默认origin):
if "%remote_rep%"=="" set remote_rep=origin
echo %remote_rep%
set /p ssh=远程仓库ssh:
echo %ssh%
git remote add %remote_rep% %ssh%

goto loop

rem 取关远程仓库
:delete_remote_rep
set /p remote_rep=远程仓库(默认origin):
if "%remote_rep%"=="" set remote_rep=origin
echo %remote_rep%
git remote remove %remote_rep%

goto loop


rem 查看仓库版本信息
:rev-parse
echo rev-parse
echo 当前分支：
git branch
echo 当前版本号：
git rev-parse HEAD
echo ----历史版本----
echo 注意，若无显示提交记录和菜单，输入wq
echo 注意，若无显示提交记录和菜单，输入wq
echo 注意，若无显示提交记录和菜单，输入wq
git log
echo ----提交记录----
git reflog
goto loop

rem 恢复
:recover
echo recover
set /p rev-parse=输入版本号：
git reset --hard %rev-parse%

goto loop

rem 设置git用户
:user_init
echo user_init

goto loop