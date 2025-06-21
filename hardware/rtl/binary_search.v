`include "config_leetcode.vh"

module binary_search(
input wire clk,
input wire rst,
input wire wr_en,
input wire rd_en,
input wire [`DATA_WIDTH-1:0]target_data,
input wire [`DATA_WIDTH-1:0]datain,
output wire [`DATA_WIDTH-1:0]dataout,
output wire [$clog2(`NUM_DATA):0]index,
output reg done
);

// input buffer to store the array

reg [`DATA_WIDTH-1:0]buff[0:`NUM_DATA-1];

// counter to write data to array for initialization

reg [$clog2(`NUM_DATA):0]wr_count;

// two counters to track the low and high index of the array during searching

reg [$clog2(`NUM_DATA):0]low_index;
reg [$clog2(`NUM_DATA):0]high_index;

// index means the mid index of the array

assign index=(low_index+high_index)/2;
assign dataout=buff[index];

// turn on rd_en when you want to start the computation
// done is asserted high when the target value and the index is found

always @(posedge clk)
begin
     if(rst)
     begin      
         wr_count<=0;        
         low_index<=0;
         high_index<=`NUM_DATA-1;
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
             if(dataout<target_data)
             low_index<=index;
             
             else if(dataout>target_data)
             high_index<=index;
             
             else
             done<=1;             
         end         
     end
end


endmodule
