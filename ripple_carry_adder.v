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

//  Constant definitions 

module ripple_carry_adder # ( parameter NUMBITS = 16 ) (
    input  wire[NUMBITS-1:0] A, 
    input  wire[NUMBITS-1:0] B, 
    input wire carryin, 
    output reg [NUMBITS-1:0] result,  
    output reg carryout); 
);
    // ------------------------------
    // Insert your solution below
    // ------------------------------ 

wire [NUMBITS:0] carri;
wire [NUMBITS-1:0] result_w;

assign carri[0] = 0;
assign carryout = carri[NUMBITS];

genvar i;

  generate
    for (i = 0; i < NUMBITS; i = i+ 1) begin
        full_adder looping(
            .a(A[i]), 
            .b(B[i]), 
            .c_in(carri[i]), 
            .c_out(carri[i+1]),
            .s(result_w[i])           
        );
    end
  endgenerate
endmodule