//------------------------------------------------------------------------------
// Title       : aes_data_path
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_data_path.v
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

module aes_data_path #(parameter
  RND_SIZE = 128,
  WRD_SIZE = 32 ,
  NUM_BLK  = 4  ,
  MAX_CNT  = 10 ,
  CNT_SIZE = 4  ,
  NUM_RND  = 10
) (
  // inputs
  input                 clk          ,
  input                 rst_n        ,
  input                 i_dp_en      ,
  input  [RND_SIZE-1:0] i_rnd_text   ,
  input  [RND_SIZE-1:0] i_rnd_key    ,
  // outputs
  output [RND_SIZE-1:0] o_cypher_text
);

/**********************************************************************
* Internal Signals as wire and registers
**********************************************************************/
  wire                o_flag                 ;
  wire [CNT_SIZE-1:0] o_count                ;
  wire [RND_SIZE-1:0] rnd_text_blk[NUM_RND:0];


  assign rnd_text_blk[0] = i_rnd_text ;
/**********************************************************************
* Round counter module instantiation
**********************************************************************/
  aes_round_counter #(
    .MAX_CNT (MAX_CNT ),
    .CNT_SIZE(CNT_SIZE)
  ) inst_aes_round_counter (
    .clk     (clk    ), // input                     clk     ,
    .rst_n   (rst_n  ), // input                     rst_n   ,
    .i_cnt_en(i_dp_en), // input                     i_cnt_en,
    .o_flag  (o_flag ), // output                    o_flag  ,
    .o_count (o_count)  // output reg [CNT_SIZE-1:0] o_count
  );
/**********************************************************************
* Round Module Instantiation
**********************************************************************/
  genvar RND_CNT;
  generate
    for ( RND_CNT = 0; RND_CNT < NUM_RND;RND_CNT=RND_CNT+1) begin
      /* Round Module Instantiation */
      aes_round #(
        .RND_SIZE(RND_SIZE),
        .WRD_SIZE(WRD_SIZE),
        .NUM_BLK (NUM_BLK )
      ) inst_aes_round(
        // inputs
        .clk       (clk         ),         // input                 clk       ,
        .rst_n     (rst_n       ),         // input                 rst_n     ,
        .i_rnd_text(rnd_text_blk[RND_CNT]),// input  [RND_SIZE-1:0] i_rnd_text,
        .i_rnd_key (i_rnd_key   [RND_CNT]),         // input  [RND_SIZE-1:0] i_rnd_key ,
        .i_lst_rnd (o_flag      ),         // input                 i_lst_rnd ,
        // outputs
        .o_rnd_key(rnd_text_blk[RND_CNT+1])// output [RND_SIZE-1:0] o_rnd_key
      );
    end
  endgenerate
  assign o_cypher_text = rnd_text_blk[NUM_RND];

endmodule