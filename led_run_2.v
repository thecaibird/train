//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: 
// Module Name:    
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 流水灯两段式状态机示例
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// *******************
// TIMESCALE
// ******************* 
`timescale 1ns/1ps 

//*******************
//DEFINE(s)
//*******************


//*******************
//DEFINE MODULE PORT
//*******************
module  LED_RUN_2(
    input clk,
    input rst_n,
    input mode,
    output reg [7:0] led_o
    );

//*******************
//DEFINE PARAMETER
//*******************
//Parameter(s) 
parameter     LED_00000001 = 8'b00000001 ;    // 
parameter     LED_00000010 = 8'b00000010 ;
parameter     LED_00000100 = 8'b00000100 ;
parameter     LED_00001000 = 8'b00001000 ;
parameter     LED_00010000 = 8'b00010000 ;    // 
parameter     LED_00100000 = 8'b00100000 ;
parameter     LED_01000000 = 8'b01000000 ;
parameter     LED_10000000 = 8'b10000000 ;                               


//*********************
//INNER SIGNAL DECLARATION
//*********************
//REGS
reg [7:0]  c_state ;
reg [7:0]  n_state ;
//WIRES
 

//*********************
//INSTANTCE MODULE
//*********************


//*********************
//MAIN CORE
//*********************

//同步时序描述状态转移
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        c_state <= LED_00000001 ;
    end
    else begin
        c_state <= n_state ;
    end
end

//组合逻辑判断状态转移条件，得到输出
always @(*) begin
    led_o = 8'b0000001 ;
    case(c_state)
        LED_00000001 :
            begin
                led_o = 8'b00000001 ;
                if (mode == 1'b0) 
                   n_state = LED_00000010 ;
                else 
                   n_state = LED_10000000 ;
            end
        LED_00000010 : 
            begin
                led_o = 8'b00000010 ;            
                if (mode == 1'b0) 
                   n_state = LED_00000100 ;
                else 
                   n_state = LED_00000001 ;
            end
        LED_00000100 : 
            begin
                led_o = 8'b00000100 ;            
                if (mode == 1'b0) 
                   n_state = LED_00001000 ;
                else 
                   n_state = LED_00000010 ;
            end
        LED_00001000 : 
           begin
                led_o = 8'b00001000 ;
                if (mode == 1'b0) 
                   n_state = LED_00010000 ;
                else 
                   n_state = LED_00000100 ;
            end
        LED_00010000 : 
           begin
                led_o = 8'b00010000 ;
                if (mode == 1'b0) 
                   n_state = LED_00100000 ;
                else 
                   n_state = LED_00001000 ;
            end
        LED_00100000 : 
           begin
                led_o = 8'b00100000 ;
                if (mode == 1'b0) 
                   n_state = LED_01000000 ;
                else 
                   n_state = LED_00010000 ;
            end
        LED_01000000 : 
           begin
                led_o = 8'b01000000 ;
                if (mode == 1'b0) 
                   n_state = LED_10000000 ;
                else 
                   n_state = LED_00100000 ;
            end
        LED_10000000 : 
           begin
                led_o = 8'b10000000 ;
                if (mode == 1'b0) 
                   n_state = LED_00000001 ;
                else 
                   n_state = LED_01000000 ;
            end
        default:begin
            led_o = 8'b0000001 ;
            n_state = LED_00000001 ;
        end
    endcase    
end



//*********************
endmodule