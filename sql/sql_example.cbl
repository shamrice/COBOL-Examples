      *>****************************************************************
      *> Author: Erik Eriksen
      *> Date: 2022-04-15
      *> Purpose: Example program showing connecting and using a Postgres
      *>          SQL database in an application.
      *>
      *> Note: WORKING-STORAGE SECTION header as well as SQL related 
      *>       statements must be in uppercase for the esqlOC precompiler
      *>       to pick them up and process them.
      *>
      *> Prerequisites: Postgres SQL database with create_db script ran
      *>                on.
      *>                esqlOC Precompiler
      *>                unixODBC odbc-postgresql driver installed
      *>
      *> Precomiler: esqlOC -static -o generated_sql_ex.cbl sql_example.cbl
      *> Tectonics: cobc -x -static -locsql generated_sql_ex.cbl
      *>
      *>****************************************************************
       identification division.
       program-id. sql-example.
       data division.
       file section.

       WORKING-STORAGE SECTION.

      *> Variables inside the DECLARE SECTION can be used in 
      *> SQL queries either as input or output. Variables outside of 
      *> this section are local to the program only.
       EXEC SQL
           BEGIN DECLARE SECTION
       END-EXEC.

      *> Replace values as needed for your own local test environment
       77  ws-db-connection-string pic x(1024) value
               'DRIVER={PostgreSQL Unicode};' &
               'SERVER=localhost;' &
               'PORT=5432;' &
               'DATABASE=cobol_db_example;' &
               'UID=postgres;' &
               'PWD=password;' &
               'COMRESSED_PROTO=0;'.

       01  ws-sql-account-record.
           05  ws-sql-account-id                  pic 9(5).
           05  ws-sql-account-first-name          pic x(8).
           05  ws-sql-account-last-name           pic x(8).
           05  ws-sql-account-phone               pic x(10).
           05  ws-sql-account-address             pic x(22).
           05  ws-sql-account-is-enabled          pic x.
           05  ws-sql-account-create-dt           pic x(20).
           05  ws-sql-account-mod-dt              pic x(20).

      *> Variables in the WHERE clause require that the string length 
      *> is supplied otherwise with a regular 'PIC X(n)' it will 
      *> include the blank space in any '=' or 'LIKE' operation and 
      *> most likely not match any records. Using the below variable
      *> declaration ensures that the correct length is passed for the
      *> text supplied. 
      *>
      *> More info can be found at this link under the 'Variable-length
      *> Character Strings' section. Note: level 49 variables are not
      *> supported so a regular '05' seems to work instead.
      *> https://www.microfocus.com/documentation/net-express/nx30books/dbdtyp.htm
       01  ws-search-value.
           05  ws-search-value-len              pic S9(4) comp-5.
           05  ws-search-value-text             pic x(50).

       EXEC SQL
           END DECLARE SECTION
       END-EXEC.

      *> Local variables to the program only. These are not seen by 
      *> the precompiler operation.
       01  ws-num-accounts                  pic 999 comp.

       01  ws-account-record                occurs 0 to 100 times
                                            depending on ws-num-accounts                                            
                                            indexed by ws-account-idx.
           05  ws-account-id                pic 9(5).
           05  ws-account-first-name        pic x(8).
           05  ws-account-last-name         pic x(8).
           05  ws-account-phone             pic x(10).
           05  ws-account-address           pic x(22).
           05  ws-account-is-enabled        pic x.
               88  ws-account-enabled       value 'Y'.
               88  ws-account-disabled      value 'N'.
           05  ws-account-create-dt         pic x(20).
           05  ws-account-mod-dt            pic x(20).

       01  ws-menu-choice                   pic x.   

       01  ws-search-string                 pic x(48).     

       01  ws-is-connected-sw               pic a value 'N'.
           88  ws-is-connected              value 'Y'.
           88  ws-is-disconnected           value 'N'.

       01  ws-search-again-sw               pic a value 'N'.
           88  ws-search-again              value 'Y'.
           88  ws-not-search-again          value 'N'.

       procedure division.
       main-procedure.
           display space 
           display "COBOL SQL DB Example Program"
           display "----------------------------"
           display space

      *> Connect to database and check response status.
           EXEC SQL
               CONNECT TO :ws-db-connection-string
           END-EXEC.
           perform check-sql-state
           set ws-is-connected to true 

      *> Set up cursors for querying records
           EXEC SQL 
               DECLARE ACCOUNT-ALL-CUR CURSOR FOR 
               SELECT 
                   ID, FIRST_NAME, LAST_NAME, PHONE, 
                   ADDRESS, IS_ENABLED, CREATE_DT, MOD_DT 
               FROM ACCOUNTS 
               ORDER BY ID;
           END-EXEC 

           perform check-sql-state           

           EXEC SQL 
               DECLARE ACCOUNT-DISABLED-CUR CURSOR FOR 
               SELECT 
                   ID, FIRST_NAME, LAST_NAME, PHONE, 
                   ADDRESS, IS_ENABLED, CREATE_DT, MOD_DT 
               FROM ACCOUNTS 
               WHERE IS_ENABLED = 'N'
               ORDER BY ID;
           END-EXEC 

           perform check-sql-state

           EXEC SQL 
               DECLARE ACCOUNT-QUERY-CUR CURSOR FOR 
               SELECT 
                   ID, FIRST_NAME, LAST_NAME, PHONE, 
                   ADDRESS, IS_ENABLED, CREATE_DT, MOD_DT 
               FROM ACCOUNTS 
               WHERE 
                   FIRST_NAME LIKE :ws-search-value
                   OR LAST_NAME LIKE :ws-search-value
                   OR PHONE LIKE :ws-search-value
                   OR ADDRESS LIKE :ws-search-value                    
               ORDER BY ID;
           END-EXEC 

           perform check-sql-state

      *> Main menu operations
           perform forever
               display space 
               display "1) Display all accounts"
               display "2) Display disabled accounts"
               display "3) Query accounts"
               display "4) Exit"
               display "Selection: " with no advancing 
               accept ws-menu-choice

               evaluate ws-menu-choice
               
                   when '1' 
                       perform display-all-accounts
                       
                   when '2' 
                       perform display-disabled-accounts 

                   when '3' 
                       perform query-accounts 

                   when '4' 
                       exit perform 

                   when other 
                       display "Please make a selection between 1-4"                       

               end-evaluate
           end-perform 

      *> Disconnect and exit
           EXEC SQL
               CONNECT RESET
           END-EXEC
           display "Disconnected."
           display space 

           stop run.
 


      *> Uses the ACCOUNT-ALL_CUR cursor to query the ACCOUNT table 
      *> for all records. If a record is found, it is moved into the 
      *> ws-account-record table array for display output.
       display-all-accounts.

      *> Open cursor
           EXEC SQL 
               OPEN ACCOUNT-ALL-CUR 
           END-EXEC 

           perform check-sql-state

      *> Use cursor to query the database for each record until no more 
      *> are found.
           move 0 to ws-num-accounts
           perform with test after until SQLCODE = 100
               EXEC SQL 
                   FETCH ACCOUNT-ALL-CUR 
                   INTO 
                       :ws-sql-account-id,
                       :ws-sql-account-first-name,
                       :ws-sql-account-last-name,
                       :ws-sql-account-phone,
                       :ws-sql-account-address,
                       :ws-sql-account-is-enabled,
                       :ws-sql-account-create-dt,
                       :ws-sql-account-mod-dt;
               END-EXEC 
               perform check-sql-state

      *> If found, add to the output record table.
               if not SQL-NODATA then 
                   add 1 to ws-num-accounts
                   
                   move ws-sql-account-record 
                   to ws-account-record(ws-num-accounts)
           end-perform 

      *> Close cursor so that it can be reused next time paragraph is 
      *> called.
           EXEC SQL 
               CLOSE ACCOUNT-ALL-CUR 
           END-EXEC 
           perform check-sql-state

      *> Display output in a nice table like view.
           perform display-account-results

           exit paragraph. 




      *> Uses the ACCOUNT-DISABLED_CUR cursor to query the ACCOUNT table 
      *> for all records where IS_ENABLED is set to 'N'. If a record is 
      *> found, it is moved into the ws-account-record table array for 
      *> display output.
      *>
      *> This paragraph is very similar to the display-all-accounts 
      *> paragraph, please see that paragraph for line by line comments
       display-disabled-accounts.

           EXEC SQL 
               OPEN ACCOUNT-DISABLED-CUR 
           END-EXEC 

           perform check-sql-state

           move 0 to ws-num-accounts
           perform with test after until SQLCODE = 100
               EXEC SQL 
                   FETCH ACCOUNT-DISABLED-CUR 
                   INTO 
                       :ws-sql-account-id,
                       :ws-sql-account-first-name,
                       :ws-sql-account-last-name,
                       :ws-sql-account-phone,
                       :ws-sql-account-address,
                       :ws-sql-account-is-enabled,
                       :ws-sql-account-create-dt,
                       :ws-sql-account-mod-dt;
               END-EXEC 
               perform check-sql-state
               if not SQL-NODATA then 
                   add 1 to ws-num-accounts
                   
                   move ws-sql-account-record 
                   to ws-account-record(ws-num-accounts)
           end-perform 

           EXEC SQL 
               CLOSE ACCOUNT-DISABLED-CUR 
           END-EXEC 
           perform check-sql-state

           perform display-account-results

           exit paragraph.



      *> Queries the ACCOUNT table where the FIRST_NAME, LAST_NAME, 
      *> PHONE, or ADDRESS columns match characters in the search term
      *> provided. 
      *>
      *> Using the LIKE or '=' in a SQL query requires that the field 
      *> length passed is the exact length or it will try to match 
      *> blank spaces and ultimately not find any records. To do this,
      *> we trim the search term using the intrinsic 'trim' function.
      *> Because we're using the "LIKE" keyword, the wildcard '%' 
      *> characters must also be added to the search string manually.
      *>
      *> After our search string is set up, we use the intrinsic 
      *> 'stored-char-length' function to get the total character count
      *> in our search string to use as the length to pass in our 
      *> SQL variable.
      *>
      *> After that, this paragraph follows similar to the ones above.
      *> It uses the ACCOUNT-QUERY-CUR cursor to fetch the matching 
      *> records and load them into the output table.
       query-accounts.

      *> Keep searching until user decides to not search again.
           set ws-search-again to true 

           perform until not ws-search-again

      *> Get user input for search
               display space 
               display "Enter search value: " with no advancing 
               accept ws-search-string
           
      *> String trimmed user input into our search variable's text 
      *> value, adding the '%' wildcard characters at the start and 
      *> end of the search string.
               move spaces to ws-search-value-text
               string 
                   '%' function trim(ws-search-string) '%'                   
                   into ws-search-value-text
               end-string 

      *> Use the stored-char-length function to determine the length
      *> in characters the search string is and set it in our SQL 
      *> search variable
               move function stored-char-length(ws-search-value-text) 
               to ws-search-value-len

               display "Search value: " ws-search-value-text
               display "Length: " ws-search-value-len

      *> From here, flow follows the other paragraphs. Fetch the records
      *> and display them.   
               EXEC SQL 
                   OPEN ACCOUNT-QUERY-CUR 
               END-EXEC 

               perform check-sql-state

               move 0 to ws-num-accounts
               perform with test after until SQLCODE = 100
                   EXEC SQL 
                       FETCH ACCOUNT-QUERY-CUR 
                       INTO 
                           :ws-sql-account-id,
                           :ws-sql-account-first-name,
                           :ws-sql-account-last-name,
                           :ws-sql-account-phone,
                           :ws-sql-account-address,
                           :ws-sql-account-is-enabled,
                           :ws-sql-account-create-dt,
                           :ws-sql-account-mod-dt;
                   END-EXEC 
                   perform check-sql-state
                   if not SQL-NODATA then 
                       add 1 to ws-num-accounts
                   
                       move ws-sql-account-record 
                       to ws-account-record(ws-num-accounts)
               end-perform 

               EXEC SQL 
                   CLOSE ACCOUNT-QUERY-CUR 
               END-EXEC 
               perform check-sql-state

               perform display-account-results

               display space 
               display "Search again? (Y/[N]) " with no advancing 
               accept ws-search-again-sw 
               
               move function upper-case(ws-search-again-sw) 
               to ws-search-again-sw 

           end-perform 

           exit paragraph.



      *> Displays the current values of the ws-account-record table 
      *> in a nice table like format. 
       display-account-results. 

           display space 
           display "ACCOUNTS:"
           display space                  
           display " ID   | First    | Last     | Phone      |"
               " Address                | Enabled "
           end-display 
           display "------|----------|----------|------------|"
               "------------------------|---------"
           end-display 

           perform varying ws-account-idx from 1 by 1 
           until ws-account-idx > ws-num-accounts

               display 
                   ws-account-id(ws-account-idx) 
                   " | "               
                   ws-account-first-name(ws-account-idx) 
                   " | "
                   ws-account-last-name(ws-account-idx)
                   " | "
                   ws-account-phone(ws-account-idx) 
                   " | "
                   ws-account-address(ws-account-idx)
                   " | "
                   ws-account-is-enabled(ws-account-idx)  
               end-display 

           end-perform 
           exit paragraph.



      *> Checks SQLSTATE for any errors. If return value was success or 
      *> "No data", the paragraph returns. Otherwise, the error message 
      *> and SQLCODE are displayed to the user. The SQL connection is 
      *> closed and the application terminates.
      *>
      *> Note: the SQL related variables can be seen by inspecting the 
      *>       generated COBOL source code by the esqlOC precompiler. 
      *>       These variables will be added to the WORKING-STORAGE
      *>       SECTION. 
       check-sql-state.

      *> If success or no data, state is still valid, return.
           if SQL-SUCCESS or SQL-NODATA then 
               exit paragraph
           end-if 
           
      *> Some sort of error has occurred, display error information to 
      *> the user.
           display space 
           display "SQL Error:"
           display "SQLCODE: " SQLCODE 
           display "SQLSTATE: " SQLSTATE 

           if SQLERRML > 0 then 
               display "ERROR MESSAGE: " SQLERRMC(1:SQLERRML) 
           end-if 
           display space 

      *> If error happened after initial connection was established, 
      *> disconnect from the database
           if ws-is-connected
               EXEC SQL
                   CONNECT RESET
               END-EXEC               
           end-if 

      *> Terminate the application.
           stop run 
           exit paragraph. *> not reachable, used as paragraph end scope.

       end program sql-example.
