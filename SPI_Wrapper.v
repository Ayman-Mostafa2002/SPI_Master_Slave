module SPI_Wrapper(MOSI,MISO,SS_n,clk,rst_n);
//parameter
parameter MEM_DEPTH=256;
parameter ADDER_SIZE=8;
//states
input SS_n;
input MOSI,clk,rst_n;
output MISO;
wire [9:0]rx_data_WIRE;
wire rx_valid_WIRE;
wire [7:0]dout_WIRE;
wire tx_valid_WIRE;
RAM #(MEM_DEPTH,ADDER_SIZE) RAM1(.din(rx_data_WIRE),.rx_valid(rx_valid_WIRE),.clk(clk),.rst_n(rst_n),.dout(dout_WIRE),.tx_valid(tx_valid_WIRE));
SPI_SLAVE  SPI1(.MOSI(MOSI),.MISO(MISO),.SS_n(SS_n),.clk(clk),.rst_n(rst_n),.rx_data(rx_data_WIRE),.rx_valid(rx_valid_WIRE),.tx_data(dout_WIRE),.tx_valid(tx_valid_WIRE));
endmodule