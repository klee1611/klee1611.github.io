---
title: C++ STL Containers 比較 - array, vector, deque, list, forward_list
date: 2020-01-12 20:40:00 +0800
categories:
- C++
tags: [Programming, C++, STL, container]
slug: c++-stl-container-compare-array-vector-dequeue-list-forward_list
---

## Array
**固定大小**的**連續記憶體空間**所構成

### 優缺點
* 不能像其他 C++ container 那樣動態改變儲存空間的大小
* **random access 很有效率** (O(1))

## Vector
**可以動態改變儲存空間大小**的 array

### 底層實作方式
* 動態的 allocate array，  
當目前的 capacity 不夠大的時候就重新 reallocate 一個新的 array 然後把舊的 element 搬過去
<!-- more -->
* 實際上的 capacity 會比目前塞進 vector 裡面的 element 數量大

### 優缺點
* **random access 很有效率** (O(1))
* 在**尾端**加入或刪除 element 相對有效率
* 在不是尾端的地方加入或刪除 element 比較慢

## Deque
Double-ended queue，  
一樣可以動態的改變 container 大小。  
不同的 library 實作 deque 的方式可能會不一樣。  

### 優缺點
* 可以當作是**在 container 的頭和尾做 insert 和 delete 都一樣很有效率**的 vector，  
但**不保證 elements 都被存在一塊連續記憶體空間**
  * Reallocate 的時候比 vector 有效率
* 在不是頭或尾端的地方加入或刪除 element 比較慢
* **random access 很有效率** (O(1))

## List
### 底層實作方式
**Doubly-linked list**

### 優缺點
* **在任何一個地方 insert, move 或 erase element 都很快 (O(1))**  
  * sorting 的時候用起來很方便
* 往前或往後 iterate 也很快
* **random access 慢 (O(n))**
* 占用額外的 memory space 來存 doubly-linked 的資訊

## Forward_list
### 底層實作方式
**Singly-linked list**

### 優缺點
* **在任何一個地方 insert, move 或 erase element 都很快 (O(1))**  
  * sorting 的時候用起來很方便
* 只能往後 iterate
* **random access 慢 (O(n))**
* 占用額外的 memory space 來存 singly-linked 的資訊
  * 儲存空間相對 list 來說較少
  * 只能往一個方向 iterate

## Reference
http://www.cplusplus.com/reference/array/array/  
http://www.cplusplus.com/reference/vector/vector/  
http://www.cplusplus.com/reference/deque/deque/  
http://www.cplusplus.com/reference/list/list/  
http://www.cplusplus.com/reference/forward_list/forward_list/

