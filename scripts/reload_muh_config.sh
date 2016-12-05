#!/bin/sh
#
# Reloads running muh process by sending SIGHUP.
# (alternative to sending REHASH command by client)
#

kill -s SIGHUP `cat $HOME/.muh/pid`

