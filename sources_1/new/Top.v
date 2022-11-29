`timescale 1ns / 1ps


module Top(rx,clk,audio, data, valid, overLimit, SD);

input rx,clk;
output audio;
output [7:0] data;
output valid;
output overLimit;
output SD;




UART_receiver uart(.clk(clk), .RxD(rx), .Rx_done(valid), .RxD_data(data),.Rx_NotDone());
Alarm alarm(.DataIn(data), .ValidData(valid), .AudioOut(audio), .SD(SD) , .Clk(clk), .overLimit(overLimit));


endmodule
