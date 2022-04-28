# UNSTRING Example


```UNSTRING``` does just as the name suggests. It unstrings a delimited source value into one or more destination variables.


**Basic example of syntax**

```
   unstring ws-source-str 
       delimited by '='
       into ws-part-1 ws-part-2
   end-unstring
```


```unstring.cbl``` demonstrates a couple of examples of using ```UNSTRING``` in different forms.


**Example of program output:**

```
=================================================
EX 1 : SIMPLE UNSTRING
 
SOURCE STRING: Hello World                   
PART1: Hello          
PART2: World          
 
=================================================
EX 2 : UNSTRING MULTIPLE TIMES INTO SAME DEST.
 
SOURCE STRING: Hello World                   
ERROR: OVERFLOW
PART VALUE: Hello          
POINTER: 00007
Successfully unstrung.
PART VALUE: World          
POINTER: 00031
 
=================================================
EX 3 : UNSTRING INTO EXPLICIT FIELDS
 
SOURCE STRING: Hello World                   
Successfully unstrung.
PART1: Hello          
PART2: World          
POINTER: 00031
 
=================================================
EX 4 : UNSTRING WITH MULTIPLE DELIMITERS 
 
SOURCE STRING: A<B<CD>E%FG!HIJ|KL!MN>OP#QR!ST
 
VALUE: A    
DELIMITER: <
CHAR COUNT:1
CURRENT POINTER: 00003
TOTAL FIELDS FILLED: 01
-------------------------------------------
 
VALUE: B    
DELIMITER: <
CHAR COUNT:1
CURRENT POINTER: 00005
TOTAL FIELDS FILLED: 02
-------------------------------------------
 
VALUE: CD   
DELIMITER: >
CHAR COUNT:2
CURRENT POINTER: 00008
TOTAL FIELDS FILLED: 03
-------------------------------------------
 
VALUE: E%FG 
DELIMITER: !
CHAR COUNT:4
CURRENT POINTER: 00013
TOTAL FIELDS FILLED: 04
-------------------------------------------
 
VALUE: HIJ  
DELIMITER: |
CHAR COUNT:3
CURRENT POINTER: 00017
TOTAL FIELDS FILLED: 05
-------------------------------------------
 
VALUE: KL   
DELIMITER: !
CHAR COUNT:2
CURRENT POINTER: 00020
TOTAL FIELDS FILLED: 06
-------------------------------------------
 
VALUE: MN   
DELIMITER: >
CHAR COUNT:2
CURRENT POINTER: 00023
TOTAL FIELDS FILLED: 07
-------------------------------------------
 
VALUE: OP#QR
DELIMITER: !
CHAR COUNT:5
CURRENT POINTER: 00029
TOTAL FIELDS FILLED: 08
-------------------------------------------
 
VALUE: ST   
DELIMITER:  
CHAR COUNT:2
CURRENT POINTER: 00031
TOTAL FIELDS FILLED: 09
-------------------------------------------
 
=================================================
EX 5 : UNSTRING WITH MULTIPLE DELIMITERS INTO MULTIPLE DESTINATIONS
 
SOURCE STRING: A<B<CD>EFG!HIJ|KLMN>O         
 
STRING NUMBER: +000000001
VALUE: A    
DELIMITER: <
CHAR COUNT:1
-------------------------------------------
 
STRING NUMBER: +000000002
VALUE: B    
DELIMITER: <
CHAR COUNT:1
-------------------------------------------
 
STRING NUMBER: +000000003
VALUE: CD   
DELIMITER: >
CHAR COUNT:2
-------------------------------------------
 
STRING NUMBER: +000000004
VALUE: EFG  
DELIMITER: !
CHAR COUNT:3
-------------------------------------------
 
STRING NUMBER: +000000005
VALUE: HIJ  
DELIMITER: |
CHAR COUNT:3
-------------------------------------------
 
STRING NUMBER: +000000006
VALUE: KLMN 
DELIMITER: >
CHAR COUNT:4
-------------------------------------------
TOTALS: 
FIELDS FILLED: 06
 
=================================================
EX 6 : UNSTRING FORMATTED NUMBER
 
SOURCE VALUE: $123,456.12
PART 1: 123
PART 2: 456
PART 3: 012

```



