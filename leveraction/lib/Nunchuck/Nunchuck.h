#ifndef NUNCHUCK_H
#define NUNCHUCK_H

#include <Arduino.h>
#include <Wire.h>

struct NunchuckData {
    uint8_t joy_x;
    uint8_t joy_y;
    bool c_pressed;
    bool z_pressed;
};

class Nunchuck {
public:
    Nunchuck();

    // Pass -1 for default pins, or specific SDA/SCL pins (e.g., PB9, PB8)
    bool begin(int sda = -1, int scl = -1);

    bool read(NunchuckData &data);

private:
    uint8_t _addr;
    bool _init();
};

#endif