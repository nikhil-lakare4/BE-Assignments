#include <stdio.h>
#include <stdlib.h>
static const int WORK_SIZE = 10;

__global__ void sort(int* a, int i, int n)
{
	int tid = threadIdx.x;
	int p;
	int temp;
	if (i % 2 == 0)
	{
		p = tid * 2;

		if (a[p] > a[p + 1])
		{
			temp = a[p];
			a[p] = a[p + 1];
			a[p + 1] = temp;
		}
	}
	else
	{
		p = tid * 2 + 1;

		if (p < n - 1)
		{
			if (a[p] > a[p + 1])
			{
				temp = a[p];
				a[p] = a[p + 1];
				a[p + 1] = temp;
			}
		}
	}
}

int main(void)
{
	int a[WORK_SIZE];
	int i;
	int* da;

	cudaMalloc((void**)&da, sizeof(int) * WORK_SIZE);

	for (i = 0; i < WORK_SIZE; i++)
	{
		printf("%d:", i);
		scanf("%d", &a[i]);
	}

	cudaMemcpy(da, a, sizeof(int) * WORK_SIZE,
		cudaMemcpyHostToDevice);

	for (i = 0; i < WORK_SIZE; i++)
	{
		sort << <1, WORK_SIZE / 2 >> > (da, i, WORK_SIZE);
	}
	cudaThreadSynchronize(); // Wait for the GPU launched work to complete
	cudaGetLastError();

	cudaMemcpy(a, da, sizeof(int) * WORK_SIZE, cudaMemcpyDeviceToHost);

	for (i = 0; i < WORK_SIZE; i++)
	{
		printf("%d\t", a[i]);
	}
	printf("\n");
	cudaFree((void*)da);
	return 0;
}