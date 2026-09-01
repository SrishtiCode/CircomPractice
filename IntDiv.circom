pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
  signal input numerator;
  signal input denominator;
  signal input quotient;
  signal input remainder;

  numerator === denominator * quotient + remainder;

  //To check remainder < denominator

  component Lt = LessThan(n);
  Lt.in[0] <== remainder;
  Lt.in[1] <== denominator;

  //If remainder < deominator , it should 1 else 0

  Lt.out === 1;
}

component main = IntDiv(252);
