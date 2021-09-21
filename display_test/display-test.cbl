      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-08-26
      * purpose: Testing different display statement options.
      * tectonics: cobc
      ******************************************************************
           identification division.
           program-id. display-test.

           procedure division.

           main-procedure.
               display "hello world" at 0505
               display "hello world" line 06 column 05
               display "hello world"
                   line 07 column 05
                   with blank line
               end-display
               display "hello world"
                   line 08 column 05
                   with erase eol
               end-display

               display "hello world"
                   line 09 column 05
                   with bell
               end-display

               display "hello world"
                   background-color 03
                   foreground-color 06
                   at 1005
               end-display
               goback.

           end program display-test.
