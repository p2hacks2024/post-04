#ifndef __CHARGE_H__
#define __CHARGE_H__

#include <Adafruit_NeoPixel.h>

void charging_action(
  Adafruit_NeoPixel* strip
);

void set_charging_timer(
  int time
);

#endif
