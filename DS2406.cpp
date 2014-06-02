#include <DS2406.h>

OneWireSwitch::OneWireSwitch(OneWire *b, uint8_t *addr) {
    bus = b;
    for(int i = 0; i<8; i++) {
        address[i] = addr[i];
    }
}

bool OneWireSwitch::getSwitchState(int port) {
    uint8_t status[10];
    readStatus(status);
    return status[7] & port;
}

void OneWireSwitch::setSwitchState(bool pio_a, bool pio_b) {
    uint8_t state = (pio_a << 5) | (pio_b << 6) | 0xf;
    bus->reset();
    bus->select(address);
    bus->write(DS2406_WRITE_STATUS);
    bus->write(0x07);
    bus->write(0);

    bus->write(state);
    // Read the CRC data
    for (int i = 0; i < 6; i++) {
        bus->read();
    }
    // Write the status back.
    bus->write(0xFF,1);
}

void OneWireSwitch::readStatus(uint8_t *buffer) {
    bus->reset();
    bus->select(address);
    bus->write(DS2406_READ_STATUS, 1);
    bus->write(0, 1);
    bus->write(0, 1);

    for(int i = 0; i<10; i++) {
        buffer[i] = bus->read();
    }
    bus->reset();
}

