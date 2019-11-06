#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

#define N 512

__global__ void bmk_add(int* a, int* b, int* result)
{
	int i = blockDim.x * blockIdx.x + threadIdx.x;
	result[i] = a[i] + b[i];
}

int main()
{
	int* a, * b, * c;
	int* dev_a, * dev_b, * dev_c;

	int size = N * sizeof(int);

	a = (int*)malloc(size);
	b = (int*)malloc(size);
	c = (int*)malloc(size);

	cudaMalloc((void**)&dev_a, size);
	cudaMalloc((void**)&dev_b, size);
	cudaMalloc((void**)&dev_c, size);

	for (int i = 0; i < N; i++)
	{
		a[i] = i;
		b[i] = i;
	}

	cudaMemcpy(dev_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, b, size, cudaMemcpyHostToDevice);

	bmk_add << <1, 512 >> > (dev_a, dev_b, dev_c);

	cudaDeviceSynchronize();

	cudaMemcpy(c, dev_c, size, cudaMemcpyDeviceToHost);

	for (int i = 0; i < N; i++)
		printf("%d  ", c[i]);

	printf("\n");
	cudaFree(dev_a);
	cudaFree(dev_b);
	cudaFree(dev_c);

	free(a);
	free(b);
	free(c);

	return 0;
}