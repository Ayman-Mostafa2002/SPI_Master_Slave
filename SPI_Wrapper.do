vlib work 
vlog SPI_SLAVE.v SPI_Wrapper.v RAM.v
vsim -voptargs=+acc work.SPI_Wrapper_tb
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/rst_n
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/clk
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SS_n
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/MOSI
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/MISO
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/RAM1/din
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/RAM1/dout
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/RAM1/rx_valid
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/rx_data
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/tx_valid
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/tx_data
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/Counter
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/RAM1/Ram
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/RAM1/ADDER_reg
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/cs
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/ns
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/DUT/SPI1/READ_ADD_0_READ_DATA_1
run -all
