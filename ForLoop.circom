pragma circom 2.1.4;

// Input : 'a',array of length 2 .
// Output : 'c 
// Using a forLoop , add a[0] and a[1] , 4 times in a row .

// So we want sum[3] = 4 * (a[0] + a[1]). We an do this but it is asking for the for loop.
template ForLoop() {

// Your Code here..
  signal input a[2];
  signal output c;

  signal sum[4];

  sum[0] <== a[0] + a[1];

  for(var i=1; i<4; i++){
    sum[i] <== sum[i-1] + a[0] + a[1];
  }
c <== sum[3];
}  

component main = ForLoop();

// Let a = [3,7] 
//sum[1] = sum[0] + a[0] + a[1]; => sum[0] = 3 + 7 
//sum[1] = 10 + 3 + 7 = 20 
//sum[2] = 20 + 3 + 7 = 30 
//sum[3] = 30 + 3 + 7 = 40 
//sum[3] = 4 * a0 + a1
