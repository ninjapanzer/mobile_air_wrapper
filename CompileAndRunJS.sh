#!/bin/sh

cd swf_air
middleman build --verbose
cd ..

adl sideload-app-js.xml
