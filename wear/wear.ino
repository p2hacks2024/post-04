#include <math.h>
#include <stdlib.h>
#include "signal.h"

#define ACCELERO_X 1
#define ACCELERO_Y 2
#define ACCELERO_Z 3

const int moveVectorThreshold = 750;

LowPath lowPath = LowPath();

void setup() {
  Serial.begin(9600);
}

void loop() {
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
