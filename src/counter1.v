// o_clk - 37 - PIO8 - pin10
// o_ddr - 36 - PIO5 - pin 7
// reset 77
module blinky(input i_clk, input i_resetn, output [7:0] o_led, output o_ddr, output o_clk);

wire	[6:0]	din_i = 7'b1010101;
wire clk5;

Gowin_rPLL inst_pll(
    .clkout(clk5), //output clkout
    .clkin(i_clk) //input clkin
);

Gowin_CLKDIV inst_div3_5(
    .clkout(clk_3_5), //output clkout
    .hclkin(clk5), //input hclkin
    .resetn(i_resetn) //input resetn
);

Gowin_DDR inst_ddr(
    .din(din_i), //input [6:0] din
    .fclk(clk5), //input fclk
    .pclk(clk_3_5), //input pclk
    .reset(~i_resetn), //input reset
    .q(o_ddr) //output [0:0] q
);

assign o_clk = clk_3_5;

reg	[31:0]	counter;
always @(posedge i_clk)
  counter <= counter + 1'b1;

assign o_led[7:0] = counter[31:25];

endmodule
