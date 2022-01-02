//Copyright (C)2014-2022 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8 
//Created Time: 2022-01-02 23:34:35
create_clock -name main -period 5 -waveform {0 2.5} [get_nets {clk_sys}]
