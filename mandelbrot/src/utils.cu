#include "utils.cuh"

__device__ void hsv_to_rgb(float h, float s, float v, unsigned char &r, unsigned char &g, unsigned char &b) {
    int i = static_cast<int>(h * 6);
    float f = h * 6 - i;
    float p = v * (1 - s);
    float q = v * (1 - f * s);
    float t = v * (1 - (1 - f) * s);
    i = i % 6;

    if (i == 0) { r = static_cast<unsigned char>(v * 255); g = static_cast<unsigned char>(t * 255); b = static_cast<unsigned char>(p * 255); }
    else if (i == 1) { r = static_cast<unsigned char>(q * 255); g = static_cast<unsigned char>(v * 255); b = static_cast<unsigned char>(p * 255); }
    else if (i == 2) { r = static_cast<unsigned char>(p * 255); g = static_cast<unsigned char>(v * 255); b = static_cast<unsigned char>(t * 255); }
    else if (i == 3) { r = static_cast<unsigned char>(p * 255); g = static_cast<unsigned char>(q * 255); b = static_cast<unsigned char>(v * 255); }
    else if (i == 4) { r = static_cast<unsigned char>(t * 255); g = static_cast<unsigned char>(p * 255); b = static_cast<unsigned char>(v * 255); }
    else { r = static_cast<unsigned char>(v * 255); g = static_cast<unsigned char>(p * 255); b = static_cast<unsigned char>(q * 255); }
}