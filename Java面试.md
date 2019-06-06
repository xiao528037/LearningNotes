# Java基础

## 1.JDK和JRE有什么区别

```txt
1. JRE是Java Runtime Environment的缩写，Java运行时环境，包含了java虚拟机，java基础类库。如果只需要运行java编写的程序，只需要安装JRE即可。
2.JDK是Java Development Kit的缩写，顾名思义是Java开发工具包，是程序员使用Java编写java程序所需的开发工具包，是提供给程序员使用的。JDK包好了JRE，同事包含了编译java源码的编译器javac。
```
## 2.== 和equals的区别

```txt
== 解读
对于基本类型和引用类型 == 的作用效果是不同的。
	1.基本类型：比较值是否相等
	2.引用类型：比较的是引用是否相同
equals 解读
	equals本质上就是 == ,只不过String和Integer等重写了equals方法，把她变成了值比较
总结：==对于基本类型来说是值比较，对于引用类型来说是比较的引用；而equals默认情况下是引用比较，只是很多类重写了equals方法，比如String、Integer等把它变成了之比较，所以一般情况下equals比较的事值是否相等。
```

## 3.两个对象的HashCode()相同，则equals()为true吗？

```txt
两个对象的HashCode相同，equals方法不一定为true
因为在散列表中，hashCode()相等即两个键值对的哈希值相等，然而哈希值相等，并不一定能得出键值对相等。
```



## 4.final在Java中有什么作用？

```txt
1.final修饰的类叫最终类，该类不能被继承
2.final修饰的方法不能被重写。
3.final修饰的变量叫常量，常量必须初始化，初始化之后值就不能被修改。
4.可通过反射来进行修改，代码如下：
```

```java
import java.lang.reflect.Field;

public class FinalTest {
    private final String test="hello world";
    @Test
    public void test() throws NoSuchFieldException, IllegalAccessException {
        FinalTest finalTest = new FinalTest();
        Field test = finalTest.getClass().getDeclaredField("test");
        test.setAccessible(true);
        test.set(finalTest,"你好世界");
        System.out.println(test.get(finalTest));
    }
}
```



## 5.Java中的Math.round(-1.5)等于多少？

```txt
等于-1，向上取整，规则是四舍五入。
```

## 6.String数据基础的数据类型吗？

```text
String 不属于基础类型，基础类型有8中：
byte shot char int float long double boolean 而String属于引用类型，并且boolean不能进行类型转换。
```

## 7.Java中操作字符串都有哪些类？他们之间有什么区别？

```txt
操作字符串的类有：String、StringBuffer、StringBuilder
String和StringBuffer、StringBuilder的区别在于String声明的事不可变的对象，每次操作都会生成新的String对象，然后然后将指针指向新的String对象，而StringBuffer、StringBuilder可以在原有对象的基础上进行操作，所以在经常改变字符串内容的情况下最好不要使用String。
StringBuffer和StringBuilder最大的区别在于，StringBuffer是线线程安全的，而StringBuilder是非线程安全的，但StringBuilder的性能却高于StringBuffer，所以在单线程的环境下推荐使用StringBuilder，多线程环境下腿甲使用StringBuffer。
```

## 8.String =“i"和new String（”i")一样吗？

```txt
不一样，因为内存的分配中方式不一样，String = "i",Java虚拟机会将其分配到常量池当中，而new String("i")怎会呸分到对内存中，但堆内存中的引用还是指向常量池当中的i。
```

## 9.控制字符串反转

```txt
使用StringBuilder或者StringBuffer的reverse()方法。
代码如下：
```

```java
// StringBuffer reverse
StringBuffer stringBuffer = new StringBuffer();
stringBuffer. append("abcdefg");
System. out. println(stringBuffer. reverse()); // gfedcba
// StringBuilder reverse
StringBuilder stringBuilder = new StringBuilder();
stringBuilder. append("abcdefg");
System. out. println(stringBuilder. reverse()); // gfedcba
```

## 10.String类的常用方法都有哪些？

```txt
1.indexof():返回指定字符的索引
2.charAt():返回指定所引出的字符
3.replace()：字符串替换
4.trim():去除字符串两端空白
5.spilt():分割字符串，返回一个分割后的字符串数组。
6.getBytes():返回字符串的byte类型数组
7.length()：返回字符串长度
8.toLowerCase()：将字符串转成小写字母
9.toUpperCase()：将字符串转成大写字母
10.subString():截取字符串
11.equals():字符串比较
```

## 11.抽象类必须要有抽象方法吗？

```txt
不需要，抽象类不一定非要有抽象方法。
```

## 12.普通类和抽象类有哪些区区别

```txt
1.普通类不能包含抽象方法，抽象类可以包含。
2.抽象类不能直接被实例化，普通类可以实例化。
```

## 13.抽象类可以被final修饰吗？

```txt
不能，定义抽象类就是用来被继承的，而final修饰的类是最终类，不能被继承。
```

## 14.接口和抽象类有什么区别

~~~txt
1.实现：抽象类的子类使用extends来继承;接口必须使用implements来实现接口。
2.构造函数：抽象类可以有构造函数；接口不能有
3.实现数量：类可以实现多个接口，但是只能继承一个抽象类
4.访问修饰符：接口中的方法默认使用public修饰；抽象类中的方法可以是任意访问修饰符。
~~~

## 15.Java中IO流分为几种？

```word
按流向分为：
	* 输入流
	* 输出流
按数据单位分：
	* 字节流：InputStream OutputStream
	* 字符流：Reader Writer
 注：字节流和字符流的用法类似，区别在于字节流的数据单元8位，字符流数据单位为16位。
 按功能分：
 	* 节点流：程序用于直接操作目标设备对所应的类叫做节点流
 	* 处理流：程序通过一个间接流类去调用节点流类，已达到更加灵活方便的读写各种类型数据，这个间接流类就是处理流。
```

