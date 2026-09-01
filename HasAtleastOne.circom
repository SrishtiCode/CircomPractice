pragma circom 2.1.8;

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.

// So the approach is we have to check if an array like - [1,2,3,4] have k=4 or not 
// If 4 is in array it will return 1 else 0

// So we change every element in 0 and 1 and if matches it will 1 and then OR it so if there is k present
// it will be 1 else it will 0

//To check if the element is zero

template iszero(){
  signal input in;
  signal output out;
  signal inv;

  inv <-- 1/in;
  out <-- 1 - in * inv;

  in * out === 0;
}

template HasAtLeastOne(n){
  signal input in[n];
  signal input k;
  signal output out;

  component check[n];

  for (var i=0; i<n; i++){
    check[i] = iszero();
    //giving check[i] that is iszero a input which is equal to in[i] - k
    //check[i].in = 0 - 15 => iszero(-15) => 0 
    check[i].in <== in[i] - k;//so it is either 0 or some random number 
  }

  signal result[n];

  result[0] <== check[0].out;
  
  for(var i=1; i<n; i++){
    // 1 OR 1 = 1 => 1 + 1 - 1*1 = 1
    // 1 OR 0 = 1 => 1 + 0 - 1*0 = 1
    // 0 OR 1 = 1 => 0 + 1 - 0*1 = 1
    // 0 OR 0 = 0 => 0 + 0 - 0*0 = 0
    result[i] <== result[i-1] + check[i].out - result[i-1]*check[i].out;// Just the OR fucntion
  }

  out <== result[n-1];
}

component main = HasAtLeastOne(4);
