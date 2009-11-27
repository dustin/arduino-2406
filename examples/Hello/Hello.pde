// This program blinks a known device.

#include <OneWire.h>
#include <DS2406.h>

OneWire ow(7);
OneWireSwitch osw(&ow,
                  // Specify the serial number of your DS2406 here.
                  (uint8_t[]){0x12, 0xE, 0xF9, 0x16, 0, 0, 0, 0xF6});

void setup(void)
{
}

void loop(void)
{
    // Turn on the switch.
    osw.setSwitchState(true);

    delay(1000);

    // Turn off the switch.
    osw.setSwitchState(false);

    delay(1000);
}


