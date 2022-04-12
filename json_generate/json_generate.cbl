      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-04-12
      * purpose: Example of using the XML GENERATE command to create
      *          JSON documents from records.
      *
      * Preqreq: libjson-c installed on system compiling source.
      *           https://github.com/json-c/json-c
      *
      * To enable, GnuCOBOL must be configured and built with the xml
      * library added. When configurating souce, use:
      *      ./configure --with-json --without-db
      * If you have the DB libs, you can leave the DB flag out
      *
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. json-generate-example.
       data division.
       file section.
       working-storage section.

       01  ws-json-output                       pic x(256).

       01  ws-json-char-count                   pic 9(4).

       01  ws-record.
           05  ws-record-name                  pic x(10).
           05  ws-record-value                 pic x(10).
           05  ws-record-blank                 pic x(10).
           05  ws-record-flag                  pic x(5) value "false".
               88  ws-record-flag-enabled      value "true".
               88  ws-record-flag-disabled     value "false".

       procedure division.
       main-procedure.

           move "Test Name" to ws-record-name
           move "Test Value" to ws-record-value
           set ws-record-flag-enabled to true

           json generate ws-json-output
               from ws-record
               count in ws-json-char-count
               name of
                   ws-record-name is "name",
                   ws-record-value is "value",
                   ws-record-flag is "enabled"
               on exception
                   display "Error generating JSON error " JSON-CODE
                   stop run
               not on exception
                   display "JSON document successfully generated."
           end-json

           display "Generated JSON for record: " ws-record
           display "----------------------------"
           display function trim(ws-json-output)
           display "----------------------------"
           display "JSON output character count: " ws-json-char-count
           display "Done."
           stop run.


       end program json-generate-example.
