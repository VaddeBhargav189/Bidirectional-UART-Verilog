`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 10:55:54
// Design Name: 
// Module Name: deviceB
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


module deviceB(
        input clk,
        input reset,
        input [7:0] data_in,
        input start,
        input rdy_clear,
        input rx,
        output [7:0] data_out,
        output rdy,
        output busy,
        output tx
    );
  // wires coming from baud_generator
  wire tx_enable,rx_enable;
  
  baud_generator baud_generator_insta(.clk(clk),.reset(reset),.tx_enable(tx_enable),.rx_enable(rx_enable));
  
  uart_tx uart_tx_insta(.clk(clk),.reset(reset),.data_in(data_in),.start(start),.enable(tx_enable),.tx(tx),.busy(busy));
  
  uart_rx uart_rx_insta(.clk(clk),.reset(reset),.rx(rx),.enable(rx_enable),.rdy_clear(rdy_clear),.data_out(data_out),.rdy(rdy));
endmodule
