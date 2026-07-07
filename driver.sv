`ifndef mem_drv
`define mem_drv

class driver;
 // static int count_drv;

  
  virtual intf dvif;
  
  mailbox gen2driv;
  transaction trans;
  
  //Coverage
    covergroup drv_cg;
      option.per_instance = 1;
     WRITE: coverpoint trans.write_enable { bins wrt[ ]={0,1};}
     READ : coverpoint trans.read_enable { bins rd[ ]={0,1};}
     DATA_IN: coverpoint trans.data_in { bins data ={[0:255]};}
    ADDRESS: coverpoint trans.address { bins address[]={[0:31]};}
     WRXRD: cross WRITE,READ;
  endgroup
  
  

  function new(virtual intf dvif , mailbox gen2driv);
    this.dvif = dvif;
    this.gen2driv = gen2driv; 
    drv_cg = new();
  endfunction
  
  task reset;
    wait(!dvif.reset);
    $display("[ Driver ]----- Reset Started -----");
    dvif.drv_cb.data_in <= 0;
    dvif.drv_cb.address <= 0;
    dvif.drv_cb.write_enable <= 0;
    dvif.drv_cb.read_enable <= 0;
    //dvif.data_out <= 'bz;
    wait(dvif.reset);
    $display("[ Driver ] ----- Reset Ended -----");
  endtask
  
  task main;
     forever begin
      
      $display("Entering in driver");
       gen2driv.get(trans);  //get from mailbox
      
      @(dvif.drv_cb);
      dvif.drv_cb.data_in <= trans.data_in;
      //drv_cg.sample(); // sample after data drived
      dvif.drv_cb.address <=trans.address;
      dvif.drv_cb.write_enable <= trans.write_enable;
      dvif.drv_cb.read_enable <= trans.read_enable;
      drv_cg.sample(); // now all drived so sampling here
      @(dvif.drv_cb);
      trans.data_out = dvif.drv_cb.data_out;

//       @(dvif.drv_cb);
      trans.display("[ Driver ]");
      $display("Exiting the driver");

      //no_transactions++;
    end
  endtask

  
endclass

`endif
