# Accept syntax examples

The accept command assigns input from the user to a variable. In its simpilest form, it is 
written as:

```accept ws-variable-name```


Please note that by adding any parameters to the basic structure above will move the application 
into "COBOL screen mode" if it isn't already. This screen mode uses either the pdcurses (Win) or 
ncurses (Mac/Linux) to display the program output instead of STDOUT. When this mode is entered, 
screen x,y locations must be provided to screen output or it will all be defaulted to the 
upper left hand corner of the terminal output. This can be done by either passing the screen 
location in the output statements or using the screen-section to define the screen's output. 
Those functionalities are covered in their related sub directories in this repo.


**Accept Secure**
```accept-secure.cbl``` demonstrates using the "secure" parameter on an except statement to hide 
the text input from being displayed on the screen. In the default case, the input will be displayed 
as asterisks. Note that the input will still be in plain text in memory so displaying the contents 
of the variable that was entered securely will display the original text that was inputted. 

**Example of program output:**
```
Enter password: ********
   You entered: password
```

