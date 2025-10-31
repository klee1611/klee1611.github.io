---
title: "C++ Container Characteristics and Usage Scenarios - array, vector, deque, list, forward_list"
date: 2020-01-12 20:40:00 +0800
categories:
- C++
tags: [Programming, C++, STL, container]
slug: c++-stl-container-compare-array-vector-dequeue-list-forward_list
toc: true
find_last_modify_date: true
---

## Introduction

C++ provides various containers to store and manage data,  
each with its unique characteristics and applicable scenarios.  
This article will delve into five common sequence containers: `array`, `vector`, `deque`, `list`, and `forward_list`,  
comparing their features, performance, and offering selection advice.

## Array

`std::array` is a fixed-size array introduced in C++11,  
combining the performance of C-style arrays with the interface of STL containers.

### Characteristics

*   **Fixed Size**: Size is determined at compile time and cannot be changed dynamically.
*   **Stack Allocation**: Typically allocates memory on the stack, offering high performance.
*   **Random Access**: Supports `O(1)` time complexity for random access.
*   **Iterator Support**: Provides iterators, allowing use with STL algorithms.

### When to Use

*   When the data size is known and fixed.
*   When pursuing ultimate performance, avoiding heap allocation overhead.
*   When interoperability with C-style arrays is required.

### Example

```cpp
#include <array>
#include <iostream>
#include <numeric> // For std::accumulate

int main() {
    std::array<int, 5> my_array = {1, 2, 3, 4, 5};

    // Access elements
    std::cout << "Element at index 2: " << my_array[2] << std::endl; // Output: 3

    // Iteration
    for (int& x : my_array) {
        x *= 2;
    }

    // Sum
    int sum = std::accumulate(my_array.begin(), my_array.end(), 0);
    std::cout << "Sum of elements: " << sum << std::endl; // Output: 30

    return 0;
}

```

## Vector

`std::vector` is a dynamic array that can change its size dynamically at runtime.  
It is the most commonly used and flexible sequence container in C++.

### Concept
Allocate array dynamically.  
When the capacity is not big enough,  
reallocate a new array with sufficient memory space and move elements to the new one.  

The actual capacity usually a bit bigger than the number of elements in the vector.  

### Characteristics

*   **Dynamic Size**: Can automatically expand or shrink at runtime.
*   **Contiguous Memory**: Elements are stored contiguously in memory, supporting **efficient random access** with `O(1)` time complexity.
*   **Automatic Memory Management**: Automatically handles memory allocation and deallocation.
*   **Efficient Back Operations**: Inserting and deleting elements at the back is typically `O(1)` amortized time complexity.
*   **Inefficient Middle Insertions/Deletions**: Inserting or deleting elements in the middle requires moving many elements, resulting in `O(n)` time complexity.

### When to Use

*   When the data size is unknown or changes dynamically.
*   When frequent additions or deletions at the back are needed.
*   When random access to elements is required.

### Example

```cpp
#include <vector>
#include <iostream>

int main() {
    std::vector<int> my_vector;

    // Add elements
    my_vector.push_back(10);
    my_vector.push_back(20);
    my_vector.push_back(30);

    // Access elements
    std::cout << "Element at index 1: " << my_vector[1] << std::endl; // Output: 20

    // Iteration
    for (int x : my_vector) {
        std::cout << x << " "; // Output: 10 20 30
    }
    std::cout << std::endl;

    // Delete back element
    my_vector.pop_back();

    // Size
    std::cout << "Vector size: " << my_vector.size() << std::endl; // Output: 2

    return 0;
}

```

## Deque

`std::deque` (double-ended queue) is a **double-ended queue** that supports efficient insertion and deletion of elements at both ends.

### Characteristics

*   **Dynamic Size**: Can automatically expand or shrink at runtime.
*   **Efficient Operations at Both Ends**: Inserting and deleting elements at both the front and back are `O(1)` time complexity. For other elements that are not at the front or back, inserting and deleting are bit slower.  
*   **Random Access**: Supports `O(1)` time complexity for random access, but typically slower than `vector`.
*   **Non-contiguous Memory**: Elements are not guaranteed to be stored contiguously in memory, usually composed of multiple fixed-size blocks.
    * Leads to more efficiency for reallocation

### When to Use

*   When frequent additions or deletions at both ends are needed.
*   When random access to elements is required, but performance requirements are not as strict as `vector`.
*   As the underlying implementation for queues or stacks.

### Example

```cpp
#include <deque>
#include <iostream>

int main() {
    std::deque<int> my_deque;

    // Add to front
    my_deque.push_front(10);
    // Add to back
    my_deque.push_back(20);
    my_deque.push_back(30);

    // Access elements
    std::cout << "First element: " << my_deque.front() << std::endl; // Output: 10
    std::cout << "Element at index 1: " << my_deque[1] << std::endl; // Output: 20

    // Iteration
    for (int x : my_deque) {
        std::cout << x << " "; // Output: 10 20 30
    }
    std::cout << std::endl;

    // Delete from front
    my_deque.pop_front();

    // Delete from back
    my_deque.pop_back();

    std::cout << "Deque size: " << my_deque.size() << std::endl; // Output: 1

    return 0;
}

```

