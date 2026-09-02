pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/bitify.circom";

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 

template Pow() {
   
   // Your Code here.. 
   signal input a[2];
   signal output c;

   component bits = Num2Bits(8);
   bits.in <== a[1];

   signal bases[8];
   signal selected[8];
   signal results[8];

   bases[0] <== a[0];

   for( var i =1 ; i< 8 ; i++){
      bases[i] <== bases[i-1] * bases[i-1];
   }

   selected[0] <== 1 + bits.out[0] * (bases[0] - 1);
   results[0] <== selected[0];

   for( var i =1 ; i< 8 ; i++){
      selected[i] <== 1 + bits.out[i] * (bases[i] - 1);
      results[i] <== results[i-1] * selected[i];
   }

   c<==results[7];

}

component main = Pow();

