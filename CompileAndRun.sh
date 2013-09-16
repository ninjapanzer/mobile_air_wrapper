#!/bin/sh

cd swf_air
middleman build
cd ..

adl sideload-app.xml
