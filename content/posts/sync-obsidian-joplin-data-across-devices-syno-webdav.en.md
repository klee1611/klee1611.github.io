---
title: "Sync Obsidian / Joplin Data Across Multiple Devices with Synology WebDAV"
date: 2024-12-25 20:40:00 +0800
lastmod: 2025-10-23 07:03:00 +0800
categories:
- Tools
tags: [WebDAV, Synology, Obsidian, Joplin]
slug: sync-obsidian-joplin-data-across-multiple-device-synology-webdav
aliases:
- /posts/joplin-with-webdav-on-synology-ds918plus.html
toc: true
find_last_modify_date: true
---

I originally used Notion as my note-taking software.  
It's feature-rich and has a beautiful interface.  
However, a few years ago, a privacy controversy arose around Notion,  
accusing them of looking at a company's content stored in Notion,  
and even proposing a partnership based on that information.  
So, I switched to [Joplin](https://joplinapp.org/) for a while,  
but eventually moved to [Obsidian](https://obsidian.md/), which has a large number of plugins, strong community support, and is highly customizable.  
<!--more-->

Joplin natively supports WebDAV synchronization.  
After switching to Obsidian, I found the "Remotely Save" plugin, which also supports WebDAV.  
This allows me to store my notes on my own NAS  
and keep them synchronized across different devices.  

## WebDAV and HTTPS Certificate Setup - Connecting to WebDAV Server on an Internal NAS Through a Router

### Equipment
* Router: Synology RT2600AC
* NAS: Synology 918+
  
### Environment Setup
After installing the WebDAV Server package on the Synology NAS,  
for security reasons, I disabled HTTP connections in the WebDAV settings  
and only enabled HTTPS access.  
(Although I'm not entirely sure, the mobile version of Joplin seems to be restricted to HTTPS for security reasons as well).  
Then, I configured port forwarding on my router as shown in the image below.  

![port_forwarding](/images/joplin_webdav_on_nas/port_forwarding.png)

Since I had already set up DDNS for the router,  
I could already connect to the router via a URL.  
So I went ahead and tested the WebDAV connection.   
In Joplin's connection settings, I selected WebDAV,  
and entered the URL, port number, and the folder to store the notes in the WebDAV URL field  
(e.g., `https://.....:5xxx/homes/xxx/xxx/xxx`).  
After clicking the test connection button, I found a certificate issue.  
After some googling, I discovered that this was because the domain name in the connection URL corresponded to the router,  
which then forwarded the connection to the NAS.  
However, the NAS did not have a certificate for that domain name,  
causing a mismatch between the certificate and the URL when Joplin tried to connect.  
(You can use https://www.geocerts.com/ssl-checker to check this).  
So, I exported the certificate from the router and imported it to the NAS.  
Then, in the NAS settings, I found the certificate configuration  
and changed the WebDAV certificate to the one imported from the router,  
as shown in the image below.  

![choose_cert](/images/joplin_webdav_on_nas/choose_cert.png)

Then I went to https://www.geocerts.com/ssl-checker and ran another test.  
This time, I confirmed that the certificate for the port connected via HTTPS was correct.  
I went back to Joplin's connection settings and tested the connection again to confirm it was successful, and synchronization worked smoothly.  

## Supplementary Information - Notion Privacy Controversy
In a 2020 post in the [Notion.Taiwan Official Community](https://www.facebook.com/groups/notion.so.taiwan/permalink/650523105498836/), someone mentioned that  
Notion would look at user data and even propose partnerships:

![notion_privacy_concern](/images/joplin_webdav_on_nas/notion_privacy_concern.png)

In the end, [Notion's official statement](https://notiontaiwancommunity.notion.site/Notion-1c9a7142157147b484bc381c3e3b35d9) removed the controversial "Business Development and Strategic Partnerships" clause.
