pragma circom 2.1.8;

// Create constraints that enforces all signals
// in `in` are binary, i.e. 0 or 1. So the answer should be either one and zero
// In circom there is rule that a statement can have only one multiplication. 
// So, we can simply do (n)*(n-1)=0,  this equation can only have two solution 1 and 0
// we have to use for loop here because we don't know the input value

template AllBinary(n) {
    signal input in[n];
    for (var i=0; i<n ; i++){
        in[i] * (in[i] - 1) === 0;
    }
}

component main = AllBinary(4);

