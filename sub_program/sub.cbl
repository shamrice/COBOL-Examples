      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2021-04-16
      * Purpose: Sub program called by main program.
      * Tectonics: cobc -x main_app.cbl sub.cbl -o a.out
      ******************************************************************
       identification division.
       program-id. sub-app.

       data division.

       file section.
       working-storage section.

       linkage section.
           01 ls-test-item-1               pic x(10).
           01 ls-test-item-2               pic x(10).

       procedure division using ls-test-item-1, ls-test-item-2.
       main-procedure.
           display "In sub program: " ls-test-item-1 " " ls-test-item-2

           display "setting variables to new value..."
           move "replace1" to ls-test-item-1
           move "replace2" to ls-test-item-2

           display "In sub program: " ls-test-item-1 " " ls-test-item-2
           goback.

       end program sub-app.
