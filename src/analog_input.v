`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:39 10/10/2014 
// Design Name: 
// Module Name:    analog_input 
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

module analog_input(
    input clk,
    input rst,
    output [3:0] channel,
    input new_sample,
    input [9:0] sample,
    input [3:0] sample_channel,
    output [9:0] out
);
 
assign channel = 4'd0; // only read A0
 
reg [9:0] sample_d, sample_q;

assign out = sample_q;
 

 
//assign out = {8{pwm}}; // duplicate the PWM signal to each LED
 
always @(*) begin
    sample_d = sample_q;
 
    if (new_sample && sample_channel == 4'd0) // valid sample
        sample_d = sample;
end
 
always @(posedge clk) begin
    if (rst) begin
        sample_q <= 10'd0;
    end else begin
        sample_q <= sample_d;
    end
end
 
endmodule

