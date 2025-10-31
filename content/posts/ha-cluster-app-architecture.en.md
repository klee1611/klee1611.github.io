---
title: HA Cluster Notes and Application Design
date: 2020-01-09 19:40:00 +0800
categories:
- Web Hosting
tags: [Cluster, High availability, Architecture]
slug: ha-cluster-app-architecture
---
When designing systems with higher traffic, you will eventually encounter cluster-related issues.

## Cluster
A collection of one or more machines (nodes) with three different purposes:

### Load Balancing
Allows multiple machines to share tasks as evenly as possible,
accelerating application execution.

### High Availability (HA)
For high availability and redundancy,
if one machine suddenly fails, others can take over.
<!-- more -->

### High Performance Computing
High-performance/parallel computing systems,
abbreviated as HPC clusters,
combine the hardware of multiple machines to increase computing power,
used to solve tasks that a single machine cannot handle.

## HA Operating Modes
There are many types, such as N+1, N+M, ...
But the most common is a two-node cluster.
A two-node cluster has two operating modes:
* Active-Passive
* Active-Active

### Active-Passive (AP)
A master-slave design.
Under normal circumstances, only the master (Active) provides the service.
When the master (Active) encounters a problem, the slave (Passive) takes over.
Once the master (Active) recovers, it switches back, and the master (Active) continues to handle the service.

Advantages:
* Fast fail-over speed.
* Relatively simple design and configuration.

Disadvantages:
* Cannot perform load balancing simultaneously, wasting some hardware resources.

### Active-Active (AA)
Both machines simultaneously run their own independent services (both are Active),
and also provide mutual redundancy (acting as the other's Passive).
When one machine encounters a problem, the other takes over its service.

Advantages:
* Neither machine is idle during normal operation,
resulting in high operational efficiency.

Disadvantages:
* The machine's load increases after fail-over,
leading to slower performance.
* Relatively complex design and configuration.

## Application Design
* There needs to be a relatively simple way to start, stop, force-stop services, and check the current status of services.  
=> When designing the application, there should be a command-line interface or script to achieve this.  
=> Services on both machines should be able to know each other's status and be able to start or stop in case of an accident.  
* Shared storage is required,
and the application should record its state as meticulously as possible to shared storage.  
=> This ensures nothing is lost when switching between the two machines.  
* It should be possible to restart another node and restore it to the state before the failure occurred.  
=> Restoring to the pre-failure state can be done using the state saved to shared storage.
* When the application crashes, the data stored on shared storage must not be corrupted.  
=> The other side needs to use it.

### Remark
* Consider scenarios that occur during application upgrades.
* Some SQL or NoSQL databases inherently support these types of configurations, which can be adopted to reduce a lot of trouble.
