`ifndef mem_env
`define mem_env

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator 	gen;
  driver 		driv;
  monitor 		mon;
  scoreboard 	scb;
  
  mailbox gen2driv;
  mailbox mon2scb;
  
  virtual intf dvif;
    virtual intf mvif;

  function new(virtual intf dvif, virtual intf mvif);
    this.dvif = dvif;
    this.mvif = mvif;
    gen2driv = new();
    mon2scb = new();
    
    gen = new(gen2driv);
    driv = new(dvif,gen2driv);
    mon = new(mvif,mon2scb);
    scb = new(mon2scb);
  endfunction
  
  task main();
    driv.reset();
    fork
      gen.main();
      driv.main();
      mon.main(); 
      scb.main();
    join_none
    
  endtask
  
  
endclass
`endif
