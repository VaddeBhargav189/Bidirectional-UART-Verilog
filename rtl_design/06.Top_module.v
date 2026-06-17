
module Top_module(
         input clk,
         input reset,
         
    // for A to B transmission
    
         input [7:0] data_inA,
         input startA,
         input rdy_clearB,
         output [7:0] data_outB,
         output rdyB,
         output busyA,
      
    // for B to A transmission   
    
         input [7:0] data_inB,
         input startB,
         input rdy_clearA,
         output [7:0] data_outA,
         output rdyA,
         output busyB
         
         
    );
    
    // AB is for transmission from A to B similarly BA is for transmission from B to A
    wire AB,BA;
    
  deviceA deviceA_insta(.clk(clk),.reset(reset),.data_in(data_inA),.start(startA),.rdy_clear(rdy_clearA),.rx(BA),.data_out(data_outA),.rdy(rdyA),.busy(busyA),.tx(AB));
  
  deviceB deviceB_insta(.clk(clk),.reset(reset),.data_in(data_inB),.start(startB),.rdy_clear(rdy_clearB),.rx(AB),.data_out(data_outB),.rdy(rdyB),.busy(busyB),.tx(BA));
  
endmodule
