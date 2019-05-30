# Spring Data JPA

## 1.ORM思想

	### 使用JDBC操作

```text
1.操作繁琐
2.占位符赋值麻烦
```

```text
ORM思想：Object Relationship Model（对象关系模型）
	主要目的：操作实体类等同于操作数据库表。
	建立两个映射关系：
		1.实体类和表的映射关系
		2.实体类中属性和表中该字段的映射关系
	在ORM框架中不在关注SQL语句的实现，而是用通过调用方法。
	ORM框架有Mybatis，Hibernate等。
	注：Mybatis是半ORM映射框架，他需要手动创建表，CRUD操作是要自己写SQL语句，而Hibernate是全ORM映射框架，他只需要配置好文件，表会自动生成，CURD的SQL语句也是会自动生成。
```



## 2.HIBERNATE框架

```text
Hibernate是一个开源代码的对象关系映射框架，
他对JDBC进行了非常轻量级的对象封装，
他将POJO与数据库表建立映射关系，是一个全自动的ORM框架。
```



## 3.JPA规范



```text
1.JPA的全称是Java Persistence API,即Java持久化API，是SUN公司推出的一套基于ORM的规范，内部是由一系列的接口和抽象类构成。
2.JPA通过JDK5.0注解买书对象-关系表的映射关系，并将运行期的实体对象持久化到数据库中。
3.JPA和HIBERNATE的关系就像JDBC和JDBC驱动的关系，JPA是规范，Hibernate除了作为ORM框架之外，它也是一种JPA实现。使用JPA规范进行数据库操作，底层需要HIBERNATE作为其实现类完成数据持久化工作。
```



![img](assets/1331009-20180222125641033-1636968052.png)







![img](assets/1331009-20180222125651264-1858696834.png)

## 4.JPA的基本操作

```text
案例：是客户的相关操作(增删改查)
	客户：就是一家公司
	
```



### 1.搭建环境

#### 创建maven工程

pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>priv.xiao.springjpa</groupId>
    <artifactId>spring_data_jpa</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>

        <!-- junit -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
        </dependency>

        <!-- hibernate对jpa的支持包 -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-entitymanager</artifactId>
            <version>5.0.12.Final</version>
        </dependency>

        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>1.1.2</version>
        </dependency>

        <!-- log日志 -->
        <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
            <version>1.2.12</version>
        </dependency>

        <!-- Mysql and MariaDB -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.46</version>
        </dependency>
    </dependencies>

</project>
```

#### 配置jpa的核心配置文件

​	**`配置到类路径下的META-INF的文件夹下`**

​	**`命名：persistence.xml`**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="http://java.sun.com/xml/ns/persistence" version="2.0">
    <!-- 必须配置 persistence-unit节点
        持久化单元：
                name:持久化单元名称。
                transaction-type:事务管理方式
                    JTA:表示分布式事务管理
                    RESOURCE_LOCAL:本地事务管理
    -->
    <persistence-unit name="myJpa" transaction-type="RESOURCE_LOCAL">
        <!-- jpa的实现方式,此处为hibernate的实现 -->
        <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>
        <!-- 数据库配置信息 -->
        <properties>
            <!--数据库信息
            用户名，javax.persistence.jdbc.user
            密码，javax.persistence.jdbc.password
            驱动，javax.persistence.jdbc.driver
            数据库地址,javax.persistence.jdbc.url
            -->
            <property name="javax.persistence.jdbc.user" value="root"/>
            <property name="javax.persistence.jdbc.password" value="123456"/>
            <property name="javax.persistence.jdbc.driver" value="com.mysql.jdbc.Driver"/>
            <property name="javax.persistence.jdbc.url" value="jdbc:mysql:///jpa"/>

            <!-- 可选配置:配置jpa实现方式的配置信息-->
            <!-- 显示SQL:[false|true]
                 自动创建数据库表:hibernate.hbm2ddl.auto
                    create : 程序运行时创阿金数据库表(如果游标，先删除表在创建)
                    update : 程勋运行时创建表(如果游标，不会创建表)
                    none   : 不会创建表
            -->

            <property name="hibernate.show_sql" value="true"/>
            <property name="hibernate.hbm2ddl.auto" value="update"/>
        </properties>
    </persistence-unit>
</persistence>

```

