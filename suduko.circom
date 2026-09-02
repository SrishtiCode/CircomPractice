pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

//  HELLO EVERYONE THIS IS DAY 7 OF BUILDING IN ZK!!!
// SO TODAY WE ARE GOING TO BUILD SUDUKO OF 4*4 WHERE IT CHECKS WHETHER THE SUDUKO IS VALID OR NOT 


/*
    Given a 4x4 sudoku board with array signal input "question" and "solution", check if the solution is correct.

    "question" is a 16 length array. Example: [0,4,0,0,0,0,1,0,0,0,0,3,2,0,0,0] == [0, 4, 0, 0]
                                                                                   [0, 0, 1, 0]
                                                                                   [0, 0, 0, 3]
                                                                                   [2, 0, 0, 0]

    "solution" is a 16 length array. Example: [1,4,3,2,3,2,1,4,4,1,2,3,2,3,4,1] == [1, 4, 3, 2]
                                                                                   [3, 2, 1, 4]
                                                                                   [4, 1, 2, 3]
                                                                                   [2, 3, 4, 1]

    "out" is the signal output of the circuit. "out" is 1 if the solution is correct, otherwise 0.                                                                               
*/

//  SO  I SOLVED IT ONCE !! THE APPROACH WE ARE GOING TO USE IS FIRST CHECKING THERE ARE ONLY ONE TIME 1,2,3,4 IS PRESENT 
//FIRSTLY EVERY CELL MUST HAVE ONE 1,2,3,4,  LIKE IF WE COMPARE IT WITH THE ROW  OR COLUMN LATER BUT FIRSTLY IT ALLOW EXACTLY ONE VALUE OF 1,2,3,4
//THEN WE CHECK IN ROWS THAT IT HAVE UNIQUELY PLACED NUMBERS AND THEN IN COLUMN
//THEN IN BLOCK 2*2 HAVE ONLY 1,2,3,4                                                                                                          


