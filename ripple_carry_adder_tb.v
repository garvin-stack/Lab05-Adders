//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Garvin Ha
// Email: gha003@ucr.edu
// 
// Assignment name: Lab05-Adders
// Lab section: 021
// TA: Eren, Omar
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module ripple_carry_adder_tb;
    parameter NUMBITS = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    wire carryout2;
    wire [NUMBITS-1:0] expected_result_carry;

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab02.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------

    // -------------------------------------------------------
    // Instantiate the 16-bit Unit Under Test (UUT)
    // -------------------------------------------------------

    ripple_carry_adder # (.NUMBITS(NUMBITS)) uut1 (
        .A(A),
        .B(B),
        .carryin(1'b0),
        .result(result),
        .carryout(carryout)
    );

    carry_look_ahead_adder # (.NUMBITS(NUMBITS)) uut2 (
        .A(A),
        .B(B),
        .carryin(1'b0),
        .result(expected_result_carry),
        .carryout(carryout2)
    );

    // 
    // .
    // .
    // .
    //
    // -------------------------------------------------------
    // Instantiate the N-bit Unit Under Test (UUT)
    // -------------------------------------------------------
    
    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    //copy initial begin to end, change result to carry_result
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // ---------------------------------------------
        // Test Group for Addition Behavior Verification 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+  0 =   0, c_out = 0 ... ");
        A = 8'h00;
        B = 8'h00;
        expected_result = 8'h00;
        
        #100; // Wait 

        $write("\t any%d", result);
        $write("\t any%d", carryout);
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 1.2:  FF + 01 = 00, c_out = 1 ... ");
        A = 8'hFF;
        B = 8'h01;
        expected_result = 8'h00;
        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait     

        totalTests = totalTests + 1;
        $write("\tTest Case 1.3:  00 + 0F = 0F, c_out = 0 ... ");
        A = 8'h00;
        B = 8'h0F;
        expected_result = 8'h0F;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        $write("\tTest Case 1.4:  7F + 01 = 0, c_out = 0 ... ");
        A = 8'h00;
        B = 8'h0F;
        expected_result = 8'h0F;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        //-1 + 1

        totalTests = totalTests + 1;
        $write("\tTest Case 1.4:  7F + 01 = 0, c_out = 0 ... ");
        A = 8'hF0;
        B = 8'h0F;
        expected_result = 8'h0F;

        #100; // Wait 
        $write("\t any%d", A);
        $write("\t any%d", B);
        $write("\t any%d", result);
        $write("\t any%d", carryout);
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        // ----------------------------------------
        // Add more test cases here 
        // ----------------------------------------

        // ----------------------------------------
        // Tests group for Increasing Number of Bits 
        // ----------------------------------------
        $write("Test Group 2: Increasing Number of Bits ...\n");
        
        // ----------------------------------------
        // Add test cases here 
        // ----------------------------------------

        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule