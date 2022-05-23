#!/bin/sh

TCZ_C="alsa-plugins alsa alsa-utils libasound libasound-dev"
TCZ="gdb alsa-modules-4.9.22-piCore alsa-oss $TCZ_C"
TCZ3="$TCZ_C"

f="$1"
if [ "X$f" = X ] ; then
  mkdir -p ../built/tcz
  mkdir -p ../built/tcz3
  for t in $TCZ ; do
    test -f ../built/tcz/$t.tcz || curl http://www.tinycorelinux.net/9.x/armv6/tcz/$t.tcz > ../built/tcz/$t.tcz
  done
  for t in $TCZ3 ; do
    test -f ../built/tcz3/$t.tcz || curl http://www.tinycorelinux.net/10.x/armv7/tcz/$t.tcz > ../built/tcz3/$t.tcz
  done
  test -f ../built/modules0.tar.gz || curl http://www.tinycorelinux.net/9.x/armv6/releases/RPi/src/kernel/4.9.22-piCore_modules.tar.xz | xzcat | gzip -c > ../built/modules0.tar.gz
  test -f ../built/modules.tar.gz || curl http://tinycorelinux.net/11.x/armv7/releases/RPi/src/kernel/modules.tar.gz > ../built/modules.tar.gz
  cp ../built/tcz{,3}/gdb.tcz

  rm -rf ../built/boot{,3}
  f=/build/image/inner.sh
fi

docker run -i -t --rm -v `cd .. && pwd`:/build pext/rpi:rpi3 "$f"
