---
title: "Joplin With Webdav on Synology 918plus"
date: 2022-01-09T19:27:21+08:00
lastmod: 2022-01-09T19:27:21+08:00
categories:
- Tools
tags: [Tools]
slug: joplin-with-webdav-on-synology-ds918plus
---
原本使用的筆記軟體是 Notion，  
功能相當強大；  
但後來看到了一些隱私權爭議，  
決定尋找有沒有替代的方案，  
方便我儲存私人專案或清單之類的個人筆記；  
然後就找到了[Joplin](https://joplinapp.org/) 這套開源軟體。  
<!--more-->
  
軟體的功能對我來說足夠齊全，  
有桌面版也有手機版，  
可以用 markdown 寫出數學算式、表格和流程圖等等，  
也有 web clipper 可以擷取網頁放進筆記裡。  
  
而另一項特點就是可以自己決定筆記內容的存放位置，  
可以只放在電腦內也可以同步到自己的 dropbox 等雲端，  
甚至可以用自己架設的 webDAV 存放，  
而我剛好也有 NAS 可以架設 webDAV 來使用。  
  
### 設備
* Router: Synology RT2600AC
* NAS: Synology 918+
  
### 環境建立
在電腦上先裝了 Joplin 之後，  
我在 NAS 裝了 WebDAV Server，  
基於安全性考量在 WebDAV 的設定關閉了 HTTP 連線，  
只開了 HTTPS 的存取權限  
（雖然不是很確定，  
不過手機的 Joplin 如果要連線似乎因為安全性限制也只能用 HTTPS），  
然後去 router 的網路設定把對應的 Port forwarding 設定好，  

![port_forwarding](/images/joplin_webdav_on_nas/port_forwarding.png)

router 的 DDNS 之前就有設定過了所以可以透過網址連線到 router；  
接著我在電腦版的 Joplin 的連線設定選了 webDAV，  
把網址跟 port 號還有要儲存筆記的資料夾放在 webDAV 的網址列  
（如： `https://.....:5xxx/homes/xxx/xxx/xxx`），  
點了測試連線發現 certificate 出現問題，  
google 了一陣子之後發現是因為連線時網址的 domain name 是對應到 router，  
router 再把連線導到 NAS，  
但在 NAS 上卻沒有找到該 domain name 的 certificate，  
導致了 Joplin 連線的時候 certificate 跟網址不 match，  
（可以用 https://www.geocerts.com/ssl-checker 檢查）；  
於是我從 router 把 certificate export 出來以後放到 NAS 上，  
然後在 NAS 上找到設定 certificate 的地方，  
把 WebDAV 的 certificate 換成從 router import 進來的，  

![choose_cert](/images/joplin_webdav_on_nas/choose_cert.png)

然後去 https://www.geocerts.com/ssl-checker 測試，  
這次確認了 HTTPS 連線到的 port 的 certificate 是正確的，  
再去 Joplin 的連線設定測試一遍確認連線成功後就可以順利同步了。  
