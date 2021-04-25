#!/bin/sh
nohup socat -d -lf $HOME/nohup.out tcp-l:9999,reuseaddr,fork exec:$1 >/dev/null 2>&1 &
