#include "kernel.cuh"
#include "utils.cuh"

__device__ int mandelbrot(float x0, float y0, int max_iter) {
    float x = 0.0f, y = 0.0f;
    int iter = 0;

    while (x * x + y * y <= 4.0f && iter < max_iter) {
        float x_temp = x * x - y * y + x0;
        y = 2.0f * x * y + y0;
        x = x_temp;
        iter++;
    }
    return iter;
}

__global__ void mandelbrot_kernel(unsigned char* image, int width, int height, float x_min, float x_max, float y_min, float y_max, int max_iter) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    int idy = blockIdx.y * blockDim.y + threadIdx.y;

    if (idx < width && idy < height) {
        // Map pixel coordinates to complex plane
        float x0 = x_min + (x_max - x_min) * idx / width;
        float y0 = y_min + (y_max - y_min) * idy / height;

        // Compute Mandelbrot iterations
        int iter = mandelbrot(x0, y0, max_iter);

        // Normalize iteration count to [0, 1]
        float hue = (float)iter / max_iter;

        // Apply HSV to RGB conversion (use a fixed saturation and value)
        unsigned char r, g, b;
        if (iter < max_iter) {
            hsv_to_rgb(hue, 0.8f, 1.0f, r, g, b);
        } else {
            r = g = b = 0;  // Points that don't escape are black
        }

        // Write color to image
        int pixel_idx = (idy * width + idx) * 3;
        image[pixel_idx + 0] = r;  // Red
        image[pixel_idx + 1] = g;  // Green
        image[pixel_idx + 2] = b;  // Blue
    }
}

void execute(unsigned char* h_image, float x_min, float x_max, float y_min, float y_max, int width, int height, int max_iter) {
    const int image_size = width * height * 3;

    unsigned char* d_image;

    // Allocate memory on the GPU
    cudaMalloc(&d_image, image_size);

    // Define grid and block dimensions
    dim3 block_size(16, 16);
    dim3 grid_size((width + block_size.x - 1) / block_size.x, (height + block_size.y - 1) / block_size.y);

    // Launch the Mandelbrot kernel
    mandelbrot_kernel<<<grid_size, block_size>>>(d_image, width, height, x_min, x_max, y_min, y_max, max_iter);
    cudaDeviceSynchronize();

    // Copy result back to the host
    cudaMemcpy(h_image, d_image, image_size, cudaMemcpyDeviceToHost);

    // Free memory
    cudaFree(d_image);
}