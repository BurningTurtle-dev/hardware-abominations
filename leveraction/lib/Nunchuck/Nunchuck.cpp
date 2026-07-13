#include "Nunchuck.h"

#define UPDATE_TIME 5

Nunchuck::Nunchuck() : _addr(0x52) {}

bool Nunchuck::_init() {
    Wire.beginTransmission(_addr);
    Wire.write(0xF0);
    Wire.write(0x55);
    if (Wire.endTransmission() != 0) return false;
    delay(10);

    Wire.beginTransmission(_addr);
    Wire.write(0xFB);
    Wire.write(0x00);
    if (Wire.endTransmission() != 0) return false;
    delay(10);
    return true;
}

bool Nunchuck::begin(int sda, int scl) {
    if (sda >= 0 && scl >= 0) {
        Wire.setSDA(sda);
        Wire.setSCL(scl);
    }
    Wire.begin();
    Wire.setClock(100000);  // Nunchuck requires 100 kHz
    return _init();
}

bool Nunchuck::read(NunchuckData &data) {
    Wire.beginTransmission(_addr);
    Wire.write(0x00);
    if (Wire.endTransmission(false) != 0) return false;
    delay(UPDATE_TIME);  // Nunchuck needs time to update

    if (Wire.requestFrom(_addr, (uint8_t)6) != 6) return false;

    uint8_t b0 = Wire.read();  // joy_x
    uint8_t b1 = Wire.read();  // joy_y
    uint8_t b2 = Wire.read();  // accel X (ignored)
    uint8_t b3 = Wire.read();  // accel Y (ignored)
    uint8_t b4 = Wire.read();  // accel Z (ignored)
    uint8_t b5 = Wire.read();  // buttons + low accel bits

    data.joy_x = b0;
    data.joy_y = b1;
    data.c_pressed = !(b5 & 0x02);
    data.z_pressed = !(b5 & 0x01);

    return true;
}