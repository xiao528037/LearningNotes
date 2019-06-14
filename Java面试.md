[TOC]

# Java基础

## 1.JDK和JRE有什么区别

```txt
1. JRE是Java Runtime Environment的缩写，Java运行时环境，包含了java虚拟机，java基础类库。如果只需要运行java编写的程序，只需要安装JRE即可。
2.JDK是Java Development Kit的缩写，顾名思义是Java开发工具包，是程序员使用Java编写java程序所需的开发工具包，是提供给程序员使用的。JDK包好了JRE，同时包含了编译java源码的编译器javac。
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
String和StringBuffer、StringBuilder的区别在于String声明的事不可变的对象，每次操作都会生成新的String对象，然后将指针指向新的String对象，而StringBuffer、StringBuilder可以在原有对象的基础上进行操作，所以在经常改变字符串内容的情况下最好不要使用String。
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

## 16.BIO/NIO/AIO有什么区别

```txt
- BIO：Block IO同步阻塞IO，就是我们平常使用的传统IO，他的特点是模式简答使用方便，并发处理能力低。
- NIO：Non IO同步非阻塞IO，是传统IOde设计，客户端和服务端通过Channel(通道)通讯，实现了多路复用
- AIO：Asynchronous IO是NIO的升级，也叫NIO2，实现了异步非堵塞IO，异步IO的操作基本事件和回调机制。
```

## 17.Files的常用方法

```txt
Files.exists():检测文件路径是否存在
Files.createFile():创建文件
Files.createDirectory():创建文件夹
Files.delete():删除一个文件或目录
Files.copy():复制文件
Files.move():移动文件
Files.size():查看文件个数
Files.read():读取文件
Files.write():写入文件
```

## 18.Java容器都有哪些

### 1.Collection和Map

* Collection：接口的接口

  * List接口：元素按进入先后有序保存，可重复
    * ArrayList：线性动态数据组，查询效率高。
    * LinkedList：双向链表。
    * Vector：线性动态数据组，查询效率高。线程安全
      * Stack：实现类

  * Set接口：仅接收一次，不可重复，并做内部排序
    * HashSet
      * LinkedHashSet
    * TreeSet

* Map接口：键值对的集合（双列集合）

  * HashMap：与HashTable一样，但线程不安全。
    * LinkedHashMap：有序的Map集合，相当于栈，先进后出。双向链表和哈希表实现
    * WeakHashMap

  * TreeMap：基于红黑树（red-black tree)数据结构实现，按key排序，默认的排序方式是升序。
  * ConcurrentHashMap
  * HashTable：内存存储的键值对是无需的事按照哈希算法进行排序，线程安全的，并且键和值不能为null，否则会抛空指针异常。

![img](assets\Collection)

### 2.List详解

1. ArrayList:底层是数组，查询快，增删慢，线程不安全，效率高，可以存储重复数据
2. LinkedList：底层实现是链表，查询慢，增删块，想成不安全，效率高，可以存储重复元素
3. Vector：底层是数据，查询快，增删慢，线程安全，效率低，可以存储重复元素。

![这里写图片描述](assets\70)

### 3.Set详解

1. HashSet：底层实现采用哈希表实现，元素且为一，线程不安全，效率高，可以存储null元素，元素的为一性是靠所存储元素类型是否重写hashCode()和equals()方法来保证，如果没有重写，则无法保证元素的唯一性。
2. Linkedhashset：底层采用链表和哈希表共同实现，链表保证了元素的顺序与存储顺序一致，哈希表保证了元素的唯一性。线程不安全，效率高。
3. TreeSet底层使用二叉树来实现，元素唯一且排好序，唯一性同样需要重写hashCode和equals方法，二叉树结构保证了元素的有序性。

## 19.Collection和Collections有什么区别

```txt
1.Collection是一个集合接口，他提供了对集合对象进行基本操作的通用接口方法，所有集合都是它的子类，比如List、Set等。
2.Collections是一个包装类，包含了很多静态方法，不能别实例化，就像一个工具类，比如提供的排序方法：collections.sort(list).
```

## 20.List、Set、Map之间的区别是什么？

```txt
List和Set多实现了Conllection父接口，List是可重复的集合，Set不可重复集合。
Map是一个独立的接口，没有实现Collection,Map是一种把键对象和值对象进行映射的集合，他的每一个元素包含了键值对，Map中存储的数据是没有顺序的，其key是不可重复的，他的值是可重复的
```

![](assets\Lista1Set1Map.png)

## 21.HashMap和Hashtable区别

* 存储：HashMap运行key和value为null，而Hashtable不允许。
* 线程安全：Hashtable是线程安全的，而HashMap是非线程安全的。
* 推荐使用：Hastable是保留类不建议使用，单线程环境下使用HashMap替代，如果需要多线程使用ConcurrentHashMap替代。

![这里写图片描述](assets\72)

## 22.如何决定那个集合

对于Map中插入、删除、定位一个元素这类操作，选择HashMap是最好的选择。

| Map     | 使用情况   | 原因                                  |
| ------- | ---------- | ------------------------------------- |
| Hashmap | 查询       | 基于散列表实现（推荐作为常规Map使用） |
| Treemap | 增加、删除 | 基于红黑树实现                        |

![这里写图片描述](assets\71)

## 23.HashMap的实现原理

```txt
HashMap基于Hash算法实现的，我们通过put(key,value)存储，get(key)来获取u，当传入key是，HashMap会更具key.hashCode()计算出来hash值，更具hash值将value保存在bucket里面，当计算出的hash值相同时，我们称之为hash冲突，HashMap的做法使用链表和红黑树存储相同hash值的value，当hash冲突的个数比较少是，使用链表否则使用红黑树。
```

## 24.HashSet的实现原理

```txt
HashSet是基于HashMap实现的，HashSet底层使用HashMap来保存所有元素，因此Hashset
的实现比较简单，相关HashSet的操作，基本都是直接调用底层hashMap的相关方法，HashSet不允许重复的值。
```

## 25.ArrayList和LinkedList的区别

```txt
1. 数据结构实现：ArrayList是动态数组，而LinkedList是双向链表。
2. 随机访问效率：ArrayList比LinkedList在随机访问的时候效率要高，因为可以通过索引进行查询，LinkedList是链表存储方式，需要移动指针进行查询
3. 增加和删除效率：在非首尾的增加和删除操作，LinkedList要比ArrayLIst效率高，因为ArrayList增删操作要影响数组内的其他数据的下标
```

## 26.如何实现数组和List之间的转换

```txt
1. 素组转List：使用Arrays.asList(array)进行转换。
2. List转数组：使用List自带的toArray（）方法。
```

## 27.ArrayList和Vector的区别

~~~txt
1.  线程安全：Vector使用了Synchronized来实现线程同步，是线程安全的，ArrayList是非线程安全的
2. 性能：ArrayList在性能方面要优于Vector
3. 扩容：ArrayList和Vector都会根据实际的需要动态的调整容量，只不过在Vector扩容每次回增加1倍，而ArrayList只会增加50%
~~~

## 28.数组和ArrayList区别

1. 数组可以存储基本数据类型和兑现个，ArrayList只能存储对象。
2. 数组是制定固定大小的，而ArrayList大小是自动扩展的
3. 数组内置方法没有ArrayList多。

## 29.在Queue中poll和remove区别

```txt
1. 相同点：都是返回第一个元素，并在队列中给删除返回的对象
2. 不同点：如果没有元素poll返回null，而remove会直接跑出NoSuchElementExeption异常
```

## 30.那些集合类是线程安全得

```txt
Vector、Hashtable、Stack都是线程安全的，而像HashMap则是非线程安全的，不过在1.5之后随着Java.util.concurrent并发包，多有相对应的安全类，比兔HashMap对应的线程安全类就是ConcurrentHashMap。
```

## 31.迭代器Iterator

```txt
Iterator接口提供便利任何Collection的接口。我们可以从一个Collection中使用迭代器方法来获取迭代器实例，迭代器取代了java集合框架中的Enumeration，迭代器允许调用者在迭代过程中一处元素。
```

## 32.Iterator特点

```txt
Itreator的特点是更加安全，因为他可以确保，在当便利的集合元素被更改的时候，就会抛出ConcurrentModificationException异常。
```

## 33.Iterator和ListIterator有什么区别

```txt
1. Iterator可以便利Set和List集合，而ListIterator只能遍历List。
2. Iterator只能单向遍历，而ListIterator可以双向遍历（向前/向后）
3. ListIterator从Iterator接口继承，然后添加了一些额外的工鞥呢，比如添加一个元素、替换一个元素、获取前面或后面元素的索引位置。
```

## 34.怎么确保一个集合不能被修改？

```txt
可以使用Collections.unmodifiableCollection(Collection c)方法创建一个只读集合，这样改变集合的任何操作都会抛出Java.lang.UnsupportedOperationException异常
```

## 35.并行和并发有什么区别

```txt
- 并行：多个处理器和多核处理器同事处理多个任务。
- 并发：多个任务在同一个cpu核上，按细分的时间片轮流执行，从逻辑上来看那些任务是同时执行。
```

## 36.线程和进程的区别

```txt
一个程序下至少有一个进程，一个进程下至少有一个线程，一个进程下也可以有多个线程来增加程序的执行速度。
```



