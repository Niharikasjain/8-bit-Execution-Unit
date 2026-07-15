`timescale 1ns / 1ps

module datapath (
    input  wire       clk,         
    input  wire       rst,         
    input  wire [3:0] operand,     
    input  wire [1:0] alu_op,      
    input  wire       acc_write,   
    output reg  [7:0] accumulator  
);

    reg [7:0] alu_out; 

    // Combinational ALU
    always @(*) begin
        case (alu_op)
            2'b00:   alu_out = accumulator + operand;             
            2'b01:   alu_out = accumulator & {4'b0000, operand};   
            2'b11:   alu_out = {4'b0000, operand};                
            default: alu_out = accumulator;
        endcase
    end

    // Sequential Accumulator Register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            accumulator <= 8'b0; 
        end else if (acc_write) begin
            accumulator <= alu_out; 
        end
    end
endmodule
