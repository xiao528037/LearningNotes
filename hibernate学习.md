# hibernate学习

## hibernate基本配置

	### 实体类

```java
package com.xiao;

import lombok.Data;

@Data
public class GoodsEntity {

    public GoodsEntity() {
    }

    public GoodsEntity(String name, Double price) {
        this.name = name;
        this.price = price;
    }

    private int sid;
    private String name;
    private Double price;

}
```

### hibernate核心配置文件 hibernate.cfg.xml

```xml
<?xml version='1.0' encoding='utf-8'?>
<!DOCTYPE hibernate-configuration PUBLIC
        "-//Hibernate/Hibernate Configuration DTD//EN"
        "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
    <session-factory>
        <!--mysql账户名-->
        <property name="connection.username">root</property>
        <!--mysql密码-->
        <property name="connection.password">xiaojiebin</property>
        <!--mysql驱动-->
        <property name="connection.driver_class">com.mysql.jdbc.Driver</property>
        <!--mysql连接URL-->
        <property name="connection.url">jdbc:mysql://47.107.158.197:3306/hibernate</property>
        <!--数据库方言-->
        <property name="dialect">org.hibernate.dialect.MySQL8Dialect</property>
        <!--显示SQL语句-->
        <property name="show_sql">true</property>
        <!--格式化sql语句-->
        <property name="format_sql">true</property>
        <!--根据需要创建数据-->
        <property name="hbm2ddl.auto">update</property>

        <mapping resource="entity/GoodsEntity.hbm.xml"></mapping>
    </session-factory>
</hibernate-configuration>
```

### 实体类映射文件

```xml
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="com.xiao">
    <class name="GoodsEntity" table="GoodsEntity">
        <id name="sid">
            <generator class="native"></generator>
        </id>
        <property name="name" column="name"></property>
        <property name="price" column="price"></property>
    </class>
</hibernate-mapping>
```

### 测试类

```java
import com.xiao.GoodsEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class TestGoods {
    private SessionFactory sessionFactory;
    private Session session;
    private Transaction transaction;


    /**
     * 执行test之前执行的代码
     */
    @Before
    public void init(){
        Configuration configuration=new Configuration().configure();//创建配置对象
        sessionFactory=configuration.buildSessionFactory();//创建session工厂
        session=sessionFactory.openSession();//获得session对象
        transaction = session.beginTransaction();//打开事务管理
    }
    /**
     * 执行After之后的的代码
     */
    @After
    public void destory(){
        transaction.commit();//事务提交
        session.close();//关闭会话
        sessionFactory.close();//关闭会话工厂
    }
    @Test
    public void testGoods(){
        //生成对象
        GoodsEntity goodsEntity=new GoodsEntity("女朋友",2333333.3);
        //保存对象数据库
        session.save(goodsEntity);
    }
}
```



## hibernate表关系

## 一对多

### 单向关系

​	实体类

```java
package com.xiao;

import lombok.Data;

@Data
public class Classess {

    public Classess(String name) {
        this.name = name;
    }

    private String id;
    private String name;

    public Classess() {
    }
}
```

```java
import lombok.Data;

@Data
public class Student {
    private String id;
    private String sname;

    public Student(String sname) {
        this.sname = sname;
    }

    private Classess classess;

    public Student() {
    }
}
```

​		映射文件

```xml
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="com.xiao">
    <class name="Classess" table="Classess">
        <id name="id" column="cid">
            <generator class="uuid"></generator>
        </id>
        <property name="name" column="name"></property>
    </class>
</hibernate-mapping>
```

```xml
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="com.xiao">
    <class name="Student" table="Student">
        <id name="id">
            <generator class="uuid"></generator>
        </id>

        <property name="sname" column="sname"></property>
        <!-- 
            映射多对一的关联关系。 使用 many-to-one 来映射多对一的关联关系 
            name: N端对应1端的属性名字
            class: 1端对应的类
            column: 一那一端在多的一端对应的数据表中的外键的名字
        -->
        <many-to-one name="classess" class="Classess" column="cid"/>
    </class>
</hibernate-mapping>
```

​		测试类

