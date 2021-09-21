      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-07-22
      * purpose: Unstring field into another field with a pointer.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. unstring-test.
       data division.
       file section.
       working-storage section.

       01  ws-source-str    pic x(30).

       01  ws-dest-str.
           05  ws-part-1    pic x(30).
           05  ws-part-2    pic x(30).

       01  ws-pointer       pic 9(5) comp value 1.

       procedure division.

       main-procedure.

           move "Hello World" to ws-source-str

           display "TEST 1 : UNSTRING MULTIPLE TIMES INTO SAME DEST."

      *> OVERFLOW FIRST TIME BECAUSE POINTER IS NOT PAST END OF SRC DATA
           perform 2 times
               unstring ws-source-str delimited by all spaces
                   into ws-part-1
                   with pointer ws-pointer
                   on overflow
                       display "ERROR: OVERFLOW"
                   not on overflow
                       display "Successfully unstrung."
               end-unstring

               display "START: " ws-source-str
               display "PART1: " ws-part-1
               display "PART2: " ws-part-2
               display "POINTER: " ws-pointer
           end-perform


           display spaces
           display "TEST 2 : UNSTRING INTO EXPLICIT FIELDS"

           move 1 to ws-pointer
      *> NO OVERFLOW BECAUSE POINTER MAKES IT PAST END OF SRC DATA IN
      *> COMMAND SCOPE.

           unstring ws-source-str delimited by all spaces
               into ws-part-1, ws-part-2
               with pointer ws-pointer
               on overflow
                   display "ERROR: OVERFLOW"
               not on overflow
                   display "Successfully unstrung."
           end-unstring

           display "START: " ws-source-str
           display "PART1: " ws-part-1
           display "PART2: " ws-part-2
           display "POINTER: " ws-pointer

           goback.

       end program unstring-test.
