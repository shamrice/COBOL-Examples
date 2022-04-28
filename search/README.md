# SEARCH and SEARCH ALL Example


```SEARCH``` and ```SEARCH ALL``` are used to search an indexed table array for specified matching condition(s). There are two 
types of search. There's a binary search (```SEARCH ALL```) and a sequential search (```SEARCH```). Binary 
search requires that the data is sorted and has a ascending or descending key (can have multiple keys as well). 
A sequential search does not have a key nor does it require that the data is presorted. Note: Sequential searches 
are slower than binary searchs.


**Basic example of syntax**

```
       set idx to 1
       search ws-item-table
           at end
               display "Item not found."
           when ws-item-id-1(idx) = ws-accept-id-1
               display "Item found."
       end-search
```


```search.cbl``` demonstrates a couple of examples of using ```SEARCH``` and ```SEARCH ALL``` in different forms.


**Example of program output:**

```
 
==================================================
Searching keyed table using binary search.
Enter id-1 to search for: 3
 Record found:
----------------
Item id-1: 0003
Item id-2: 0103
Item id-3: 0498
Item Name: test item 3     
Item Date: 2021/03/03
 
 
==================================================
Searching again with all required ids matching.
Enter id-1 to search for: 2
Enter id-2 to search for: 102
Enter id-3 to search for: 499 
 Record found:
----------------
Item id-1: 0002
Item id-2: 0102
Item id-3: 0499
Item Name: test item 2     
Item Date: 2021/02/02
 
 
==================================================
Searching not keyed table using sequential search.
Enter id: 1
 Record found:
---------------
   ws-no-key-id: 0001
ws-no-key-value: Value of id 1.           
 
```

