---
title: 常用 DNS Resource Record 紀錄
date: 2020-01-08 20:40:00 +0800
categories:
- Web Hosting
tags: [DNS]
slug: common-dns-resource-record
---
DNS server 中每個 DNS zone 都有一個 zone file，  
DNS zone 通常會是一個 single domain (有時候不是)，  
zone file 是由很多個 dns resource record (RR) 組成，  
RR 有很多種不同的類型，  
紀錄一下常用幾種。  

## A record
將 hostname 對應到 IPv4。 (32-bit)
```
hostname IN A xxx.xxx.xxx.xxx
```
<!--more-->
## AAAA record
將 hostname 對應到 IPv6。 (128-bit)
```
hostname IN AAAA xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx
```

## CNAME record
為 hostname 設立的別名。  
```
alias IN CNAME hostname
```
注意 alias 不能再有其他 A record 或 MX record。  

## MX record
Mail exchanger record。  
Email server 的 domain name, priority 和 hostname。  
注意**是 hostname 而不是直接是 IP**，  
也不能是 cname 的 alias，  
所以 IP 還要另外多設一個 RR。(A 或 AAAA record)  
Priority 數字越低代表優先權越高 (先傳送到優先權高的)。  
```
mail_domain_name IN MX priority hostname
```
例子，
```
example.com. IN MX 10 mailserver.example.com
```

