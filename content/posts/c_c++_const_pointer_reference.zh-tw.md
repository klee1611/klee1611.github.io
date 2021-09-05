---
title: C/C++ - const 加上 pointer 和 reference 的用法整理
date: 2019-12-30 08:19:00 +0800
categories:
- C++
tags: [Programming, C, C++]
slug: const-pointer-reference
---
## const 和一般變數
有兩種寫法
  
```cpp
const TYPE NAME = VALUE; // more common
TYPE const NAME = VAULE;
```
  
意思都一樣，  
就是這個變數不能再被指定別的值。  
  
舉個例：  
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
  
``i``和``j``兩個噴的 error 一模一樣:
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
  
## const 和 reference
跟一般變數一樣有兩種寫法:  
  
```cpp
const TYPE &NAME = VALUE; // more common
TYPE const &NAME = VAULE;
```
  
意思也一樣，  
有兩個限制:  
1. Reference 不能再拿去指定別的變數
2. 被 reference 指到的變數不能**用 reference 去指定**別的值。  
不過他**可以在不透過 reference 的情況下自己改變他的值**。  
  
例子:  
  
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
**constant reference 唯一能做的就是拿來讀**，  
要改值的話**只能是他 reference 到的變數不透過 reference 自己改自己**。  
  
## const 和 pointer
這就複雜了，  
可以用 ``const`` 的位置來記 ``const`` 是用來修飾誰:  
  
```cpp
TYPE* const pNAME;  // 1
TYPE const *pNAME;  // 2
const TYPE *pNAME;  // 3
const TYPE* const pNAME;  // 4
```
  
1 的情況下 const 修飾的是 pNAME，  
也就是 pNAME 不能再被改變 (不能 pNAME = ...)；  
2 的情況 const 修飾的是 \*pNAME，  
是說 \*pNAME 不能再被改變 (不能 \*pNAME = ...)；  
3 的情況 const 修飾的是 TYPE \*pNAME，  
跟 2 一樣是說 \*pNAME 不能再被改變 (不能 \*pNAME = ...)；  
4 的情況 const 修飾的是 pNAME 和 TYPE\*，  
所以 pNAME 和 TYPE\* 都不能改變 (pNAME = ... 和 \*pNAME = ... 都不行)。  
  
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
  

