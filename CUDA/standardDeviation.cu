#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#include<math.h>

#define N 512

__global__ void Sum (int *a,int *o)
{

    int tid = blockDim.x*blockIdx.x+threadIdx.x;

    for(int i = N/2; i > 0; i = i/2)
    {
        if(tid < i)
        {
            a[tid]+=a[tid+i];
        }

    }

    o[0] = a[0];
}

__global__ void standardDeviation(int *a,int avg)
{
  int tid = blockDim.x*blockIdx.x+threadIdx.x;
  if(tid<N)
  {
    a[tid] -= avg;
    a[tid] = a[tid]*a[tid];
  }
}

int main()
{
    int *h_a,*d_a,*o_a,*oh_a,*d_a1;

    int size = N*sizeof(int);

    h_a = (int *)malloc(size);
    oh_a = (int *)malloc(size);

    cudaMalloc((void**)&d_a,size);
    cudaMalloc((void**)&o_a,size);
    //new
    cudaMalloc((void**)&d_a1,size);

    for(int i = 1; i <= N; i++)
    {
        h_a[i-1] = i;
    }


    cudaMemcpy(d_a,h_a,size,cudaMemcpyHostToDevice);
    cudaMemcpy(d_a1,h_a,size,cudaMemcpyHostToDevice);

    Sum<<<1,N/2>>>(d_a,o_a);

    cudaDeviceSynchronize();

    cudaMemcpy(oh_a,o_a,size,cudaMemcpyDeviceToHost);

    int arithmetcMean = oh_a[0]/N;

    standardDeviation<<<1,N>>>(d_a1,arithmetcMean);

    Sum<<<1,N/2>>>(d_a1,o_a);

    cudaDeviceSynchronize();

    cudaMemcpy(oh_a,o_a,size,cudaMemcpyDeviceToHost);

    int tmp = oh_a[0]/N;

    printf("Standard Deviation is - %.2f\n", sqrt(tmp));

    cudaFree(d_a);
    free(h_a);
    cudaFree(o_a);
    free(oh_a);
    cudaFree(d_a1);

    return 0;
}

