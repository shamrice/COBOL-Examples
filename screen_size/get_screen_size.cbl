      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-07
      * updated: 2022-05-02
      * purpose: Example on getting the row and column count of the
      * current terminal.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. screen-size-test.

       environment division.

       configuration section.
       repository.
           function all intrinsic.

       data division.
       file section.

       working-storage section.

       01  ws-scr-lines         usage binary-char unsigned.
       01  ws-scr-cols          usage binary-char unsigned.

       01  ws-scr-lines-disp    pic zz9.
       01  ws-scr-cols-disp     pic zz9.


       procedure division.

       main-procedure.

      *> Both methods of getting the screen size enter the program in to
      *> "COB SCREEN MODE" which requires either the use of a screen
      *> section or the location of the display statements specified.

           display space blank screen

      *> Example of using ACCEPT .. FROM.. to get the lines and column
      *> size of the current display.
           display "Using 'ACCEPT ... FROM LINES' and 'ACCEPT ... FROM "
               & "COLUMNS' to get screen size:" at 0101

           perform 3 times

               accept ws-scr-lines-disp from lines
               accept ws-scr-cols-disp from cols

               perform display-screens-size

           end-perform

      *> Same example as above but using the CBL_GET_SCR_SIZE call. This
      *> works the same but gets both values in one call instead of
      *> two separate ones. Note that the line and column
      *> sizes returned must be converted to display data before they
      *> can be viewed.
           display space blank screen
           display "Using 'CBL_GET_SCR_SIZE' to get screen size:"

           perform 3 times

               call "CBL_GET_SCR_SIZE" using ws-scr-lines ws-scr-cols

               move ws-scr-lines to ws-scr-lines-disp
               move ws-scr-cols to ws-scr-cols-disp

               perform display-screens-size

           end-perform

           display "Done." at 0901

           stop run.


       display-screens-size.
           display "-------------------------------------------------"
               & "------------" at 0201
           display "Current screen size: " at 0301
           display concat("Columns: " ws-scr-cols-disp) at 0401
           display concat("  Lines: " ws-scr-lines-disp) at 0501
           display "Resize and press enter to continue" at 0701
           accept omitted
           exit paragraph.


       end program screen-size-test.
