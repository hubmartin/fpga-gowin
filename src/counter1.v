// o_clk - 37 - PIO8 - pin10
// o_ddr - 36 - PIO5 - pin 7
// reset 77
module blinky(input i_clk, input i_resetn, output [7:0] o_led, output o_ddr, output o_clk,


              output o_lvds_clk, output [2:0] o_lvds_tx, output [2:0] o_lvds_even_tx,
output [2:0] slot);

wire [11:0] x;
wire [11:0] y;
wire [23:0] color;


reg [23:0] r_color = 24'hFFFFFF;
reg [23:0] r_color_even = 24'hFFFFFF;

wire	[6:0]	din_i = 7'b1010101;
wire clk_sys;

lvds my_lvds (
	.button(1'b0),
	.clk_in(clk_sys),
	
	.clk_out(o_lvds_clk),
	.rx(o_lvds_tx),
	.rx_even(o_lvds_even_tx),
	
	.x(x),
	.y(y),
	.color(r_color),
	.color_even(r_color_even),
	.o_slot(slot)

);



Gowin_rPLL inst_pll(
    .clkout(clk_sys), //output clkout
    .clkin(i_clk) //input clkin
);

Gowin_CLKDIV inst_div3_5(
    .clkout(clk_3_5), //output clkout
    .hclkin(clk_sys), //input hclkin
    .resetn(i_resetn) //input resetn
);

Gowin_DDR inst_ddr(
    .din(din_i), //input [6:0] din
    .fclk(clk_sys), //input fclk
    .pclk(clk_3_5), //input pclk
    .reset(~i_resetn), //input reset
    .q(o_ddr) //output [0:0] q
);

assign o_clk = clk_3_5;

reg	[31:0]	counter;
always @(posedge clk_sys)
  counter <= counter + 1'b1;

assign o_led[7:0] = counter[31:25];

endmodule
