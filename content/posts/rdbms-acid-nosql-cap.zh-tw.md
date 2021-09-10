---
title: RDBMS 與 NoSQL 差異筆記
date: 2020-01-06 04:06:00 +0800
categories:
- Database
tags: [Database, NoSQL, RDBMS]
slug: rdbms-acid-nosql-cap
---
## RDBMS
**Relational Database Management System**
* 在資料之前有很強的 **Relation (關聯性)** 的時候使用:
  * 設計不太會去變動的 schema 將 table 互相關聯，  
  就可以去透過 SQL 取得想要的資料
* **資料的正確性**很重要的時候使用
  * 通常會提供**ACID**
* 要變動 schema 是一件很浩大的工程:
  * 要把的 table 的 schema 更新還要 migrate 資料
  * 所有用到要被更換 schema 的 table 的程式都要修改
<!--more-->
* **Vertical scaling** 效果比較明顯 (提升機器的性能)

### ACID
通常 RDBMS 會保證交易(transaction)有四種特性:
* **Atomicity**  
只有 **全部做完(Commit)** 跟 **全部沒做(Abort)** 兩種可能，  
沒有做了一半這種狀態  
如果執行中有 error 的話就是 Rollback 成全部沒做的狀態

* **Consistency**  
交易前後 database 都會保持合法的狀態。  

* **Isolation**  
多筆 transaction 都要執行時每筆 transaction 都是分開的不會互相干擾。  
A 和 B 做交易不影響 B 和 C 做交易。  

* **Durability**  
Transaction 做完了就是永久有效的不會失效，  
就算系統突然壞了也一樣。

## NoSQL
**Not only SQL**
* 比較不在意資料之間的 Relation
  * 存取資料時不需要固定的 schema
  * 每筆資料單獨存在沒有誰關聯誰的問題
* 比較在意資料的內容
  * 是否需要更新、新增、刪除等等
  * 資料可以有**不同的格式**
* 比較適合分散式系統
* 通常提供 **CAP** 其中兩種
* **Horizontal scaling** 效果比較明顯 (多找幾台機器)

### CAP
對一個分散式系統來說，  
CAP 三種特性不可能都能**保證**存在(但有可能同時存在，網路很順的時候)，  
頂多同時能保證存在兩種。  
  
* **Consistency**  
每次 read 如果不是得到 error 都會讀到**最近一次寫入的結果**。  
=> **每個 node 的 data 都是一樣的**

* **Availability**  
每個 request 都會得到一個不是 error 的 response，  
不管這個 response 回傳的資料是不是最新的。  
=> **怎麼樣都保證資料會被回傳，不過資料可能是舊的**

* **Partition tolerance**  
就算有些在 node 之間傳送的訊息被 delay 或是掉了系統也會繼續運作。  
=> 網路有狀況的時候，**正常連線的那一部份 node 可以正常運行**。  

## Reference
[Wiki ACID](https://en.wikipedia.org/wiki/ACID)  
[Wiki CAP](https://en.wikipedia.org/wiki/CAP_theorem)


