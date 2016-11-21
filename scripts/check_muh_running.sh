#!/bin/bash

if [ `pidof muh` ]; then
    echo "muh process found."
else
    echo "muh process not found, starting..."
    muh
fi