#### 编写客户的实体类

配置实体类和表，类中属性和表中字段的映射关系

```java
package priv.xiao.domian;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

/**
 * 客户实体类
 * 配置映射关系
 * 1.实体类和标的映射关系
 *
 * @Entity:声明实体类
 * @Table:配置实体类和标的映射关系 name:配置数据库表的名称
 * 2.实体类中属性和表中该字段的映射关系
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "cst_customer")
public class Customer {
    /**
     * 客户ID
     *
     * @id:声明主键的配置
     * @GeneratedValue:配置主键的生成策略
     *      GenerationType.IDENTITY : 自增
     *           * 底层数据库必须支持自动增长(底层数据库支持的自动增长方式，对ID自增)
     *      GenerationType.SEQUENCE : 序列,Oracle
     *           * 底层数据库必须支持序列
     *      GenerationType.TABLE :JPA提供的一种机制，通过一张数据库标的形式帮助我们完成主键自增
     *      GenerationType.AUTO : 由程序自动的帮助我们选择住家生成策略
     *
     * @Column:配置数据属性和字段的的映射关系 name:数据库表中字段的名称
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "cust_id")
    private Long custId;

    //客户姓名
    @Column(name = "cust_name")
    private String custName;

    //客户来源
    @Column(name = "cust_source")
    private String custSource;

    //客户级别
    @Column(name = "cust_level")
    private String custLevel;

    //客户所属行业
    @Column(name = "cust_industry")
    private String custIndustry;

    //客户的联系方式
    @Column(name = "cust_phone")
    private String custPhone;

    //客户地址
    @Column(name = "cust_address")
    private String custAddress;
}

```

#### JPA操作步骤

```text
1. 加载配置文件创建实体管理器工厂
	Persistence：静态方法(根据持久化单元名称创建实体管理器工厂)
		createEntityMnagerFactory("持久化单元名称")
		作用:创建实体管理器工厂
2. 根据实体管理器工厂，创建实体管理器
	EntityManagerFactory:获取EntityManager对象
	方法：createEntityManager
		 * 内部维护数据库信息
		   维护了缓存信息
		   维护了所有的实体管理器对象
		   在创建EntityManagerFactory的过程中会根据配置创建数据库表
		 * EntityManagerFactory的创建过程比较浪费资源
		 	特点:线程安全
		 		多个线程访问同一个entityManagerFactory不会有线程安全问题
		 * 创建一个公共EntityManagerFactory来解决资源浪费问题。
3. 创建事务对象，开启事务
	EntityManager对象：实体类管理器
		beginTransaction:创建实物对象
		presist:保存
		merge：更新
		remove：删除
		find/getRefrence:根据ID查询
	Transaction对象：根据ID查询
		begin：开启事务
		commit:提交事务
		rollback：回滚事务
4. 增删改查操作
5. 提交事务
6. 释放资源
```



### 2.完成基本CRUD案例

