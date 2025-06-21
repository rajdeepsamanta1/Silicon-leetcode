`include "config_leetcode.vh"

module bubble_sort(
input wire clk,
input wire rst,
input wire wr_en,
input wire rd_en,
input wire [`DATA_WIDTH-1:0]datain,
output reg [`DATA_WIDTH-1:0]dataout,
output reg done);

// counters for writing to and reading from the array

reg [$clog2(`NUM_DATA):0]wr_count;
reg [$clog2(`NUM_DATA):0]rd_count;

// i and j are index of the array 

reg [$clog2(`NUM_DATA):0]i;
reg [$clog2(`NUM_DATA):0]j;

reg [DATA_WIDTH-1:0]buff[0:`NUM_DATA-1];

// assert rd_en when you want to start computation
// done will be asserted when sorting is done
// data from the array will be at the output port at each 
// pulse after done is asserted

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
             
             if(j==`NUM_DATA-2-i)
             begin
                j<=0;
                i<=i+1;
             end
             
             if(i==`NUM_DATA-2)
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
