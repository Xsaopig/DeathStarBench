#!/bin/bash

# 脚本功能：抹掉当前仓库的所有git信息，并重新初始化一个新的git仓库

# 检查是否在git仓库中
if [ ! -d ".git" ]; then
    echo "错误：当前目录不是一个git仓库！"
    exit 1
fi

# 备份重要文件（可选）
echo "正在备份重要文件..."
cp .gitignore .gitignore.bak 2>/dev/null
cp README.md README.md.bak 2>/dev/null
cp LICENSE LICENSE.bak 2>/dev/null

echo "开始抹除git信息..."

# 移除主仓库的.git目录
rm -rf .git

# 移除所有子模块的.git目录
# 查找所有子模块的.git目录
SUBMODULE_GIT_DIRS=$(find . -name ".git" -type d)
for dir in $SUBMODULE_GIT_DIRS; do
    echo "移除子模块git目录: $dir"
    rm -rf "$dir"
done

# 移除.gitmodules文件（如果存在）
if [ -f ".gitmodules" ]; then
    echo "移除.gitmodules文件"
    rm -f .gitmodules
fi

# 移除可能存在的.gitignore和其他git相关文件
# 注意：这里保留了.gitignore，因为用户可能需要它
echo "重新初始化git仓库..."

# 重新初始化git仓库
git init

echo "
=========================
git信息已成功抹除并重新初始化！
下一步操作：
1. 添加你的远程仓库：git remote add origin <你的GitHub仓库URL>
2. 提交所有文件：git add . && git commit -m "Initial commit"
3. 推送到远程仓库：git push -u origin master
========================="