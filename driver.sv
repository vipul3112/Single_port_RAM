`ifndef mem_drv
`define mem_drv
`include "transaction.sv"
class driver;
  int no_transactions;
  
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
     WRXRD: cross WRITE,READ{
		ignore_bins illegal = binsof(WRITE) intersect{1} && binsof(READ) intersect {1}; 
	}
     
  endgroup

  function new(virtual intf dvif , mailbox gen2driv);
    this.dvif = dvif;
    this.gen2driv = gen2driv; 
    drv_cg = new();   
  endfunction
  
  task reset;
    wait(!dvif.reset);
    $display("[ Driver ]----- Reset Started -----");
    dvif.data_in <= 0;
    dvif.address <= 0;
    dvif.write_enable <= 0;
    dvif.read_enable <= 0;
    //dvif.data_out <= 'bz;
    wait(dvif.reset);
    $display("[ Driver ] ----- Reset Ended -----");
  endtask
  
  task main;
    forever begin
      
      $display("Entering in driver");
      gen2driv.get(trans);  //get from mailbox

      drv_cg.sample();
      
      @(dvif.drv_cb);
      dvif.drv_cb.data_in <= trans.data_in;
      dvif.drv_cb.address <=trans.address;
      dvif.drv_cb.write_enable <= trans.write_enable;
      dvif.drv_cb.read_enable <= trans.read_enable;

      @(dvif.drv_cb);
      trans.data_out = dvif.drv_cb.data_out;

//       @(dvif.drv_cb);
      trans.display("[ Driver ]");
      $display("Exiting the driver");

      no_transactions++;
    end
  endtask
  
  
endclass

`endif
