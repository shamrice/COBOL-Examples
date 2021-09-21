      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-05
      * purpose: intrinsic trim function example.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. trim-function-test.

       data division.
       file section.

       working-storage section.

       01  ws-test-string      pic x(30) value "    hello world   ".

       procedure division.
       main-procedure.
           display ws-test-string "2"
           display function trim(ws-test-string) "2"

           stop run.

       end program trim-function-test.
