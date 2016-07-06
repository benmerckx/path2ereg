#!/bin/sh
zip -r path2ereg.zip path2ereg haxelib.json readme.md -x "*/\.*"
haxelib submit path2ereg.zip
rm path2ereg.zip 2> /dev/null