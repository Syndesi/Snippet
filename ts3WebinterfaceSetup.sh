#!/bin/bash
TMPFILE           = "tmp.zip"
PATH              = "/var/www/html/ts3/"
TS3_WEB_INTERFACE = "https://github.com/Syndesi/Snippet/raw/master/ts3wi_3.4.3.1.zip"

# Download and extract the TS3-Webinterface
wget $TS3_WEB_INTERFACE -O $TMPFILE
unzip -d $PATH $TMPFILE
rm $TMPFILE