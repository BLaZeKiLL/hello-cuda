project(Mandelbrot LANGUAGES CXX CUDA)

# Takes care of setting up and linking of CUDA
find_package(CUDAToolkit REQUIRED)

set(CMAKE_CUDA_ARCHITECTURES 61) # GTX 1070

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set the CUDA standard
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

set(INC
    include
)

set(SRC
    src/kernel.cu
    src/utils.cu

    src/image.cpp

    src/main.cpp
)

add_executable(mandelbrot "${SRC}")

target_include_directories(mandelbrot PRIVATE "${INC}")

set_target_properties(mandelbrot PROPERTIES CUDA_SEPARABLE_COMPILATION ON)