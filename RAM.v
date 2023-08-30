module RAM(din,rx_valid,clk,rst_n,dout,tx_valid);
parameter MEM_DEPTH=256;
parameter ADDER_SIZE=8;
input [9:0]din;
input clk,rst_n,rx_valid;
output reg [7:0]dout;
output reg tx_valid;
reg [7:0] Ram [MEM_DEPTH-1:0]; 
reg [7:0] ADDER_reg;
always @(posedge clk ) begin
	if (~rst_n) begin
         dout<=1'b0;
         tx_valid<=1'b0;
         ADDER_reg<=1'b0;	
	end
	else if(rx_valid) begin
	case(din[9:8])
	2'b00:begin
	      ADDER_reg<=din[7:0];
	      tx_valid<=1'b0;
	      end
	      
	2'b01:
	     begin
	     Ram[ADDER_reg]<=din[7:0];
	     tx_valid<=1'b0;
	     end
	      
	2'b10:
	      begin
	      ADDER_reg<=din[7:0];
	      tx_valid<=1'b0;
	      end
	
	2'b11:begin
	      dout<=Ram[ADDER_reg];
	      tx_valid<=1'b1;
	      end

	endcase
	end
	
end
endmodule