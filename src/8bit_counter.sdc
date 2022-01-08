//Copyright (C)2014-2022 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8 
//Created Time: 2022-01-06 23:54:20
create_clock -name main -period 4 -waveform {0 2} [get_nets {clk_sys}]
create_clock -name clk_3_5 -period 28 -waveform {0 14} [get_nets {o_clk}]
