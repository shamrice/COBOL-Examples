      ******************************************************************
      * author: Erik Eriksen
      * date: 2021-09-08
      * updated: 2022-06-15
      * purpose: Example of using redefines on a field.
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. redefines-test.
       data division.
       file section.

       working-storage section.

       01  ws-num-records                      pic 9 value 3.

       01  ws-customer                       occurs 0 to 99 times
                                             depending on ws-num-records
                                             indexed by ws-customer-idx.
           05  ws-customer-type                pic 9.
               88  ws-customer-type-person     value 1.
               88  ws-customer-type-corp       value 2.
           05  ws-customer-name.
               10  ws-customer-first-name      pic x(10).
               10  ws-customer-last-name       pic x(20).
           05  ws-corp-name redefines ws-customer-name pic x(30).
           05  ws-customer-address.
               10  ws-street-address           pic x(20).
               10  ws-state                    pic xx.
               10  ws-zip-code                 pic 9(5).


       01  ws-diff-data-types               occurs 2 times.
           05  ws-data-type                    pic a.
               88  ws-display-type             value 'D'.
               88  ws-comp-type                value 'C'.
           05  ws-data-disp-value              pic x(10).
           05  ws-data-comp-value           redefines ws-data-disp-value
                                            comp-2.


       procedure division.

       setup-test-data.
           display space
           display "1. Person record with first/last name entered."
           set ws-customer-type-person(1) to true
           move "test-first" to ws-customer-first-name(1)
           move "test-last" to ws-customer-last-name(1)
           move "123 fake st" to ws-street-address(1)
           move "NV" to ws-state(1)
           move 12345 to ws-zip-code(1)

           display "2. Corp record with corp name entered."
           set ws-customer-type-corp(2) to true
           move "no-name corp" to ws-corp-name(2)
           move "567 real st" to ws-street-address(2)
           move "NY" to ws-state(2)
           move 11795 to ws-zip-code(2)

           display "3. Person record with corp name entered."
           set ws-customer-type-person(3) to true
           move "SET CORP VALUE" to ws-corp-name(3)
           move "890 what st" to ws-street-address(3)
           move "MA" to ws-state(3)
           move 09345 to ws-zip-code(3).


       display-customer-data.
           display space
           display "Displaying fake customer data:"
           display "------------------------------"
           display space

           perform varying ws-customer-idx
           from 1 by 1 until ws-customer-idx > ws-num-records

               if ws-customer-type-person(ws-customer-idx) then
                   display "Customer Type: PERSON"
                   display "First Name: "
                       ws-customer-first-name(ws-customer-idx)
                   end-display

                   display "Last Name: "
                       ws-customer-last-name(ws-customer-idx)
                   end-display
               else
                   display "Customer Type: CORP"
                   display "Company name: "
                       ws-corp-name(ws-customer-idx)
                   end-display
               end-if

               display "Address: "
               display ws-street-address(ws-customer-idx)
               display ws-state(ws-customer-idx) ", "
                   ws-zip-code(ws-customer-idx)
               end-display

               display "------------------------------"
               display space
           end-perform.


       setup-second-test-data.
      *> Setting up next set of test data where the redefines changes
      *> the variable type.
           set ws-display-type(1) to true
           move "ABC123" to ws-data-disp-value(1)

           set ws-comp-type(2) to true
           move 12345.63 to ws-data-comp-value(2).


       display-second-test-data.
           display space
           display "Redefines with different variable types:"
           display "----------------------------------------"
           display "Value entered in ws-data-disp-value: ABC123"
           display "ws-data-disp-value x(10): " ws-data-disp-value(1)
           display "ws-data-comp-value comp-2: " ws-data-comp-value(1)
           display space
           display "----------------------------------------"
           display "Value entered in ws-data-comp-value: 12345.63"
           display "ws-data-disp-value x(10): " ws-data-disp-value(2)
           display "ws-data-comp-value comp-2: " ws-data-comp-value(2)
           display space

           stop run.
       end program redefines-test.
