
module baud_generator(
         input clk,
         input reset,
         output tx_enable,rx_enable
    );
    reg [15:0] count_tx;
    reg [11:0] count_rx;
    
    // making tx_enable one for every 52083 clocks
    always@(posedge clk)
       begin
       if(reset || count_tx==16'd52082) count_tx<=16'd0;
       else count_tx<=count_tx+16'd1;
       end
       
    // making rx_enable one for every 3255 clocks
   always@(posedge clk)
      begin
      if(reset || count_rx==12'd3255)count_rx<=12'd0;
      else count_rx<=count_rx+12'd1;
      end
    
    assign tx_enable = (count_tx==16'd0);
    assign rx_enable = (count_rx==12'd0);
endmodule
