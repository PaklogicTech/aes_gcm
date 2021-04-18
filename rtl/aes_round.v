//------------------------------------------------------------------------------
// Title       : aes_round
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_round.vh
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


module aes_round #(parameter
  RND_SIZE = 128,
  WRD_SIZE = 32 ,
  NUM_BLK  = 4
) (
  // inputs
  input                 clk       ,
  input                 rst_n     ,
  input  [RND_SIZE-1:0] i_rnd_text,
  input  [RND_SIZE-1:0] i_rnd_key ,
  input                 i_lst_rnd ,
  // outputs
  output [RND_SIZE-1:0] o_rnd_cypher
);

 `include "round_function.vh"

/**********************************************************************
* Extract words and calculate intermediate values from round key
**********************************************************************/

 wire [WRD_SIZE-1:0] i_rnd_text_blk[NUM_BLK-1:0];
 wire [WRD_SIZE-1:0] i_rnd_key_blk [NUM_BLK-1:0];
 wire [WRD_SIZE-1:0] sbox_lkup_blk [NUM_BLK-1:0];


  assign i_rnd_text_blk[0] = i_rnd_text[127 :  96];
  assign i_rnd_text_blk[1] = i_rnd_text[ 95 :  64];
  assign i_rnd_text_blk[2] = i_rnd_text[ 63 :  32];
  assign i_rnd_text_blk[3] = i_rnd_text[ 31 :   0];


  assign i_rnd_key_blk[0] = i_rnd_key[127 :  96];
  assign i_rnd_key_blk[1] = i_rnd_key[ 95 :  64];
  assign i_rnd_key_blk[2] = i_rnd_key[ 63 :  32];
  assign i_rnd_key_blk[3] = i_rnd_key[ 31 :   0];

/**********************************************************************
* Internal Round state
**********************************************************************/
  wire [RND_SIZE-1:0] shiftrows_state  ;
  wire [RND_SIZE-1:0] mix_column_state ;
  wire [RND_SIZE-1:0] add_rnd_key_mux  ;
  wire [RND_SIZE-1:0] add_rnd_key_state;
/**********************************************************************
* output is flopped
**********************************************************************/

  reg [RND_SIZE-1:0] o_rnd_key_reg;
/**********************************************************************
* Sub byte conversion
**********************************************************************/
  genvar S_BOX_CONV;
  generate
    for ( S_BOX_CONV = 0; S_BOX_CONV < NUM_BLK; S_BOX_CONV=S_BOX_CONV+1) begin
      /* modiule instatiation */
      aes_sbox inst_aes_sbox (
        .i_wrd_sbox(i_rnd_text_blk[S_BOX_CONV]),
        .o_wrd_sbox(sbox_lkup_blk [S_BOX_CONV])
      );
    end
  endgenerate

  assign shiftrows_state = shiftrows({sbox_lkup_blk[3],sbox_lkup_blk[2],sbox_lkup_blk[1],sbox_lkup_blk[0]});
// TODOD :add pipeline stag here
    assign mix_column_state = mixcolumns(shiftrows_state);
// TODOD :add pipeline stag here

  assign add_rnd_key_mux   = (i_lst_rnd) ? shiftrows_state : mix_column_state;
  assign add_rnd_key_state = addroundkey(add_rnd_key_mux,{{i_rnd_key_blk[3],i_rnd_key_blk[2],i_rnd_key_blk[1],i_rnd_key_blk[0]}});

/**********************************************************************
* output is flopped
**********************************************************************/

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      o_rnd_key_reg <= {RND_SIZE{1'b0}};
    end else begin
      o_rnd_key_reg <= add_rnd_key_state ;
    end
  end
assign o_rnd_cypher=o_rnd_key_reg ;
endmodule