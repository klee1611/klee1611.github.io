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
HTTP is a **stateless protocol**,  
meaning that **each request/response is independent**,  
and is unrelated to previous or subsequent requests/responses.  
The same request will always receive the same response,  
and will not differ based on the content of previous requests/responses.  

This allows the server to save a large amount of database and server storage space because it doesn't need to store user information.  
It also speeds up response times and saves considerable network bandwidth because the client doesn't always have to connect to the same socket.  
<!-- more -->
However, when a website needs to perform continuous actions (e.g., requiring user authentication),  
some mechanisms are needed to assist.  
At this point, most websites utilize sessions or cookies.  

## Session

A **session is a stateful period of time**.  
HTTP requests/responses are stateless,  
but if state information is carried through stateless requests/responses,  
the client and server can create stateful operations using the state information carried in the requests/responses.  

For example, if a certain action requires the user to be logged in and have selected option A before it can be performed,  
it is desirable to have a **stateful period (session)** that represents the state "user is logged in and has selected option A."  
There are many ways to achieve this state.  
For instance, during this period,  
requests can carry an encrypted user ID and option A to inform the server that the user is logged in,  
their identity, and the selected option.  

There are many ways to implement a session,  
the most common being cookies.  
However, cookies are just one method;  
it doesn't mean that sessions can only be implemented through cookies.  
Sessions can also be created through other means,  
such as using query strings to record previous interactions.  


## Cookie

A cookie is a mechanism for implementing sessions.  
The server can use the **`Set-Cookie` header** to instruct the browser to set a cookie and specify its content.  
Subsequently, when the browser sends a request to the same domain and path, it will include the cookie with the request.  
This way, when certain states need to be remembered,  
the server only needs to instruct the browser to set the necessary cookie.  
Then, when a request is sent, the server can understand the current state by examining the cookie's content.  

Since **the content of a cookie can be modified by the user**,  
for security considerations,  
there are two common approaches when using cookies (they can also be used together):  

### Cookie-based session
**Encrypt the cookie content**.  
The server decrypts the content after receiving it to understand what the cookie stores.  

Continuing the example above,  
the user ID and option A would be encrypted and placed in the cookie.  

Points to note:
- Because cookies have a size limit, special attention must be paid to ensure the encrypted cookie size is not too large.
- The encryption key must be properly secured.

### Session ID
Use an ID (Session Identifier, Session ID) to record user identity,  
while all other data (Session Data) is stored on the server.  

Continuing the example above, the user's selected option A would be stored on the server,  
and the user's ID would be placed in the cookie.  

Points to note:
- The Session ID must be designed to be difficult to guess; if it is guessed, the user's identity will be stolen.
- If the website is not secure enough, and the Session ID is stolen by another malicious website or hacker on a certain page, the user's identity will be stolen.