template Sudoku () { 
    // Question Setup 
    signal input  question[16];
    signal input solution[16];
    signal output out;

    signal rowAcc[17];
    signal colAcc[17];
    signal blockAcc[17];
    
    // Checking if the question is valid -> checking the 4*4 matrix
    for(var v = 0; v < 16; v++){
        log(solution[v],question[v]);
        assert(question[v] == solution[v] || question[v] == 0);
    }
    
    var m = 0 ;
    component row1[4];
    for(var q = 0; q < 4; q++){
        row1[m] = IsEqual();
        row1[m].in[0]  <== question[q];
        row1[m].in[1] <== 0;
        m++;
    }
    3 === row1[3].out + row1[2].out + row1[1].out + row1[0].out;

    m = 0;
    component row2[4];
    for(var q = 4; q < 8; q++){
        row2[m] = IsEqual();
        row2[m].in[0]  <== question[q];
        row2[m].in[1] <== 0;
        m++;
    }
    3 === row2[3].out + row2[2].out + row2[1].out + row2[0].out; 

    m = 0;
    component row3[4];
    for(var q = 8; q < 12; q++){
        row3[m] = IsEqual();
        row3[m].in[0]  <== question[q];
        row3[m].in[1] <== 0;
        m++;
    }
    3 === row3[3].out + row3[2].out + row3[1].out + row3[0].out; 

    m = 0;
    component row4[4];
    for(var q = 12; q < 16; q++){
        row4[m] = IsEqual();
        row4[m].in[0]  <== question[q];
        row4[m].in[1] <== 0;
        m++;
    }
    3 === row4[3].out + row4[2].out + row4[1].out + row4[0].out; 

    // Write your solution from here.. Good Luck! //I think instead of logic there is syntax problem
    
    // Firsly every solution cell must have one 1,2,3,4

    component e1[16]; //defining e1 to put check  the all  16 values
    component e2[16];
    component e3[16];
    component e4[16];

    for( var i = 0 ; i < 16; i++){
        e1[i] = IsEqual(); //putting the function isequal in e1 because we want to check if they are equal to 1,2,3,4
        e2[i] = IsEqual();
        e3[i] = IsEqual();
        e4[i] = IsEqual();

        //checking if solution[i] = 1
        e1[i].in[0] <== solution[i];
        e1[i].in[1] <== 1; //if both are equal it will return 1 

        e2[i].in[0] <== solution[i];
        e2[i].in[1] <== 2; //if both are equal it will return 1 else 0

        

        e3[i].in[0] <== solution[i];
        e3[i].in[1] <== 3; //if both are equal it will return 1

        e4[i].in[0] <== solution[i];
        e4[i].in[1] <== 4; //if both are equal it will return 1  I hate there is no color in this 

        // so the one row have three 0 and one 1 [0,1,0,0] like this because only 1 number will match so the sum will be 1.
        e1[i].out + e2[i].out + e3[i].out + e4[i].out === 1;// Each row will have one number unique
    }  

    //Checking the rows

    component rowA[16];
    component rowB[16];
    component rowC[16];
    component rowD[16];

    component rowValid[16];
    signal rowCount[16];

    var k = 0;

    // Row -> contain 1,2,3,4 exactly once 
    
    for (var r = 0 ; r < 4; r++){// first in row  
        for (var n = 1; n<=4; n++){
            rowA[k] = IsEqual();
            rowB[k] = IsEqual();
            rowC[k] = IsEqual();
            rowD[k] = IsEqual();

            rowValid[k] = IsZero();

            rowA[k].in[0] <== solution[r * 4];//when r = 0 it start with 0 and goes it will give value 0,4,8,12 like 0 4 8 12
            rowA[k].in[1] <== n;

            rowB[k].in[0] <== solution[r * 4 + 1];//when r = 1 it start with 5// sorry I started solving on paper as I got confused 1 5 9 13
            rowB[k].in[1] <== n;// it will give value 1,5,9,13

            rowC[k].in[0] <== solution[r * 4 + 2];//So like in each loop it starting from 0 and going 1 2 3 2 6 10 14
            rowC[k].in[1] <== n;

            rowD[k].in[0] <== solution[r * 4 + 3];// 3 7 11 15
            rowD[k].in[1] <== n;

            rowCount[k] <== rowA[k].out + rowB[k].out + rowC[k].out + rowD[k].out - 1; //All the value of sum should be 1

            rowValid[k].in <== rowCount[k];
            k++;
        }
    }   


    //Columns
    //Checking if they have exactly one 1,2,3,4

    component colA[16];
    component colB[16];
    component colC[16];
    component colD[16];

    component colValid[16];

    signal colCount[16];

    k = 0;

    for (var c = 0 ; c < 4; c++){// first in column
        for (var n = 1; n<=4; n++){
            colA[k] = IsEqual();
            colB[k] = IsEqual();
            colC[k] = IsEqual();
            colD[k] = IsEqual();

            colValid[k] = IsZero();

            colA[k].in[0] <== solution[c];//0 1 2 3
            colA[k].in[1] <== n;

            colB[k].in[0] <== solution[4 + c];//4 5 6 7
            colB[k].in[1] <== n;

            colC[k].in[0] <== solution[8 + c];//8 9 10 11
            colC[k].in[1] <== n;

            colD[k].in[0] <== solution[12 + c];//12 13 14 15 
            colD[k].in[1] <== n;

            colCount[k] <== colA[k].out + colB[k].out + colC[k].out + colD[k].out - 1; //All the value of sum should be 1

            colValid[k].in <== colCount[k];
            k++;
        }
    }   

    // 2 * 2 blocks

    // so blockCol = 0 -> left block
    // blockCol = 1 -> right block

    // think like a graph signs (0,0), (0,1), (1,0), (1,1)
    // (blockRow = 0, blockCol = 0) -> top left
    // (blockRow = 0, blockCol = 1) -> top right
    // (blockRow = 1, blockCol = 0) -> bottom left
    // (blockRow = 1, blockCol = 1) -> bottom right

    // these blocks should contain exactly one 1,2,3,4

    component blockA[16];
    component blockB[16];
    component blockC[16];
    component blockD[16];    

    component blockValid[16];
    signal blockCount[16];

    k =0;

    for (var blockRow = 0; blockRow <2; blockRow++){
        for (var blockCol = 0; blockCol <2 ; blockCol++){
            for(var n =1; n<=4; n++){

                blockValid[k] = IsZero();

                blockA[k] = IsEqual();
                blockB[k] = IsEqual();
                blockC[k] = IsEqual();
                blockD[k] = IsEqual();

                var start = blockRow * 8 + blockCol * 2;

                blockA[k].in[0] <== solution[start];
                blockA[k].in[1] <== n;

                blockB[k].in[0] <== solution[start + 1];
                blockB[k].in[1] <== n;

                blockC[k].in[0] <== solution[start + 4];
                blockC[k].in[1] <== n;

                blockD[k].in[0] <== solution[start + 5];
                blockD[k].in[1] <== n;

                blockCount[k] <== blockA[k].out + blockB[k].out + blockC[k].out + blockD[k].out - 1;

                blockValid[k].in <== blockCount[k];

                k++;

            }
        }
    }

    signal finalCheck;

    rowAcc[0] <== 1;
    colAcc[0] <== 1;
    blockAcc[0] <== 1;

    for (var i=0; i<16; i++){
        rowAcc[i+1] <== rowAcc[i] * rowValid[i].out;
        colAcc[i+1] <== colAcc[i] * colValid[i].out;
        blockAcc[i+1] <== blockAcc[i] * blockValid[i].out;
    }

    finalCheck <== rowAcc[16] * colAcc[16];

    out <== finalCheck * blockAcc[16];   
}


component main = Sudoku();



