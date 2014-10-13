`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:19:44 10/07/2014 
// Design Name: 
// Module Name:    pwm 
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
module pwm #(parameter MAX_WAVE = 24) (
  input clk,
  input rst,
  input [MAX_WAVE-1:0] period,
  input [MAX_WAVE-1:0] compare,
  output pwm
  );

reg pwm_d, pwm_q;
reg [MAX_WAVE-1:0] ctr_d, ctr_q;

assign pwm = pwm_q;

always@(ctr_q) begin
    // reset ctr when we get to period, else increment
    if (ctr_q > period) begin
        ctr_d = 1'b0;
    end else begin
        ctr_d = ctr_q + 1'b1;
    end

    // set pwm based on ctr and compare threshold
    if (compare > ctr_d) begin
        pwm_d = 1'b0;
    end else begin
        pwm_d = 1'b1;
    end
end

always@(posedge clk) begin
    if (rst) begin
        ctr_q <= 1'b0;
		  pwm_q <= 1'b0;
    end else begin
        ctr_q <= ctr_d;
		  pwm_q <= pwm_d;
    end
end

endmodule
