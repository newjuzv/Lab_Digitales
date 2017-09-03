`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:30:52 01/30/2011
// Design Name:   MiniAlu
// Module Name:   D:/Proyecto/RTL/Dev/MiniALU/TestBench.v
// Project Name:  MiniALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MiniAlu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg Clock;
	reg Reset;

	// Outputs
	wire [7:0] oLed;
	reg [1:0] oA; //Entrada A
	reg [1:0] oB; // Entrada B
	reg [3:0] oA2; //Entrada A
	reg [3:0] oB2; //Entrada B
	

	// Instantiate the Unit Under Test (UUT)
	MiniAlu uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.oLed(oLed),
		.iA(oA),
		.iB(oB),
		.iA2(oA2),
		.iB2(oB2)
		
	);
	
	always
	begin
		#5  Clock =  ! Clock;

	end

	initial begin
		// Initialize Inputs
		#0
		Clock = 0;
		Reset = 0;
		oA = 2'b11;
		oB= 2'b01;
		oA2 = 4'b1000;
		oB2 = 4'b1000;
		
		#20
		oA = 2'b01;
		oB= 2'b10;
		oA2 = 4'b1111;
		oB2 = 4'b1111;
		
		
		#20
		oA = 2'b10;
		oB= 2'b10;
		oA2 = 4'b0000;
		oB2 = 4'b0000;
		
		#20
		oA = 2'b11;
		oB= 2'b11;
		oA2 = 4'b0111;
		oB2 = 4'b0101;
		
		#20

		oA2 = 4'b0111;
		oB2 = 4'b0111;
		
		#20

		oA2 = 4'b0101;
		oB2 = 4'b0101;
		
		#20

		oA2 = 4'b0011;
		oB2 = 4'b0111;
		
		#20
		oA = 2'b0;
		oB= 2'b0;
		oA2 = 4'b1011;
		oB2 = 4'b1101;
		
		

		// Wait 100 ns for global reset to finish
		#100
		Reset = 1;
		#50
		Reset = 0;
        
		// Add stimulus here

	end
      
endmodule

