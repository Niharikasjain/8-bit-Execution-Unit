`timescale 1ns / 1ps

module mini_processor (
    input  wire       clk,                // Global system clock input port
    input  wire       rst,                // Asynchronous reset control input port
    input  wire [7:0] instruction,        // 8-bit master instruction entry bus
    output wire [7:0] execution_result    // Final calculated value routed to output pins
);

    // Internal inter-module routing wires (Buses)
    wire [3:0] w_operand;
    wire [1:0] w_alu_op;
    wire       w_acc_write;

    // Instantiate and wire the Control Unit Submodule (Brain)
    control_unit ctrl_inst (
        .instruction(instruction),
        .operand(w_operand),
        .alu_op(w_alu_op),
        .acc_write(w_acc_write)
    );

    // Instantiate and wire the Datapath Submodule (Muscle & Memory)
    datapath dp_inst (
        .clk(clk),
        .rst(rst),
        .operand(w_operand),
        .alu_op(w_alu_op),
        .acc_write(w_acc_write),
        .accumulator(execution_result)
    );

endmodule
