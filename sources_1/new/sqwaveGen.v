module sqwaveGen(clk,H,clk_out);
input wire clk, H;
output reg  clk_out = 0;


reg [3:0] count = 0;

always @(posedge clk)
begin
    if (count < 10)
        count = count +1;
    else
        count = 0;
end

always @(count)
begin

    if (H)
        begin
        if (count != 9) clk_out = 1;
        else clk_out = 0;
        
        end
    else
        begin
        if (count != 9) clk_out = 0;
        else clk_out = 1;
        end

end



 
endmodule
 