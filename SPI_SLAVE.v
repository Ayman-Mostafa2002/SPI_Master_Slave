module SPI_SLAVE(MOSI,MISO,SS_n,clk,rst_n,rx_data,rx_valid,tx_data,tx_valid);
parameter IDLE=3'b000;
parameter CHK_CMD=3'b001;
parameter WRITE=3'b010;
parameter READ_ADD=3'b011;
parameter READ_DATA=3'b100;
input MOSI;
output reg MISO;
input SS_n;
input clk;
input rst_n;
input tx_valid;
input [7:0]tx_data;
output reg rx_valid;
output reg [9:0] rx_data;
 
//(* fsm_encoding = "gray" *)
(* fsm_encoding = "sequential" *)
// (* fsm_encoding = "one_hot" *)
reg [2:0]cs,ns;
reg [3:0]Counter=4'b0;
reg READ_ADD_0_READ_DATA_1;

//State Memory
always @(posedge clk or negedge rst_n) begin
	if (~rst_n)begin
	   cs<=IDLE;
	end
	else
	cs<=ns;
end

//Next State
always@(*)begin
 case(cs)
  IDLE:
  if(SS_n==1'b0)
      ns<=CHK_CMD;
  else
      ns<=IDLE;    

  CHK_CMD:
  if(SS_n==1'b0 && MOSI==1'b0)
      ns<=WRITE;
  else if(SS_n==1'b0 && MOSI==1'b1 && READ_ADD_0_READ_DATA_1==1'b0)
      ns<=READ_ADD;
  else if(SS_n==1'b0 && MOSI==1'b1 && READ_ADD_0_READ_DATA_1==1'b1)
          ns<=READ_DATA;
  else 
          ns<=IDLE;

  WRITE:
  if(SS_n==1'b1)
      ns<=IDLE;
  else
      ns<=WRITE;

  READ_ADD:
  if(SS_n==1'b1)
      ns<=IDLE;
  else
      ns<=READ_ADD;
  
  READ_DATA:
  if(SS_n==1'b1)
      ns<=IDLE;
  else
      ns<=READ_DATA;
  default:ns<=IDLE;
  endcase
end

//Output State
always@(posedge clk)begin
 if(~rst_n)begin
 MISO<=0;
 READ_ADD_0_READ_DATA_1<=0;
 end

 case(cs)
  IDLE:begin
  rx_valid<=1'b0;
  MISO<=1'b0;
  end

  CHK_CMD:
  Counter<=1'b0;
  
  WRITE:begin
  if(SS_n==0)begin
    rx_data[9-Counter]<=MOSI;
    Counter<=Counter+1'b1;
  end
  if(Counter==9)begin
    rx_valid<=1'b1;
    Counter<=1'b0;
    end
  end

  READ_ADD:begin
  if(SS_n==0)begin
    rx_data[9-Counter]<=MOSI;
    Counter<=Counter+1'b1;
  end
  if(Counter==9)begin
    rx_valid<=1'b1;
    Counter<=1'b0;
    READ_ADD_0_READ_DATA_1<=1'b1;
  end
  end
  
  READ_DATA:begin
  if(SS_n==0)begin

    if(tx_valid==1'b0)begin
    rx_data[9-Counter]<=MOSI;
    Counter<=Counter+1'b1;
    if(Counter==9)begin
       Counter<=1'b0;
       rx_valid=1'b1;
    end

    end   

    if(tx_valid==1'b1)begin
      MISO<=tx_data[7-Counter];
      Counter<=Counter+1'b1;
      if(Counter==7)begin
         READ_ADD_0_READ_DATA_1<=1'b0;
         Counter<=1'b0;
      end

    end

  end
  end

  endcase
end
endmodule