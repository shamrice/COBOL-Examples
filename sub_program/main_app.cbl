      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2020-04-16
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
           display "Enter value for #1: "
           accept ws-item-1

           display "Enter value for #2: "
           accept ws-item-2.

           perform display-message

           display "Calling subroutine by content:"
           call "sub-app" using
               by content ws-item-1,
               by content ws-item-2
           end-call

           perform display-message
           display "Calling subroutine by reference:"
           call "sub-app" using ws-item-1, ws-item-2

           perform display-message

           stop run.

       display-message.
           display "Main app: " ws-group-1.


       end program main-app.
