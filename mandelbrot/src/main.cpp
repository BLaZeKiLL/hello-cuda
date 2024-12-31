#include <iostream>

#include "kernel.cuh"
#include "image.hpp"

#define WIDTH 1920
#define HEIGHT 1080
#define MAX_ITER 1000

int main() {
    // Image properties
    const int image_size = WIDTH * HEIGHT * 3;
    unsigned char* h_image = new unsigned char[image_size];

    // Define the region of the complex plane
    float x_min = -2.0f, x_max = 1.0f;
    float y_min = -1.0f, y_max = 1.0f;

    // Execute kernel
    execute(h_image, x_min, x_max, y_min, y_max, WIDTH, HEIGHT, MAX_ITER);

    // Save the image
    save_image(h_image, WIDTH, HEIGHT, "mandelbrot.ppm");

    delete[] h_image;

    std::cout << "Mandelbrot set image saved to 'mandelbrot.ppm'\n";
    return 0;
}
