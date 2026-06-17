
module uart_tx(
       input clk,
       input reset,
       input [7:0] data_in,
       input start,
       input enable,
       output reg tx,
       output reg busy
    );
    reg [1:0] state;
    reg [2:0] index;
    reg [7:0] data;
    
    parameter Idle = 2'b00;
    parameter Start = 2'b01;
    parameter Data = 2'b10;
    parameter Stop = 2'b11;
    
    always@(posedge clk)
      begin
        if(reset)  begin
                     state <= Idle;
                     index <= 3'd0;
                   end
         else begin   case(state)
             Idle : begin  // changing to Start state when start is 1
                     tx <= 1'd1;
                     if(start)begin
                     state<=Start;
                     data <= data_in;
                     index <= 3'd0;
                     end
                    end
             Start : begin
                      tx <= 1'd0;
                      if(enable)state<=Data; // changing to data state                
                     end
             Data : begin
                       tx<=data[index];
                      if(enable) begin
                        if(index == 3'd7) begin
                                        state<=Stop;
                                          end
                         else index <= index+3'd1;
                      end
                    end
             Stop : begin 
                     tx <= 1'd1;
                     if(enable) state<=Idle;
                     end
             endcase
             end
           end   
             always@(posedge clk) // keeping busy during data transfer
               begin
               if(state==Idle) busy <= 1'd0;
               else busy <= 1'd1;
               end
      
endmodule
