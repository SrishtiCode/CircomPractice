pragma circom 2.1.6;

template Add(){ //Template is like a class or function in this language
  signal input  in[3];

  in[0] === in[1] + in[2];
}

component main = Add(); //component is actual instance that will implement.
