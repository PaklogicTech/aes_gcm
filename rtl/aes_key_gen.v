//------------------------------------------------------------------------------
// Title       : aes_key_gen
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_key_gen.v
// Author      : aamir <fpgaservices@gmail.com>
// Company     : PaklogicTechs
// Created     : Wed Mar 18 12:20:48 2021
// Last update : Wed Mar 18 12:20:48 2021
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
//---------------------------------------------------------------------------

module aes_key_gen (
input clk, 
input rst_n,
  input      [127:0] pre_rnd_key ,
  input              i_en_key_gen,
  input      [  3:0] round_num   ,
  output   reg  [127:0] next_rnd_key
);

  reg  [ 31:0] rcon               ;
  wire [ 31:0] rot_word           ;
  wire [ 31:0] sub_word           ;
  wire [ 31:0] xor_word      [3:0];
  wire [127:0] w_next_rnd_key     ;
/* Step 1: Apply RotWord transformation */
  assign rot_word = { pre_rnd_key[23:0], pre_rnd_key[31:24] };


/* Lookup table for round constant (RCON) */
  always @ (round_num)
    begin
      case (round_num)
        4'h0    : rcon=32'h01000000;
        4'h1    : rcon=32'h02000000;
        4'h2    : rcon=32'h04000000;
        4'h3    : rcon=32'h08000000;
        4'h4    : rcon=32'h10000000;
        4'h5    : rcon=32'h20000000;
        4'h6    : rcon=32'h40000000;
        4'h7    : rcon=32'h80000000;
        4'h8    : rcon=32'h1b000000;
        4'h9    : rcon=32'h36000000;
        default : rcon=32'h00000000;
      endcase
    end

/* Step 2. Apply SubBytes transformation */
/* Instantiate 4 aes_sbox units */
  aes_sbox sbox (
    .i_wrd_sbox(rot_word),
    .o_wrd_sbox(sub_word)
  );

/* Step 3: XOR */
  assign xor_word[3] = pre_rnd_key[127:96] ^ sub_word ^ rcon;
  assign xor_word[2] = pre_rnd_key[95:64]  ^ xor_word[3];
  assign xor_word[1] = pre_rnd_key[63:32]  ^ xor_word[2];
  assign xor_word[0] = pre_rnd_key[31:0]   ^ xor_word[1];

  assign w_next_rnd_key = i_en_key_gen ? { xor_word[3], xor_word[2], xor_word[1], xor_word[0] } : pre_rnd_key;
   always @(posedge clk or negedge rst_n)
     begin
       if(~rst_n) begin
         next_rnd_key <= 'h0;
       end else begin
         next_rnd_key <= (i_en_key_gen)?w_next_rnd_key:next_rnd_key;
       end
     end
endmodule