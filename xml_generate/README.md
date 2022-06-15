# XML GENERATE Example


To run this example, you need to have [libxml2](https://github.com/GNOME/libxml2) installed on your system 
and enabled during the configuration process of builing the GnuCOBOL compiler. 


Configuring GnuCOBOL compilation with the XML library is done by adding the following flag: ```./configure --with-xml2```


After configured, you will need to also run ```make``` ```make install``` to rebuid and reinstall GnuCOBOL with the new library.


If successful, ```cobcrun --info``` should display:
```XML library              : libxml2, version 2.9.3```


**Example output of program:**
```
XML document successfully generated.
Generated xml for record: Test Name Test Value          true 
----------------------------
<?xml version="1.0"?>
<ws-record enabled="true"><name>Test Name</name><value>Test Value</value></ws-record>
----------------------------
XML output character count: 0107
Done.
```

