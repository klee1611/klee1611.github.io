---
title: "Sync Obsidian / Joplin Data Across Multiple Device with Synology WebDAV"
date: 2024-12-25 20:40:00 +0800
lastmod: 2025-10-23 07:03:00 +0800
categories:
- Tools
tags: [WebDAV, Synology, Obsidian, Joplin]
slug: sync-obsidian-joplin-data-across-multiple-device-synology-webdav
aliases:
- /zh-tw/posts/joplin-with-webdav-on-synology-ds918plus.html
toc: true
find_last_modify_date: true
---

原先我使用的筆記軟體是 Notion，  
功能豐富且介面美觀，  
但幾年前 Notion 出現了隱私權爭議，  
被指控偷看某公司放在 Notion 的內容，  
甚至進一步提出合作；  
就改用了一陣子 [Joplin](https://joplinapp.org/)，  
但最後還是轉到了擁有大量外掛及社群支援，  
而且可以高度客製化的 [Obsidian](https://obsidian.md/)。  
<!--more-->

Joplin 原先就支援 WebDAV 同步，  
轉到 Obsidian 後我找到了 Remotely save 這個也支援 WebDAV 的 plugin，  
方便我將筆記儲存在自己的 NAS 上，  
同時可以在不同裝置之間保持同步。  

## WebDAV 和 HTTPS Certificate 設定 - 穿透 Router 連線內網 NAS 上的 WebDAV server

### 設備
* Router: Synology RT2600AC
* NAS: Synology 918+
  
### 環境建立
Synology NAS 上安裝 WebDAV Server 套件後，  
基於安全性考量在 WebDAV 的設定關閉 HTTP 連線，  
只開啟 HTTPS 存取權限  
（雖然不是很確定，  
不過手機版的 Joplin 似乎因為安全性限制也只能用 HTTPS），  
然後在 router 上的網路設定將對應的 Port forwarding 做設定如圖，  

![port_forwarding](/images/joplin_webdav_on_nas/port_forwarding.png)

由於之前也經設定過 router 的 DDNS，  
所以原先就可以透過網址連線到 router；  
於是我就直接進行了 WebDAV 的連線測試，   
我在 Joplin 的連線設定選了 WebDAV，  
把網址跟 port 號還有要儲存筆記的資料夾放在 WebDAV 的網址列  
（如： `https://.....:5xxx/homes/xxx/xxx/xxx`），  
點了測試連線後就發現 certificate 出現問題，  
google 了一陣子之後發現是因為連線時網址的 domain name 是對應到 router，  
router 再把連線導到 NAS，  
但在 NAS 上卻沒有找到該 domain name 的 certificate，  
導致了 Joplin 連線的時候 certificate 跟網址對不上，  
（可以用 https://www.geocerts.com/ssl-checker 檢查）；  
於是我從 router 把 certificate export 出來以後放到 NAS 上，  
然後在 NAS 上找到設定 certificate 的地方，  
把 WebDAV 的 certificate 換成從 router import 進來的，  
設定如下圖，  

![choose_cert](/images/joplin_webdav_on_nas/choose_cert.png)

然後去 https://www.geocerts.com/ssl-checker 又做了一次測試，  
這次確認了 HTTPS 連線到的 port 的 certificate 是正確的，  
再回到 Joplin 的連線設定測試一遍確認連線成功後就可以順利同步了。  

## 補充資訊 - Notion 隱私權爭議
2020 年一篇在[Notion.Taiwan 台灣官方社群的貼文](https://www.facebook.com/groups/notion.so.taiwan/permalink/650523105498836/) 中有人提到，  
Notion 會偷看用戶資料甚至提出合作：

![notion_privacy_concern](/images/joplin_webdav_on_nas/notion_privacy_concern.png)

最後 [Notion 官方聲明](https://notiontaiwancommunity.notion.site/Notion-1c9a7142157147b484bc381c3e3b35d9) 移除了引發爭議的 Business Development and Strategic Partnerships 條款
