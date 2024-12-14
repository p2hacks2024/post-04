#include <Adafruit_NeoPixel.h>
#include <math.h>
#include <stdlib.h>
#include "signal.h"
#include "state.h"
#include "explode.h"

#define ACCELERO_X 1
#define ACCELERO_Y 2
#define ACCELERO_Z 3

const int moveVectorThreshold = 750;

LowPath lowPath = LowPath();
WearableState currentState = WearableState::Waiting;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(49, 6, NEO_GRB + NEO_KHZ800);

int charging_timer = 0;
int led_cnt = 0;

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
      charging_action();
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

void charging_action() {
  double ax = analogRead(ACCELERO_X) * 5.0/1023.0;
  double ay = analogRead(ACCELERO_Y) * 5.0/1023.0;
  double az = analogRead(ACCELERO_Z) * 5.0/1023.0;

  int axi = ax*1000 - 2300;
  int ayi = ay*1000 - 2300;
  int azi = az*1000 - 2300;

  int vec = sqrt(ax*ax + ay*ay + az*az) * 1000;

  long long ave = lowPath.average();
  if (lowPath.ready() && abs(ave - vec) > moveVectorThreshold) {
    char dat[50];
    sprintf(dat, "x: %d, y: %d, z: %d, vec: %d\nave: %ld", axi, ayi, azi, vec, ave);
    Serial.println(dat);
    Serial.println("Triggered!");
  }  

  lowPath.push(vec);
}