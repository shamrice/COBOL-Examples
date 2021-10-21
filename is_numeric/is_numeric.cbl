      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-10-21
      * purpose: Example using "is numeric"
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. is-numeric-test.
       data division.
       file section.
       working-storage section.

       01  ws-user-input                    pic x(10).
       01  ws-user-input-justified          pic x(10) justified right.


       procedure division.
       main-procedure.
           perform process-plain
           perform process-zero-fill
           perform process-trim
           stop run.


       process-plain.
      *> If alphanumeric value entered has spaces, even if the user entered
      *> just digits, it will not pass the "is numeric" test. (Even if
      *> spaces are only trailing.)
           display "(plain) Enter a value: " with no advancing
           accept ws-user-input

           if ws-user-input is numeric then
               display ws-user-input " is numeric!"
           else
               display ws-user-input " is not numeric."
           end-if

           exit paragraph.



       process-zero-fill.
      *> Right justifying and then filling the spaces with zeros followed
      *> by testing for numeric does work.
           display
               "(right justify, zero fill) Enter another value: "
               with no advancing
           end-display
           accept ws-user-input-justified

           inspect ws-user-input-justified
               replacing leading spaces by '0'

           if ws-user-input-justified is numeric then
               display ws-user-input-justified " is numeric!"
           else
               display ws-user-input-justified " is not numeric."
           end-if

           exit paragraph.



       process-trim.
      *> Using the intrinsic "TRIM" function to remove any spaces in the
      *> input also will pass the "is numeric" test if trimmed data is all
      *> contiguous digits.
           display "(trim) Enter a third value: " with no advancing
           accept ws-user-input

           if function trim(ws-user-input) is numeric then
               display function trim(ws-user-input) " is numeric!"
           else
               display function trim(ws-user-input) " is not numeric."
           end-if

           exit paragraph.

       end program is-numeric-test.
