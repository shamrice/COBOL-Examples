      ******************************************************************
      * author: Erik Eriksen
      * date: 2022-04-11
      * purpose: Example of using the XML GENERATE command to create
      *          XML documents from records.
      *
      * Preqreq: libxml2 installed on system compiling source.
      *
      * To enable, GnuCOBOL must be configured and built with the xml
      * library added. When configurating souce, use:
      *      ./configure --with-xml2 --without-db
      * If you have the DB libs, you can leave the DB flag out
      *
      * tectonics: cobc
      ******************************************************************
       identification division.
       program-id. xml-generate-example.
       data division.
       file section.
       working-storage section.

       01  ws-xml-output                       pic x(256).

       01  ws-xml-char-count                   pic 9(4).

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

           xml generate ws-xml-output
               from ws-record
               count in ws-xml-char-count
               with xml-declaration
               name of
                   ws-record-name is "name",
                   ws-record-value is "value",
                   ws-record-flag is "enabled"
               type of ws-record-flag is attribute
               suppress when spaces
               on exception
                   display "Error generating xml error " XML-CODE
                   stop run
               not on exception
                   display "XML document successfully generated."
           end-xml

           display "Generated xml for record: " ws-record
           display "----------------------------"
           display function trim(ws-xml-output)
           display "----------------------------"
           display "XML output character count: " ws-xml-char-count
           display "Done."
           stop run.


       end program xml-generate-example.
