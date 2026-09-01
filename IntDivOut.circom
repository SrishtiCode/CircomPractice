pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

template IntDivOut(n){
  signal input numerator;
  signal input denominator;
  signal output out;

  signal remainder;

  out <-- numerator \ denominator;
  remainder <-- numerator % denominator;

  numerator === denominator * out + remainder;

  component Lt = LessThan(n);
  Lt.in[0] <== remainder;
  Lt.in[1] <== denominator;

  Lt.out === 1;
}

component main = IntDivOut(252);
