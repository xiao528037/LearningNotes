

# Oracle体系结构

​	Oracle的体系结构是指数据库的组成、工作过程与原理，以及数据在数据库中组织与管理机制

​	Oracle服务器提供开发、全面和综合的信息管理，它由Oracle数据库和Oracle实例组成

​			1.数据库：物理操作系统文件或磁盘的集合

​			2.实例：管理数据库的后台进程和内存结构的集合。有一			组ORACLE后台进程/线程以及一个共享内存区组成。

# Oracle网络配置

​	Oracle产品安装完成后，服务器和客户端都需要进行网络配置才能实现网络连接。**服务器端配置监听器**，**客户端配置网络服务名。**

​	服务端监听器配置信息包括`监听协议`、`地址`及其他相关信息。

​	配置信息保存在名为`listener.ora`的文件中在安装服务器软件是自动配置一个监听器

​	客户端的网络服务名配置信息包括`服务器地址`、`监听端口号`和`数据库SID`等，与服务器的监听器建立连接。

​	配置信息报错在名为`tnsnames.ora`的文件中

Oracle中的Net Configuration Assistant和Net Manager工具都能用来配置监听器和网络服务名

# Oracle的默认用户

​	只有合法的用户账号磁能访问Oracle数据库，Oracle有几个默认的数据库用户：sys、system、scott

​	连接数据库需要用户账号，每个用户拥有表空间和一个临时表空间。

```sql
create user <userneme> identified by <password>
default tablespace users
temporary tablespace temp;
```



# SQL分类

```txt
数据定义语言：简称DDL（Data Definition Language）,来定义数据库对象：数据库database，表table，列column等。关键字create，修改alter，删除drop等（结构）

数据操作语言简称DML（Data Manipulation Language），用来对数据库中表的记录进行更新。关键字：插入insert，删除delete，更新update等（数据）

数据查询语句：简称DQL（Date Query Language），用来查询数据库中表的记录。关键字：select，from，where等

数据控制语言：简称DCL（Date Control Language），用来定义数据库的访问权限和安全级别，及创建用户：关键字：grant等
```

# 基本操作

```sql
//通过CMD连接ORCLE
sqlplus [用户]/[密码]

//退出
exit

//查看当前数据库实例
show user

```

