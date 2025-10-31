---
title: Common DNS Resource Records
date: 2020-01-08 20:40:00 +0800
categories:
- Web Hosting
tags: [DNS]
slug: common-dns-resource-record
---
Each DNS zone in a DNS server has a zone file.  
A DNS zone is usually a single domain (though not always).  
A zone file is composed of many DNS resource records (RRs).  
There are many different types of RRs.  
Let's record some common ones.  

## A record
Maps a hostname to an IPv4 address. (32-bit)
```
hostname IN A xxx.xxx.xxx.xxx
```
<!--more-->
## AAAA record
Maps a hostname to an IPv6 address. (128-bit)
```
hostname IN AAAA xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx
```

## CNAME record
An alias for a hostname.
```
alias IN CNAME hostname
```
Note that an alias cannot have other A records or MX records.

## MX record
Mail exchanger record.  
The email server's domain name, priority, and hostname.  
Note that it **must be a hostname, not directly an IP address**,  
and it cannot be a CNAME alias.  
Therefore, an additional RR (A or AAAA record) must be set up for the IP.  
A lower priority number indicates higher priority (mail is delivered to higher priority servers first).  
```
mail_domain_name IN MX priority hostname
```
Example:
```
example.com. IN MX 10 mailserver.example.com
```
