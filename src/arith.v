`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:23:15 10/10/2014 
// Design Name: 
// Module Name:    arith 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module arith(
    input [7:0] a,
	 input [7:0] b,
	 output [7:0] out
    );

    assign out = 1'b1 << 3;
	 
endmodule

