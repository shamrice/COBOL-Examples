      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-02-09
      * purpose: Shows using secure in accept statement to hide text
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. accept-secure.
       data division.
       file section.
       working-storage section.

       01  ws-password                     pic x(16).

       procedure division.
       main-procedure.
           display "Enter password: " at 0101
           accept ws-password secure  at 0117
           display "You entered: " at 0204 ws-password at 0217
           goback.
       end program accept-secure.
