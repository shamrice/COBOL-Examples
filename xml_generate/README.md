To run this example, you need to have xmllib2 installed on your system 
and enabled during the configuration process of builing the GnuCOBOL 
compiler. 

This is done using the following flag:
```./configure --with-xml2```

If successful, ```cobcrun --info``` should display:
```XML library              : libxml2, version 2.9.3```


**Example output of program:**
```
Generating xml for record: Test Name Test Valuetrue 
----------------------------
<?xml version="1.0"?>
<ws-record enabled="true"><name>Test Name</name><value>Test Value</value></ws-record>
----------------------------
Done.
```

