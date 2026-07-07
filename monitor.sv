`ifndef mem_mon
`define mem_mon
class monitor;
  
  virtual intf mvif;
  transaction trans;

  mailbox mon2scb; 
  
  function new(virtual intf mvif, mailbox mon2scb);
    this.mvif = mvif;
    this.mon2scb = mon2scb;    
  endfunction
  
  task main();
    forever begin
      trans  = new();
      @(mvif.mon_cb);
      trans.data_in 		= mvif.mon_cb.data_in;
      trans.address 		= mvif.mon_cb.address;
      trans.write_enable 	= mvif.mon_cb.write_enable;
      trans.read_enable 	= mvif.mon_cb.read_enable;

      @(mvif.mon_cb);
      trans.data_out = mvif.mon_cb.data_out;

      //@(mvif.mon_cb);
      trans.display("[ Monitor ]");
      mon2scb.put(trans);
    end
  endtask
  
endclass
`endif
