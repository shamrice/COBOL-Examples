      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-04-16
      * purpose: Examples of using various forms of the ACCEPT verb.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. accept-example.
       data division.
       file section.
       working-storage section.

       01  ws-input                     pic x(16).

       procedure division.
       main-procedure.

      *> Basic accept syntax. Entered value is stored in the variable
      *> provided.
           display "Simple accept. Enter a value: " with no advancing
           accept ws-input
           display "You entered: " ws-input

      *> Accept omitted waits for user input but does not store it
           display "Press any key to enter screen mode."
           accept omitted

      *> From here out, the accept command examples use parameters.
      *> Once this happens, the program enteres screen mode which requires
      *> the inclusion of the line and column numbers to be specified
      *> to each input/output statement when not using the
      *> screen section. Here I am using "at yyxx" to do this.

      *> Timeout specifies how long to wait for the user to enter a
      *> value before continuing. The scale of this can be controlled
      *> using the environment setting:
      *>
      *> set environment "COB_TIMEOUT_SCALE" to '1000'.
      *>
      *> default value is 1000 (1 second). Can be any value between
      *> zero and 1000.
           display "Enter value or wait 3 seconds: " at 0101
           accept ws-input timeout 3 at 0132
           display "You entered: " at 0201 ws-input at 0214

      *> auto-skip automatically enteres the user's input once it reaches
      *> the end width of the variable size. In this case, it's 16
      *> characters as we declared ws-input as PIC X(16). The user
      *> can still enter less characters and submit using the enter
      *> key.
           display "Enter 16 chars to auto skip: " at 0301
           accept ws-input auto-skip at 0330
           display "You entered: " at 0401 ws-input at 0414

      *> No-echo is similar to secure (see accept-secure.cbl) where the
      *> text entered by the user is not displayed on the screen during
      *> entry. The difference is that secure will show '*' for characters
      *> where no-echo will not show anything.
           display "Enter a value (no echo): " at 0501
           accept ws-input no-echo at 0526
           display "You entered: " at 0601 ws-input at 0614


      *> 'upper' converts any input from the user to uppercase. This is
      *> helpful when comparing user input to some string constant.
      *> Example: "Enter y/n: " the user can enter in either case and
      *> when you check the value, you only need to check if the uppercase
      *> values match.
           display "Enter a value: " at 0701
           accept ws-input upper at 0716
           display "You entered: " at 0801 ws-input at 0814


           goback.
       end program accept-example.
