
`timescale 1ns / 1ps
`include "Defintions.v"


module MiniAlu
(
 input wire Clock,
 input wire [1:0] iA,
 input wire [1:0] iB,
 input wire [3:0] iA2,
 input wire [3:0] iB2,
 
 input wire Reset,
 output wire [7:0] oLed,
 output wire [3:0] oResult_Mux,
 output wire [3:0] oResult_Mux4

 );

wire [15:0]  wIP,wIP_temp;
reg         rWriteEnable,rBranchTaken;
wire [27:0] wInstruction;
wire [3:0]  wOperation;
reg [15:0]   rResult;
reg [3:0] rResult4;
wire [7:0]  wSourceAddr0,wSourceAddr1,wDestination;
wire [15:0] wSourceData0,wSourceData1,wIPInitialValue,wImmediateValue;

wire [9:0] wA, wB;
wire [31:0] R;

reg signed [15:0] wAs, wBs;
reg signed [31:0] rRs;

ROM InstructionRom 
(
	.iAddress(     wIP          ),
	.oInstruction( wInstruction )
);

RAM_DUAL_READ_PORT DataRam
(
	.Clock(         Clock        ),
	.iWriteEnable(  rWriteEnable ),
	.iReadAddress0( wInstruction[7:0] ),
	.iReadAddress1( wInstruction[15:8] ),
	.iWriteAddress( wDestination ),
	.iDataIn(       rResult      ),
	.oDataOut0(     wSourceData0 ),
	.oDataOut1(     wSourceData1 )
);

assign wIPInitialValue = (Reset) ? 8'b0 : wDestination;

MULT_LUT_2_BITS Lut2(
					.iA(iA),
					.iB(iB),
					.oResult_Mux(oResult_Mux)
					);
					
MULT_LUT_4_BITS Lut4(
					.iA2(iA2),
					.iB2(iB2),
					.oResult_Mux4(oResult_Mux4)
					);
	

UPCOUNTER_POSEDGE IP
(
.Clock(   Clock                ), 
.Reset(   Reset | rBranchTaken ),
.Initial( wIPInitialValue + 1  ),
.Enable(  1'b1                 ),
.Q(       wIP_temp             )
);
assign wIP = (rBranchTaken) ? wIPInitialValue : wIP_temp;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD1 
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[27:24]),
	.Q(wOperation)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD2
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[7:0]),
	.Q(wSourceAddr0)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD3
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[15:8]),
	.Q(wSourceAddr1)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD4
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[23:16]),
	.Q(wDestination)
);


reg rFFLedEN;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LEDS
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( rFFLedEN ),
	.D( wSourceData1 ),
	.Q( oLed    )
);

assign wImmediateValue = {wSourceAddr1,wSourceAddr0};



always @ ( * )
begin
	case (wOperation)
	//-------------------------------------
	`NOP:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
	end
	//-------------------------------------
	`ADD:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult      <= wSourceData1 + wSourceData0;
	end
	//-------------------------------------
    `SUB:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult      <= wSourceData1 - wSourceData0;
	end
	//-------------------------------------
	`MUL:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult            <= wSourceData0 * wSourceData1; //multiplicacion sin signo
	end
	//-------------------------------------
	`MULs:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		wAs <= wSourceData0;
		wBs <= wSourceData1;
		rRs            <= wAs * wBs; //multiplicacion con signo
		rResult <= rRs[15:8];
	end
	//-------------------------------------
	`STO:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b1;
		rBranchTaken <= 1'b0;
		rResult      <= wImmediateValue;
	end
	//-------------------------------------
	`BLE:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
		if (wSourceData1 <= wSourceData0 )
			rBranchTaken <= 1'b1;
		else
			rBranchTaken <= 1'b0;
		
	end
	//-------------------------------------	
	`JMP:
	begin
		rFFLedEN     <= 1'b0;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b1;
	end
	//-------------------------------------	
	`LED:
	begin
		rFFLedEN     <= 1'b1;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b0;
	end
	
	`MULT_LUT_2_BITS:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult4 <= oResult_Mux;
	end
	//-------------------------------------
	
	
	//-------------------------------------
	default:
	begin
		rFFLedEN     <= 1'b1;
		rWriteEnable <= 1'b0;
		rResult      <= 0;
		rBranchTaken <= 1'b0;
	end	
	//-------------------------------------	
	endcase	
end


endmodule

//*****************************************************************************//

module MULT_LUT_2_BITS(iA, iB, oResult_Mux);
	
input wire [1:0] iA; //Entrada A
input wire [1:0] iB; // Entrada B
output reg [3:0] oResult_Mux; //A*B
	
	always @*
	begin
	
	case (iB)
	
	0 : oResult_Mux = 0 ; // multiplica por cero
	1 : oResult_Mux = iA ; // multiplica por uno
	2 : oResult_Mux = iA << 1 ; //Por dos
	3 : oResult_Mux = ( iA << 1) + iA ; //Por 3
	
	endcase
		
	end //end always
	
	endmodule
	
//*****************************************************************************//
	
module MULT_LUT_4_BITS(iA2, iB2, oResult_Mux4);
	
input wire [3:0] iA2; //Entrada A
input wire [3:0] iB2; // Entrada B
output reg [7:0] oResult_Mux4; //A*B
	
	always @*
	begin
	
	case (iB2)
	
	0 : oResult_Mux4 = 0 ; // multiplica por cero
	1 : oResult_Mux4 = iA2 ; // multiplica por uno
	2 : oResult_Mux4 = iA2 << 1 ; //Por dos
	3 : oResult_Mux4 = ( iA2 << 1) + iA2 ; //Por 3
	4 : oResult_Mux4 = iA2 << 2 ; //Por 4
	5 : oResult_Mux4 = ( iA2 << 2) + iA2 ; //Por 5
	6 : oResult_Mux4 = iA2 << 3; //Por 6
	7 : oResult_Mux4 = ( iA2<< 3) + iA2 ; //Por 7
	
	endcase
		
	end //end always
	
	endmodule
	
