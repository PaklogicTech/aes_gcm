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
  MAX_CNT  = 11,
  CNT_SIZE = 4
) (
  // inputs
  input                     clk     ,
  input                     rst_n   ,
  input                     i_cnt_en,
  output                 o_flag  ,
  output reg    [CNT_SIZE-1:0] o_count
);

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      o_count <= {CNT_SIZE{1'b0}};
    end else begin
      if(i_cnt_en) begin
        if (o_count==MAX_CNT) begin
          o_count <= 'h0;
        end
        else begin
          o_count <= o_count + 1;
        end
      end
      else
        o_count <= 'h0;
    end
  end
  assign o_flag = (o_count=='ha) ? 1'b1: 1'b0 ;
endmodule