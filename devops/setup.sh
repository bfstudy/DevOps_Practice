#!/bin/bash

# 创建MySQL相关目录
echo "创建MySQL目录结构..."
mkdir -p storage/mysql/{data,logs,conf,init}

# 创建MySQL配置文件
echo "创建MySQL配置文件..."
cat > storage/mysql/conf/my.cnf << EOF
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
max_connections=200
innodb_buffer_pool_size=256M
slow_query_log=1
slow_query_log_file=/var/log/mysql/slow.log
long_query_time=2
log-error=/var/log/mysql/error.log
general_log=1
general_log_file=/var/log/mysql/general.log

[client]
default-character-set=utf8mb4

[mysql]
default-character-set=utf8mb4
EOF

# 设置目录权限
echo "设置目录权限..."
sudo chown -R 999:999 storage/mysql/data
sudo chown -R 999:999 storage/mysql/logs

echo "目录结构创建完成！"
echo "目录结构："
tree storage/ 2>/dev/null || find storage/ -type d

echo ""
echo "使用方法："
echo "1. 编辑 .env 文件设置密码"
echo "2. 运行: docker-compose up -d"
echo "3. 查看状态: docker-compose ps"