      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-08-30
      * purpose: Example using the search syntax.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. search-example.
       data division.
       file section.
       working-storage section.

      *>   Table must have asc or desc indexed key for binary searching
       01  ws-item-table                occurs 3 times
                                        ascending key is
                                        ws-item-id-1, ws-item-id-2
                                        descending key is
                                        ws-item-id-3
                                        indexed by idx.
           05  ws-item-id-1             pic 9(4).
           05  ws-item-id-2             pic 9(4).
           05  ws-item-id-3             pic 9(4).
           05  ws-item-name             pic x(16).
           05  ws-item-date.
               10  ws-item-year         pic 9(4).
               10  filler               pic x value "/".
               10  ws-item-month        pic 99.
               10  filler               pic x value "/".
               10  ws-item-day          pic 99.

       01  ws-accept-id-1               pic 9(4).
       01  ws-accept-id-2               pic 9(4).
       01  ws-accept-id-3               pic 9(4).

       procedure division.
       main-procedure.
           perform setup-test-data


           display "Enter id-1 to search for: " with no advancing
           accept ws-accept-id-1

      *>   Binary search - table must be indexed by an asc or desc id
      *>   and sorted for search to work. MUCH faster than sequential
      *>   search which does not require any sorting or indexing.
      *>   Binary search is indicated by the "SEARCH ALL" syntax.
           search all ws-item-table
               at end
                   display "Item not found."
               when ws-item-id-1(idx) = ws-accept-id-1
                   perform display-found-item
           end-search


           display "Searching again with all required ids matching."

           display "Enter id-1 to search for: " with no advancing
           accept ws-accept-id-1

           display "Enter id-2 to search for: " with no advancing
           accept ws-accept-id-2

           display "Enter id-3 to search for: " with no advancing
           accept ws-accept-id-3

           search all ws-item-table
               at end
                   display "Item not found."
               when ws-item-id-1(idx) = ws-accept-id-1 and
                   ws-item-id-2(idx) = ws-accept-id-2 and
                   ws-item-id-3(idx) = ws-accept-id-3
                   perform display-found-item
           end-search


           stop run.

       display-found-item.
           display " Record found:"
           display "----------------"
           display "Item id-1: " ws-item-id-1(idx)
           display "Item id-2: " ws-item-id-2(idx)
           display "Item id-3: " ws-item-id-3(idx)
           display "Item Name: " ws-item-name(idx)
           display "Item Date: " ws-item-date(idx)

           exit paragraph.


       setup-test-data.

           move 0001 to ws-item-id-1(1)
           move 0101 to ws-item-id-2(1)
           move 0500 to ws-item-id-3(1)
           move "test item 1" to ws-item-name(1)
           move "2021/01/01" to ws-item-date(1)

           move 0002 to ws-item-id-1(2)
           move 0102 to ws-item-id-2(2)
           move 0499 to ws-item-id-3(2)
           move "test item 2" to ws-item-name(2)
           move "2021/02/02" to ws-item-date(2)

           move 0003 to ws-item-id-1(3)
           move 0103 to ws-item-id-2(3)
           move 0498 to ws-item-id-3(3)
           move "test item 3" to ws-item-name(3)
           move "2021/03/03" to ws-item-date(3)


           exit paragraph.

       end program search-example.
