#常见的CMAKE选项
#-DCMAKE_INSTALL_PREFIX=/usr/local/mysql    MySQL安装目录
#-DWITH_INNOBASE_STORAGE_ENGINE=1           安装InnoDB存储引擎
#-DWITH_MYISAM_STORAGE_ENGINE=1             安装MyISAM存储引擎
#-DWITH_MEMORY_STORAGE_ENGINE=1             安装内存存储引擎
#-DDEFAULT_CHARSET=utf8                     默认编码设置成utf8
#-DDEFAULT_COLLATION=utf8_general_ci        默然校验规则是utf8_general_ci
#-DWITH_EXTRA_CHARSETS=all                  支持其他所有的编码
#-DMYSQL_TCP_PORT=3306                      MySQL端口指定为3306
#-DMYSQL_UNIX_ADDR=/tmp/mysql.sock          指定SOCK文件路径
#-DMYSQL_DATADIR=/usr/local/mysql/data      MySQL数据目录
#make -j n  支持多线程编译（一般跟内核数相等）


优化数据库配置（4G内存优化方案，仅供参考）
vim /etc/my.cnf  
[client]  
port=3306  
socket=/tmp/mysql.sock  
  
[mysqld]  
#bind_address=127.0.0.1  
binlog_cache_size=128K  
thread_stack=256K  
join_buffer_size=2048K  
query_cache_type=1  
max_heap_table_size=512M  
port=3306  
pid-file=/tmp/mysql.pid  
socket=/tmp/mysql.sock  
datadir=/usr/local/mysql-5.7.27/data  
skip-external-locking  
performance_schema_max_table_instances=400  
table_definition_cache=400  
key_buffer_size=384M  
max_allowed_packet=100G  
table_open_cache=384  
sort_buffer_size=1024K  
net_buffer_length=8K  
read_buffer_size=1024K  
read_rnd_buffer_size=768K  
myisam_sort_buffer_size=16M  
thread_cache_size=128  
query_cache_size=192M  
tmp_table_size=512M  
sql-mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES  
  
explicit_defaults_for_timestamp=true  
#skip-networking  
max_connections=300  
max_connect_errors=100  
open_files_limit=65535  
  
#log-bin=mysql-bin  
#binlog_format=mixed  
server-id=1  
expire_logs_days=10  
slow_query_log=1  
slow-query-log-file=/usr/local/mysql-5.7.27/data/mysql-slow.log  
long_query_time=3  
#log_queries_not_using_indexes=on  
early-plugin-load=""  
  
default_storage_engine=InnoDB  
innodb_data_home_dir=/usr/local/mysql-5.7.27/data  
innodb_data_file_path=ibdata1:10M:autoextend  
innodb_log_group_home_dir=/usr/local/mysql-5.7.27/data  
innodb_buffer_pool_size=512M  
innodb_log_file_size=128M  
innodb_log_buffer_size=32M  
innodb_flush_log_at_trx_commit=1  
innodb_lock_wait_timeout=120  
innodb_max_dirty_pages_pct=90  
innodb_read_io_threads=2  
innodb_write_io_threads=2  
  
[mysqldump]  
quick  
max_allowed_packet=16M  
  
[mysql]  
no-auto-rehash  
  
[myisamchk]  
key_buffer_size=64M  
sort_buffer_size=1M  
read_buffer=2M  
write_buffer=2M  
  
[mysqlhotcopy]  
interactive-timeout