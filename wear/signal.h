#ifndef __SIGNALH__
#define __SIGNALH__

class LowPath {
  private:
    static const int size = 30;
    int data[size] = {};
  
  public:
    bool ready();
    long long average();
    void push(int new_data);
};

inline bool LowPath::ready() {
  return data[0] != 0;
}

#endif