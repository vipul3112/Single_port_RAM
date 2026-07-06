`ifndef mem_gen
`define mem_gen

class generator;
  rand transaction trans;
  
  int repeat_count;
  
  mailbox gen2driv;
  
  event e;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task main();
    repeat(500) begin
      trans = new();
      if(!trans.randomize())
        $fatal("Gen:: trans randomization fail");
      trans.display("[Generator]");
      gen2driv.put(trans);
    end
    -> e;
    
  endtask
  
endclass

`endif
