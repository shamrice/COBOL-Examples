      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-08-29
      * purpose: Testing screen writing speed between the two
      * different display at screen position syntaxes.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. display-timing.

       environment division.
       input-output section.


       data division.

       file section.


       working-storage section.


       01  ws-max-rows                 constant as 20.
       01  ws-max-cols                 constant as 80.
       01  ws-max-times-to-run         constant as 10.

       01  ws-times-to-run             pic 999 comp.

       01  ws-times-to-refresh         pic 999 comp.

       01  ws-start-time.
           05  ws-start-hour           pic 99.
           05  ws-start-min            pic 99.
           05  ws-start-sec            pic 99.
           05  ws-start-milli          pic 99.

       01  ws-start-time-calc.
           05  ws-start-sec-calc       pic 999.
           05  ws-start-milli-calc     pic 999.

       01  ws-end-time.
           05  ws-end-hour             pic 99.
           05  ws-end-min              pic 99.
           05  ws-end-sec              pic 99.
           05  ws-end-milli            pic 99.

       01  ws-end-time-calc.
           05  ws-end-sec-calc         pic 999.
           05  ws-end-milli-calc       pic 999.

       01  ws-time-diff                occurs 0 to 999 times
                                       depending on ws-times-to-run.
           05  ws-diff-hour            pic 99.
           05  ws-diff-min             pic 99.
           05  ws-diff-sec             pic 99.
           05  ws-diff-milli           pic 99.




       01  ws-time-diff-avg.
           05  ws-time-diff-hour-avg   pic 999.
           05  ws-time-diff-min-avg    pic 999.
           05  ws-time-diff-sec-avg    pic 999.
           05  ws-time-diff-milli-avg  pic 999.


       01  ws-time-diff-avg-disp.
           05  ws-time-diff-sec-avg-disp   pic 99.
           05  filler                      pic x value '.'.
           05  ws-time-diff-milli-avg-disp pic 99.



       01  ws-screen-position.
           05  ws-row-idx              pic 99.
           05  ws-col-idx              pic 99.

       01  ws-accept                   pic x.

       01  sys-call-val                pic 9(13).

       procedure division.
       main-procedure.

           display "Press enter to start..."
           accept ws-accept
           display spaces with blank screen

           perform varying ws-times-to-run
           from 1 by 1 until ws-times-to-run > ws-max-times-to-run

               accept ws-start-time from time

               perform varying ws-times-to-refresh
               from 1 by 1 until ws-times-to-refresh > 100



                   perform varying ws-row-idx
                   from 1 by 1 until ws-row-idx > ws-max-rows
                       perform varying ws-col-idx
                       from 1 by 1 until ws-col-idx > ws-max-cols

                           display "@" at ws-screen-position

                       end-perform
                   end-perform
               end-perform

               accept ws-end-time from time

               perform compute-and-display-diff


           end-perform


           display spaces with blank screen

           perform compute-and-display-average

           display spaces with blank screen


           perform varying ws-times-to-run
           from 1 by 1 until ws-times-to-run > ws-max-times-to-run

               accept ws-start-time from time

               perform varying ws-times-to-refresh
               from 1 by 1 until ws-times-to-refresh > 100



                   perform varying ws-row-idx
                   from 1 by 1 until ws-row-idx > ws-max-rows
                       perform varying ws-col-idx
                       from 1 by 1 until ws-col-idx > ws-max-cols

                           display "@"
                               line ws-row-idx column ws-col-idx
                           end-display

                       end-perform
                   end-perform
               end-perform

               accept ws-end-time from time

               perform compute-and-display-diff

           end-perform

           display spaces with blank screen

           perform compute-and-display-average

           goback.


       compute-and-display-diff.

           move ws-start-sec to ws-start-sec-calc
           move ws-end-sec to ws-end-sec-calc

           move ws-start-milli to ws-start-milli-calc
           move ws-end-milli to ws-end-milli-calc

           if ws-start-milli-calc > ws-end-milli-calc then
               add 100 to ws-end-milli-calc
               subtract 1 from ws-end-sec-calc
           end-if

           compute ws-diff-milli(ws-times-to-run) =
                   ws-end-milli-calc - ws-start-milli-calc
           end-compute


           if ws-start-sec-calc > ws-end-sec-calc then
               add 60 to ws-end-sec-calc
           end-if


           compute ws-diff-sec(ws-times-to-run) =
                   ws-end-sec-calc - ws-start-sec-calc
           end-compute


           display ws-start-time at 2501
           display ws-end-time at 2601
           display ws-time-diff(ws-times-to-run) at 2701

           exit paragraph.


       compute-and-display-average.
           move zeros to ws-time-diff-avg

           perform varying ws-times-to-run
           from 1 by 1 until ws-times-to-run > ws-max-times-to-run
               display ws-time-diff(ws-times-to-run)
                   line ws-times-to-run column 1
               end-display

               add ws-diff-sec(ws-times-to-run) to ws-time-diff-sec-avg

               add ws-diff-milli(ws-times-to-run)
                   to ws-time-diff-milli-avg
               end-add

           end-perform

           display ws-time-diff-avg at 1201
           compute ws-time-diff-sec-avg =
               ws-time-diff-sec-avg / ws-max-times-to-run
           end-compute

           compute ws-time-diff-milli-avg =
               ws-time-diff-milli-avg / ws-max-times-to-run
           end-compute

           display ws-time-diff-avg at 1301

           move ws-time-diff-sec-avg to ws-time-diff-sec-avg-disp
           move ws-time-diff-milli-avg to ws-time-diff-milli-avg-disp

           display ws-time-diff-avg-disp at 1401


           accept ws-accept

           exit paragraph.

       end program display-timing.
