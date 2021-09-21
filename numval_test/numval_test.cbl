      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-05
      * purpose: Converting PIC X to PIC 9 using numval function.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. numval-test.
       data division.
       file section.

       working-storage section.

       01  ws-x-val               pic x(10).
       01  ws-9-val               pic 9(10).

       01  ws-total               comp-2.

       procedure division.
       main-procedure.

           display "Enter first number: " with no advancing
           accept ws-x-val

           display "Enter second number: " with no advancing
           accept ws-9-val

           compute ws-total = function numval(ws-x-val) + ws-9-val

           display "Total: " ws-total

           stop run.

       end program numval-test.
