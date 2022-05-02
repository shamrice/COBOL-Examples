      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-04-18
      * updated: 2022-05-02
      * purpose: Examples of using various forms of the ACCEPT...FROM...
      *
      *          For this example program, I have every accept being stored
      *          in a generic x(50) variable. These can be broken down as
      *          needed on a case by case basis.
      *
      *          Ex FROM DATE could instead use:
      *
      *            accept ws-current-date from date
      *
      *          Variable declaration:
      *
      *            01  ws-current-date.
      *                05  ws-current year      pic 99.
      *                05  ws-current-month     pic 99.
      *                05  ws-current-day       pic 99.
      *
      *
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. accept-from-example.
       data division.
       file section.
       working-storage section.

       01  ws-input                     pic x(50).

       01  ws-num-lines                 usage binary-char unsigned. *>pic x comp-x also works
       01  ws-num-cols                  usage binary-char unsigned.

       01  ws-num-lines-disp            pic 9(3).
       01  ws-num-cols-disp             pic 9(3).

       01  ws-max-args                  pic 9(3) comp.
       01  ws-idx                       pic 9(3) comp.

       procedure division.
       main-procedure.

           display space
           display "ACCEPT... FROM... Example Program"
           display "---------------------------------"
           display "Pass command line parameters to demo that feature"
           display space

      *> FROM COMMAND-LINE returns the command line argument string in full.
           accept ws-input from command-line
           display "accept from command-line: " ws-input

      *> FROM ARGUMENT-NUMBER returns the number of command line arguments
      *> passed to the program.
           accept ws-input from argument-number
           display "accept from argument-number: " ws-input

      *> Here is a quick demo iterating through any command lines arguments
      *> and displaying them one by one.
           if ws-input > 0 then
               move ws-input to ws-max-args

               perform varying ws-idx
               from 1 by 1 until ws-idx > ws-max-args

      *> DISPLAY {VALUE} UPON ARGUMENT-NUMBER sets the current index of
      *> the command line argument to return when calling
      *> ACCEPT ... FROM ARGUMENT-VALUE
                   display ws-idx upon argument-number
                   accept ws-input from argument-value
                   display "accept from argument-value: " ws-input
               end-perform
           end-if


      *> FROM ENVIRONMENT returns the value of the environment variable
      *> passed. (If exists). This first call should return nothing.
           display "Before environment setting set:"
           accept ws-input from environment "COB_TEST_ENV_KEY"
           display "accept from environment: " ws-input


      *> FROM EXCEPTION STATUS returns the latest exception status value.
      *> Due to calling the above on an environment variable that is not
      *> yet set, this will be set to 1537 or 0x0601 (EC-IMP-ACCEPT)
           accept ws-input from exception status
           display "accept from exception status: " ws-input

      *> SET ENVIRONMENT sets the environment variable to the value
      *> supplied.
           set environment "COB_TEST_ENV_KEY" to "NOW SET!"


      *> Now that the environment value is set, this will return
      *> "NOW SET!" when called.
           display "After environment setting set:"
           accept ws-input from environment "COB_TEST_ENV_KEY"
           display "accept from environment: " ws-input


      *> FROM DATE returns current date in YYMMDD format. Note that this
      *> can cause calculation issues on year if you're not careful
      *> as there no century included in the year value.
           accept ws-input from date
           display "accept from date: " ws-input

      *> FROM DATE YYYYMMDD fixes the above issue and returns a four digit
      *> value for the year.
           accept ws-input from date yyyymmdd
           display "accept from date yyyymmdd: " ws-input

      *> FROM DAY returns the date in the format YYDDD where DDD is a
      *> three digit representation of the day of the year. The year is
      *> only returned in two digits so it has similar issues as
      *> "FROM DATE".
           accept ws-input from day
           display "accept from day: " ws-input

      *> FROM DAY YYYYDDD is the same as above but includes a four digit
      *> year in the returned value.
           accept ws-input from day yyyyddd
           display "accept from day yyyyddd: " ws-input

      *> FROM TIME returns the current time in the format: hhmmssnn
           accept ws-input from time
           display "accept from time: " ws-input

      *> FROM DAY-OF-WEEK returns the day of the week 1-7 starting on
      *> Monday (1) and ending on Sunday (7).
           accept ws-input from day-of-week
           display "accept from day-of-week: " ws-input

      *> FROM USER NAME returns the current user name logged in running
      *> the application (if available)
           accept ws-input from user name
           display "accept from user name: " ws-input

      *> FROM CONSOLE is the default if not specified. Reads user input
      *> from the console.
           display "Enter value: " with no advancing
           accept ws-input from console
           display "accept from console: " ws-input

      *> After this point, the final ACCEPTs require screen mode so
      *> the screen will blank and text positions must be provied.
           display "Press enter to enter screen mode."
           accept omitted


      *> Returns the current number of lines of the current screen
           accept ws-input from lines
           display "accept from lines: " at 0201 ws-input at 0220

      *> Returns the current number of columns of the current screen.
           accept ws-input from columns
           display "accept from columns: " at 0301 ws-input at 0322

      *> Example of using the CBL_GET_SCR_SIZE" system call to do the
      *> same as above. Note: return values must be converted to numeric
      *> in order to be displayed. Alphanumeric seems to truncate the
      *> value to two digits regardless of variable length.
           display "Using CBL_GET_SCR_SIZE instead: " at 0401
           call "CBL_GET_SCR_SIZE" using ws-num-lines ws-num-cols
           move ws-num-lines to ws-num-lines-disp
           display "Num lines: " at 0501 ws-num-lines-disp at 0514
           move ws-num-cols to ws-num-cols-disp
           display "Num cols: " at 0601 ws-num-cols-disp at 0614

           goback.
       end program accept-from-example.
