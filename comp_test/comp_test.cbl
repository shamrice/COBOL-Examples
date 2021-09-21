      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-05-15
      * purpose: testing converting comp to display values.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. comp-conversion-test.
       data division.
       file section.
       working-storage section.

       01  ws-comp-val               pic 999 comp.

       01  ws-disp-val               pic 999.

       01  ws-dyn-disp-val           pic zz9.

       01  ws-input                  pic 999.

       procedure division.
       main-procedure.
            move 12 to ws-comp-val
            multiply ws-comp-val by 2 giving ws-comp-val
            display "COMP: " ws-comp-val

            move ws-comp-val to ws-disp-val
            display "DISP:" ws-disp-val

            move ws-comp-val to ws-dyn-disp-val
            display "DYNA:" ws-dyn-disp-val

            display "INPUT: " with no advancing
            accept ws-input

            display "INPUT: " ws-input

            move ws-input to ws-comp-val
            display "COMP: " ws-comp-val

            stop run.
       end program comp-conversion-test.