```java
package priv.xiao.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import priv.xiao.domian.Customer;
import priv.xiao.utils.JpaUtils;

import javax.persistence.EntityManager;

public class JpaTest2 {

    private EntityManager em;


    /**
     * 添加
     */
    @Test
    public void testAdd(){
        Customer customer = new Customer();
        customer.setCustName("王八蛋");
        customer.setCustSource("网络");
        customer.setCustIndustry("IT行业");
        customer.setCustLevel("一级");
        customer.setCustAddress("湖南长沙");
        customer.setCustPhone("123456789");
        em.persist(customer);
    }
    /**
     * 根据Id查询
     *  使用find方法查询
     *      1.查询的对象就是当前客户对象。
     *      2.在调用find方法的时候，就会发送SQL语句查询数据库
     *
     *  立即加载
     *
     */
    @Test
    public void testFind() {
        Customer customer = em.find(Customer.class, 1L);
        System.out.println(customer);
    }
    /**
     * 根据Id查询
     *  使用getReference方法查询
     *      1.查询的对象就是动态代理对象
     *      2.调用getReference不会立即发送SQL查询数据库
     *          * 当调用查询结果的实收才会发送SQL语句
     *
     *
     * 延迟加载(也称为懒加载) 推荐使用
     *      * 得到动态代理对象
     *      * 使用该对象,才进行查询
     */
    @Test
    public void testReference() {
        Customer customer = em.getReference(Customer.class, 1L);
        System.out.println(customer);
    }

    /**
     * 删除
     */
    @Test
    public void testRemove(){
        //根据ID查询客户
        Customer reference = em.getReference(Customer.class, 1L);
        //调用remove方法进行删除。
        em.remove(reference);
    }

    /**
     * 更新
     */
    @Test
    public void testupdate(){
        Customer reference = em.getReference(Customer.class, 2L);
        reference.setCustPhone("987654321");
        em.merge(reference);
    }

    @Before
    public void init() {
        //获取实体管理器
        em = JpaUtils.getEm();
        //开启事务
        JpaUtils.getEt().begin();
    }

    @After
    public void destroy() {
        em.close();
        JpaUtils.getEt().commit();
    }
}

```

## JPQL进行操作

``` java
package priv.xiao.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import priv.xiao.domian.Customer;
import priv.xiao.utils.JpaUtils;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.util.List;

public class JpqlTest {

    private EntityManager em;

    /**
     * 查询全部
     * jqpl: from Customer
     * SQL: select * from cst_customer
     */
    @Test
    public void testFindAll() {
        String jpql = "from Customer";
        Query query = em.createQuery(jpql);
        List<Customer> resultList = query.getResultList();
        for (Customer c : resultList
        ) {
            System.out.println(c);
        }
    }

    /**
     * 排序查询，倒叙查询全部客户(根据ID）
     * SQL:select * from cst_customer order by cust_id desc;
     * jpql: from Customer order by custId desc;
     */
    @Test
    public void testOrders() {
        String jpql = "from Customer order by custId desc ";
        Query query = em.createQuery(jpql);
        List<Customer> resultList = query.getResultList();
        for (Customer c : resultList
        ) {
            System.out.println(c);
        }
    }

    /**
     * 统计客户总数
     * SQL:select count(cust_id) from sct_customer
     * jpql:select count(custId) from Customer
     */
    @Test
    public void testCount() {
        String jpql = "select count(custId) from Customer";
        Query query = em.createQuery(jpql);
        Long singleResult = (Long) query.getSingleResult();
        System.out.println(singleResult);
    }

    /**
     * 分页查询
     * sql:select * from cst_customer limit ?,?;
     * jpql:from Customer
     */
    @Test
    public void testPaged() {
        String jpql = "from Customer";
        Query query = em.createQuery(jpql);
        //对参数复制  --分页参数
        //起始索引
        query.setFirstResult(2);
        //每页查询的条数
        query.setMaxResults(2);
        //发送查询
        List<Customer> resultList = query.getResultList();
        for (Customer c : resultList
        ) {
            System.out.println(c);
        }
    }

    /**
     * 条件查询
     * SQL:select * from cst_customer where cst_name=?
     * jpql:from Customer where custName like ?1
     */
    @Test
    public void testondition() {
        //第一种方式:
        //        String jpql = "from Customer where custName like :custName";
        //        query.setParameter("custName","%你%");
        //第二种方式
        String jpql = "from Customer where custName like ?1";
        Query query = em.createQuery(jpql);
        //索引从1开始
        query.setParameter(1, "%你%");
        List<Customer> resultList = query.getResultList();
        for (Customer c : resultList
        ) {
            System.out.println(c);
        }
    }

    @Before
    public void init() {
        //获取实体管理器
        em = JpaUtils.getEm();
        //开启事务
        JpaUtils.getEt().begin();
    }

    @After
    public void destroy() {
        //提交事务
        JpaUtils.getEt().commit();
        //释放资源
        em.close();

    }
}

```

