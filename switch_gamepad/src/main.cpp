#include <Arduino.h>
#include <Joystick.h>

#define ARRLEN(X) (sizeof(X) / sizeof(*X))

// Joystick object initialization
Joystick_ Joystick(JOYSTICK_DEFAULT_REPORT_ID, JOYSTICK_TYPE_GAMEPAD,
  32, 1,                 // Button Count, Hat Switch Count
  true, true, false,     // X and Y, but no Z Axis
  true, false, false,     // No Rx, Ry, or Rz
  false, false,          // No rudder or throttle
  false, false, false    // No accelerator, brake, or steering
);

typedef struct
{
  int Pin;
  int Code;
} ActionButton;

typedef struct
{
  int PinPositive, PinNegative;
  void (*Action)(int value);
} ActionJoystick;

void action_rx(int v) {
  Joystick.setZAxis(v);
}

void action_ry(int v) {
  Joystick.setRxAxis(v);
}

void action_x(int v) {
  Joystick.setXAxis(v);
}

void action_y(int v) {
  Joystick.setYAxis(v);
}

#define CODE 27

const ActionButton action_buttons[] =
{
  { .Pin = PB10, .Code =  0 },  //A
  { .Pin = PB2,  .Code =  1 },  //B
  { .Pin = PB1,  .Code =  3 },  //X
  { .Pin = PB0,  .Code =  4 },  //Z
  { .Pin = PA7,  .Code =  13 },  //Ddown
  { .Pin = PA6,  .Code =  15 },  //Dright
  { .Pin = PA5,  .Code =  12 },  //Dup
  { .Pin = PA4,  .Code =  14 },  //Dleft
  { .Pin = PA3,  .Code =  7 },  //r1
  { .Pin = PA2,  .Code =  9 },  //r2
  { .Pin = PA1,  .Code =  14 },  //r3
  { .Pin = PA0,  .Code =  6 },  //l1
  { .Pin = PC15, .Code =  8 },  //l2
  { .Pin = PC14, .Code =  13 },  //l3
  { .Pin = PB12, .Code =  11},  //start
  { .Pin = PB13, .Code =  10},  //select
  { .Pin = PB14, .Code =  12},   // sony
};

const ActionJoystick action_joysticks[] =
{
  { .PinPositive = PA15, .PinNegative = PB3, .Action = action_x },
  { .PinPositive = PB4,  .PinNegative = PB5, .Action = action_y },
  { .PinPositive = PB6,  .PinNegative = PB7, .Action = action_rx },
  { .PinPositive = PB8,  .PinNegative = PB9, .Action = action_ry }
};

int lastButtonState[ARRLEN(action_buttons)];

void setup() {
  Joystick.begin();
  Joystick.setXAxisRange(-5, 5);
  Joystick.setYAxisRange(-5, 5);
  Joystick.setZAxisRange(-5, 5);
  Joystick.setRxAxisRange(-5, 5);
  Joystick.setRyAxisRange(-5, 5);
  Joystick.setRzAxisRange(-5, 5);

  

  // CRITICAL for STM32: start the USB hardware
  USB_Begin();

  //pinMode(PC13, OUTPUT);

  // Set all input pins as pull-down
  for (int i = 0; i < ARRLEN(action_buttons); i++) {
    pinMode(action_buttons[i].Pin, INPUT_PULLDOWN);
    lastButtonState[i] = LOW;   // initialize state
  }

  for (int i = 0; i < ARRLEN(action_joysticks); i++) {
    pinMode(action_joysticks[i].PinPositive, INPUT_PULLDOWN);
    pinMode(action_joysticks[i].PinNegative, INPUT_PULLDOWN);
  }
}

void update_inputs() {
  for (int i = 0; i < ARRLEN(action_buttons); i++) {
    const ActionButton *ab = action_buttons + i;
    int current = digitalRead(ab->Pin);
    if (current != lastButtonState[i]) {
      // Button state changed – update joystick button
      Joystick.setButton(ab->Code, current);
      lastButtonState[i] = current;
    }
  }

  for (int i = 0; i < ARRLEN(action_joysticks); i++) {
    const ActionJoystick *aj = action_joysticks + i;
    int pos = digitalRead(aj->PinPositive);
    int neg = digitalRead(aj->PinNegative);
    if(pos) {
      aj->Action(2);
    }
    else if(neg) {
      aj->Action(-2);
    }
    else {
      aj->Action(0);
    }
  }
}

void loop() {
  /*
  Mapping of pins to joystick buttons (for reference)
  A=      0     PB10
  B=      1     PB2
  X=      2     PB1
  Y=      3     PB0
  Ddown=  13    PA7
  Dright= 15    PA6
  Dup=    12    PA5
  Dleft=  14    PA4
  r1=     5     PA3
  r2=     7     PA2
  r3=     11    PA1
  l1=     4     PA0
  l2=     6     PC15
  l3=     10    PC14
  start=  9     PB12
  select= 8     PB13
  sony=   16    PB14

  lJoyUP=       PA15
  lJoyDOWN      PB3
  lJoyLEFT      PB4
  lJoyRIGHT     PB5
  rJoyUP        PB6
  rJoyDOWN      PB7
  rJoyLEFT      PB8
  rJoyRIGHT     PB9
  */

  // Read all inputs and update joystick buttons
  update_inputs();
}
