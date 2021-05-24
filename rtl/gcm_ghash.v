/**********************************************************************************
//  Title       : gcm_ghash
//  Project     : AES Encruption
// ------------------------------------------------------------------------------
//  File        : aes_inv_sbox.v
//  Author      : aamir <fpgaservices@gmail.com>
//  Company     : PaklogicTechs
//  Created     : Mon Mar  8 09:04:24 2021
//  Last update : Mon Mar  8 09:04:24 2021
//  Platform    : Default Part Number
//  Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
// ------------------------------------------------------------------------------
//  Copyright (c) 2021 PaklogicTechs Semiconductor
// -----------------------------------------------------------------------------
//  Description:
// ------------------------------------------------------------------------------
//  Revisions:  Revisions and documentation are controlled by
//  the revision control system (RCS).  The RCS should be consulted
//  on revision history.
**********************************************************************************/

module gcm_ghash #(parameter NUM_BLK=1) (
  input                       clk        ,
  input                       reset      ,
  input  wire [127*NUM_BLK:0] m_string   , // that is 128*m
  input  wire [        127:0] pre_hash   , // preveious rnd_hash
  input  wire [        127:0] hash_subkey, // preveious rnd_hash
  input  wire [        127:0] r_mul_plol ,
  input  wire                 zero_block ,
  output      [        127:0] ghash
);

  `include "gcm_function.vh"

  reg [127:0] blck_msg ;
  reg [127:0] ghash_cmb;
  reg [127:0] ghash_ff ;
// ghash logic here

  always@(*)
    begin
      if(zero_block) begin
        blck_msg  = m_string^'h0;
        ghash_cmb = gcm_mul_128 (blck_msg,hash_subkey,r_mul_plol);
        end
        else
          begin
            blck_msg = m_string ^ pre_hash;
          ghash_cmb = gcm_mul_128 (blck_msg,hash_subkey,r_mul_plol);
          end
      end



    always @(posedge clk or negedge reset)
      begin
        if(~reset) begin
          ghash_ff <= 'h0;
      end else begin
        ghash_ff <= ghash_cmb;
      end
    end

  assign ghash = ghash_ff;

endmodule // gcm_gmult
