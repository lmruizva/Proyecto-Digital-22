`timescale 1ns / 1ps


module Alarm(DataIn, ValidData, AudioOut, Clk,overLimit, SD);
input [7:0] DataIn;
input ValidData;
input Clk;
output AudioOut;
output overLimit;
output SD;



reg HighAceleration = 0;
assign overLimit = HighAceleration;

always @(DataIn)
begin
    if (ValidData)
    begin
        if (DataIn>177) HighAceleration = 1;
        else HighAceleration = 0;
    end
end

pwm audioSource(.CLK100MHZ(Clk) , .BTNC(HighAceleration) , .AUD_PWM(AudioOut) , .AUD_SD(SD));



endmodule
