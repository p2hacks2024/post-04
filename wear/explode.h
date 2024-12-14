#ifndef __EXPLODE_H__
#define __EXPLODE_H__

#include <Adafruit_NeoPixel.h>
#include "state.h"

void explode_action(
  WearableState* currentState,
  Adafruit_NeoPixel* strip,
  unsigned int colorR,
  unsigned int colorG,
  unsigned int colorB
);

// WearableState::Explodeでない状態から
// explode_timerをいじるときに使う
// e.g.) 状態移行時に移行時の時間を記録する
void set_explode_timer(
  int time
);

#endif