## List

`std::list` is a **doubly linked list** that supports efficient insertion and deletion of elements at any position.

### Characteristics

*   **Efficient Operations at Any Position**: Inserting and deleting elements at any position are `O(1)` time complexity.
    * Good choice for sorting
*   **Efficient iterator**: Move backward or forward efficiently with doubly linked list
*   **Slow Random Access**: Can only be accessed sequentially via iterators, with `O(n)` time complexity.
*   **Non-contiguous Memory**: Elements are not stored contiguously in memory; each element contains pointers to the previous and next elements.
*   **Additional Memory Overhead**: Each element requires extra memory to store pointers.

### When to Use

*   When frequent insertions or deletions at any position are needed.
*   When random access to elements is not required.
*   When not sensitive to memory overhead.

### Example

```cpp
#include <list>
#include <iostream>
#include <algorithm> // For std::find

int main() {
    std::list<int> my_list;

    // Add elements
    my_list.push_back(10);
    my_list.push_back(20);
    my_list.push_back(40);

    // Insert in the middle
    auto it = std::find(my_list.begin(), my_list.end(), 20);
    my_list.insert(it, 30);

    // Iteration
    for (int x : my_list) {
        std::cout << x << " "; // Output: 10 20 30 40
    }
    std::cout << std::endl;

    // Delete element
    my_list.remove(20);

    std::cout << "List size: " << my_list.size() << std::endl; // Output: 3

    return 0;
}

```

## Forward_list

`std::forward_list` is a **singly linked list**, a lightweight version of `std::list` that only supports forward traversal.

### Characteristics

*   **Forward Traversal Only**: Can only traverse from head to tail.
*   **Efficient Operations at Any Position**: Inserting and deleting elements at any position are `O(1)` time complexity (requires an iterator to the element before the insertion/deletion point).
*   **No Random Access Support**: Can only be accessed sequentially via iterators, with `O(n)` time complexity.
*   **Smaller Memory Overhead**: Each element contains only one pointer to the next element, saving memory compared to `list`.

### When to Use

*   When only forward traversal is needed.
*   When frequent insertions or deletions at any position are needed.
*   When extremely sensitive to memory overhead.

### Example

```cpp
#include <forward_list>
#include <iostream>

int main() {
    std::forward_list<int> my_forward_list;

    // Add elements (Note: forward_list does not have push_back)
    my_forward_list.push_front(40);
    my_forward_list.push_front(30);
    my_forward_list.push_front(10);

    // Insert after a specified position
    auto it = my_forward_list.begin(); // Points to 10
    it++; // Points to 30
    my_forward_list.insert_after(it, 20); // Insert 20 after 30

    // Iteration
    for (int x : my_forward_list) {
        std::cout << x << " "; // Output: 10 30 20 40
    }
    std::cout << std::endl;

    // Delete element (requires an iterator to the element before)
    my_forward_list.remove(30);

    // Iteration
    for (int x : my_forward_list) {
        std::cout << x << " "; // Output: 10 20 40
    }
    std::cout << std::endl;

    return 0;
}

```

## Summary and Selection Advice

| Feature \ Container | Array | Vector | Deque | List | Forward_list |
| :------------------- | :---- | :----- | :---- | :--- | :----------- |
| Size                 | Fixed | Dynamic | Dynamic | Dynamic | Dynamic      |
| Memory Allocation    | Stack | Heap   | Heap  | Heap | Heap         |
| Memory Contiguous    | Yes   | Yes    | No    | No   | No           |
| Random Access        | O(1)  | O(1)   | O(1)  | O(n) | O(n)         |
| Front Insert/Delete  | O(n)  | O(n)   | O(1)  | O(1) | O(1)         |
| Back Insert/Delete   | O(n)  | O(1)   | O(1)  | O(1) | O(n) (no push_back) |
| Middle Insert/Delete | O(n)  | O(n)   | O(n)  | O(1) | O(1)         |
| Additional Overhead  | None  | Small  | Small | Large | Small        |

### Selection Advice

*   **`Array`**: When data size is fixed and known, and highest performance is desired.
*   **`Vector`**: The most common and versatile choice. When data size changes dynamically, and operations are primarily at the back with a need for random access.
*   **`Deque`**: When frequent insertions/deletions at both ends are needed, and random access is also required.
*   **`List`**: When frequent insertions/deletions at any position are needed, and random access is not required.
*   **`Forward_list`**: When all conditions for `List` are met, and only forward traversal is needed, with extreme sensitivity to memory overhead.

## References

*   [C++ Reference - Containers](https://en.cppreference.com/w/cpp/container)
*   [GeeksforGeeks - C++ STL Containers](https://www.geeksforgeeks.org/cpp-stl-containers/)
* http://www.cplusplus.com/reference/array/array/  
* http://www.cplusplus.com/reference/vector/vector/  
* http://www.cplusplus.com/reference/deque/deque/  
* http://www.cplusplus.com/reference/list/list/  
* http://www.cplusplus.com/reference/forward_list/forward_list/
