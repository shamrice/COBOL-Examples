      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-02-02
      * purpose: Reading command line args into variable one by one.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. cmd-args-example.

       data division.
       working-storage section.
       01  ws-cmd-args pic x(99).
       01  ws-counter comp-1.
       01  ws-num-args comp-1.

       procedure division.
      *> Get total number of cmd args.
           accept ws-num-args from argument-number

      *> loop through all of them.
           perform varying ws-counter
           from 1 by 1 until ws-counter > ws-num-args
               *> set current command ptr to argument number of ws-counter.
               display ws-counter upon argument-number
               *> get value of that command line arguement and move to ws-cmd-args variable.
               accept ws-cmd-args from argument-value

               display ws-cmd-args
           end-perform.

       end program cmd-args-example.