```java
import com.xiao.Classess;
import com.xiao.GoodsEntity;
import com.xiao.Student;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class TestGoods {
    private SessionFactory sessionFactory;
    private Session session;
    private Transaction transaction;

    /**
     * 执行test之前执行的代码
     */
    @Before
    public void init() {
        Configuration configuration = new Configuration().configure();//创建配置对象
        sessionFactory = configuration.buildSessionFactory();//创建session工厂
        session = sessionFactory.openSession();//获得session对象
        transaction = session.beginTransaction();//打开事务管理
    }

    /**
     * 执行After之后的的代码
     */
    @After
    public void destory() {
        transaction.commit();//事务提交
        session.close();//关闭会话
        sessionFactory.close();//关闭会话工厂
    }

    @Test
    public void testGoods() {
        //生成对象
        GoodsEntity goodsEntity = new GoodsEntity("男朋友", 5633333.3);
        //保存对象数据库
        session.save(goodsEntity);

        Classess classess = new Classess("软件一班");

        Student student1 = new Student("肖杰斌");
        Student student2 = new Student("鹿丽娟");

        student1.setClassess(classess);
        student2.setClassess(classess);

        session.save(classess);
        session.save(student1);
        session.save(student2);
    }
}
```



### 双向关系

​		实体类

```java
package com.xiao;

import lombok.Data;

import java.util.HashSet;
import java.util.Set;

@Data
public class Classess {
    public Classess() {
    }

    public Classess(String name) {
        this.name = name;
    }

    private String id;
    private String name;
    /*
     * 1. 声明集合类型时, 需使用接口类型, 因为 hibernate 在获取
     * 集合类型时, 返回的是 Hibernate 内置的集合类型, 而不是 JavaSE 一个标准的集合实现.
     * 2. 需要把集合进行初始化, 可以防止发生空指针异常
     */
    private Set<Student> student=new HashSet<>();
}

```

```jav
package com.xiao;

import lombok.Data;

@Data
public class Student {
    private String id;
    private String sname;

    public Student(String sname) {
        this.sname = sname;
    }

    private Classess classess;

    public Student() {
    }
}

```

​		映射文件

```xml
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="com.xiao">
    <class name="Classess" table="Classess">
        <id name="id" column="cid">
            <generator class="uuid"></generator>
        </id>
        <property name="name" column="name"></property>
        <!-- 映射 1 对多的那个集合属性 -->
        <!-- set: 映射 set 类型的属性, name:一的这一端关联的多的那一端的属性名,
        table: set 中的元素对应的记录放在哪一个数据表中.
        该值需要和多对一的多的那个表的名字一致 -->
        <set name="student" table="Student">
            <!-- 指定关联的表中的外键列的名字 -->
            <key column="cid"></key>
            <!-- 指定映射类型 -->
            <one-to-many class="Student"></one-to-many>
        </set>
    </class>
</hibernate-mapping>
```

```xml
<?xml version="1.0"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="com.xiao">
    <class name="Student" table="Student">
        <id name="id">
            <generator class="uuid"></generator>
        </id>

        <property name="sname" column="sname"></property>
        <!-- 
            映射多对一的关联关系。 使用 many-to-one 来映射多对一的关联关系 
            name: N端对应1端的属性名字
            class: 1端对应的类
            column: 一那一端在多的一端对应的数据表中的外键的名字
        -->
        <many-to-one name="classess" class="Classess" column="cid"/>
    </class>
</hibernate-mapping>
```



## 一对多级联

### 级联的添加

​		配置

```xml
<set name="orders" table="ORDERS" cascade="save-update">
```

![image_1b352uke6ftd1kj45n93jejci4o.png-217.9kB](C:\Users\xiangxin\Desktop\课件\image_1b352uke6ftd1kj45n93jejci4o.png)

​		测试

```java
    @Test
    public void testOne() {
        Classess r1 = new Classess("软件一班");

        Student s1 = new Student("小李子");
        Student s2 = new Student("李瘦子");

        r1.getStu().add(s1);
        r1.getStu().add(s2);

        session.save(r1);
      
    }
```

### 级联删除

```xml
<set name="orders" table="ORDERS" cascade="save-update,delete">
```

```java
   @Test
    public void testTwo(){
        Classess classess = session.get(Classess.class, "402880ea6abfcf45016abfcf49ce0000");
        session.delete(classess);
    }
```

### 级联修改

```xml
<!-- inverse true放弃维护关系 flase维护关系-->
        <set name="stu" table="T_student" cascade="save-update,delete" inverse="true">
```

```java
    @Test
    public void update(){
        Student student = session.get(Student.class, "402880ea6abfdd92016abfdd97820001");
        Classess classess = session.get(Classess.class, "402880ea6abfdd92016abfdd97650000");
        student.setClassess(classess);
    }
```

