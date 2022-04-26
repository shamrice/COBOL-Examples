      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-05
      * updated: 2022-04-26
      * purpose: intrinsic trim function example.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. trim-function-test.

       data division.
       file section.

       working-storage section.

       01  ws-test-string-1    pic x(30) value "    hello world       ".

       01  ws-test-string-2    pic x(30).

       procedure division.
       main-procedure.
           display "--" ws-test-string-1 "--"
           display "--" function trim(ws-test-string-1) "--"
           display "--" function trim(ws-test-string-1 leading) "--"
           display "--" function trim(ws-test-string-1 trailing) "--"

           move "******************************" to ws-test-string-2
           display ws-test-string-2
           move ws-test-string-1 to ws-test-string-2
           display ws-test-string-2

           move "******************************" to ws-test-string-2
           display ws-test-string-2
           move function trim(ws-test-string-1) to ws-test-string-2
           display ws-test-string-2

           move "******************************" to ws-test-string-2
           display ws-test-string-2
           move function trim(ws-test-string-1 leading)
               to ws-test-string-2
           display ws-test-string-2

           move "******************************" to ws-test-string-2
           display ws-test-string-2
           move function trim(ws-test-string-1 trailing)
               to ws-test-string-2
           display ws-test-string-2


           display "--" "    String literal    " "--"
           display "--" function trim("   String literal    ") "--"
           display
               "--" function trim("     String literal   " leading) "--"
           end-display
           display
               "--" function trim("   String literal    " trailing) "--"
           end-display


           stop run.

       end program trim-function-test.
