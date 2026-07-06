`ifndef mem_tb
`define mem_tb

`include "interface.sv"
`include "test.sv"
`include "design.sv"
module tb;
  bit clk;
  bit reset;
    intf i_intf(clk, reset);

  always #5 clk = ~clk;
  
    test t1;

   RAM dut(
    .clk(clk),
    .reset(reset),
    .data_in(i_intf.data_in),
    .address(i_intf.address),
    .write_enable(i_intf.write_enable),
    .read_enable(i_intf.read_enable),
    .data_out(i_intf.data_out)
  );
  

  
  initial begin
    reset = 0;
    #10 reset = 1;
    #10 reset = 0;
    #10 reset = 1;
  end
  
    
  initial begin
    t1 = new(i_intf,i_intf);
    t1.main();
  end
  
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(); 
    #100000 $display("Coverage = %0.2f%%",t1.env.driv.drv_cg.get_coverage());
    #1 $finish;
  end
  
  
endmodule

`endif
