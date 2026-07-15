`timescale 1ns / 1ps

module control_unit (
    input  wire [7:0] instruction, 
    output reg  [3:0] operand,     
    output reg  [1:0] alu_op,      
    output reg        acc_write    
);
    always @(*) begin
        operand   = instruction[3:0]; 
        alu_op    = 2'b00;
        acc_write = 1'b0;

        case (instruction[7:4]) 
            4'b0001: begin // LOAD
                alu_op    = 2'b11; 
                acc_write = 1'b1;  
            end
            4'b0010: begin // ADD
                alu_op    = 2'b00; 
                acc_write = 1'b1;  
            end
            4'b0011: begin // AND
                alu_op    = 2'b01; 
                acc_write = 1'b1;  
            end
            default: begin
                alu_op    = 2'b00;
                acc_write = 1'b0;
            end
        endcase
    end
endmodule
