#!/bin/sh

cd $ANALYTICS_DATA
npm install --unsafe-perm
ng serve --host 0.0.0.0 --disable-host-check
