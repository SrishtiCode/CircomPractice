// Create a circuit that is satisfied if
// in[0] is the floor of the integer
// sqrt of in[1]. For example:
// 
// int[2, 5] accept
// int[2, 5] accept
// int[2, 9] reject
// int[3, 9] accept
//
// If b is the integer square root of a, then
// the following must be true:
//
// (b - 1)(b - 1) < a
// (b + 1)(b + 1) > a
// 
// be careful when verifying that you 
// handle the corner case of overflowing the 
// finite field. You should validate integer
// square roots, not modular square roots

template IntSqrt(n) {
    signal input in[2];

    signal sq1;
    signal sq2;

    sq1 <== (in[0] -1) * (in[0]-1);
    sq2 <== (in[0] +1) * (in[0]+1);

    component I1 = LessThan(n);
    component I2 = LessThan(n);

    I1.in[0] <== sq1;
    I1.in[1] <== in[1];

    I2.in[0] <==  in[1];
    I2.in[1] <== sq2;

    I1.out === 1;
    I2.out === 1;
}
