---
title: C/C++ - const with Pointer or Reference
date: 2019-12-30 08:19:00 +0800
lastmod: 2021-11-15 00:40:00 +0800
categories:
- C++
tags: [Programming, C, C++]
slug: const-pointer-reference
---
## ``const`` with Normal Variables
Two ways to add ``const`` for normal variables:

```cpp
const TYPE NAME = VALUE; // more common
TYPE const NAME = VAULE;
```

Both means this variable cannot be assigned to another value.  

For example,  
<!--more-->

```cpp
#include <iostream>

using namespace std;

int main(void)
{
	const int i = 1;
	int const j = 1;
	i = 2; // error
	j = 2; // error
	cout << "i = " << i << endl;
	cout << "j = " << j << endl;

	return 0;
}
```

The same error cames out for ``i`` and ``j``:

```
const.cpp:9:4: error: cannot assign to variable 'i' with const-qualified type 'const int'
        i = 2;
        ~ ^
const.cpp:7:12: note: variable 'i' declared const here
        const int i = 1;
        ~~~~~~~~~~^~~~~
const.cpp:10:4: error: cannot assign to variable 'j' with const-qualified type 'const int'
        j = 2;
        ~ ^
const.cpp:8:12: note: variable 'j' declared const here
        int const j = 1;
        ~~~~~~~~~~^~~~~
2 errors generated.
```

## ``const`` and Reference
Also two ways to add ``const`` to a reference:  

```cpp
const TYPE &NAME = VALUE; // more common
TYPE const &NAME = VAULE;
```

Both have the same meaning.  
There are two limits for them:  
1. This reference cannot be assigned to another variable
2. The variable being referenced **cannot change its value with this reference**,  
but it **can change its value without using that reference**.  

For example,  

```cpp
#include <iostream>

using namespace std;

int main(void)
{
	int i = 1, j = 2;
	int const &r1 = i;
	const int &r2 = i;

	// change value with reference
	r1 = 3;  // error
	r2 = 3;  // error

	// change value
	i = 4;

	// change reference object
	r1 = j;  // error
	r2 = j;  // error

	return 0;
}
```

**constant reference can only be read**.  
if the value of the variable it referenced to has be changed,  
it **can only change the value without that reference**.  

## ``const`` and Pointer
This one is complicated.  

But we can use the position of ``const`` to remember which one ``const`` is decorating:  

```cpp
TYPE* const pNAME;  // 1
TYPE const *pNAME;  // 2
const TYPE *pNAME;  // 3
const TYPE* const pNAME;  // 4
```

For 1,  
``const`` decorates ``pNAME``,  
that means ``pNAME`` cannot be changed (No ``pNAME = ...``).  

For 2,  
``const`` decorates `*pNAME`,  
so `*pNAME` cannot be changed (No `*pNAME = ...`).  

For 3,  
`const` decorates `TYPE *pNAME`.  
it is the same as 2,  
saying that `*pNAME` cannot be changed (No `*pNAME = ...`).

For 4,  
`const` decorates `pNAME` and `TYPE*`,  
so both `pNAME` and `TYPE*` cannot be changed (No `pNAME = ...` or `*pNAME = ...`).  

```cpp
#include <iostream>

using namespace std;

int main(void)
{
	int i = 1, j = 2;
	int* const p1 = &i;
	int const *p2 = &i;
	const int *p3 = &i;
	const int* const p4 = &i;

	// change value with pointer
	*p1 = 2;
	*p2 = 2;  // error
	*p3 = 2;  // error
	*p4 = 2;  // error

	// change value
	i = 3;

	// change pointer position
	p1 = &j;  // error
	p2 = &j;
	p3 = &j;
	p4 = &j;  // error

	return 0;
}
```
