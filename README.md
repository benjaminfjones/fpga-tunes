# fpga-tunes

The goal of this project is to replicate the functionality of the MOS
Technology SID 6581 sound chip by combining a small FPGA development board for
the digital functions and hand crafted analog circuits for the analog aspects.

The FPGA platform we've chosen is the [Mojo
v3](https://embeddedmicro.com/mojo-v3.html) from Embedded Micro. It features a
Xilinx Spartan 6 FPGA, onboard microproccesor and ADCs, and 84 broken out
digital IO pins. It's very easy to get started programming the Mojo, highly
recommended!

## First version of fpga-tunes

This first version enables **very** basic audio synthesis on the Mojo v3 FPGA
dev board. Features include:

  - generation of square waves (variable duty cycle and period)
  - additive synthesis of four waveforms based on button input
  - variable frequency of last waveform based on trimpot input
  - 8-bit digital output at up to 50 Mhz

This repository is suitable for opening in [Xilinx ISE Design
Suite](https://embeddedmicro.com/tutorials/mojo-software-and-updates/installing-ise/).
It was written using ISE-DS v14.7 (with free WebPack license).

A complete schematic for the interactive synthesizer, including a simple input
pad, an 8-bit DAC, and low-pass filter, is coming soon.
