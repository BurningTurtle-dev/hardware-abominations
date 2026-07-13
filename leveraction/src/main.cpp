#include <Arduino.h>
#include <Joystick.h>
#include <Nunchuck.h>

#define ARRLEN(X) (sizeof(X) / sizeof(*X))

#define rX_pin_pos PB4
#define rX_pin_neg PB5
#define Z_pin_pos PB6
#define Z_pin_neg PB7


Nunchuck nunchuck;
NunchuckData data;
bool hold_down_mode = 0;

// Joystick object initialization
Joystick_ Joystick(JOYSTICK_DEFAULT_REPORT_ID, JOYSTICK_TYPE_GAMEPAD,
  32, 0,                 // Button Count, Hat Switch Count
  true, true, true,     // X and Y, but no Z Axis
  true, true, true,     // Rx and Ry, but no Rz
  false, false,          // No rudder or throttle
  false, false, false    // No accelerator, brake, or steering
);

typedef struct
{
  int Pin;
  int Code;
  bool Hold;
} ActionButton;

//TODO corrent pins
const ActionButton action_buttons[] =
{
  { .Pin = PB10, .Code =  0,  .Hold = false },  //A
  { .Pin = PB2,  .Code =  1,  .Hold = true  },  //B
  { .Pin = PB1,  .Code =  3,  .Hold = false },  //X
  { .Pin = PB0,  .Code =  4,  .Hold = false },  //Z
  { .Pin = PA7,  .Code =  13, .Hold = false },  //Ddown
  { .Pin = PA6,  .Code =  15, .Hold = false },  //Dright
  { .Pin = PA5,  .Code =  12, .Hold = false },  //Dup
  { .Pin = PA4,  .Code =  14, .Hold = false },  //Dleft
  { .Pin = PA3,  .Code =  7,  .Hold = false },  //r1
  { .Pin = PA2,  .Code =  9,  .Hold = false },  //r2
  { .Pin = PA1,  .Code =  14, .Hold = false },  //r3
  { .Pin = PA0,  .Code =  6,  .Hold = true  },  //l1
  { .Pin = PC15, .Code =  8,  .Hold = true  },  //l2
  { .Pin = PC14, .Code =  13, .Hold = false },  //l3
  { .Pin = PB12, .Code =  11, .Hold = false },  //start
  { .Pin = PB13, .Code =  10, .Hold = false },  //select
//  { .Pin = PB14, .Code =  12, .Hold = false},   // sony
};

int lastButtonState[ARRLEN(action_buttons)];

//////////////////////////////////////////////////////////////////////////////////

void setup() {
  pinMode(PC13, OUTPUT);
  digitalWrite(PC13, HIGH);

  Joystick.begin();
  Joystick.setXAxisRange(0, 255);
  Joystick.setYAxisRange(0, 255);

  Joystick.setRxAxisRange(-5, 5);

  Joystick.setZAxisRange(-5, 5);


  USB_Begin();

  bool started = nunchuck.begin(PB9, PB8);

  // Set all button input pins as pull-down
  for (int i = 0; i < ARRLEN(action_buttons); i++) {
    pinMode(action_buttons[i].Pin, INPUT_PULLDOWN);
    lastButtonState[i] = LOW;
  }

  // Set all joystick input pins as pull-down
  for (int i = 0; i < 4; i++) {
    lastButtonState[i] = LOW;
  }

  pinMode(rX_pin_pos, INPUT_PULLDOWN);
  pinMode(rX_pin_neg, INPUT_PULLDOWN);
  pinMode(Z_pin_pos, INPUT_PULLDOWN);
  pinMode(Z_pin_neg, INPUT_PULLDOWN);
}

void update_nunchuck() {
  bool ok = nunchuck.read(data);

  if (!ok) {
    update_nunchuck();
    return;
  }

  Joystick.setXAxis(data.joy_x);
  Joystick.setYAxis(255 - data.joy_y);
  

  hold_down_mode = data.z_pressed;
}

//TODO change hold, not hold behaviour.
void update_button_hold() {
  for (int i = 0; i < ARRLEN(action_buttons); i++) {
    const ActionButton *ab = action_buttons + i;
    int current = digitalRead(ab->Pin);

    if (ab->Hold) {
      if (current != lastButtonState[i]) {
        // Button state changed – update joystick button
        Joystick.setButton(ab->Code, current);
        lastButtonState[i] = current;
      }

    }
    else {
      if (current != lastButtonState[i]) {
        // Button state changed – update joystick button
        Joystick.setButton(ab->Code, current);
        lastButtonState[i] = current;
      }
    } 

  }
  
}


void update_button_press() {
  for (int i = 0; i < ARRLEN(action_buttons); i++) {
    const ActionButton *ab = action_buttons + i;
    int current = digitalRead(ab->Pin);
    if (current != lastButtonState[i]) {
      // Button state changed – update joystick button
      Joystick.setButton(ab->Code, current);
      lastButtonState[i] = current;
    }
  }
}


void update_right_joystick() {
  // rX axis
  if (digitalRead(rX_pin_pos)) {
    Joystick.setRxAxis(2);
  }
  else if (digitalRead(rX_pin_neg)) {
    Joystick.setRxAxis(-2);
  }
  else {
    Joystick.setRxAxis(0);
  }

  // Z axis
  if (digitalRead(Z_pin_pos)) {
    Joystick.setZAxis(2);

  }
  else if (digitalRead(Z_pin_neg)) {
    Joystick.setZAxis(-2);

  }
  else {
    Joystick.setZAxis(0);
  }
}


void loop() {

  /*digitalWrite(PC13, LOW);
  delay(500);
  digitalWrite(PC13, HIGH);
  delay(500);*/

  update_nunchuck();
  update_right_joystick();

  if (hold_down_mode) {
    //digitalWrite(PC13, LOW);
    update_button_hold();
  }
  else {
    digitalWrite(PC13, HIGH);
    //update_button_press();
  }

}
