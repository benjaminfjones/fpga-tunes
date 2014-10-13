`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:40:26 10/09/2014
// Design Name:   mojo_top
// Module Name:   /home/bjones/src/fpga-tunes/test/mojo_top_tb.v
// Project Name:  fpga-tunes
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mojo_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mojo_top_tb;

	// Inputs
	reg clk;
	reg rst_n;
	reg cclk;
	reg spi_ss;
	reg spi_mosi;
	reg spi_sck;
	reg avr_tx;
	reg avr_rx_busy;
	reg [4:0] button;

	// Outputs
	wire [7:0] led;
	wire spi_miso;
	wire [3:0] spi_channel;
	wire avr_rx;
	wire [7:0] dac;

	// Instantiate the Unit Under Test (UUT)
	mojo_top uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.cclk(cclk), 
		.led(led), 
		.spi_miso(spi_miso), 
		.spi_ss(spi_ss), 
		.spi_mosi(spi_mosi), 
		.spi_sck(spi_sck), 
		.spi_channel(spi_channel), 
		.avr_tx(avr_tx), 
		.avr_rx(avr_rx), 
		.avr_rx_busy(avr_rx_busy), 
		.dac(dac), 
		.button(button)
	);
	
	assign led[4:0] = button;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		cclk = 0;
		spi_ss = 0;
		spi_mosi = 0;
		spi_sck = 0;
		avr_tx = 0;
		avr_rx_busy = 0;
		button = 0;

		// 10 ns without clock
		#10
		// 10 ns with clock
		repeat(10) #1 clk = ~clk;
		// bring rst low
		rst_n = ~rst_n;
        
		// Press buttons 0 - 3 at increasing intervals
		button[0] = 1;
		repeat(20000) #1 clk = ~clk;
		
		button[1] = 1;
		repeat(40000) #1 clk = ~clk;
		
		button[2] = 1;
		repeat(160000) #1 clk = ~clk;
		
		button[3] = 1;
		repeat(320000) #1 clk = ~clk;
		
		$finish;

	end
      
endmodule

