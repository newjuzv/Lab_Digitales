module MULT_LUT_2_BITS(
	input wire [1:0] iA, //Entrada A
	input wire [1:0] iB, // Entrada B
	output reg [ 15:0 ] oResult_Mux //A*B
	);


always @ ( * ) {
	case (iB) :
		0 : oResult_Mux = 0 ; // multiplica por cero
		1 : oResult_Mux = iA ; // multiplica por uno
		2 : oResult_Mux = iA << 1 ; //Por dos
		3 : oResult_Mux = ( iA << 1) + iA ; //Por 3
		}
endmodule
