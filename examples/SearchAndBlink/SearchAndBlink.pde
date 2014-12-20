// This program blinks any 2406 device it finds and prints the devices
// it finds over the serial port.

// This program demonstrates the following:
//  1) Finding and identifying a DS2406
//  2) Setting a switch port's state.
//  3) Reading the switch port's state.

#include <OneWire.h>
#include <DS2406.h>

#define DEBUG_OUT 1

#if DEBUG_OUT
#define DEBUG_PRINT(a) Serial.print(a)
#else
#define DEBUG_PRINT(a)
#endif /* DEBUG_OUT */

// On which pin will you put the 1wire bus?
OneWire ow(7);
bool foundDevice = false;

void setup(void)
{
#if DEBUG_OUT
    Serial.begin(9600);
#endif /* DEBUG_OUT */
}

#ifdef DEBUG_OUT
void printDevice(uint8_t *addr) {
    for(int i = 0; i < 8; i++) {
        if(i != 0) {
            Serial.print(":");
        }
        Serial.print(addr[i], HEX);
    }
}
#endif /* DEBUG_OUT */

void showState(bool on) {
    DEBUG_PRINT(on ? "\tState is on\n" : "\tState is off\n");
}

void flipSwitch(uint8_t *addr) {
    // We're using a temporary switch object here only because we're
    // discovering them dynamically.  Depending on your app, you may
    // already know the serial number of the device you intend to
    // control and will use it there.
    OneWireSwitch osw(&ow, addr);

    // Turn on the switch.
    osw.setSwitchState(true);
    // Read the switch state back (getSwitchState() will return true here).
    showState(osw.getSwitchState());

    delay(1000);

    // Turn off the switch.
    osw.setSwitchState(false);
    // Read the switch state back (getSwitchState() will return false here).
    showState(osw.getSwitchState());
}

void loop(void)
{
    DEBUG_PRINT("Beginning Search...\n");
    uint8_t addr[8];

    ow.reset_search();

    // Set the LED state to the previous iteration's found state.
    digitalWrite(13, foundDevice ? HIGH : LOW);
    // Assume we can't find something until we prove otherwise.
    foundDevice = false;

    while(ow.search(addr) == 1) {
        if ( OneWire::crc8( addr, 7) != addr[7]) {
            DEBUG_PRINT("CRC is not valid!\n");
            delay(1000);
            return;
        }

#if DEBUG_OUT
        Serial.print("Found a device: ");
        printDevice(addr);
        Serial.println("");
#endif /* DEBUG_OUT */

        // At this point, we know we have a DS2406.  Blink it.
        if(addr[0] == DS2406_FAMILY) {
            foundDevice = true;
            digitalWrite(13, HIGH);
            flipSwitch(addr);
        }
    }
    delay(1000);
}
