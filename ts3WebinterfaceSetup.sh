#!/bin/bash
TMPFILE           = "tmp.zip"
PATH              = "/var/www/html/ts3/"
TS3_WEB_INTERFACE = "http://interface.ts-rent.de/smf/index.php?page=Attachment&attachmentID=178"

# Download and extract the TS3-Webinterface
wget $TS3_WEB_INTERFACE -O $TMPFILE
unzip -d $PATH $TMPFILE
rm $TMPFILE