//------------------------------------------------------------------------------
// Title       : aes_round_counter
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_round_counter.v
// Author      : aamir <fpgaservices@gmail.com>
// Company     : PaklogicTechs
// Created     : Sun Mar 14 16:57:48 2021
// Last update : Sun Mar 14 16:57:48 2021
// Platform    : Default Part Number
// Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
//------------------------------------------------------------------------------
// Copyright (c) 2021  PaklogicTechs Semiconductor
//-----------------------------------------------------------------------------
// Description:
//------------------------------------------------------------------------------
// Revisions:  Revisions and documentation are controlled by
// the revision control system (RCS).  The RCS should be consulted
// on revision history.
//-----------------------------------------------------------------------------

module aes_round_counter #(parameter
  MAX_CNT  = 10,
  CNT_SIZE = 4
) (
  // inputs
  input                     clk     ,
  input                     rst_n   ,
  input                     i_cnt_en,
  output reg                o_flag  ,
  output reg [CNT_SIZE-1:0] o_count
);

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      o_count <= {CNT_SIZE{1'b0}};
      o_flag  <=  'b0;
    end else begin
      if (o_count==MAX_CNT) begin
        o_flag <= 'b0;
      end
      else begin
        o_count <= o_count + 1;
        o_flag  <= 'b0;
      end
    end
  end

endmodule