pragma circom 2.1.4;

// In this exercise , we will learn how to check the range of a private variable and prove that 
// it is within the range . 

include "../node_modules/circomlib/circuits/comparators.circom";


// For example we can prove that a certain person's income is within the range
// Declare 3 input signals `a`, `lowerbound` and `upperbound`.
// If 'a' is within the range, output 1 , else output 0 using 'out'


template Range() {
    // your code here
    signal input a;
    signal input lowerbound;
    signal input upperbound;
    signal output out;

    component lower = LessEqThan(252);
    component upper = LessEqThan(252);

    lower.in[0] <== lowerbound;
    lower.in[1] <== a;

    upper.in[0] <== a;
    upper.in[1] <== upperbound;

    out <== lower.out * upper.out;
 
}

component main  = Range();


