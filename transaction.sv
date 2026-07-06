`ifndef mem_trans
`define mem_trans

class transaction;
  rand bit [7:0] data_in;
  rand bit [4:0]address;
  rand bit write_enable;
  rand bit read_enable;
  bit [7:0] data_out;
  
  constraint c_r_w_11{
     {read_enable, write_enable} inside {[0:3]};
 
  }
  
  constraint c_addr{
    address inside {[0:31]};
  }
  
  function void display(string name);
    $display("-------------------------");
    $display("- %s ",name);
    $display("-------------------------");
    $display("w = %0d, r = %0d", write_enable, read_enable);
    $display("- data_in = %0d, address = %0d",data_in,address);
    $display("- data_out = %0d",data_out);
    $display("-------------------------");
    
  endfunction
  
  
endclass

`endif
