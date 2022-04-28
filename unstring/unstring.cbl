      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-07-22
      * updated: 2022-04-28
      * purpose: Unstring field into another field examples.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. unstring-example.
       data division.
       file section.
       working-storage section.

       01  ws-source-str                  pic x(30).

       01  ws-dest-str.
           05  ws-part-1                  pic x(15).
           05  ws-part-2                  pic x(15).


       01  ws-delimiter                   pic x value '|'.

       01  ws-single-stats.
           05  ws-single-fields-filled    pic 99.
           05  ws-single-dest-info.
               10  ws-single-dest-str     pic x(5).
               10  ws-single-delimiter    pic x.
               10  ws-single-char-count   pic 9.

       01  ws-multi-stats.
           05  ws-multi-fields-filled     pic 99.
           05  ws-multi-dest-info         occurs 6 times
                                          indexed by ws-multi-idx.
               10  ws-multi-dest-str      pic x(5).
               10  ws-multi-delimiter     pic x.
               10  ws-multi-char-count    pic 9.

       01  ws-pointer                     pic 9(5) comp.

       01  ws-source-num                  pic $999,999.99.
       01  ws-dest-num                    pic 999 occurs 3 times.

       procedure division.

       main-procedure.

           move "Hello World" to ws-source-str

      *> EXAMPLE 1:
      *> This is a simple example of unstringing a value into other
      *> variables
           display spaces
           display "================================================="
           display "EX 1 : SIMPLE UNSTRING"
           display space
           display "SOURCE STRING: " ws-source-str

           unstring ws-source-str
               delimited by space
               into ws-part-1 ws-part-2
           end-unstring

           display "PART1: " ws-part-1
           display "PART2: " ws-part-2


      *> EXAMPLE 2:
      *> This is an example of unstringing a variable into another using
      *> space as the delimter. The pointer is a running current string
      *> position variable. At the start, it's set to one (start of string)
      *> and then auto incremented by the unstring command each time it
      *> is called. It's value is the position in the source string where
      *> it "left off".
           move 1 to ws-pointer

           display spaces
           display "================================================="
           display "EX 2 : UNSTRING MULTIPLE TIMES INTO SAME DEST."

      *> Overflow first time because pointer is not past end of source data
      *> indicating that there was more source string to unstring that did
      *> not fit in the destination ("into") variables.
      *>
      *> In example 3, we see that if UNSTRING is able to split the source
      *> string into the destiniation variables, there is no overflow.

           display space
           display "SOURCE STRING: " ws-source-str

           perform 2 times
               unstring ws-source-str delimited by all spaces
                   into ws-part-1
                   with pointer ws-pointer
                   on overflow
                       display "ERROR: OVERFLOW"
                   not on overflow
                       display "Successfully unstrung."
               end-unstring

               display "PART VALUE: " ws-part-1
               display "POINTER: " ws-pointer
           end-perform


      *> EXAMPLE 3:
      *> This is similar to example 1 but only requires one call to
      *> unstring the whole source string due to there being enough
      *> destination (into) variables supplied. The pointer isn't used
      *> but is added to show that it's position is at the end of the
      *> source string length after the unstring is performed.
           display spaces
           display "================================================="
           display "EX 3 : UNSTRING INTO EXPLICIT FIELDS"

           move 1 to ws-pointer
      *> No overflow because pointer is past end of source data length
      *> by the end of the command scope.

           display space
           display "SOURCE STRING: " ws-source-str

           unstring ws-source-str delimited by all spaces
               into ws-part-1 ws-part-2
               with pointer ws-pointer
               on overflow
                   display "ERROR: OVERFLOW"
               not on overflow
                   display "Successfully unstrung."
           end-unstring

           display "PART1: " ws-part-1
           display "PART2: " ws-part-2
           display "POINTER: " ws-pointer


      *> EXAMPLE 4:
      *> This example uses a loop to unstring the source string into
      *> a single variable. There are multiple delimiters specified that
      *> split the string up. There are also some statistics/useful
      *> info added by adding delmiter in, count in, and tallying in
      *> keywords.
           display spaces
           display "================================================="
           display "EX 4 : UNSTRING WITH MULTIPLE DELIMITERS "

           move 1 to ws-pointer

           move "A<B<CD>E%FG!HIJ|KL!MN>OP#QR!ST" to ws-source-str

           display space
           display "SOURCE STRING: " ws-source-str

           perform until ws-pointer > function length(ws-source-str)

               unstring ws-source-str
                   delimited by all "<" or ">" or "!" or ws-delimiter
                   into
                       ws-single-dest-str
                           delimiter in ws-single-delimiter
                           count in ws-single-char-count
                   with pointer ws-pointer
                   tallying in ws-single-fields-filled
               end-unstring

               display space
               display "VALUE: " ws-single-dest-str
               display "DELIMITER: " ws-single-delimiter
               display "CHAR COUNT:" ws-single-char-count
               display "CURRENT POINTER: " ws-pointer
               display "TOTAL FIELDS FILLED: " ws-single-fields-filled
               display "-------------------------------------------"
           end-perform

      *> EXAMPLE 5:
      *> This example is similar to example 4 except that the source
      *> string is unstrung with multiple delimiters into multiple
      *> destination strings.
           display spaces
           display "================================================="
           display "EX 5 : UNSTRING WITH MULTIPLE DELIMITERS " &
               "INTO MULTIPLE DESTINATIONS"

           move "A<B<CD>EFG!HIJ|KLMN>O" to ws-source-str

           display space
           display "SOURCE STRING: " ws-source-str

           unstring ws-source-str
               delimited by
                   all "<"
                   or all ">"
                   or "!"
                   or ws-delimiter
               into
                   ws-multi-dest-str(1)
                       delimiter in ws-multi-delimiter(1)
                       count in ws-multi-char-count(1)
                   ws-multi-dest-str(2)
                       delimiter in ws-multi-delimiter(2)
                       count in ws-multi-char-count(2)
                   ws-multi-dest-str(3)
                       delimiter in ws-multi-delimiter(3)
                       count in ws-multi-char-count(3)
                   ws-multi-dest-str(4)
                       delimiter in ws-multi-delimiter(4)
                       count in ws-multi-char-count(4)
                   ws-multi-dest-str(5)
                       delimiter in ws-multi-delimiter(5)
                       count in ws-multi-char-count(5)
                   ws-multi-dest-str(6)
                       delimiter in ws-multi-delimiter(6)
                       count in ws-multi-char-count(6)
               tallying in ws-multi-fields-filled
           end-unstring

           perform varying ws-multi-idx
           from 1 by 1 until ws-multi-idx > 6
               display space
               display "STRING NUMBER: " ws-multi-idx
               display "VALUE: " ws-multi-dest-str(ws-multi-idx)
               display "DELIMITER: " ws-multi-delimiter(ws-multi-idx)
               display "CHAR COUNT:" ws-multi-char-count(ws-multi-idx)
               display "-------------------------------------------"
           end-perform

           display "TOTALS: "
           display "FIELDS FILLED: " ws-multi-fields-filled



      *> EXAMPLE 6:
      *> This examples using UNSTRING to get parts of a formatted
      *> number. It's probably not the best example but gives an
      *> idea.
           display spaces
           display "================================================="
           display "EX 6 : UNSTRING FORMATTED NUMBER"
           display space

           move 123456.12 to ws-source-num
           display "SOURCE VALUE: " ws-source-num

           unstring ws-source-num(2:) *> start at 2 to not include '$'
               delimited by ',' or '.'
               into ws-dest-num(1)
                   ws-dest-num(2)
                   ws-dest-num(3)
           end-unstring

           display "PART 1: " ws-dest-num(1)
           display "PART 2: " ws-dest-num(2)
           display "PART 3: " ws-dest-num(3)
           display space

           goback.

       end program unstring-example.
