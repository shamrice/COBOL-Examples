# Example calling a sub program


This example shows how to call a sub program and pass variables by content and by reference. It also demonstrates 
how the working-storage section variables of the sub program retain their values until the sub program is 
cancelled using the cancel statement. Local-storage variables do not retain their values between sub program 
calls. 


**Example program output:**

```
 
Enter value for #1: hello  
Enter value for #2: world
 
-----------------------------------------------
Main app: hello     world     
Calling sub program by content:
In sub program: hello      world     
 
working-storage values at start:
ws-test-item-1:           
ws-test-item-2:           
 
local-storage values at start:
ls-test-item-1:           
ls-test-item-2:           
 
Moving linkage section values to ws and ls vars..
setting input variables to new value...
 
working-storage values at end:
ws-test-item-1: hello     
ws-test-item-2: world     
 
local-storage values at end:
ls-test-item-1: hello     
ls-test-item-2: world     
 
Exit sub program: replace1   replace2  
 
-----------------------------------------------
Main app: hello     world     
Second call of sub program should retain WS values.
Calling sub program by reference:
In sub program: hello      world     
 
working-storage values at start:
ws-test-item-1: hello     
ws-test-item-2: world     
 
local-storage values at start:
ls-test-item-1:           
ls-test-item-2:           
 
Moving linkage section values to ws and ls vars..
setting input variables to new value...
 
working-storage values at end:
ws-test-item-1: hello     
ws-test-item-2: world     
 
local-storage values at end:
ls-test-item-1: hello     
ls-test-item-2: world     
 
Exit sub program: replace1   replace2  
 
-----------------------------------------------
Main app: replace1  replace2  
Cancelling sub program
Calling sub program. WS values should be reset:
In sub program: replace1   replace2  
 
working-storage values at start:
ws-test-item-1:           
ws-test-item-2:           
 
local-storage values at start:
ls-test-item-1:           
ls-test-item-2:           
 
Moving linkage section values to ws and ls vars..
setting input variables to new value...
 
working-storage values at end:
ws-test-item-1: replace1  
ws-test-item-2: replace2  
 
local-storage values at end:
ls-test-item-1: replace1  
ls-test-item-2: replace2  
 
Exit sub program: replace1   replace2  
 
-----------------------------------------------
Main app: replace1  replace2 
```


