# DS2406 Library for Arduino

This library provides a simple class for querying and modifying the
state of [DS2406][ds2406] 1wire addressable switches.

It builds upon the [Arduino 1wire][a1wire] library but provides
device-specific commands.

The following schematic possibly shows how to wire up a circuit for
remote control.  I'm more of a hacker than an EE, so please criticize
if anything here is confusing.

![schematic](http://github.com/dustin/arduino-2406/raw/gh-pages/2406-example.png)

[ds2406]: http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2907
[a1wire]: http://www.arduino.cc/playground/Learning/OneWire
