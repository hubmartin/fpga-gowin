//
//Written by GowinSynthesis
//Product Version "GowinSynthesis V1.9.8"
//Tue Jan  4 21:19:32 2022

//Source file index table:
//file0 "\/home/martin/dev/fpga/gowin/Gowin_V1.9.8_linux/IDE/ipcore/DDR/data/ddr.v"
`timescale 100 ps/100 ps
module Gowin_DDR (
  din,
  fclk,
  pclk,
  reset,
  q
)
;
input [48:0] din;
input fclk;
input pclk;
input reset;
output [6:0] q;
wire [6:0] ddr_inst_o;
wire VCC;
wire GND;
  OBUF \obuf_gen[0].obuf_inst  (
    .O(q[0]),
    .I(ddr_inst_o[0]) 
);
  OBUF \obuf_gen[1].obuf_inst  (
    .O(q[1]),
    .I(ddr_inst_o[1]) 
);
  OBUF \obuf_gen[2].obuf_inst  (
    .O(q[2]),
    .I(ddr_inst_o[2]) 
);
  OBUF \obuf_gen[3].obuf_inst  (
    .O(q[3]),
    .I(ddr_inst_o[3]) 
);
  OBUF \obuf_gen[4].obuf_inst  (
    .O(q[4]),
    .I(ddr_inst_o[4]) 
);
  OBUF \obuf_gen[5].obuf_inst  (
    .O(q[5]),
    .I(ddr_inst_o[5]) 
);
  OBUF \obuf_gen[6].obuf_inst  (
    .O(q[6]),
    .I(ddr_inst_o[6]) 
);
  OVIDEO \ovideo_gen[0].ovideo_inst  (
    .Q(ddr_inst_o[0]),
    .D6(din[42]),
    .D5(din[35]),
    .D4(din[28]),
    .D3(din[21]),
    .D2(din[14]),
    .D1(din[7]),
    .D0(din[0]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  OVIDEO \ovideo_gen[1].ovideo_inst  (
    .Q(ddr_inst_o[1]),
    .D6(din[43]),
    .D5(din[36]),
    .D4(din[29]),
    .D3(din[22]),
    .D2(din[15]),
    .D1(din[8]),
    .D0(din[1]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  OVIDEO \ovideo_gen[2].ovideo_inst  (
    .Q(ddr_inst_o[2]),
    .D6(din[44]),
    .D5(din[37]),
    .D4(din[30]),
    .D3(din[23]),
    .D2(din[16]),
    .D1(din[9]),
    .D0(din[2]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  OVIDEO \ovideo_gen[3].ovideo_inst  (
    .Q(ddr_inst_o[3]),
    .D6(din[45]),
    .D5(din[38]),
    .D4(din[31]),
    .D3(din[24]),
    .D2(din[17]),
    .D1(din[10]),
    .D0(din[3]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  OVIDEO \ovideo_gen[4].ovideo_inst  (
    .Q(ddr_inst_o[4]),
    .D6(din[46]),
    .D5(din[39]),
    .D4(din[32]),
    .D3(din[25]),
    .D2(din[18]),
    .D1(din[11]),
    .D0(din[4]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  OVIDEO \ovideo_gen[5].ovideo_inst  (
    .Q(ddr_inst_o[5]),
    .D6(din[47]),
    .D5(din[40]),
    .D4(din[33]),
    .D3(din[26]),
    .D2(din[19]),
    .D1(din[12]),
    .D0(din[5]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  OVIDEO \ovideo_gen[6].ovideo_inst  (
    .Q(ddr_inst_o[6]),
    .D6(din[48]),
    .D5(din[41]),
    .D4(din[34]),
    .D3(din[27]),
    .D2(din[20]),
    .D1(din[13]),
    .D0(din[6]),
    .PCLK(pclk),
    .FCLK(fclk),
    .RESET(reset) 
);
  VCC VCC_cZ (
    .V(VCC)
);
  GND GND_cZ (
    .G(GND)
);
  GSR GSR (
    .GSRI(VCC) 
);
endmodule /* Gowin_DDR */
