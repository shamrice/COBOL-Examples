# JSON GENERATE Example


To run this example, you need to have [libjson-c](https://github.com/json-c/json-c) installed on your system
and enabled during the configuration process of builing the GnuCOBOL 
compiler. 

Note: You may have to ```sudo ldconfig``` after making and installing the libjson-c library for the GnuCOBOL build script to pick it up.

Configuring GnuCOBOL compilation with the JSON library is done by adding the following flag:
```./configure --with-json```

After configured, you will need to also run ```make``` ```make install``` to rebuid and reinstall GnuCOBOL with the new library.

If successful, ```cobcrun --info``` should display:
```JSON library             : json-c, version 0.15.99```


**Example output of program:**
```
JSON document successfully generated.
Generated JSON for record: Test Name Test Value          true 
----------------------------
{"ws-record":{"name":"Test Name","value":"Test Value","ws-record-blank":" ","enabled":"true"}}
----------------------------
JSON output character count: 0094
Done.
```

