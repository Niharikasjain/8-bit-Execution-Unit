`timescale 1ns / 1ps

module tb_mini_processor;

    reg clk;
    reg rst;
    reg [7:0] instruction;
    wire [7:0] execution_result;

    // Instantiate the Unit Under Test (UUT)
    mini_processor uut (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .execution_result(execution_result)
    );

    // 100MHz Global System Clock Generator (Toggles every 5ns)
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        instruction = 8'b0;

        #20;
        rst = 0; // Release reset
        #10;

        // Cycle 1: LOAD 5
        instruction = 8'b0001_0101; 
        #10; 

        // Cycle 2: ADD 3 (Result = 8)
        instruction = 8'b0010_0011;
        #10;

        // Cycle 3: AND 15 (Result = 8)
        instruction = 8'b0011_1111;
        #10;

        // Cycle 4: ADD 10 (Result = 18 / Hex 12)
        instruction = 8'b0010_1010;
        #10;

        $finish;
    end

endmodule
