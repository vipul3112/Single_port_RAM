`ifndef mem_intf
`define mem_intf

interface intf(input clk, input reset);
  
  logic [7:0] data_in;
  logic [4:0]address;
  logic write_enable, read_enable;
  logic [7:0] data_out;
  
  clocking drv_cb @(posedge clk);
    default input #1 output #1;
    output data_in, address, read_enable, write_enable;
    input data_out;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #1 output #1;
    input data_in, address, read_enable, write_enable;
    input data_out;  
  endclocking
  
  modport drv_mp(clocking drv_cb,input clk, input reset); 
    modport mon_mp(clocking mon_cb,input clk, input reset);
  
endinterface

`endif
