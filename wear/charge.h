#ifndef __CHARGE_H__
#define __CHARGE_H__

#include "state.h"
#include <Adafruit_NeoPixel.h>

void charging_action(
  WearableState* currentState,
  Adafruit_NeoPixel* strip
);

void set_charging_timer(
  int time
);

#endif
