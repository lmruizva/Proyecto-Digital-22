
`timescale 1ns / 1ps
// Origin: http://www.fpga4fun.com/MusicBox2.html

module pwm(
    input CLK100MHZ,
    input BTNC,
    output AUD_PWM,
    output AUD_SD
    );
    parameter clk_divider_440 = (100000000 / 440) / 2;
    parameter clk_divider_1_5 = (100000000 / 3) * 2;
    reg [25:0] cnt_1_5;
    reg [19:0] cnt;
    reg CLK_1_5;
    always @(negedge CLK100MHZ) begin
        if (~AUD_SD || cnt_1_5 == 0) begin
            cnt_1_5 <= clk_divider_1_5 - 1;
            CLK_1_5 = ~CLK_1_5;
        end
        else begin
            cnt_1_5 <= cnt_1_5 - 1;
        end
    end
    reg speaker;
    always @(negedge CLK100MHZ) begin
        if (cnt == 0) begin
            cnt <= (CLK_1_5) ? clk_divider_440 - 1 : (clk_divider_440 / 2) - 1;
            speaker <= ~speaker;
        end
        else cnt <= cnt - 1;
    end
    assign AUD_PWM = speaker;
    assign AUD_SD = BTNC;
endmodule