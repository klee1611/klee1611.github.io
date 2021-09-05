---
title: Deep Copy and Shallow Copy
date: 2020-01-21 01:19:00 +0800
categories:
- Programming
tags: [Programming]
slug: deep-copy-shallow-copy
---
### Shallow Copy
複製越少越好，  
Shallow copy 出來的新的 structure 擁有跟舊的 structure 相同的結構，  
並一起**共享 elements**。  
  
舉個 Java 的例子，
<!-- more -->
{% codeblock lang:java %}
int[] arr1 = {1, 2, 3};
int[] arr2 = arr1;
{% endcodeblock %}
``arr2`` 就是一個 ``arr1`` 的 shallow copy。

- 一旦其中一個 structure 更動了 element 另外一個也會受到影響。

### Deep Copy
全部複製，  
Deep copy 出來的 structure 不但有跟舊的 structure 相同的結構，  
還把**舊的 structure 的 elements 全部複製了一份給新的**。
  
{% codeblock lang:java %}
int[] arr1 = {1, 2, 3};
int[] arr2 = new int[arr1.length];

for (int i = 0; i < arr1.length; ++i) {
	arr2[i] = arr1[i];
}
{% endcodeblock %}
``arr2`` 是 ``arr1`` 的 deep copy。

- 占用的記憶體空間比較多。
