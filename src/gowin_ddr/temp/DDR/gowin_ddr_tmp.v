//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: GowinSynthesis V1.9.8
//Part Number: GW1NR-LV9QN88C6/I5
//Device: GW1NR-9
//Created Time: Sat Jan  1 21:47:30 2022

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Gowin_DDR your_instance_name(
		.din(din_i), //input [6:0] din
		.fclk(fclk_i), //input fclk
		.pclk(pclk_i), //input pclk
		.reset(reset_i), //input reset
		.q(q_o) //output [0:0] q
	);

//--------Copy end-------------------
