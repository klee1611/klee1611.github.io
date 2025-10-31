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

Both mean this variable cannot be assigned to another value.  

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

The same error occurs for ``i`` and ``j``:

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
There are also two ways to add ``const`` to a reference:  

```cpp
const TYPE &NAME = VALUE; // more common
TYPE const &NAME = VAULE;
```

Both have the same meaning.  
There are two restrictions for them:  
1. This reference cannot be reassigned to another variable
2. The variable being referenced **cannot have its value changed through this reference**,  
but its value **can be changed without using this reference**.  

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

**A constant reference can only be read**.  
If the value of the variable it references has been changed,  
it **can only be changed without using that reference**.  

## ``const`` and Pointer
This can be complicated.  

However, we can use the position of ``const`` to determine what it is modifying:  

```cpp
TYPE* const pNAME;  // 1
TYPE const *pNAME;  // 2
const TYPE *pNAME;  // 3
const TYPE* const pNAME;  // 4
```

For 1,  
``const`` modifies ``pNAME``,  
meaning that ``pNAME`` cannot be changed (i.e., ``pNAME = ...`` is not allowed).  

For 2,  
``const`` modifies `*pNAME`,  
so the value pointed to by `pNAME` cannot be changed (i.e., `*pNAME = ...` is not allowed).  

For 3,  
`const` modifies `TYPE *pNAME`.  
This is the same as case 2, meaning that the value pointed to by `pNAME` cannot be changed (i.e., `*pNAME = ...` is not allowed).

For 4,  
`const` modifies both `pNAME` and the `TYPE` it points to,  
so neither `pNAME` nor the value it points to can be changed (i.e., `pNAME = ...` or `*pNAME = ...` are not allowed).  

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

	// Change value through pointer
	*p1 = 2;
	*p2 = 2;  // error
	*p3 = 2;  // error
	*p4 = 2;  // error

	// change value
	i = 3;

	// Change pointer's target
	p1 = &j;  // error
	p2 = &j;
	p3 = &j;
	p4 = &j;  // error

	return 0;
}
```
