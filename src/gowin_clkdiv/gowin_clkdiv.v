//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8
//Part Number: GW1NR-LV9QN88C6/I5
//Device: GW1NR-9
//Created Time: Sat Jan  1 21:49:03 2022

module Gowin_CLKDIV (clkout, hclkin, resetn);

output clkout;
input hclkin;
input resetn;

wire gw_gnd;

assign gw_gnd = 1'b0;

CLKDIV clkdiv_inst (
    .CLKOUT(clkout),
    .HCLKIN(hclkin),
    .RESETN(resetn),
    .CALIB(gw_gnd)
);

defparam clkdiv_inst.DIV_MODE = "3.5";
defparam clkdiv_inst.GSREN = "false";

endmodule //Gowin_CLKDIV
