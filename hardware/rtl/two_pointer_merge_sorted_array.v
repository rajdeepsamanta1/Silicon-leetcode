`include "config_leetcode.vh"

module two_pointer_merge_array(
input wire clk,
input wire rst,
input wire wr_en,
input wire compute_start,
input wire rd_en,
input wire [`DATA_WIDTH-1:0]datain1,
input wire [`DATA_WIDTH-1:0]datain2,
output reg [`DATA_WIDTH-1:0]dataout,
output reg done);

// datain1 and datain2 are two input data port for loading two array
// i and j are two pointers to track which data of the two array are transferred 
// k is a pointer to track the data movement in resultant array

reg [$clog2(`NUM_DATA):0]wr_count;
reg [$clog2(`NUM_DATA):0]i;
reg [$clog2(`NUM_DATA):0]j;
reg [$clog2(2*`NUM_DATA):0]k;
reg [$clog2(2*`NUM_DATA):0]rd_count;

// buff1 and buff2 are for storing input arrays
// buff_res is the resultant array after merging the sorted arrays
// done is asserted when the resultant array is ready
// then you can assert rd_en signal and read the data from the resultant array

reg [`DATA_WIDTH-1:0]buff1[0:`NUM_DATA-1];
reg [`DATA_WIDTH-1:0]buff2[0:`NUM_DATA-1];
reg [`DATA_WIDTH-1:0]buff_res[0:2*(`NUM_DATA)-1];


always @(posedge clk)
begin
    if(rst)
    begin
        wr_count<=0;
        i<=0;
        j<=0;
        k<=0;
        rd_count<=0;
        dataout<=0;
        done<=0;
    end
    
    else
    begin
        if(wr_en)
        begin
            buff1[wr_count]<=datain1;
            buff2[wr_count]<=datain2;
            wr_count<=wr_count+1;
        end
        
        if(compute_start)
        begin
            k<=k+1;
            if(buff1[i]>buff2[j])
            begin
                buff_res[k]<=buff2[j];
                j<=j+1;
            end
            
            else
            begin
                buff_res[k]<=buff1[i];
                i<=i+1;
            end
        end
        
        if(k==2*`NUM_DATA-1)
        done<=1;
        
        if(rd_en)
        begin
            dataout<=buff_res[rd_count];
            rd_count<=rd_count+1;
        end         
    end
 end        
              

endmodule
