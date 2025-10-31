---
title: RDBMS and NoSQL Differences Notes
date: 2020-01-06 04:06:00 +0800
categories:
- Database
tags: [Database, NoSQL, RDBMS]
slug: rdbms-acid-nosql-cap
---
## RDBMS
**Relational Database Management System**
* Used when there are strong **Relations** between data:
  * Design a schema that is unlikely to change, relating tables to each other,
  then you can retrieve the desired data through SQL.
* Used when **data correctness** is very important:
  * Usually provides **ACID** properties.
* Changing the schema is a huge undertaking:
  * Requires updating the table schema and migrating data.
  * All programs that use the table with the changed schema need to be modified.
<!--more-->
* **Vertical scaling** is more effective (improving machine performance).

### ACID
RDBMS usually guarantees four properties for transactions:
* **Atomicity**
Only two possibilities: **all completed (Commit)** or **all not done (Abort)**.
There is no "half-done" state.
If there is an error during execution, it will Rollback to the state where nothing was done.

* **Consistency**
The database will remain in a legal state before and after the transaction.

* **Isolation**
When multiple transactions need to be executed, each transaction is separate and does not interfere with each other.
Transaction A and B does not affect transaction B and C.

* **Durability**
Once a transaction is completed, it is permanently valid and will not be lost,
even if the system suddenly fails.

## NoSQL
**Not only SQL**
* Less concerned with relations between data:
  * Does not require a fixed schema for data access.
  * Each piece of data exists independently, without issues of who relates to whom.
* More concerned with the content of the data:
  * Whether updates, additions, deletions, etc., are needed.
  * Data can have **different formats**.
* More suitable for distributed systems.
* Usually provides two of the **CAP** properties.
* **Horizontal scaling** is more effective (adding more machines).

### CAP
For a distributed system,
it is impossible to **guarantee** all three CAP properties simultaneously (though they might coexist when the network is stable).
At most, two can be guaranteed simultaneously.

* **Consistency**
Every read, if it doesn't result in an error, will return the **result of the most recent write**.
=> **Data on every node is identical.**

* **Availability**
Every request will receive a non-error response,
regardless of whether the data returned by this response is the latest.
=> **Guarantees that data will always be returned, but the data might be old.**

* **Partition tolerance**
Even if some messages transmitted between nodes are delayed or lost, the system will continue to operate.
=> When network issues occur, **the normally connected part of the nodes can continue to operate.**

## Reference
[Wiki ACID](https://en.wikipedia.org/wiki/ACID)
[Wiki CAP](https://en.wikipedia.org/wiki/CAP_theorem)
