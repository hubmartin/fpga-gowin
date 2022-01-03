//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: GowinSynthesis V1.9.8
//Part Number: GW1NR-LV9QN88C6/I5
//Device: GW1NR-9
//Created Time: Mon Jan  3 22:05:15 2022

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Gowin_DDR your_instance_name(
		.din(din_i), //input [41:0] din
		.fclk(fclk_i), //input fclk
		.pclk(pclk_i), //input pclk
		.reset(reset_i), //input reset
		.q(q_o) //output [5:0] q
	);

//--------Copy end-------------------
