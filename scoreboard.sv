`ifndef mem_sco
`define mem_sco

class scoreboard;

  transaction trans;
  bit [7:0] mem [int];
  
  static int pass;
  static int fail;

  mailbox mon2scb; 
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;    
  endfunction
  
  task main();
    forever begin
      trans  = new();
      mon2scb.get(trans);
      
      if((trans.write_enable == 0) && (trans.read_enable == 0)) begin  
        $display("No Operation");
      end
      
      else if((trans.write_enable == 0) && (trans.read_enable == 1)) begin
        if(trans.data_out == mem[trans.address]) begin
          $display("Pass"); pass++; end
        else begin
          $display("Fail"); fail++; end
      end
      
      else if((trans.write_enable == 1) && (trans.read_enable == 0)) begin  
        mem[trans.address] = trans.data_in;
      end
      
      else if((trans.write_enable == 1) && (trans.read_enable == 1)) begin  
        $display("RAM does not support simultaneous read and write operations");
      end
    end //forever ka
  endtask
  
endclass

`endif
