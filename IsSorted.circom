pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted(){
  signal input in[4];

  component check0 = LessEqThan(252);
  component check1 = LessEqThan(252);
  component check2 = LessEqThan(252);

  check0.in[0] <== in[0];
  check0.in[1] <== in[1];

  check0.in[0] <== in[1];
  check0.in[1] <== in[2];
  
  check0.in[0] <== in[2];
  check0.in[1] <== in[3];

  check0.out === 1;
  check1.out === 1;
  check2.out === 1;
  
}

component main = IsSorted();
