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
    repeat(200) begin
	repeat_count++;
      trans = new();
      if(!trans.randomize())
        $fatal("Gen:: trans randomization fail");
      trans.display("[Generator]");
      gen2driv.put(trans);
    end
	begin
	trans = new();
	trans.read_enable = 1'b0;
	trans.write_enable = 1'b1;
	trans.address = 25;
	trans.data_in = 50;
	gen2driv.put(trans);
	repeat_count++;
	end

	begin
	
        trans = new();
        trans.read_enable = 1'b1;
        trans.write_enable = 1'b0;
        trans.address = 25;
        trans.data_in = 50;
        gen2driv.put(trans);
        repeat_count++;
        end

	begin
        trans = new();
        trans.read_enable = 1'b1;
        trans.write_enable = 1'b0;
        trans.address = 25;
        trans.data_in = 50;
        gen2driv.put(trans);
        repeat_count++;
        end

////////////////////////////

	 begin
        trans = new();
        trans.read_enable = 1'b0;
        trans.write_enable = 1'b1;
        trans.address = 25;
        trans.data_in = 51;
        gen2driv.put(trans);
        repeat_count++;
        end

        begin
        trans = new();
        trans.read_enable = 1'b1;
        trans.write_enable = 1'b0;
        trans.address = 25;
        trans.data_in = 51;
        gen2driv.put(trans);
        repeat_count++;
        end

        begin
        trans = new();
        trans.read_enable = 1'b1;
        trans.write_enable = 1'b0;
        trans.address = 25;
        trans.data_in = 51;
        gen2driv.put(trans);
        repeat_count++;
        end

///////////////////
    if(repeat_count == 201)
    	-> e;
    
  endtask
  
endclass

`endif
