# Thymeleaf

##  变量表达式

```html
语法：${...}
<span th:text="${book.author.name}"/>//从域中book.author.name属性，
```



## 消息表达式

```html
#{...}
<th th:text="#{header.address.city}">...</th>
//获取值，赋给text属性
//也称为文本外部化，国际化或i18n
```

## 选择表达式

```html
*{...}
<div th:object="${book}">
    <span th:text="*{title}">...</span>
</div>
//与变量表达式区别：他们是在当前选择的对象，而不是整个上下文变量映射上执行。
```

## 分段表达式

```html
语法：th:insert 或者 th:replace


```

### 字面量

```html
文本
<span th:text"'此处表示为文本'"></span>
数字
<span th:text="2013"></span>
<span th:text="2013 + 6"></span>//进行运算
布尔
<div th:if="${user.isAdmin()} == false">
    ...
</div>
null
<div th:if="${user.isAdmin()} == null">
    ...
</div>
```

### 比较

```html
>、<、>=、<=<(gt、lt、ge、le)
==、!=（eq、ne）

条件运算符
    三元运算符
<tr th:class="${row.even} ? 'even' : 'old'></tr>
     无操作
              <tr th:class="${row.even} ? _"></tr>
```

## 设置属性值

`th:attr`

## 迭代器

<li th:each="book" : ${books}">

## 条件语句

```html
th:if
th:unless
```

