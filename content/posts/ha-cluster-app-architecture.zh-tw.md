---
title: HA cluster 筆記和 Application 設計
date: 2020-01-09 19:40:00 +0800
categories:
- Web Hosting
tags: [Cluster, High availability, Architecture]
slug: ha-cluster-app-architecture
---
設計比較大流量的系統時早晚要遇上 cluster 的問題。  

## Cluster
一台以上的機器(node)組成的集合，  
有三種不同的目的:  

### Load Balancing
讓多台機器一起盡可能的平均分擔任務，  
加速應用程式執行。

### High Availability (HA)
為了高可用性和備援，  
如果其中一台機器突然掛了其他的機器可以接替。
<!-- more -->

### High Performance Computing
高效能/平行運算系統，  
簡稱 HPC cluster，  
結合多台機器的硬體來增加運算能力，  
用來解決單一一台機器不能解決的任務。

## HA 運作模式
有很多種例如 N+1, N+M, ...  
但最常見的是 two-node cluster，  
two-node cluster 有兩種運作方式:  
* Active-Passive
* Active-Acitve

### Active-Passive (AP)
Master-slave 的設計，  
正常狀況下只有 master (Active) 在做 service，  
當 master (Active) 出現問題時 slave (Passive) 才接手，  
等到 master (Active) 恢復正常狀態再換回來由 master (Active) 繼續處理 service  
  
優點:
* Fail-over 的速度快
* 設計跟設定都相對簡單
  
缺點:
* 沒辦法同時做 load balance 會浪費一些硬體

### Active-Active (AA)
兩台機器都同時有自己獨立執行的 service (都同時是 Active)，  
同時也互相備援 (當對方的 Passive)，  
當其中一台出現問題時另一台接手他的 service。  
  
優點:
* 正常運作的時候兩台機器都沒有閒置，  
運作效益高
  
缺點:
* Fail-over 之後機器的負擔變大，  
速度變慢
* 設計設定相對複雜

## Application Design
* 需要有相對簡單的方法來 start, stop, force-stop service 和檢查 service 目前的狀態。   
=> 設計 application 的時候要有 command line interface 或 script 能夠做到這點  
=> 兩台機器上的 service 要互相可以知道對方狀態跟發生意外的時候要能啟動 or 停止
* 需要有 shared storage，  
而且 Application 要能將自己的狀態盡量仔細的紀錄到 shared storage。  
=> 兩台機器切換的時候才不會少東西  
* 要能 restart 另一個 node 並恢復到 failure 發生前的狀態  
=> 恢復 failure 前的狀態可以用存到 shared storage 的狀態來做  
* 當 application crash 的時候不能毀損存到 shared storage 上的資料  
=> 另外一邊要用  

### Remark
* Application upgrade 時會發生的狀況要考慮進去
* 有些 SQL 或 noSQL 本身有支援這類的設定可以採用可以減少不少麻煩


