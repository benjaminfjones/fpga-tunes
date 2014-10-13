module mojo_top(
    // 50MHz clock input
    input  clk,
    // Input from reset button (active low)
    input  rst_n,
    // cclk input from AVR, high when AVR is ready
    input  cclk,
    // Outputs to the 8 onboard LEDs
    output [7:0] led,
    // AVR SPI connections
    output spi_miso,
    input  spi_ss,
    input  spi_mosi,
    input  spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input  avr_tx,      // AVR Tx => FPGA Rx
    output avr_rx,      // AVR Rx => FPGA Tx
    input  avr_rx_busy, // AVR Rx buffer full
	 // external interfaces
	 output [7:0] dac,   // external 8-bit dac
	 input  [4:0] button // external buttons
    );

wire rst = ~rst_n; // make reset active high

wire [3:0] gen;  // hook up to wave generators

// these signals should be high-z when not used
assign spi_miso = 1'bz;
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;

// ADC input(s)
wire [3:0] channel;
wire new_sample;
wire [9:0] sample;
wire [3:0] sample_channel;
wire [7:0] adc_wire;

wire [24-1:0] m_period;

assign m_period = (1 << 8) * adc_wire;

// Button indicators
// XXX LEDs now tied to potentiometer
// assign led = {0,0,0,0,button[3:0]};

// DAC output levels on the 4 voices
//
localparam a0 = 16;  // 8'd128;
localparam a1 = 32;  // 8'd64;
localparam a2 = 64;  // 8'd32;
localparam a3 = 128;  // 8'd16;

// XXX Why does this fail to update?
// assign dac[7:0] = a0 & {8{gen[0] & button[0]}} +
//                  a1 & {8{gen[1] & button[1]}} +
//                  a2 & {8{gen[2] & button[2]}} +
//                  a3 & {8{gen[3] & button[3]}};

assign dac[7:0] = (gen[0] & button[0] ? a0 : 0) +
  (gen[1] & button[1] ? a1 : 0) +
  (gen[2] & button[2] ? a2 : 0) +
  (gen[3] & button[3] ? a3 : 0);

// Square waveforms with 4 different frequencies
// (controlled by the p_i paramters) and 50% duty
// cycle (controlled by the compare parameters)
//
localparam p0 = 1 << 12;
localparam p1 = 1 << 14;
localparam p2 = 1 << 16;
localparam p3 = 1 << 18;

pwm pwm0 (
  .clk(clk),
  .rst(rst),
  .period(p0),
  .compare(p0/2),
  .pwm(gen[0])
  );

pwm pwm1 (
  .rst(rst),
  .clk(clk),
  .period(p1),
  .compare(p1/2),
  .pwm(gen[1])
  );

pwm pwm2 (
  .rst(rst),
  .clk(clk),
  .period(p2),
  .compare(p2/2),
  .pwm(gen[2])
  );

pwm pwm3 (
  .rst(rst),
  .clk(clk),
  .period(m_period),
  .compare(m_period/2),
  .pwm(gen[3])
  );

// PWM test
//
// generate 8 pulse waveforms and output to LED array
// genvar i;
// generate
//     for (i = 0; i < 8; i=i+1) begin: pwm_gen_loop
//         pwm #(.CTR_SIZE(3)) pwm (
//             .rst(rst),
//             .clk(clk),
//             .compare(i),
//             .pwm(led[i])
//         );
//     end
// endgenerate

// Blinker test
//
//assign led[7:1] = 7'b0101010;
//blinker blinkLastLed(.clk(clk), .rst(rst), .blink(led[0]));

// Interface with microcontroller

avr_interface avr_interface (
    .clk(clk),
    .rst(rst),
    .cclk(cclk),
    .spi_miso(spi_miso),
    .spi_mosi(spi_mosi),
    .spi_sck(spi_sck),
    .spi_ss(spi_ss),
    .spi_channel(spi_channel),
    .tx(avr_rx),
    .rx(avr_tx),
    .channel(channel),
    .new_sample(new_sample),
    .sample(sample),
    .sample_channel(sample_channel),
    .tx_data(8'h00),
    .new_tx_data(1'b0),
    .tx_busy(),
    .tx_block(avr_rx_busy),
    .rx_data(),
    .new_rx_data()
);

// ADC sampler 
analog_input analog_input (
    .clk(clk),
    .rst(rst),
    .channel(channel),
    .new_sample(new_sample),
    .sample(sample),
    .sample_channel(sample_channel),
    .out(adc_wire) 
);

wire led_pwm_wire;
assign led = {8{led_pwm_wire}};
pwm led_pwm ( // 10bit PWM
    .clk(clk),
    .rst(rst),
	 .period({10{1'b1}}),
    .compare(adc_wire),
    .pwm(led_pwm_wire)
);


endmodule
