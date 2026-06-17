`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 11:53:05
// Design Name: 
// Module Name: uart_rx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_rx(
      input clk,reset,
      input rx,
      input enable,
      input rdy_clear,
      output reg [7:0] data_out,
      output reg rdy
    );
    
    parameter Idle = 2'b00;
    parameter Start = 2'b01;
    parameter Data = 2'b10;
    parameter Stop = 2'b11;
    
    reg [1:0] state;
    reg [3:0] sample_count;
    reg [3:0] index;
    reg [7:0] temp_register;
    
    always@(posedge clk)
       begin
       if(reset)begin
       state<=2'd0;
       sample_count<=4'd0;
       index<=4'd0;
       temp_register<=8'd0;
       data_out<=8'd0;
       rdy<=1'd0;
       end
      else if(rdy_clear)rdy<=1'd0;
       else if(enable) begin 
        case(state)  
        Idle : if(rx==1'd0)  begin // Detect the falling edge of the start bit (RX: 1 -> 0)
                  state<=Start;
                  sample_count<=4'd1;
                  index<=4'd0;
                  temp_register<=8'd0; 
                  data_out<=8'd0;
                   rdy<=1'd0;
                 end
        Start :begin 
                      sample_count<=sample_count+4'd1;
                      if(sample_count==4'd15)  state<=Data;
                 end
        Data : begin 
               sample_count<=sample_count+4'd1;
               if(sample_count==4'd7)temp_register[index]<=rx; // Sample the incoming bit at the midpoint of the bit period
               if(sample_count==4'd15)index<=index+4'd1;
               if(index==4'd7 && sample_count==4'd15) state<=Stop;
               end
        Stop : begin
                  if(sample_count==4'd15) begin 
                                          state<=Idle;
                                          data_out<=temp_register;
                                          rdy<=1'd1;
                                          end
                  else sample_count<=sample_count+4'd1;
               end
        endcase
        
        end
       end
       
      
endmodule
