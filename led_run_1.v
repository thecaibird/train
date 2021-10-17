//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    
// Design Name: led_fsm_1
// Module Name:    
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 流水灯一段式状态机示例
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
module  LED_RUN_1(
    input clk,
    input rst_n,
    input mode,
    output reg [3:0] led_o
    );

//*******************
//DEFINE PARAMETER
//*******************
//Parameter(s) 
parameter IDLE = 3'b001;
parameter LEFT = 3'b010;
parameter RIGHT = 3'b100;

//*********************
//INNER SIGNAL DECLARATION
//*********************
//REGS
 
reg [2:0] state;
//WIRES
 

//*********************
//INSTANTCE MODULE
//*********************
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        // reset
        led_o <= 4'd0;
        state <= IDLE;
    end
    else begin
        case (state)
            IDLE:begin
                led_o <= 4'b0001;
                if (mode == 1'b0) 
                    state <= LEFT;
                else 
                    state <= RIGHT;
            end
            LEFT:begin
                led_o <= {led_o[2:0],led_o[3]};
                if (mode == 1'b0) 
                    state <= LEFT;
                else 
                    state <= RIGHT;
            end
            RIGHT:begin
                led_o <= {led_o[0],led_o[3:1]};
                if (mode == 1'b0) 
                    state <= LEFT;
                else 
                    state <= RIGHT;
            end
            default: begin
                state <= IDLE;
                led_o <= 4'd0;
            end
        endcase
    end
end

//*********************
//MAIN CORE
//*********************



//*********************
endmodule