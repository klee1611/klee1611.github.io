---
title: 'Stateless HTTP, Stateful Session and Cookies'
date: 2021-06-28 02:51:00
tags:
  - Web
  - Session
  - Cookie
categories:
  - Web
slug: stateless-http-stateful-session-and-cookies
---
## Stateless HTTP
HTTP 是一種 **stateless 的 protocol**，  
也就是說**每一次的 request / response 都是獨立的**，  
和之前或之後的 request / response 無關。  
相同的 request 就會回應相同的 response，  
不會因為之前的 request / response 內容而有不同。 

這樣一來 server 因為不需要儲存使用者資訊可以省去大量的資料庫、伺服器儲存空間，  
也因為不需要讓 client 每次都必須連線到相同的 socket 而能夠加快 response time 和省去不少 network bandwidth，  
<!-- more -->
但在網站需要做連續動作（例如需要確認使用者身份認證時）就會需要一些機制來協助，  
這時候大部分的網站就會利用 session 或 cookie。

## Session

**Session 是一段具有狀態 (stateful) 的時間**。  
HTTP request / response 是 stateless 的，  
但如果透過 stateless 的 request / response 夾帶 state 資訊的話，  
client 和 server 就可以透過 request / response 夾帶的 state 資訊製造出 stateful 的運作。  

例如說當某個動作必須要使用者登入並且選定了選項 A 後才能夠操作，  
就希望能有一段**具有狀態的時期 (session)** 是“使用者已登入且選定了 A 選項”的狀態，  
做出這個狀態的方式有許多種，   
例如在這個期間的 request 透過攜帶加密過後的使用者 ID 和選項 A 來告訴 server 現在使用者已經登入、使用者的身份和選定的選項等。  

做出 session 的做法可以有很多種，  
最常見的是 cookie，  
但 cookie 只是方法之一，  
並不是說 session 一定只能透過 cookie 來實作，  
透過別的方式也能做出 session，  
例如利用 query string 來記錄前幾次的互動等。


## Cookie

Cookie 是實作出 session 的一種機制，  
server 可以用 **`Set-Cookie` 這個 Header** 請 browser 設定 cookie 並指定 cookie 的內容，  
之後 browser 在發送 request 到相同的 domain 和 path 時會將 cookie 帶入一併發送，  
這樣一來在需要記憶某些 state 時，  
server 只要讓 browser 去設定需要的 cookie，  
之後當發送 request 時 server 看到 cookie 的內容就能知道現在的 state 了。  

由於 **cookie 的內容可以在使用者端被自行修改**，  
所以為了安全性考量，  
在使用 cookie 的時候有比較常見的兩種做法(也能兩者一起使用)：

### Cookie-based session
**將 cookie 內容加密**，  
傳到 server 後由 server 解密才知道 cookie 存的內容。  

接續上面的例子就是將使用者 ID 和選項 A 加密後放進 cookie。    

使用上要注意：
- 因為 Cookie 的大小有限制，所以加密後 cookie 的大小要特別注意不能太大
- 加密的 key 必須妥善保存

### Session ID
使用一個 ID (Session Identifier, Session ID) 來記錄使用者身份，  
其餘的資料 (Session Data) 都儲存在 server。  

接續上面的例子就是將使用者選定的選項 A 放在 server，  
cookie 裡放置使用者的 ID。  

使用上要注意：
- Session ID 要設計的不好猜，一旦被猜中使用者的身份就會被偷走
- 如果網站不夠安全，一旦 Session ID 在某個頁面被其他惡意網站或駭客盜走，使用者的身份就會被偷走
