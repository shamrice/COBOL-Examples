# Accept syntax examples

The ```ACCEPT``` statement assigns input from the user/environment/screen/etc to a variable. In its simpilest form, it is 
written as:

```accept ws-variable-name```


Please note that by adding certain screen related parameters to the basic structure above will move the application 
into "COBOL screen mode" if it isn't already. This screen mode uses either the pdcurses (Win) or 
ncurses (Mac/Linux) library to display the program output instead of STDOUT. When this mode is entered, 
screen x,y locations must be provided to screen output or it will all be defaulted to the 
upper left hand corner of the terminal output. This can be done by either passing the screen 
location in the output statements or using the ```screen section``` to define the screen's output. 
Those functionalities are covered in their related sub directories in this repo.



## Accept


```accept.cbl``` demonstrates a couple of examples of the different ```ACCEPT``` syntax options. Please
refer to the comments in the source code for explainations of each example.


**Example of program output:**

```
Simple accept. Enter a value: test
You entered: test
Press any key to enter screen mode.

Enter a value or wait 3 seconds:
You entered:
Enter 16 chars to auto skip: 1234567890123456
You entered: 1234567890123456
Enter a value (no echo):
You entered: test
Enter a value: TEST
You entered: TEST  
```



## Accept Secure

```accept-secure.cbl``` demonstrates using the ```SECURE``` keyword on an ```ACCEPT``` statement to hide 
the text input from being displayed on the screen. In the default case, the input will be displayed 
as asterisks. Note that the input will still be in plain text in memory so displaying the contents 
of the variable that was entered securely will display the original text that was inputted. 

**Example of program output:**

```
Enter password: ********
   You entered: password
```



## Accept From 

```accept_from.cbl``` demonstrates a bunch of different examples when using the ```FROM``` keyword 
in an ```ACCEPT``` statement. Please see the source code for an explaination of each example.


**Example of program output:** Called using: ```./accept_from "this is one cmd arg" these are individual```

```
 
ACCEPT... FROM... Example Program
---------------------------------
Pass command line parameters to demo that feature
 
accept from command-line: this is one cmd arg these are individual 
accept from argument-number: 000000004                
accept from argument-value: this is one cmd arg
accept from argument-value: these                    
accept from argument-value: are                      
accept from argument-value: individual               
Before environment setting set:
accept from environment:                          
accept from exception status: 000001537                
After environment setting set:
accept from environment: NOW SET!                 
accept from date: 220418                   
accept from date yyyymmdd: 20220418                 
accept from day: 22108                    
accept from day yyyyddd: 2022108                  
accept from time: 15462522                 
accept from day-of-week: 1                        
accept from user name: erik                     
Enter value: value
accept from console: value                    
Press enter to enter screen mode.

accept from lines: 000000020
accept from columns: 000000080
Using CBL_GET_SCR_SIZE instead:
Num lines:    20 
Num cols:     80

```



