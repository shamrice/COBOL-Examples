      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2021-04-16
      * Updated: 2022-04-13
      * Purpose: Sub program called by main program.
      * Tectonics: cobc -x main_app.cbl sub.cbl -o a.out
      ******************************************************************
       identification division.
       program-id. sub-app.

       data division.

       file section.

      *> Working storage values persist until a "cancel" call is made
      *> on the sub program.
       working-storage section.
       01  ws-test-item-1                 pic x(10).
       01  ws-test-item-2                 pic x(10).

      *> Local storage values are fresh on each call of the sub program
      *> even if no "cancel" statement is made.
       local-storage section.
       01  ls-test-item-1                 pic x(10).
       01  ls-test-item-2                 pic x(10).

       linkage section.
       01  l-test-item-1                  pic x(10).
       01  l-test-item-2                  pic x(10).

       procedure division using l-test-item-1 l-test-item-2.
       main-procedure.
           display "In sub program: " l-test-item-1 " " l-test-item-2
           display space
           display "working-storage values at start:"
           display "ws-test-item-1: " ws-test-item-1
           display "ws-test-item-2: " ws-test-item-2
           display space
           display "local-storage values at start:"
           display "ls-test-item-1: " ls-test-item-1
           display "ls-test-item-2: " ls-test-item-2
           display space
           display "Moving linkage section values to ws and ls vars.."

           move l-test-item-1 to ws-test-item-1
           move l-test-item-2 to ws-test-item-2
           move l-test-item-1 to ls-test-item-1
           move l-test-item-2 to ls-test-item-2


           display "setting input variables to new value..."
           move "replace1" to l-test-item-1
           move "replace2" to l-test-item-2

           display space
           display "working-storage values at end:"
           display "ws-test-item-1: " ws-test-item-1
           display "ws-test-item-2: " ws-test-item-2
           display space
           display "local-storage values at end:"
           display "ls-test-item-1: " ls-test-item-1
           display "ls-test-item-2: " ls-test-item-2
           display space
           display "Exit sub program: " l-test-item-1 " " l-test-item-2
           goback.

       end program sub-app.
