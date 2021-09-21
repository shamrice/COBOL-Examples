      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-07
      * purpose: Example on getting the row and column count of the
      * current terminal.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. screen-size-test.
       data division.
       file section.

       working-storage section.

       01  ws-scr-lines         usage binary-char unsigned.
       01  ws-scr-cols          usage binary-char unsigned.

       01  ws-scr-lines-disp    pic 999.
       01  ws-scr-cols-disp     pic 999.



       procedure division.

       main-procedure.

           display space blank screen

           perform display-current-screen-size 3 times

           display "Done." at 0901

           stop run.


       display-current-screen-size.

           call "CBL_GET_SCR_SIZE" using ws-scr-lines, ws-scr-cols

           move ws-scr-lines to ws-scr-lines-disp
           move ws-scr-cols to ws-scr-cols-disp

           display spaces at 0101
           display "Current screen size: " at 0201
           display function concatenate(
               "  lines: ", ws-scr-lines-disp)
               at 0301
           end-display
           display function concatenate("columns: ",
               ws-scr-cols-disp)
               at 0401
           end-display
           display spaces  at 0501

           display "Resize and press enter to continue" at 0701
           accept omitted


           exit paragraph.

       end program screen-size-test.
