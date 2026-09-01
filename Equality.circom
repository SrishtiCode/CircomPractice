// The circuit is checking if all three inputs are equal
// For example : [5,5,5] -> c = 1
//[5,5,7] -> c = 0
pragma circom 2.1.4;

template iszero(){
  signal input in;
  signal output out;
  signal inv;

  inv <-- 1/in;
  out <-- 1 - in * inv;
  in * out === 0;
}

template Equality(){
  signal input a[3];
  signal output c;

  component eq1 = iszero();//creating two copies of iszero circuit
  component eq2 = iszero();

  eq1.in <== a[0] - a[1];//let a[0] = 5, let a[1] = 5 so IsZero(0) = 1
  eq2.in <== a[1] - a[2];// else 0

  c <== eq1.out * eq2.out; //if all are equal meaning both eq1 and eq2 will give the 1 so answer will be 1 else it will give 0 
}

component main = Equality();
