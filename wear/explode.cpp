#include "explode.h"

#include <Arduino.h>
#include <Adafruit_NeoPixel.h>
#include "state.h"

int explode_timer = 0;
unsigned int explode_phase = 0;
const unsigned int explode_duration = 75;
const unsigned int explode_blur_duration = 900;
unsigned int explode_breath_count = 0;

void explode_action(
    WearableState* currentState,
    Adafruit_NeoPixel* strip,
    unsigned int colorR,
    unsigned int colorG,
    unsigned int colorB
) {
  int elapsed = millis() - explode_timer;
  if (explode_phase == 0) {
    if (elapsed < explode_duration) {
      double ratio = elapsed / (double)explode_duration;
      Serial.println(ratio);
      for (int j = 1; j < strip->numPixels(); j++) {
        strip->setPixelColor(
          j,
          strip->Color(ratio * colorR, ratio * colorG, ratio * colorB)
        );
      }
      strip->show();
    }
    else if (elapsed < 4 * explode_duration) {
      double ratio = 1.0 - (elapsed-explode_duration) / (double)explode_duration;
      for (int j = 1; j < strip->numPixels(); j++) {
        strip->setPixelColor(
          j,
          strip->Color(ratio * colorR, ratio * colorG, ratio * colorB)
        );
      }
      strip->show();
    }
    else {
      explode_timer = millis();
      if (explode_breath_count++ == 4) {
        explode_phase = 1;
        explode_breath_count = 0;
      }
    }
  }
  else if (explode_phase == 1) {
    if (elapsed < explode_blur_duration) {
      double ratio = elapsed / (double)explode_blur_duration;
      for (int j = 1; j < strip->numPixels(); j++) {
        strip->setPixelColor(
          j,
          strip->Color(ratio * colorR, ratio * colorG, ratio * colorB)
        );
      }
      strip->show();
    }
    else if (elapsed < 2 * explode_blur_duration) {
      double ratio = 1.0 - (elapsed-explode_blur_duration) / (double)explode_blur_duration;
      for (int j = 1; j < strip->numPixels(); j++) {
        strip->setPixelColor(
          j,
          strip->Color(ratio * colorR, ratio * colorG, ratio * colorB)
        );
      }
      strip->show();
    }
    else {
      explode_breath_count++;
      explode_timer = millis();
      if (explode_breath_count == 5) {
        explode_phase = 0;
        explode_breath_count = 0;
        *currentState = WearableState::Waiting;
      }
    }
  }
}

void set_explode_timer(int time) {
  explode_timer = time;
}
