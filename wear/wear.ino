#include <Adafruit_NeoPixel.h>
#include <math.h>
#include <stdlib.h>
#include "signal.h"
#include "state.h"
#include "charge.h"
#include "explode.h"

WearableState currentState = WearableState::Waiting;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(49, 6, NEO_GRB + NEO_KHZ800);

void setup() {
  Serial.begin(9600);
  // デバッグ用にChargeにしている。
  // ある程度コードが完成してきたらここでChargeにしないようにする。
  currentState = WearableState::Explode;
  strip.begin();
  strip.show();
}

void loop() {
  switch(currentState) {
    case WearableState::Waiting:
      // 今のところはなにもしない
      break;
    case WearableState::WaitingWithColor:
      // TODO: 色が明滅するようなエフェクトをつける
      break;
    case WearableState::Charge:
      charging_action(
        &currentState,
        &strip
      );
      break;
    case WearableState::Explode:
      // TODO: 評価関数をつくる
      explode_action(
        &currentState,
        &strip,
        90, // Red
        0, // Green
        130   // Blue
      );
      break;
    default:
      // UNREACHABLE
      break;
  }
}
