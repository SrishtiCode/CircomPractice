pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in` and
// returns 1 if all of the signals are 1. If any of the
// signals are 0 return 0. If any of the signals are not
// 0 or 1 the circuit should not be satisfiable.

template MultiAND(n) {
    signal input in[n];
    signal output out;

    signal temp[n];

    for(var i =0; i<n;i++){
        in[i] * (in[i]-1) === 0;
    }

    temp[0] <== in[0];

    for(var i=1;i<n;i++){
        temp[i] <== temp[i-1] * in[i];
    }

    out <== temp[n-1];

}

component main = MultiAND(4);
