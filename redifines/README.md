# REDEFINES Example


```REDEFINES``` does as the name suggests. It redefines a previous variable's declaration to something new. The data's 
memory location does not change and is shared between the original variable and the redefined ones. This can be used to 
display or interpret data different ways.


**Basic example of syntax**

```
       01  ws-customer.
           05  ws-customer-name.
               10  ws-customer-first-name      pic x(10).
               10  ws-customer-last-name       pic x(20).
           05  ws-corp-name redefines ws-customer-name pic x(30).
```


```redefines.cbl``` demonstrates a couple of examples of using ```REDEFINES```.


**Example of program output:**

```
 
1. Person record with first/last name entered.
2. Corp record with corp name entered.
3. Person record with corp name entered.
 
Displaying fake customer data:
------------------------------
 
Customer Type: PERSON
First Name: test-first
Last Name: test-last           
Address: 
123 fake st         
NV, 12345
------------------------------
 
Customer Type: CORP
Company name: no-name corp                  
Address: 
567 real st         
NY, 11795
------------------------------
 
Customer Type: PERSON
First Name: SET CORP V
Last Name: ALUE                
Address: 
890 what st         
MA, 09345
------------------------------
 
 
Redefines with different variable types:
----------------------------------------
Value entered in ws-data-disp-value: ABC123
ws-data-disp-value x(10): ABC123    
ws-data-comp-value comp-2: 6.041250258948924E-154
 
----------------------------------------
Value entered in ws-data-comp-value: 12345.63
ws-data-disp-value x(10): =
ף��@  
ws-data-comp-value comp-2: 12345.63
 
```

