//Copyright (C)2014-2022 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8 
//Created Time: 2022-01-08 20:16:01
create_clock -name main -period 4 -waveform {0 2} [get_nets {clk_sys}]
create_clock -name outputs -period 5 -waveform {0 2.5} [get_ports {o_q[6] o_q[5] o_q[4] o_q[3] o_q[2] o_q[1] o_q[0]}]
