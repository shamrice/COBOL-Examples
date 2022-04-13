      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-04-13
      * purpose: A simple paint program to demo the mouse functionality.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. mouse-example.

       environment division.

       configuration section.

       special-names.
           cursor is ws-cursor-position
           crt status is ws-crt-status.

       data division.
       file section.

       working-storage section.

       copy screenio.

       01  ws-cursor-position.
           05  ws-cursor-line                  pic 99.
           05  ws-cursor-col                   pic 99.

       01  ws-kb-input                         pic x.

       01  ws-crt-status.
           05  ws-crt-key-1                    pic xx.
           05  ws-crt-key-2                    pic xx.

       01  ws-mouse-flags                      pic 9(4).

       01  ws-mouse-clicked-sw                 pic a value 'N'.
           88  ws-mouse-clicked                value 'Y'.
           88  ws-mouse-not-clicked            value 'N'.

       01  ws-exit-sw                          pic a value 'N'.
           88  ws-exit                         value 'Y'.
           88  ws-not-exit                     value 'N'.

       01  ws-draw-color                       pic 9.

       procedure division.
           set environment "COB_SCREEN_EXCEPTIONS" to 'Y'.
           set environment "COB_SCREEN_ESC" to 'Y'.
           set environment "COB_EXIT_WAIT" to 'N'.
           set environment "COB_TIMEOUT_SCALE" to '3'.

           compute ws-mouse-flags = COB-AUTO-MOUSE-HANDLING
               + COB-ALLOW-LEFT-DOWN
               + COB-ALLOW-LEFT-UP
               + COB-ALLOW-MOUSE-MOVE
           end-compute.

           set environment "COB_MOUSE_FLAGS" to ws-mouse-flags.

       main-procedure.

           move 1 to ws-draw-color

           display "Current Draw color:" at 1901
           display
               "Esc to exit. Number keys to change cursor draw color" &
               ". Left mouse down to draw current color."
               foreground-color cob-color-white highlight
               background-color cob-color-blue
               at 2001
           end-display


           perform until ws-exit

               display
                   " "
                   background-color ws-draw-color
                   at 1921
               end-display

               accept ws-kb-input
                   with auto-skip no-echo
                   timeout after 50
                   upper
               end-accept

               if ws-kb-input not = space then

                   if ws-kb-input = 'Q' then
                       stop run
                   end-if

                   if ws-kb-input is numeric then
                       move ws-kb-input to ws-draw-color
                       if ws-draw-color > 7 then
                           move 7 to ws-draw-color
                       end-if
                   end-if
               end-if

               evaluate ws-crt-status

                   when COB-SCR-ESC
                       set ws-exit to true

                   when COB-SCR-LEFT-PRESSED
                       set ws-mouse-clicked to true

                   when COB-SCR-LEFT-RELEASED
                       set ws-mouse-not-clicked to true

               end-evaluate

               if ws-cursor-position not = zeros
               and ws-cursor-line < 19
               and ws-cursor-col <= 80
               and ws-mouse-clicked
               then
                   display
                       " "
                       background-color ws-draw-color
                       at ws-cursor-position
                   end-display
               end-if

           end-perform

           stop run.

       end program mouse-example.
