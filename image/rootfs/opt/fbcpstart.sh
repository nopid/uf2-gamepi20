#!/bin/sh
ok=1
while : ; do
    if kill -0 `cat /tmp/fbcp-pid` 2>/dev/null ; then
      ok=1
    else
      if [ $ok = 0 ] ; then
        /usr/sbin/fbcp &
        echo $! > /tmp/fbcp-pid
        sleep 5
        ok=1
      else
        ok=0
      fi
    fi
    sleep 0.5
done
