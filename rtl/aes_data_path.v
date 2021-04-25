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
  MAX_CNT  = 11 ,
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
  output [RND_SIZE-1:0] o_cypher_text,
  output                o_flag
);
  `include "round_function.vh"
/**********************************************************************
* Internal Signals as wire and registers
**********************************************************************/
  wire [CNT_SIZE-1:0] o_count;

  wire [RND_SIZE-1:0] w_pre_rnd_key ;
  wire [RND_SIZE-1:0] w_next_rnd_key;
  wire [RND_SIZE-1:0] w_rnd_txt     ;
  wire [RND_SIZE-1:0] o_rnd_cypher  ;
/**********************************************************************
* Mux logic
**********************************************************************/
  assign w_pre_rnd_key = (o_count==0) ? i_rnd_key : w_next_rnd_key;
  assign w_rnd_txt     = (o_count==0) ? i_rnd_text : o_rnd_cypher;
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
* key expension Module
**********************************************************************/
  aes_key_gen i_aes_key_gen (
    .clk         (clk           ),
    .rst_n       (rst_n         ),
    .pre_rnd_key (w_pre_rnd_key ), // input  [127:0] pre_rnd_key ,
    .i_en_key_gen(i_dp_en       ), // input          i_en_key_gen,
    .round_num   (o_count       ), // input  [  3:0] round_num   ,
    .next_rnd_key(w_next_rnd_key)  // output [127:0] next_rnd_key
  );
/**********************************************************************
* Round Module Instantiation
**********************************************************************/
  aes_round #(
    .RND_SIZE(RND_SIZE),
    .WRD_SIZE(WRD_SIZE),
    .NUM_BLK (NUM_BLK )
  ) inst_aes_round (
    // inputs
    .clk         (clk          ), // input                 clk       ,
    .rst_n       (rst_n        ), // input                 rst_n     ,
    .i_rnd_en    (i_dp_en      ),
    .i_rnd_text  (w_rnd_txt    ), // input  [RND_SIZE-1:0] i_rnd_text,
    .i_rnd_key   (w_pre_rnd_key), // input  [RND_SIZE-1:0] i_rnd_key ,
    .i_rnd_cnt   (o_count      ), // input [CNT_SIZE-1:0] i_rnd_cnt;
    // outputs
    .o_rnd_cypher(o_rnd_cypher )  // output [RND_SIZE-1:0] o_rnd_key
  );

  assign o_cypher_text = (o_count=='hb)? o_rnd_cypher : 'h0;

endmodule