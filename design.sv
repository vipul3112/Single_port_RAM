// Signle port RAM my code
/*
module Mem_32_bit(output reg [7:0]data_out, 
                  input [7:0] data_in,
                  input [4:0]address,
                  input clk,reset,write_enable,read_enable);
reg [7:0] mem [31:0];

  always @(posedge clk) begin
    if(reset) begin
      for(int i=0;i<32;i=i+1) begin
            mem[i]<=0;
            data_out<= 'bz;
        end
    end
    else begin
      if(write_enable) begin
        mem[address] <= data_in;
      end
      else if(read_enable) begin
        data_out <= mem[address];
      end
    end
end
endmodule
*/


// DUT we need to verify

module RAM(
          clk, // Clk input
          reset, //Reset input active low
          address, // Address Input
          data_in, // Data in 
          write_enable, // Write Enable
          read_enable,  // Read Enable
          data_out   // Data out
          );          

//Input port declaration
 input [4:0] address;
 input write_enable;
 input read_enable; 
 input [7:0] data_in;
 input clk;
 input reset; 

//Output port declaration 
 output [7:0] data_out;
 
//Variable declarations 
 reg [7:0] data_out ;
 reg [7:0] memory [0:31];

//Memory Write Block Write Operation : When write_enable = 1,
always @(posedge clk)
 begin 
  if(!reset)
   memory[address] <= 8'bz;
  else if(write_enable && !read_enable) 
   memory[address] <= data_in;
 end 
 
//Memory Read Block  Read Operation : When read_enable=1
always @(posedge clk)
 begin
  if(!reset) 
    data_out <= 8'bz;
  else if(read_enable && !write_enable)
    data_out <= memory[address];
  else
    data_out <= 8'bz;
 end
endmodule 

