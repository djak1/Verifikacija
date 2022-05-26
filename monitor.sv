`ifndef MONITOR_SV
 `define MONITOR_SV

class monitor;

   newTransaction tr_q[$];
   int i=0;

   virtual memory_if mem_if;

   function new(virtual memory_if mem_if);
      this.mem_if = mem_if;
   endfunction : new

   task run();
	while(1) begin
              @(negedge mem_if.clk);
	      tr_q[i] = new();
	      if(mem_if.en) begin
	      	tr_q[i].addr = mem_if.addr;
	      	tr_q[i].data_i = mem_if.data_i;
	      	tr_q[i].en = mem_if.en;
	      	tr_q[i].rw = mem_if.rw;
                disp(tr_q[i]);
		i++;
	      end
	end
   endtask : run
   task disp(newTransaction tr);
	$display("Transakcija:\n");
	$display("addr: %0h \n",tr.addr);
	$display("data_i: %0h \n",tr.data_i);
	$display("en: %0h \n", tr.en);
	$display("rw: %0h \n", tr.rw);
   endtask : disp
endclass : monitor

`endif
