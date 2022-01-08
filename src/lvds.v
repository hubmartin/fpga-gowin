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

    localparam [11:0] h_active = 960;
	localparam [11:0] h_sync_offset = 24;
	localparam [11:0] h_sync_width = 16;
    localparam [11:0] h_blanking = (24 + 16 + 40);

	localparam [11:0] v_active = 1200;
	localparam [11:0] v_sync_offset = 3;
    localparam [11:0] v_sync_width = 6;
	localparam [11:0] v_blanking = (3 + 6 + 26);

	
	reg [11:0] h_current = 0;
	reg [11:0] v_current = 0;

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

    reg dataenable;
   
		
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

    assign x = (h_current < h_active) ? (h_current + 1) : 0;
    assign y = (v_current < v_active) ? (v_current) : 0;


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

    reg dataenable_next;

	// Slot increment
	always @ (posedge i_clk_div_3_5)
	begin
		
		if(h_current > (h_active + h_sync_offset) & h_current < (h_active + h_sync_offset + h_sync_width))
			hsync <= 0;
		else
			hsync <= 1;

		if(v_current > (v_active + v_sync_offset) & v_current < (v_active + v_sync_offset + v_sync_width))
			vsync <= 0;
		else
			vsync <= 1;

        dataenable_next <= (h_current < h_active) & (v_current < v_active);
        dataenable <= dataenable_next;



		nextColor <= {  color[15:10], color[23:18], color[7:2]};
		nextColor_even <= {  color_even[15:10], color_even[23:18], color_even[7:2]};

        green <= dataenable_next ? nextColor[17:12] : 8'b0;
        red <= dataenable_next ? nextColor[11:6] : 8'b0;
        blue <= dataenable_next ? nextColor[5:0] : 8'b0;

        green_even <= dataenable_next ? nextColor_even[17:12] : 8'b0;
        red_even <= dataenable_next ? nextColor_even[11:6] : 8'b0;
        blue_even <= dataenable_next ? nextColor_even[5:0] : 8'b0;

        if(h_current == (h_active + h_blanking))
        begin
            h_current <= 0;

            if(v_current == (v_active + v_blanking))
            begin
                v_current <= 0;
            end
            else
            begin
                v_current <= v_current + 1;
            end
        
        end
        else
        begin
            h_current <= h_current + 1;
        end


	end


	initial
	begin
		//$monitor("hsync %d", hsync);
	end
	
endmodule