To run this example, you need to have [libjson-c](https://github.com/json-c/json-c) installed on your system
and enabled during the configuration process of builing the GnuCOBOL 
compiler. 

Note: You may have to ```sudo ldconfig``` after making and installing the libjson-c library for the GnuCOBOL build script to pick it up.

GnuCOBOL compile configuration with the JSON library is done using the following flag:
```./configure --with-json```

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

