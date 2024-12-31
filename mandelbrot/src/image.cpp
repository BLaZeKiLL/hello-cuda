#include "image.hpp"

#include <fstream>

// Save the image as a PPM file
void save_image(const unsigned char* image, int width, int height, const char* filename) {
    std::ofstream file(filename, std::ios::out | std::ios::binary);
    file << "P6\n" << width << " " << height << "\n255\n";
    file.write(reinterpret_cast<const char*>(image), width * height * 3);
    file.close();
}