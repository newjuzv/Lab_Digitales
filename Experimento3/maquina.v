`include "Definitions.v"

`timescale 1ns / 1ps

localparam STATE_RESET = 0;
localparam STATE_POWERON_INIT_0 = 1;
localparam STATE_POWERON_INIT_1 = 2;
localparam STATE_POWERON_INIT_2 = 3;
localparam STATE_POWERON_INIT_3 = 4;
localparam STATE_POWERON_INIT_4 = 5;
localparam STATE_POWERON_INIT_5 = 6;
localparam STATE_POWERON_INIT_6 = 7;
localparam STATE_POWERON_INIT_7 = 8;
localparam STATE_POWERON_INIT_8 = 9;
localparam STATE_POWERON_INIT_9 = 10;
localparam STATE_POWERON_INIT_10 = 11;
localparam STATE_POWERON_INIT_11 = 12;
localparam STATE_POWERON_INIT_12 = 13;
localparam STATE_POWERON_INIT_13 = 14;
localparam STATE_POWERON_INIT_14 = 15;
localparam STATE_POWERON_INIT_15 = 16;
localparam STATE_POWERON_INIT_16 = 17;
localparam STATE_POWERON_INIT_17 = 18;
localparam STATE_POWERON_INIT_18 = 19;
localparam STATE_POWERON_INIT_19 = 20;
localparam STATE_POWERON_INIT_20 = 21;
localparam STATE_POWERON_INIT_21 = 22;
localparam STATE_POWERON_INIT_22 = 23;
localparam STATE_POWERON_INIT_23 = 24;
localparam STATE_POWERON_INIT_24 = 25;
localparam STATE_POWERON_INIT_25 = 26;

module Module_LCD_Control
(
input wire Clock ,
input wire Reset ,
input wire wWrite ,
input wire [ 7 : 0 ] wData ,
output reg wReady ,
output reg oLCD_Enabled ,
output reg oLCD_RegisterSelect ,
output wire oLCD_StrataFlashControl ,
output wire oLCD_ReadWrite ,
output reg [ 3 : 0 ] oLCD_Data
) ;

assign oLCD_ReadWrite = 0 ;
assign oLCD_StrataFlashControl = 1 ;
reg [7:0] rCurrentState , rNextState ;
reg [31:0] rTimeCount ;
reg rTimeCountReset ;

always @ ( posedge Clock )
begin
if ( Reset )
begin
rCurrentState = 'STATE_RESET;
rTimeCount = 32'b0 ;
end
else
begin
if ( rTimeCountReset )
rTimeCount = 32'b0 ;
else
rTimeCount = rTimeCount + 32'b1 ;
rCurrentState = rNextState ;
end
end

always @ ( * )
begin
case ( rCurrentState )
//
STATE_RESET:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h0 ;
oLCD_RegisterSelect = 1'b0 ;
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_0;
end
//
STATE_POWERON_INIT_0:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd750000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_1;
end

else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_0;
end
end
//

STATE_POWERON_INIT_1:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd11 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_2;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_1;
end
end
//

STATE_POWERON_INIT_2:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd205000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_3;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_2;
end
end
//
STATE_POWERON_INIT_3:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd11 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_4;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_3;
end
end
//
STATE_POWERON_INIT_4:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd5000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_5;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_4;
end
end
STATE_POWERON_INIT_5:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd11 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_6;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_5;
end
end
//
STATE_POWERON_INIT_6:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd2000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_7;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_6;
end
end
//
STATE_POWERON_INIT_7:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'h2 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd11 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_8;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_7;
end
end
//
STATE_POWERON_INIT_8:
begin
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
wReady = 1'b0 ;
if ( rTimeCount > 32'd2000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_9;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_8;
end
end
//
STATE_POWERON_INIT_9:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0010 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_10;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_9;
end
end
//
STATE_POWERON_INIT_10:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b1000 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_12;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_11;
end
end
//
STATE_POWERON_INIT_11:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd2000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_13;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_12;
end
end
STATE_POWERON_INIT_12:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0000 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_14;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_13;
end
end
STATE_POWERON_INIT_13:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0110 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_16;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_15;
end
end
//
STATE_POWERON_INIT_14:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd2000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_17;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_16;
end
end
//
STATE_POWERON_INIT_15:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0000 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_18;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_17;
end
end
//
STATE_POWERON_INIT_16:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b1101 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_20;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_19;
end
end
 //
STATE_POWERON_INIT_17:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd2000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_21;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_20;
end
end
//
STATE_POWERON_INIT_18:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0000 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_22;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_21;
end
end
//
STATE_POWERON_INIT_19:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0001 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_24;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_23;
end
end
//
STATE_POWERON_INIT_20:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd82000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_25;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_24;
end
end
//
 STATE_POWERON_INIT_21:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b1000 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_26;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_25;
end
end
//
STATE_POWERON_INIT_22:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = 4'b0000 ;
oLCD_RegisterSelect = 1'b0 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_28;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_27;
end
end
//
STATE_POWERON_INIT_23:
begin
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
wReady = 1'b0 ;
if ( rTimeCount > 32'd2000 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_29;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_28;
end
end
STATE_POWERON_INIT_24:
begin
wReady = 1'b1 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h3 ;
oLCD_RegisterSelect = 1'b0 ;
if (wWrite )
rNextState = STATE_POWERON_INIT_30;
else
rNextState = STATE_POWERON_INIT_29;
end
//
STATE_POWERON_INIT_25:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = wData [ 7 : 4 ] ;
oLCD_RegisterSelect = 1'b1 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_31;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_30;
end
end
//
 STATE_POWERON_INIT_26:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b1 ;
oLCD_Data = wData [ 3 : 0 ] ;
oLCD_RegisterSelect = 1'b1 ;
if ( rTimeCount > 32'd12 )
begin
rTimeCountReset = 1'b1 ;
rNextState = STATE_POWERON_INIT_28;
end
else
begin
rTimeCountReset = 1'b0 ;
rNextState = STATE_POWERON_INIT_32;
end
end
//
 default:
begin
wReady = 1'b0 ;
oLCD_Enabled = 1'b0 ;
oLCD_Data = 4'h0 ;
oLCD_RegisterSelect = 1'b0 ;
rTimeCountReset = 1'b0 ;
rNextState = STATE_RESET;
end
//
endcase
end
endmodule











