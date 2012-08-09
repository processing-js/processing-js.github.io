#!/bin/sh

rsync -vaz _site/ -e ssh processingjs@ftp.processingjs.org:~/processingjs.org
