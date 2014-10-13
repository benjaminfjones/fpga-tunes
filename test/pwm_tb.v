`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:54:44 10/08/2014
// Design Name:   pwm
// Module Name:   /home/bjones/src/fpga-led-counter/test/pwm_tb.v
// Project Name:  fpga-led-counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pwm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module pwm_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [23:0] compare0;
	reg [23:0] period0;

	// Outputs
	wire pwm_out;

	// Instantiate the Unit Under Test (UUT)
	pwm uut (
		.clk(clk), 
		.rst(rst),
		.period(period0),
		.compare(compare0), 
		.pwm(pwm_out)
	);

	// clock and reset block
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		// Wait 100 ns for global reset to finish
		#10;
		// toggle clock a bit
		repeat(4) #1 clk = ~clk;
		// bring rst low
		rst = 0;
		// generate the clock forever
		forever #1 clk = ~clk;
	end
	
	// set parameters for pwm modules
	initial begin
		compare0 = 0;
		period0  = 0;
		@(negedge rst);  // wait for reset to lower
		compare0 = 192;  // 75%
		period0  = 256;
		repeat(1000) @(posedge clk);
		$finish;
	end
      
endmodule

