#include "charge.h"
#include "explode.h"
#include "signal.h"
#include "state.h"

#include <Arduino.h>
#include <Adafruit_NeoPixel.h>
#include <math.h>

#define ACCELERO_X 1
#define ACCELERO_Y 2
#define ACCELERO_Z 3

const int moveVectorLowerThreshold = 800;
const int moveVectorUpperThreshold = 950;

LowPath lowPath = LowPath();
int charging_timer = 0;
int led_timer = 0;
int led_cnt = 1;
int anime_count = 0;

void charging_animation(Adafruit_NeoPixel* strip);

unsigned int eval_color(double seed1, double seed2) {
  return abs(sin(seed1 * seed2)) * 160.0;
}

void charging_action(
  WearableState* currentState,
  Adafruit_NeoPixel* strip,
  unsigned int* explode_color
) {
  charging_animation(strip);
  
  int elapsed = millis() - charging_timer;

  double ax = analogRead(ACCELERO_X) * 5.0/1023.0;
  double ay = analogRead(ACCELERO_Y) * 5.0/1023.0;
  double az = analogRead(ACCELERO_Z) * 5.0/1023.0;

  int axi = ax*1000 - 2300;
  int ayi = ay*1000 - 2300;
  int azi = az*1000 - 2300;

  int vec = sqrt(ax*ax + ay*ay + az*az) * 1000;

  lowPath.push(vec);

  // 溜め状態に移行したとき、最初の2秒は爆発状態に移行しない。
  if (elapsed > 2000) {
    long long ave = lowPath.average();
    long ax_val = abs(ave - vec);
    if (lowPath.ready() && moveVectorLowerThreshold < ax_val && ax_val < moveVectorUpperThreshold) {
      char dat[50];
      unsigned int r = eval_color(axi + 2300, millis() << (axi%5));
      unsigned int g = eval_color(ayi + 2300, millis() << (ayi%5));
      unsigned int b = eval_color(azi + 2300, millis() << (azi%5));

      sprintf(dat, "CLR ff%02x%02x%02x", r, g, b);
      Serial.println(dat);

      explode_color[0] = r;
      explode_color[1] = g;
      explode_color[2] = b;
      *currentState = WearableState::Explode;
      set_explode_timer(millis());
    }
  }
}

void charging_animation(
  Adafruit_NeoPixel* strip
) {
  int led_elapsed = millis() - led_timer;

  // 1マス点灯が流れていくアニメーション
  if (anime_count < 3) {
    if (led_elapsed > 25) {
      for (int i = 1; i < strip->numPixels(); i++) {
        uint32_t color = i==led_cnt
          ? strip->Color(
              (anime_count == 0)*50,
              (anime_count == 1)*50,
              (anime_count == 2)*50
            )
          : strip->Color(0, 0, 0);
        
        strip->setPixelColor(
          i,
          color
        );
      }
      strip->show();
      led_timer = millis();
      led_cnt++;
      
      if (led_cnt > strip->numPixels()) {
        led_cnt = 1;
        anime_count++;
      }
    }
  }
  else if (anime_count < 6) {
    // TODO: Waveっぽいアニメーションをつける
    anime_count = 0;
  }
}

void set_charging_timer(
  int time
) {
  charging_timer = time;
}
