pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.

function intSqrtFloor(x){
  //compute the floor of the 
  //integer square root
  var r = 0;
  while ((r+1) * (r+1) <= x){
    r++;
  }
  return r;
}

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    out <-- intSqrtFloor(in);
    // constrain out using your
    // work from IntSqrt

    signal lower;
    signal upper;

    lower <== (out - 1) * (out -1);
    upper <== (out + 1) * (out + 1);

    component I1 = LessThan(n);
    component I2 = LessThan(n);

    I1.in[0] <== lower;
    I1.in[1] <== in;

    I2.in[0] <==  in;
    I2.in[1] <==  upper;

    I1.out === 1;
    I2.out === 1;

}

component main = IntSqrtOut(252);
