//You can include any C libraries that you normally use
#include "math.h"
#include "mex.h"   //--This one is required
#define min(a , b) ((a) <= (b) ? (a) : (b))
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
//---Inside mexFunction---

//Declarations
mxArray *xData;
double *xValues, *outArray;
int i,j;
int rowLen, colLen;

//Copy input pointer x
xData = prhs[0];

//Get matrix x
xValues = mxGetPr(xData);
rowLen = mxGetN(xData);
colLen = mxGetM(xData);


//Allocate memory and assign output pointer

plhs[0] = mxCreateDoubleMatrix(colLen, rowLen,mxREAL); //mxReal is our data-type

//Get a pointer to the data space in our newly allocated memory
outArray = mxGetPr(plhs[0]);


for(i=0;i<rowLen;i++)
{
outArray[i*colLen]=xValues[i*colLen]; //copy first row
}
 for (j=1;j<colLen;j++)      
 {
 for(i=0;i<rowLen;i++)
    {    
        if (i==0)
            outArray[(i*colLen)+j]= xValues[(i*colLen)+j]+ min(outArray[(i*colLen)+j-1],outArray[((i*colLen)+j+colLen)-1]);
        else 
        if (i+1==rowLen)
            outArray[(i*colLen)+j]= xValues[(i*colLen)+j]+min(outArray[(i*colLen)+j-1],outArray[(i*colLen)+j-colLen-1]);
       else
            outArray[(i*colLen)+j]= xValues[(i*colLen)+j]+min(outArray[(i*colLen)+j-1],min(outArray[(i*colLen)+j-colLen-1],outArray[(i*colLen)+j+colLen-1]));
    }
}




           
}