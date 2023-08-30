module SPI_Wrapper_tb();
//parameter
parameter MEM_DEPTH=256;
parameter ADDER_SIZE=8;
//states
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD=3'b011;
parameter READ_DATA=3'b100;
reg SS_n;
reg MOSI,clk,rst_n;
wire MISO;
integer i;
SPI_Wrapper #(MEM_DEPTH,ADDER_SIZE) DUT(MOSI,MISO,SS_n,clk,rst_n);
//generate clock
initial begin
clk=0;
forever
#1 clk=~clk;	
end
initial begin
rst_n=0;
SS_n=1;
MOSI=0;
repeat(15) @(negedge clk);
rst_n=1;
repeat(15) @(negedge clk);

//60ns
//WRITE (WRITE ADDRESS)
//write address (8'hFF) in ADDER_reg(internal signal in RAM)
//testing 00
SS_n=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
for(i=0;i<8;i=i+1)begin
MOSI=1;
@(negedge clk);
end
//84ns
SS_n=1;
repeat(15) @(negedge clk);

//114ns
//WRITE (WRITE DATA)
//write valie (8'h55) in RAM[ADDER_reg] where ADDER_reg=8'hFF
//testing 01
SS_n=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
MOSI=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
for(i=0;i<8;i=i+1)begin
MOSI=~MOSI;
@(negedge clk);
end
//138ns
SS_n=1;
repeat(15) @(negedge clk);

//Reset to clear address in ADDER_reg
//168ns
rst_n=0;
repeat(15) @(negedge clk);
//198ns
rst_n=1;
repeat(15) @(negedge clk);


//228ns
//READ (READ ADDRESS)
//ADDER_reg(internal signal in RAM) will hold the address that we read the value in this address in next stage
//testing 10
SS_n=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
MOSI=1;
@(negedge clk);
MOSI=0;
@(negedge clk);
for(i=0;i<8;i=i+1)begin
MOSI=1;
@(negedge clk);
end
//252ns
SS_n=1;
repeat(15) @(negedge clk);

//282
//READ (READ DATA)
//Chect din[9:8] equal 2'b11 to send the vlaue in Ram[ADDER_reg] to dout(parellal) then SPI Read it ( convet it to serial) 
//testing 11
SS_n=0;
@(negedge clk);
MOSI=1;
@(negedge clk);
MOSI=1;
@(negedge clk);
MOSI=1;
@(negedge clk);
for(i=0;i<8;i=i+1)begin
MOSI=~MOSI;
@(negedge clk);
end
repeat(8) @(negedge clk);
SS_n=1;
repeat(15) @(negedge clk);

#10;
$stop;	
end


endmodule