#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#include<math.h>

#define N 10

__global__ void fMatrixMultiplication (int *A,int *B,int *C)
{
  int ROW = blockIdx.y*blockDim.y+threadIdx.y;
  int COL = blockIdx.x*blockDim.x+threadIdx.x;

  int tmpSum = 0;

  if (ROW < N && COL < N) {
      // each thread computes one element of the block sub-matrix
      for (int i = 0; i < N; i++) {
          tmpSum += A[ROW * N + i] * B[i * N + COL];
      }
      C[ROW * N + COL] = tmpSum;
    }
}

int main()
{
    int *h_A,*h_B,*h_C;

    int cnt=1;

    int size = N*N*sizeof(int);

    h_A = (int*) malloc(size);
    h_B = (int*) malloc(size);
    h_C = (int*) malloc(size);

    // Initialize matrices on the host
    for (int i=1; i<=N*N; i++){
      if(cnt==N+1)
        cnt = 1;
      h_A[i-1] = cnt;
      h_B[i-1] = cnt;
      cnt+=1;
    }

    printf("Matrix A\n");
    for (int i=0; i<N*N; i++){
	     printf("%d", h_A[i]);
	     if(i%N==N-1)
		    printf("\n");
    }
    printf("\n");

    printf("Matrix B\n");
    for (int i=0; i<N*N; i++){
	     printf("%d", h_B[i]);
	     if(i%N==N-1)
		      printf("\n");
    }
    printf("\n");

    int *d_A,*d_B,*d_C;

    cudaMalloc((void**)&d_A,size);
    cudaMalloc((void**)&d_B,size);
    cudaMalloc((void**)&d_C,size);

    cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,h_B,size,cudaMemcpyHostToDevice);

    // declare the number of blocks per grid and the number of threads per block
    // use 1 to 512 threads per block
    dim3 threadsPerBlock(N, N);
    dim3 blocksPerGrid(1, 1);
     
    fMatrixMultiplication<<<blocksPerGrid,threadsPerBlock>>>(d_A,d_B,d_C);

    cudaDeviceSynchronize();

    cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost);
    
    printf("Matrix C = A*B\n");
        
    for (int i=0; i<N*N; i++){
        cout<<h_C[i]<<" ";
        if(i%N==N-1)
          printf("\n");
    }

    cudaFree(d_A);
    free(h_A);
    cudaFree(d_B);
    free(h_B);
    cudaFree(d_C);
    free(h_C);

    return 0;
}