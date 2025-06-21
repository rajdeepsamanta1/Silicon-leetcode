None selected 

Skip to content
Using Gmail with screen readers
in:sent 
Enable desktop notifications for Gmail.
   OK  No, thanks
Conversations
99% of 15 GB used
Terms · Privacy · Programme Policies
Last account activity: 18 hours ago
Details
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2025 15:30:48
// Design Name: 
// Module Name: sort
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

`include "config_leetcode.vh"

module bubble_sort(
input wire clk,
input wire rst,
input wire wr_en,
input wire rd_en,
input wire [DATA_WIDTH-1:0]datain,
output reg [DATA_WIDTH-1:0]dataout,
output reg done);

  reg [$clog2(NUM_DATA):0]wr_count;
  reg [$clog2(NUM_DATA):0]rd_count;

  reg [$clog2(NUM_DATA):0]i;
  reg [$clog2(NUM_DATA):0]j;

  reg [DATA_WIDTH-1:0]buff[0:NUM_DATA-1];


always @(posedge clk)
begin

      if(rst)
      begin
          wr_count<=0;
          rd_count<=0;
          i<=0;
          j<=0;
          dataout<=0;
          
      end
      
      
      else
      begin
      
         if(wr_en)
         begin
             buff[wr_count]<=datain;
             wr_count<=wr_count+1;
         end
         
         if(rd_en)
         begin
         
             j<=j+1;
             
             if(j==NUM_DATA-2-i)
             begin
             j<=0;
             i<=i+1;
             end
             
             if(i==NUM_DATA-2)
             done<=1;
             
             
             if(buff[j]>buff[j+1])
             begin
             
             buff[j]<=buff[j+1];
             buff[j+1]<=buff[j];
             
             end      
         
         
         end 
         
         
         if(done)
         begin
         
         dataout<=buff[rd_count];
         rd_count<=rd_count+1;
         
         end    
      
      
      end
      
end



endmodule
