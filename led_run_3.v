// **************************************************************
// COPYRIGHT(c)2015, Xidian University
// All rights reserved.
//
// IP LIB INDEX :  
// IP Name      :      
// File name    : led_run.v 
// Module name  : LED_RUN 
// Full name    :  
//
// Author       : 
// Email        : 
// Data         : 
// Version      : V 1.0 
// 
// Abstract     : 三段式状态机，通过状态转移实现灯的亮灭变化。
// Called by    :  
// 
// Modification history
// -----------------------------------------------------------------
// 
// 
//
// *****************************************************************

// *******************
// TIMESCALE
// ******************* 
`timescale 1ns/1ps 

// *******************
// INFORMATION
// *******************

//*******************
//DEFINE(s)
//*******************
//`define UDLY 1    //Unit delay, for non-blocking assignments in sequential logic

//*******************
//DEFINE MODULE PORT
//*******************
module  LED_RUN ( 
                    input                  clk    ,        
                    input                  rst_n  ,  
                    input                  mode   ,    
                    output    reg [7:0]    led_o        
             );

//*******************
//DEFINE LOCAL PARAMETER
//*******************
//parameter(s)
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
reg [7:0] c_state ;//current_state
reg [7:0] n_state ;//next_state
   
 

//WIRES
 

//*********************
//INSTANTCE MODULE
//*********************

 
 

//*********************
//MAIN CORE
//********************* 
// 三段式状态机实现LED流水灯
// 第一段，状态转移
always @(posedge clk or negedge rst_n) begin
    if (rst_n ==  1'b0) begin
        c_state <= LED_00000001 ;
    end
    else begin
        c_state <= n_state ;
    end    
end

// 第二段，决定下一个状态
always@(*) begin//@*和@（*），它们都表示对其后面语句块中所有输入变量的变化是敏感的,只要满足条件立刻会变
    //n_state = 4'bx ;
    case ( c_state )
        LED_00000001 :
            begin
                if (mode == 1'b0) 
                   n_state = LED_00000010 ;
                else 
                   n_state = LED_10000000 ;
            end
        LED_00000010 : 
            begin
                if (mode == 1'b0) 
                   n_state = LED_00000100 ;
                else 
                   n_state = LED_00000001 ;
            end
        LED_00000100 : 
            begin
                if (mode == 1'b0) 
                   n_state = LED_00001000 ;
                else 
                   n_state = LED_00000010 ;
            end
        LED_00001000 : 
           begin
                if (mode == 1'b0) 
                   n_state = LED_00010000 ;
                else 
                   n_state = LED_00000100 ;
            end
        LED_00010000 : 
           begin
                if (mode == 1'b0) 
                   n_state = LED_00100000 ;
                else 
                   n_state = LED_00001000 ;
            end
        LED_00100000 : 
           begin
                if (mode == 1'b0) 
                   n_state = LED_01000000 ;
                else 
                   n_state = LED_00010000 ;
            end
        LED_01000000 : 
           begin
                if (mode == 1'b0) 
                   n_state = LED_10000000 ;
                else 
                   n_state = LED_00100000 ;
            end
        LED_10000000 : 
           begin
                if (mode == 1'b0) 
                   n_state = LED_00000001 ;
                else 
                   n_state = LED_01000000 ;
            end
        default  : n_state = LED_00000001 ;
    endcase
end

// 第三段，决定输出
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        led_o <= 8'b0 ;
    end
    else  begin
        case ( c_state )
            LED_00000001 : led_o <= 8'b00000001 ;
            LED_00000010 : led_o <= 8'b00000010 ;
            LED_00000100 : led_o <= 8'b00000100 ;
            LED_00001000 : led_o <= 8'b00001000 ;
            LED_00010000 : led_o <= 8'b00010000 ;
            LED_00100000 : led_o <= 8'b00100000 ;
            LED_01000000 : led_o <= 8'b01000000 ;
            LED_10000000 : led_o <= 8'b10000000 ;
            default  : led_o <= 8'b00000001 ;
        endcase
    end
end

//*********************
endmodule    // hookup byte controller block
                