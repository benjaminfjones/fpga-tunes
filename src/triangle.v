`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:29 10/08/2014 
// Design Name: 
// Module Name:    triangle 
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
module triangle #(parameter CTR_SIZE = 8) (
	input  clk,
	input  rst,
	input  [CTR_SIZE-1:0] invslope,
	output [CTR_SIZE-1:0] out
    );

reg out_d, out_q;
reg [CTR_SIZE-1:0] ctr_d, ctr_q;
reg [CTR_SIZE-1:0] dir;

assign out = out_q;

always@(*) begin
    ctr_d = ctr_q + 1'b1;
	 if (ctr_d > invslope) begin
	     out_d = out_q + 1'b1;
		  
    end else begin
        pwm_d = 1'b1;
    end		  
end

always@(posedge clk) begin
    if (rst) begin
	     ctr_q <= 1'b0;
		  dir_q <= 8'd1;
	 end else begin
	     ctr_q <= ctr_d;
		  dir_q <= dir_d;
	 end
	 out_q <= out_d;
end

endmodule
