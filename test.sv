`ifndef mem_t
`define mem_t

`include "environment.sv"

class test;
  environment env;
  virtual intf dvif;
  virtual intf mvif;
  
  function new(virtual intf dvif, virtual intf mvif);
      this.dvif = dvif;
    this.mvif = mvif;
    env = new(dvif,mvif);
  endfunction
  
  task main();
    env.main();
    
  endtask
  
endclass

`endif
