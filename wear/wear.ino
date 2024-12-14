#include <Adafruit_NeoPixel.h>
#include <math.h>
#include <stdlib.h>
#include "signal.h"
#include "state.h"
#include "charge.h"
#include "explode.h"

WearableState currentState = WearableState::Waiting;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(49, 6, NEO_GRB + NEO_KHZ800);

char serial_buffer[256] = {};
unsigned int buffer_index = 0;
unsigned int explode_color[3] = {83, 255, 255};

void setup() {
  Serial.begin(9600);
  strip.begin();
  strip.show();
}

void loop() {
  serial_observer();
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
        &strip,
        explode_color
      );
      break;
    case WearableState::Explode:
      explode_action(
        &currentState,
        &strip,
        explode_color[0], // Red
        explode_color[1], // Green
        explode_color[2]  // Blue
      );
      break;
    default:
      // UNREACHABLE
      break;
  }
}

void serial_observer() {
  while(Serial.available() > 0) {
    serial_buffer[buffer_index] = Serial.read();
    buffer_index++;
    if (buffer_index >= 256) {
      break;
    }
  }

  if (buffer_index > 0 && serial_buffer[buffer_index - 1] == (char)10) {
    String message = String(serial_buffer);
    message.trim();
    String tag = message.substring(0, 3);

    if (tag == "CRG") {
      if (currentState == WearableState::Waiting || currentState == WearableState::WaitingWithColor) {
        currentState = WearableState::Charge;
        set_charging_timer(millis());
        Serial.println("OK. 0");
      }
      else {
        Serial.println("WAM 0");
      }
    }
    else if (tag == "SET") {
      if (currentState == WearableState::Waiting) {
        // SET ******** のスペースまでを切り取る
        String payload = message.substring(4);
        if (payload.length() != 8) {
          Serial.println("INV 0");
        }

        String r = payload.substring(2, 4), g = payload.substring(4, 6), b = payload.substring(6, 8);
        explode_color[0] = strtol(r.c_str(), NULL, 16);
        explode_color[1] = strtol(g.c_str(), NULL, 16);
        explode_color[2] = strtol(b.c_str(), NULL, 16);
        currentState = WearableState::WaitingWithColor;
      }
      else {
        Serial.println("WAM 0");
      }
    }

    for (int i = 0; i < 256; i++) serial_buffer[i] = 0;
    buffer_index = 0;
  }
}
