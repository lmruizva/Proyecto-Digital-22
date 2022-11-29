`timescale 1ns / 1ps


module FreqDivider(
    ClkIn,
    ClkOut
    );
    
    input ClkIn;
    output  reg [0:0] ClkOut = 0;
    
    always @(posedge ClkIn )
    begin
        ClkOut = ~ClkOut;
    end
    
endmodule
