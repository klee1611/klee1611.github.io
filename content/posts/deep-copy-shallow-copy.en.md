---
title: Deep Copy and Shallow Copy
date: 2020-01-21 01:19:00 +0800
categories:
- Programming
tags: [Programming]
slug: deep-copy-shallow-copy
---
### Shallow Copy
Copies as little as possible.  
A new structure created by a shallow copy has the same structure as the old one,  
and they **share the memory address of elements**.

For example, in Java:
<!-- more -->
```java
int[] arr1 = {1, 2, 3};
int[] arr2 = arr1;
```
`arr2` is a shallow copy of `arr1`.

- If one of the structures modifies an element, the other will also be affected.

### Deep Copy
Copies everything.  
A new structure created by a deep copy not only has the same structure as the old one,  
but also **copies all elements of the old structure to the new memory address**.  

```java
int[] arr1 = {1, 2, 3};
int[] arr2 = new int[arr1.length];

for (int i = 0; i < arr1.length; ++i) {
	arr2[i] = arr1[i];
}
```
`arr2` is a deep copy of `arr1`.

- It occupies more memory space.
