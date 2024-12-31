# Hello CUDA

Cpp + Vcpkg + CUDA + VsCode starter project.

## Project Structure
The `mandelbrot` project is an example project and it's `CMakeLists.txt` can be used as a reference.

> You can create your own project by creating a new directory and adding it as a sub-directory in the top-level CMakeLists.txt file

## CMake Preset
You can update values in here depending upon your systems and requirements, do take a look at the CMake Cache Variables
- `CMAKE_C_COMPILER` - C compiler path
- `CMAKE_CXX_COMPILER` - C++ compiler path
- `CMAKE_CUDA_COMPILER` - CUDA compiler path
- `CMAKE_TOOLCHAIN_FILE` - vcpkg toolchain file path

## Vcpkg
This project assumes vcpkg is installed on your system and the toolchain path is configured in the cmake preset. dependencies can be added by listing them in the vcpkg.json

## VSCode
Official C++ and CMake vscode extensions are required for this project to work, the base cmake preset is configured to export the compile commands.json file which is configured to be used by extensions in the `.vscode` folder to provide intellisense 