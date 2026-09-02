pragma circom 2.1.8;

template Summation(n) {
    signal input in[n];
    signal input sum;

    // constrain sum === in[0] + in[1] + in[2] + ... + in[n-1]
    // this should work for any n

    signal a[n+1];
    a[0] <== 0;

    for(var i=0;i<n;i++){
        a[i+1] <== a[i] + in[i];
    }

    sum === a[n];
}

component main = Summation(8);
