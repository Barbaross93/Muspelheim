#!/bin/sh
regex='(((http|https|ftp|gopher)|mailto)[.:][^ >"\t]*|www\.[-a-z0-9.]+)[^ .,;\t>">\):]'
url=$(grep -Po "$regex" | ddmenu -p "Urls:") || exit
linkhandler "$url"
