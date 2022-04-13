      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-04-13
      * purpose: Simple example of reading full command line args.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. read-cmd-line-args.
       data division.
       file section.

       working-storage section.
       01  ws-cmd-args                  pic x(256).

       01  ws-test-arg-count            pic 9(3) comp.

       procedure division.
       main-procedure.
           display space
           display "Pass arg '--test' for special message".

           accept ws-cmd-args from command-line
           display "Full command line args: " ws-cmd-args

           inspect function lower-case(ws-cmd-args)
               tallying ws-test-arg-count
               for all "--test"

           if ws-test-arg-count > 0 then
               display "You entered the '--test' cmd arg!"
           end-if

           display space

           stop run.
       end program read-cmd-line-args.
