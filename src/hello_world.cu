// hello_world.cu
#include <iostream>

// CUDA kernel function
__global__ void helloWorld() {
    printf("Hello, World from GPU!\n");
}

int main() {
    // Launch the kernel with one block and one thread
    helloWorld<<<1, 1>>>();

    // Wait for the GPU to finish before accessing the results
    cudaDeviceSynchronize();

    std::cout << "Hello, World from CPU!" << std::endl;

    return 0;
}
