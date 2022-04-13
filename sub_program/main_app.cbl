      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2020-04-16
      * Updated: 2022-04-13
      * Purpose: Main application calls sub-app by content and reference
      * Tectonics: cobc -x main_app.cbl sub.cbl -o a.out
      ******************************************************************
       identification division.
       program-id. main-app.

       data division.

       file section.

       working-storage section.

       01 ws-group-1.
           05 ws-item-1                        pic x(10).
           05 ws-item-2                        pic x(10).

       procedure division.
       main-procedure.
           display space
           display "Enter value for #1: " with no advancing
           accept ws-item-1

           display "Enter value for #2: " with no advancing
           accept ws-item-2.

           perform display-message

      *> Calling by content, the variables passed will not be modified
      *> upon return to the main application.
           display "Calling sub program by content:"
           call "sub-app" using
               by content ws-item-1
               by content ws-item-2
           end-call
           perform display-message

      *> Calling by reference (default) the variables can be modified by
      *> the called sub program. Note that the working-storage variables
      *> of the sub program retain their values between calls where the
      *> linkage section variables do not.
           display "Second call of sub program should retain WS values."
           display "Calling sub program by reference:"
           call "sub-app" using
               ws-item-1 ws-item-2
           end-call
           perform display-message

      *> Cancelling the sub program will reset all variables in the
      *> working storage section back to their original values.
           display "Cancelling sub program"
           cancel "sub-app"
           display "Calling sub program. WS values should be reset:"
           call "sub-app" using
               ws-item-1 ws-item-2
           end-call
           perform display-message


           stop run.

       display-message.
           display space
           display "-----------------------------------------------"
           display "Main app: " ws-group-1
           exit paragraph.


       end program main-app.
