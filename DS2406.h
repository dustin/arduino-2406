#include <OneWire.h>

#include <inttypes.h>

#define DS2406_FAMILY       0x12

#define DS2406_WRITE_STATUS 0x55
#define DS2406_READ_STATUS  0xaa

#define PIO_A 0x20
#define PIO_B 0x40

#define DS2406_STATE_BUF_LEN 10

// Represents a single 1wire switch on an MLan.
class OneWireSwitch {

 public:

    // Construct the OneWireSwitch with the given OneWire bus and address.
    // addr must be 8 bytes.
    OneWireSwitch(OneWire *b, uint8_t *addr);

    // Get the switch state.
    // An optional argument indicates *which* switch state in the case
    // where you have a TSOC package with two ports.
    bool getSwitchState(int port = PIO_A);

    // Set the switch state(s).
    void setSwitchState(bool pio_a, bool pio_b = false);

 private:
    OneWire *bus;
    uint8_t address[8];

    void readStatus(uint8_t *buffer);
};
