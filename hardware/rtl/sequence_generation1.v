
// the problem is to generate the sequence 1,2,2,3,3,3,4,4,4,4,.... with a counter and a adder/substractor and some minimal combinational logic

`include "config_leetcode.vh"

module sequence_generation1(
input wire clk,
input wire rst,
output reg [`DATA_WIDTH-1:0]count);

reg [`DATA_WIDTH-1:0]en;

// when en is 0, counter will increment 
// en will get counter value at each pulse and
// the circuit will decrement its value by 1 till en is 0 

always @(posedge clk)
begin
    
    if(rst)
    begin
       count<=0;
       en<=0;
    end
    
    else
    begin
    
        if(count>0)
        en <= (en==0) ? count : en-1;
   
    
        if(en==0)
        count<=count+1;
    
    end
    
end

endmodule

