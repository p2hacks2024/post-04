#include "signal.h"

long long LowPath::average() {
  long long sum = 0;
  for (int i = 0; i < size; i++) sum += data[i];
  return sum / size;
}

void LowPath::push(int new_data) {
  for (int i = 1; i < size; i++) data[i-1] = data[i];
  data[size-1] = new_data;
}