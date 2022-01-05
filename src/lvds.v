// LVDS

/*

LVDS panel LP171WU3
https://www.beyondinfinite.com/lcd/Library/LG-Philips/LP171WU3-TLB3.pdf

180 MHz ok

*/

module lvds (i_clk_fast, i_clk_div_3_5, 
	tx_odd, tx_even,
	x,y,
	color, color_even, i_resetn,
    o_q
);

    input i_clk_fast;
    input i_clk_div_3_5;
    input [23:0] color, color_even;

    input i_resetn;

	output [2:0] tx_odd;
	output [2:0] tx_even;
	
	output [11:0] x;
	output [11:0] y;
		
    output [6:0] o_q;
    //output [5:0] o_debug;

    // LVDS
    localparam [6:0] ckdata = 7'b1100011;
    wire [0:6] RX0DATA, RX0EDATA;
    wire [0:6] RX1DATA, RX1EDATA;
    wire [0:6] RX2DATA, RX2EDATA;

	localparam [11:0] hfront = 24;
	localparam [11:0] hback = 40;
	localparam [11:0] hactive = 960;
	localparam [11:0] htotal = 960+hback;

	localparam [11:0] vfront = 3;
	localparam [11:0] vback = 26;
	localparam [11:0] vactive = 1200;
	localparam [11:0] vtotal = 1200+vback;

	reg [11:0] hcurrent = 0;
	reg [11:0] vcurrent = 0;

	wire [11:0] x;
	wire [11:0] y;

    reg [5:0] red = 6'b0;
    reg [5:0] green = 6'b0;
    reg [5:0] blue = 6'b0;

	reg [5:0] red_even = 6'b0;
    reg [5:0] green_even = 6'b0;
    reg [5:0] blue_even = 6'b0;

    reg [17:0] nextColor = 18'b0;
    reg [17:0] nextColor_even = 18'b0;

    reg hsync = 0;
    reg vsync = 0;

    wire dataenable;

    
		
	//
	// ODD DATA
	//
	//RX2DATA is (DE, vsync, hsync, blue[5:2])
	assign RX2DATA[0] = dataenable;
	assign RX2DATA[1] = hsync;
	assign RX2DATA[2] = vsync;
	assign RX2DATA[3:6] = blue[5:2];

	//RX1DATA is (blue[1:0], green[5:1])
	assign RX1DATA[0:1] = blue[1:0];
	assign RX1DATA[2:6] = green[5:1];

	//RX1DATA is (green[0], red[5:0])
	assign RX0DATA[0] = green[0];
	assign RX0DATA[1:6] = red[5:0];
	
	//
	// EVEN DATA
	//
	assign RX2EDATA[0] = dataenable;
	assign RX2EDATA[1] = hsync;
	assign RX2EDATA[2] = vsync;
	assign RX2EDATA[3:6] = blue_even[5:2];

	assign RX1EDATA[0:1] = blue_even[1:0];
	assign RX1EDATA[2:6] = green_even[5:1];

	assign RX0EDATA[0] = green_even[0];
	assign RX0EDATA[1:6] = red_even[5:0];
	
	//assign x = (hcurrent - hfront >= 0) & (hcurrent - hfront < hactive) ? hcurrent - hfront : 0;
	//assign y = (vcurrent - vfront >= 0) & (vcurrent - vfront < vactive) ? vcurrent - vfront : 0;
    assign x = (hcurrent - hfront >= 0) & (hcurrent - hfront < hactive) ? hcurrent - hfront : 0;
	assign y = (vcurrent - vfront >= 0) & (vcurrent - vfront < vactive) ? vcurrent - vfront : 0;

    //assign dataenable = (hcurrent >= hfront) & (hcurrent < (hactive + hfront)) & (vcurrent >= vfront) & (vcurrent < (vactive + vfront));
    assign dataenable = vsync & hsync;

    wire [48:0] din_i = {RX0EDATA, RX1EDATA, RX2EDATA, RX0DATA, RX1DATA, RX2DATA, 7'b1100011};

    wire [48:0] din_i_remaped = {
            din_i[0], din_i[7], din_i[14], din_i[21], din_i[28], din_i[35], din_i[42], 
            din_i[1], din_i[8], din_i[15], din_i[22], din_i[29], din_i[36], din_i[43], 
            din_i[2], din_i[9], din_i[16], din_i[23], din_i[30], din_i[37], din_i[44], 
            din_i[3], din_i[10], din_i[17], din_i[24], din_i[31], din_i[38], din_i[45], 
            din_i[4], din_i[11], din_i[18], din_i[25], din_i[32], din_i[39], din_i[46], 
            din_i[5], din_i[12], din_i[19], din_i[26], din_i[33], din_i[40], din_i[47], 
            din_i[6], din_i[13], din_i[20], din_i[27], din_i[34], din_i[41], din_i[48]
    };
    
	Gowin_DDR gearbox_i(
		.din(din_i_remaped), //input [48:0] din
		.fclk(i_clk_fast), //input fclk
		.pclk(i_clk_div_3_5), //input pclk
		.reset(~i_resetn), //input reset
		.q(o_q) //output [6:0] q
	);

	// Slot increment
	always @ (posedge i_clk_div_3_5)
	begin
		
		if(hcurrent < hfront | (hcurrent >= (hfront + hactive)))
        //if(hcurrent == 0)
			hsync <= 0;
		else
			hsync <= 1;

		if(vcurrent < vfront | (vcurrent >= (vfront + vactive)))
        //if(vcurrent == 0)
			vsync <= 0;
		else
			vsync <= 1;
		
		nextColor <= {  color[15:10], color[23:18], color[7:2]};
		nextColor_even <= {  color_even[15:10], color_even[23:18], color_even[7:2]};

        green <= dataenable ? nextColor[17:12] : 8'b0;
        red <= dataenable ? nextColor[11:6] : 8'b0;
        blue <= dataenable ? nextColor[5:0] : 8'b0;

        green_even <= dataenable ? nextColor_even[17:12] : 8'b0;
        red_even <= dataenable ? nextColor_even[11:6] : 8'b0;
        blue_even <= dataenable ? nextColor_even[5:0] : 8'b0;

        if(hcurrent == htotal)
        begin
            hcurrent <= 0;

            if(vcurrent == vtotal)
                vcurrent <= 0;
            else
                vcurrent <= vcurrent + 1;
        end
        else
        begin
            hcurrent <= hcurrent + 1;
        end


	end


	initial
	begin
		//$monitor("hsync %d", hsync);
	end
	
endmodule