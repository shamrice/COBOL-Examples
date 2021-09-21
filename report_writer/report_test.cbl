      ******************************************************************
      * Author: Erik Eriksen
      * Date: 2021-01-13
      * Purpose: Report writer test application.
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. report-test.

       environment division.
       input-output section.
       file-control.

           select fd-test-input-file
           assign to "input.txt"
           organization is line sequential.

           select fd-report-file assign to "report.txt".

       DATA DIVISION.
       FILE SECTION.

           fd  fd-test-input-file.
           01  f-test-record.
               05  f-test-student-id                   pic 9(6).
               05  f-test-student-name                 pic x(20).
               05  f-test-major                        pic xxx.
               05  f-test-num-courses                  pic 99.


           fd  fd-report-file
           report is r-test-report.

       WORKING-STORAGE SECTION.

           01  ws-eof-sw                           pic a value 'N'.
               88  ws-eof                          value 'Y'.
               88  ws-not-eof                      value 'N'.

       report section.
           rd  r-test-report
           page limit is 66
           heading is 1
           first detail 6
           last detail 42
           footing 52.

           01  report-header type report heading.
               05  line 1 column 44
                   pic x(21) value "Customer Order Report".

               05  line 2.
                   10  column 100
                       pic x(4) value "PAGE".

                   10  column 105
                       pic zz9 source page-counter.

           01  report-line type detail line plus 1.
               05  column 4  pic 9(6) source f-test-student-id.
               05  column 15 pic x(20) source f-test-student-name.
               05  column 40 pic xxx source f-test-major.
               05  column 46 pic 99 source f-test-num-courses.


       PROCEDURE DIVISION.
       main-procedure.

           display "Starting test report program."

           move 'N' to ws-eof-sw

           open input fd-test-input-file output fd-report-file
               display "Init test report."
               initiate r-test-report

               perform until ws-eof
                   read fd-test-input-file
                       at end set ws-eof to true
                   end-read
                   display "Generate report line."
                   generate report-line

               end-perform

               display "Terminate report."
               terminate r-test-report
           close fd-test-input-file fd-report-file

           display "Done."
           goback.


       populate-input-file.

           open extend fd-test-input-file

      *         move 3345 to ws-student-id
      *         move "Test Name2" to ws-student-name
      *         move "PHY" to ws-major
      *         move 12 to ws-num-courses

      *         move ws-student-record to f-test-record

               write f-test-record
           close fd-test-input-file


           exit paragraph.

       END PROGRAM report-test.
