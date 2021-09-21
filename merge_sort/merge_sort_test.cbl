      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-19
      * purpose: Testing sort and merge syntax on test data.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. merge-sort-example.

       environment division.
       input-output section.

       file-control.

           select fd-test-file-1 assign to "test-file-1.txt"
           organization is line sequential
           file status is ws-fs-status-1.

           select fd-test-file-2 assign to "test-file-2.txt"
           organization is line sequential
           file status is ws-fs-status-2.

           select fd-sorting-file assign to "work-temp.txt".

           select fd-merged-file assign to "merge-output.txt"
           organization is line sequential
           file status is ws-fs-status-merge.

           select fd-sorted-contract-id
           assign to "sorted-contract-id.txt"
           organization is line sequential
           file status is ws-fs-status-sorted.


       data division.

       file section.

       sd  fd-sorting-file.
       01  f-customer-record-sort.
           05  f-customer-id                       pic 9(5).
           05  f-customer-last-name                pic x(50).
           05  f-customer-first-name               pic x(50).
           05  f-customer-contract-id              pic 9(5).
           05  f-customer-comment                  pic x(25).

       fd  fd-test-file-1 recording mode F.
       01  f-customer-record-east.
           05  f-customer-id                       pic 9(5).
           05  f-customer-last-name                pic x(50).
           05  f-customer-first-name               pic x(50).
           05  f-customer-contract-id              pic 9(5).
           05  f-customer-comment                  pic x(25).

       fd  fd-test-file-2 recording mode F.
       01  f-customer-record-west.
           05  f-customer-id                       pic 9(5).
           05  f-customer-last-name                pic x(50).
           05  f-customer-first-name               pic x(50).
           05  f-customer-contract-id              pic 9(5).
           05  f-customer-comment                  pic x(25).

       fd  fd-merged-file recording mode F.
       01  f-customer-record-merged.
           05  f-customer-id                       pic 9(5).
           05  f-customer-last-name                pic x(50).
           05  f-customer-first-name               pic x(50).
           05  f-customer-contract-id              pic 9(5).
           05  f-customer-comment                  pic x(25).

       fd  fd-sorted-contract-id recording mode F.
       01  f-customer-record-sorted-contract-id.
           05  f-customer-id                       pic 9(5).
           05  f-customer-last-name                pic x(50).
           05  f-customer-first-name               pic x(50).
           05  f-customer-contract-id              pic 9(5).
           05  f-customer-comment                  pic x(25).

       working-storage section.

       01  ws-fs-status-1                          pic xx.
       01  ws-fs-status-2                          pic xx.
       01  ws-fs-status-merge                      pic xx.
       01  ws-fs-status-sorted                     pic xx.

       01  ws-eof-sw                               pic x value 'N'.
           88  ws-eof                              value 'Y'.
           88  ws-not-eof                          value 'N'.

       procedure division.
       main-procedure.
           perform create-test-data

           perform merge-and-display-files

           perform sort-and-display-file

           display "Done."

           stop run.


       merge-and-display-files.

           display "Merging and sorting files..."

           merge fd-sorting-file
               on ascending key f-customer-id
               of f-customer-record-merged
               using fd-test-file-1 fd-test-file-2 giving fd-merged-file

           open input fd-merged-file

               if ws-fs-status-merge not = "00" then
                   display "Error opening merged output file: "
                       ws-fs-status-merge
                   end-display
                   stop run
               end-if

               set ws-not-eof to true

               perform until ws-eof
                   read fd-merged-file
                       at end
                           set ws-eof to true
                       not at end
                           display f-customer-record-merged
                   end-read
               end-perform

           close fd-merged-file

           exit paragraph.



       sort-and-display-file.

           display "Sorting merged file on descending contract id...."

           sort fd-sorting-file
               on descending key f-customer-contract-id
               of f-customer-record-sorted-contract-id
               using fd-merged-file giving fd-sorted-contract-id

           open input fd-sorted-contract-id

               if ws-fs-status-sorted not = "00" then
                   display "Error opening sorted output file: "
                       ws-fs-status-sorted
                   end-display
                   stop run
               end-if

               set ws-not-eof to true

               perform until ws-eof
                   read fd-sorted-contract-id
                       at end
                           set ws-eof to true
                       not at end
                           display f-customer-record-sorted-contract-id
                   end-read
               end-perform

           close fd-sorted-contract-id

           exit paragraph.



       create-test-data.

           display "Creating test data files..."

           open output fd-test-file-1
               if ws-fs-status-1 not = "00" then
                   display "Failed to open file for output: "
                       ws-fs-status-1
                   end-display
                   stop run
               end-if

               move 1 to f-customer-id of f-customer-record-east
               move "last-1" to f-customer-last-name
                   of f-customer-record-east
               move "first-1" to f-customer-first-name
                   of f-customer-record-east
               move 5423 to f-customer-contract-id
                   of f-customer-record-east
               move "comment-1" to f-customer-comment
                   of f-customer-record-east

               write f-customer-record-east


               move 5 to f-customer-id of f-customer-record-east
               move "last-5" to f-customer-last-name
                   of f-customer-record-east
               move "first-5" to f-customer-first-name
                   of f-customer-record-east
               move 12323 to f-customer-contract-id
                   of f-customer-record-east
               move "comment-5" to f-customer-comment
                   of f-customer-record-east

               write f-customer-record-east


               move 10 to f-customer-id of f-customer-record-east
               move "last-10" to f-customer-last-name
                   of f-customer-record-east
               move "first-10" to f-customer-first-name
                   of f-customer-record-east
               move 653 to f-customer-contract-id
                   of f-customer-record-east
               move "comment-10" to f-customer-comment
                   of f-customer-record-east

               write f-customer-record-east


               move 50 to f-customer-id of f-customer-record-east
               move "last-50" to f-customer-last-name
                   of f-customer-record-east
               move "first-50" to f-customer-first-name
                   of f-customer-record-east
               move 5050 to f-customer-contract-id
                   of f-customer-record-east
               move "comment-50" to f-customer-comment
                   of f-customer-record-east

               write f-customer-record-east

               move 25 to f-customer-id of f-customer-record-east
               move "last-25" to f-customer-last-name
                   of f-customer-record-east
               move "first-25" to f-customer-first-name
                   of f-customer-record-east
               move 7725 to f-customer-contract-id
                   of f-customer-record-east
               move "comment-25" to f-customer-comment
                   of f-customer-record-east

               write f-customer-record-east


               move 75 to f-customer-id of f-customer-record-east
               move "last-75" to f-customer-last-name
                   of f-customer-record-east
               move "first-75" to f-customer-first-name
                   of f-customer-record-east
               move 1175 to f-customer-contract-id
                   of f-customer-record-east
               move "comment-75" to f-customer-comment
                   of f-customer-record-east

               write f-customer-record-east
           close fd-test-file-1



           open output fd-test-file-2
               if ws-fs-status-2 not = "00" then
                   display "Failed to open file for output: "
                       ws-fs-status-2
                   end-display
                   stop run
               end-if

               move 999 to f-customer-id of f-customer-record-west
               move "last-999" to f-customer-last-name
                   of f-customer-record-west
               move "first-999" to f-customer-first-name
                   of f-customer-record-west
               move 1610 to f-customer-contract-id
                   of f-customer-record-west
               move "comment-99" to f-customer-comment
                   of f-customer-record-west

               write f-customer-record-west


               move 3 to f-customer-id of f-customer-record-west
               move "last-03" to f-customer-last-name
                   of f-customer-record-west
               move "first-03" to f-customer-first-name
                   of f-customer-record-west
               move 3331 to f-customer-contract-id
                   of f-customer-record-west
               move "comment-03" to f-customer-comment
                   of f-customer-record-west

               write f-customer-record-west

               move 30 to f-customer-id of f-customer-record-west
               move "last-30" to f-customer-last-name
                   of f-customer-record-west
               move "first-30" to f-customer-first-name
                   of f-customer-record-west
               move 8765 to f-customer-contract-id
                   of f-customer-record-west
               move "comment-30" to f-customer-comment
                   of f-customer-record-west

               write f-customer-record-west


               move 85 to f-customer-id of f-customer-record-west
               move "last-85" to f-customer-last-name
                   of f-customer-record-west
               move "first-85" to f-customer-first-name
                   of f-customer-record-west
               move 4567 to f-customer-contract-id
                   of f-customer-record-west
               move "comment-85" to f-customer-comment
                   of f-customer-record-west

               write f-customer-record-west


               move 24 to f-customer-id of f-customer-record-west
               move "last-24" to f-customer-last-name
                   of f-customer-record-west
               move "first-24" to f-customer-first-name
                   of f-customer-record-west
               move 247 to f-customer-contract-id
                   of f-customer-record-west
               move "comment-24" to f-customer-comment
                   of f-customer-record-west

               write f-customer-record-west

           close fd-test-file-2


           exit paragraph.

       end program merge-sort-example.
