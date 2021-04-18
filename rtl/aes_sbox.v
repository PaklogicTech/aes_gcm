
/**********************************************************************************
//  Title       : Subtitute Byte 
//  Project     : AES Encruption
// ------------------------------------------------------------------------------
//  File        : aes_sbox.v
//  Author      : aamir <fpgaservices@gmail.com>
//  Company     : PaklogicTechs
//  Created     : Mon Mar  8 09:04:24 2021
//  Last update : Mon Mar  8 09:04:24 2021
//  Platform    : Default Part Number
//  Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
// ------------------------------------------------------------------------------
//  Copyright (c) 2021 PaklogicTechs Semiconductor
// -----------------------------------------------------------------------------
//  Description: In cryptography, an S-box (substitution-box) is a basic component
                 of symmetric key algorithms which performs substitution. In block 
                 ciphers, they are typically used to obscure the relationship 
                 between the key and the ciphertext — Shannon's property of 
                 confusion. {Reference: https://en.wikipedia.org/wiki/S-box} 
/*********************************************************************************
*  Revisions:  Revisions and documentation are controlled by
*  the revision control system (RCS).  The RCS should be consulted
*  on revision history.
**********************************************************************************/

module aes_sbox (
  input    [31:0] i_wrd_sbox,
  output   [31:0] o_wrd_sbox
);


  /*****************************************************************
  * The sbox_lkup_tbl byte array.
  *****************************************************************/
  wire [7:0] sbox_lkup_tbl[0:255];

wire [7:0] w_byt0_sbox ;
wire [7:0] w_byt1_sbox ;
wire [7:0] w_byt2_sbox ;
wire [7:0] w_byt3_sbox ;
  /*****************************************************************
  * Four parallel muxes.
  *****************************************************************/
 assign w_byt0_sbox = i_wrd_sbox[31 : 24] ;
 assign w_byt1_sbox = i_wrd_sbox[23 : 16] ;
 assign w_byt2_sbox = i_wrd_sbox[15 : 08] ;
 assign w_byt3_sbox = i_wrd_sbox[07 : 00] ;



  assign o_wrd_sbox[31:24] = sbox_lkup_tbl[w_byt0_sbox];
  assign o_wrd_sbox[23:16] = sbox_lkup_tbl[w_byt1_sbox];
  assign o_wrd_sbox[15:08] = sbox_lkup_tbl[w_byt2_sbox];
  assign o_wrd_sbox[07:00] = sbox_lkup_tbl[w_byt3_sbox];


  /*****************************************************************
  * Creating the sbox_lkup_tbl array contents.
  *****************************************************************/

   assign sbox_lkup_tbl[8'h00] = 8'h63;
   assign sbox_lkup_tbl[8'h01] = 8'h7c;
   assign sbox_lkup_tbl[8'h02] = 8'h77;
   assign sbox_lkup_tbl[8'h03] = 8'h7b;
   assign sbox_lkup_tbl[8'h04] = 8'hf2;
   assign sbox_lkup_tbl[8'h05] = 8'h6b;
   assign sbox_lkup_tbl[8'h06] = 8'h6f;
   assign sbox_lkup_tbl[8'h07] = 8'hc5;
   assign sbox_lkup_tbl[8'h08] = 8'h30;
   assign sbox_lkup_tbl[8'h09] = 8'h01;
   assign sbox_lkup_tbl[8'h0a] = 8'h67;
   assign sbox_lkup_tbl[8'h0b] = 8'h2b;
   assign sbox_lkup_tbl[8'h0c] = 8'hfe;
   assign sbox_lkup_tbl[8'h0d] = 8'hd7;
   assign sbox_lkup_tbl[8'h0e] = 8'hab;
   assign sbox_lkup_tbl[8'h0f] = 8'h76;
   assign sbox_lkup_tbl[8'h10] = 8'hca;
   assign sbox_lkup_tbl[8'h11] = 8'h82;
   assign sbox_lkup_tbl[8'h12] = 8'hc9;
   assign sbox_lkup_tbl[8'h13] = 8'h7d;
   assign sbox_lkup_tbl[8'h14] = 8'hfa;
   assign sbox_lkup_tbl[8'h15] = 8'h59;
   assign sbox_lkup_tbl[8'h16] = 8'h47;
   assign sbox_lkup_tbl[8'h17] = 8'hf0;
   assign sbox_lkup_tbl[8'h18] = 8'had;
   assign sbox_lkup_tbl[8'h19] = 8'hd4;
   assign sbox_lkup_tbl[8'h1a] = 8'ha2;
   assign sbox_lkup_tbl[8'h1b] = 8'haf;
   assign sbox_lkup_tbl[8'h1c] = 8'h9c;
   assign sbox_lkup_tbl[8'h1d] = 8'ha4;
   assign sbox_lkup_tbl[8'h1e] = 8'h72;
   assign sbox_lkup_tbl[8'h1f] = 8'hc0;
   assign sbox_lkup_tbl[8'h20] = 8'hb7;
   assign sbox_lkup_tbl[8'h21] = 8'hfd;
   assign sbox_lkup_tbl[8'h22] = 8'h93;
   assign sbox_lkup_tbl[8'h23] = 8'h26;
   assign sbox_lkup_tbl[8'h24] = 8'h36;
   assign sbox_lkup_tbl[8'h25] = 8'h3f;
   assign sbox_lkup_tbl[8'h26] = 8'hf7;
   assign sbox_lkup_tbl[8'h27] = 8'hcc;
   assign sbox_lkup_tbl[8'h28] = 8'h34;
   assign sbox_lkup_tbl[8'h29] = 8'ha5;
   assign sbox_lkup_tbl[8'h2a] = 8'he5;
   assign sbox_lkup_tbl[8'h2b] = 8'hf1;
   assign sbox_lkup_tbl[8'h2c] = 8'h71;
   assign sbox_lkup_tbl[8'h2d] = 8'hd8;
   assign sbox_lkup_tbl[8'h2e] = 8'h31;
   assign sbox_lkup_tbl[8'h2f] = 8'h15;
   assign sbox_lkup_tbl[8'h30] = 8'h04;
   assign sbox_lkup_tbl[8'h31] = 8'hc7;
   assign sbox_lkup_tbl[8'h32] = 8'h23;
   assign sbox_lkup_tbl[8'h33] = 8'hc3;
   assign sbox_lkup_tbl[8'h34] = 8'h18;
   assign sbox_lkup_tbl[8'h35] = 8'h96;
   assign sbox_lkup_tbl[8'h36] = 8'h05;
   assign sbox_lkup_tbl[8'h37] = 8'h9a;
   assign sbox_lkup_tbl[8'h38] = 8'h07;
   assign sbox_lkup_tbl[8'h39] = 8'h12;
   assign sbox_lkup_tbl[8'h3a] = 8'h80;
   assign sbox_lkup_tbl[8'h3b] = 8'he2;
   assign sbox_lkup_tbl[8'h3c] = 8'heb;
   assign sbox_lkup_tbl[8'h3d] = 8'h27;
   assign sbox_lkup_tbl[8'h3e] = 8'hb2;
   assign sbox_lkup_tbl[8'h3f] = 8'h75;
   assign sbox_lkup_tbl[8'h40] = 8'h09;
   assign sbox_lkup_tbl[8'h41] = 8'h83;
   assign sbox_lkup_tbl[8'h42] = 8'h2c;
   assign sbox_lkup_tbl[8'h43] = 8'h1a;
   assign sbox_lkup_tbl[8'h44] = 8'h1b;
   assign sbox_lkup_tbl[8'h45] = 8'h6e;
   assign sbox_lkup_tbl[8'h46] = 8'h5a;
   assign sbox_lkup_tbl[8'h47] = 8'ha0;
   assign sbox_lkup_tbl[8'h48] = 8'h52;
   assign sbox_lkup_tbl[8'h49] = 8'h3b;
   assign sbox_lkup_tbl[8'h4a] = 8'hd6;
   assign sbox_lkup_tbl[8'h4b] = 8'hb3;
   assign sbox_lkup_tbl[8'h4c] = 8'h29;
   assign sbox_lkup_tbl[8'h4d] = 8'he3;
   assign sbox_lkup_tbl[8'h4e] = 8'h2f;
   assign sbox_lkup_tbl[8'h4f] = 8'h84;
   assign sbox_lkup_tbl[8'h50] = 8'h53;
   assign sbox_lkup_tbl[8'h51] = 8'hd1;
   assign sbox_lkup_tbl[8'h52] = 8'h00;
   assign sbox_lkup_tbl[8'h53] = 8'hed;
   assign sbox_lkup_tbl[8'h54] = 8'h20;
   assign sbox_lkup_tbl[8'h55] = 8'hfc;
   assign sbox_lkup_tbl[8'h56] = 8'hb1;
   assign sbox_lkup_tbl[8'h57] = 8'h5b;
   assign sbox_lkup_tbl[8'h58] = 8'h6a;
   assign sbox_lkup_tbl[8'h59] = 8'hcb;
   assign sbox_lkup_tbl[8'h5a] = 8'hbe;
   assign sbox_lkup_tbl[8'h5b] = 8'h39;
   assign sbox_lkup_tbl[8'h5c] = 8'h4a;
   assign sbox_lkup_tbl[8'h5d] = 8'h4c;
   assign sbox_lkup_tbl[8'h5e] = 8'h58;
   assign sbox_lkup_tbl[8'h5f] = 8'hcf;
   assign sbox_lkup_tbl[8'h60] = 8'hd0;
   assign sbox_lkup_tbl[8'h61] = 8'hef;
   assign sbox_lkup_tbl[8'h62] = 8'haa;
   assign sbox_lkup_tbl[8'h63] = 8'hfb;
   assign sbox_lkup_tbl[8'h64] = 8'h43;
   assign sbox_lkup_tbl[8'h65] = 8'h4d;
   assign sbox_lkup_tbl[8'h66] = 8'h33;
   assign sbox_lkup_tbl[8'h67] = 8'h85;
   assign sbox_lkup_tbl[8'h68] = 8'h45;
   assign sbox_lkup_tbl[8'h69] = 8'hf9;
   assign sbox_lkup_tbl[8'h6a] = 8'h02;
   assign sbox_lkup_tbl[8'h6b] = 8'h7f;
   assign sbox_lkup_tbl[8'h6c] = 8'h50;
   assign sbox_lkup_tbl[8'h6d] = 8'h3c;
   assign sbox_lkup_tbl[8'h6e] = 8'h9f;
   assign sbox_lkup_tbl[8'h6f] = 8'ha8;
   assign sbox_lkup_tbl[8'h70] = 8'h51;
   assign sbox_lkup_tbl[8'h71] = 8'ha3;
   assign sbox_lkup_tbl[8'h72] = 8'h40;
   assign sbox_lkup_tbl[8'h73] = 8'h8f;
   assign sbox_lkup_tbl[8'h74] = 8'h92;
   assign sbox_lkup_tbl[8'h75] = 8'h9d;
   assign sbox_lkup_tbl[8'h76] = 8'h38;
   assign sbox_lkup_tbl[8'h77] = 8'hf5;
   assign sbox_lkup_tbl[8'h78] = 8'hbc;
   assign sbox_lkup_tbl[8'h79] = 8'hb6;
   assign sbox_lkup_tbl[8'h7a] = 8'hda;
   assign sbox_lkup_tbl[8'h7b] = 8'h21;
   assign sbox_lkup_tbl[8'h7c] = 8'h10;
   assign sbox_lkup_tbl[8'h7d] = 8'hff;
   assign sbox_lkup_tbl[8'h7e] = 8'hf3;
   assign sbox_lkup_tbl[8'h7f] = 8'hd2;
   assign sbox_lkup_tbl[8'h80] = 8'hcd;
   assign sbox_lkup_tbl[8'h81] = 8'h0c;
   assign sbox_lkup_tbl[8'h82] = 8'h13;
   assign sbox_lkup_tbl[8'h83] = 8'hec;
   assign sbox_lkup_tbl[8'h84] = 8'h5f;
   assign sbox_lkup_tbl[8'h85] = 8'h97;
   assign sbox_lkup_tbl[8'h86] = 8'h44;
   assign sbox_lkup_tbl[8'h87] = 8'h17;
   assign sbox_lkup_tbl[8'h88] = 8'hc4;
   assign sbox_lkup_tbl[8'h89] = 8'ha7;
   assign sbox_lkup_tbl[8'h8a] = 8'h7e;
   assign sbox_lkup_tbl[8'h8b] = 8'h3d;
   assign sbox_lkup_tbl[8'h8c] = 8'h64;
   assign sbox_lkup_tbl[8'h8d] = 8'h5d;
   assign sbox_lkup_tbl[8'h8e] = 8'h19;
   assign sbox_lkup_tbl[8'h8f] = 8'h73;
   assign sbox_lkup_tbl[8'h90] = 8'h60;
   assign sbox_lkup_tbl[8'h91] = 8'h81;
   assign sbox_lkup_tbl[8'h92] = 8'h4f;
   assign sbox_lkup_tbl[8'h93] = 8'hdc;
   assign sbox_lkup_tbl[8'h94] = 8'h22;
   assign sbox_lkup_tbl[8'h95] = 8'h2a;
   assign sbox_lkup_tbl[8'h96] = 8'h90;
   assign sbox_lkup_tbl[8'h97] = 8'h88;
   assign sbox_lkup_tbl[8'h98] = 8'h46;
   assign sbox_lkup_tbl[8'h99] = 8'hee;
   assign sbox_lkup_tbl[8'h9a] = 8'hb8;
   assign sbox_lkup_tbl[8'h9b] = 8'h14;
   assign sbox_lkup_tbl[8'h9c] = 8'hde;
   assign sbox_lkup_tbl[8'h9d] = 8'h5e;
   assign sbox_lkup_tbl[8'h9e] = 8'h0b;
   assign sbox_lkup_tbl[8'h9f] = 8'hdb;
   assign sbox_lkup_tbl[8'ha0] = 8'he0;
   assign sbox_lkup_tbl[8'ha1] = 8'h32;
   assign sbox_lkup_tbl[8'ha2] = 8'h3a;
   assign sbox_lkup_tbl[8'ha3] = 8'h0a;
   assign sbox_lkup_tbl[8'ha4] = 8'h49;
   assign sbox_lkup_tbl[8'ha5] = 8'h06;
   assign sbox_lkup_tbl[8'ha6] = 8'h24;
   assign sbox_lkup_tbl[8'ha7] = 8'h5c;
   assign sbox_lkup_tbl[8'ha8] = 8'hc2;
   assign sbox_lkup_tbl[8'ha9] = 8'hd3;
   assign sbox_lkup_tbl[8'haa] = 8'hac;
   assign sbox_lkup_tbl[8'hab] = 8'h62;
   assign sbox_lkup_tbl[8'hac] = 8'h91;
   assign sbox_lkup_tbl[8'had] = 8'h95;
   assign sbox_lkup_tbl[8'hae] = 8'he4;
   assign sbox_lkup_tbl[8'haf] = 8'h79;
   assign sbox_lkup_tbl[8'hb0] = 8'he7;
   assign sbox_lkup_tbl[8'hb1] = 8'hc8;
   assign sbox_lkup_tbl[8'hb2] = 8'h37;
   assign sbox_lkup_tbl[8'hb3] = 8'h6d;
   assign sbox_lkup_tbl[8'hb4] = 8'h8d;
   assign sbox_lkup_tbl[8'hb5] = 8'hd5;
   assign sbox_lkup_tbl[8'hb6] = 8'h4e;
   assign sbox_lkup_tbl[8'hb7] = 8'ha9;
   assign sbox_lkup_tbl[8'hb8] = 8'h6c;
   assign sbox_lkup_tbl[8'hb9] = 8'h56;
   assign sbox_lkup_tbl[8'hba] = 8'hf4;
   assign sbox_lkup_tbl[8'hbb] = 8'hea;
   assign sbox_lkup_tbl[8'hbc] = 8'h65;
   assign sbox_lkup_tbl[8'hbd] = 8'h7a;
   assign sbox_lkup_tbl[8'hbe] = 8'hae;
   assign sbox_lkup_tbl[8'hbf] = 8'h08;
   assign sbox_lkup_tbl[8'hc0] = 8'hba;
   assign sbox_lkup_tbl[8'hc1] = 8'h78;
   assign sbox_lkup_tbl[8'hc2] = 8'h25;
   assign sbox_lkup_tbl[8'hc3] = 8'h2e;
   assign sbox_lkup_tbl[8'hc4] = 8'h1c;
   assign sbox_lkup_tbl[8'hc5] = 8'ha6;
   assign sbox_lkup_tbl[8'hc6] = 8'hb4;
   assign sbox_lkup_tbl[8'hc7] = 8'hc6;
   assign sbox_lkup_tbl[8'hc8] = 8'he8;
   assign sbox_lkup_tbl[8'hc9] = 8'hdd;
   assign sbox_lkup_tbl[8'hca] = 8'h74;
   assign sbox_lkup_tbl[8'hcb] = 8'h1f;
   assign sbox_lkup_tbl[8'hcc] = 8'h4b;
   assign sbox_lkup_tbl[8'hcd] = 8'hbd;
   assign sbox_lkup_tbl[8'hce] = 8'h8b;
   assign sbox_lkup_tbl[8'hcf] = 8'h8a;
   assign sbox_lkup_tbl[8'hd0] = 8'h70;
   assign sbox_lkup_tbl[8'hd1] = 8'h3e;
   assign sbox_lkup_tbl[8'hd2] = 8'hb5;
   assign sbox_lkup_tbl[8'hd3] = 8'h66;
   assign sbox_lkup_tbl[8'hd4] = 8'h48;
   assign sbox_lkup_tbl[8'hd5] = 8'h03;
   assign sbox_lkup_tbl[8'hd6] = 8'hf6;
   assign sbox_lkup_tbl[8'hd7] = 8'h0e;
   assign sbox_lkup_tbl[8'hd8] = 8'h61;
   assign sbox_lkup_tbl[8'hd9] = 8'h35;
   assign sbox_lkup_tbl[8'hda] = 8'h57;
   assign sbox_lkup_tbl[8'hdb] = 8'hb9;
   assign sbox_lkup_tbl[8'hdc] = 8'h86;
   assign sbox_lkup_tbl[8'hdd] = 8'hc1;
   assign sbox_lkup_tbl[8'hde] = 8'h1d;
   assign sbox_lkup_tbl[8'hdf] = 8'h9e;
   assign sbox_lkup_tbl[8'he0] = 8'he1;
   assign sbox_lkup_tbl[8'he1] = 8'hf8;
   assign sbox_lkup_tbl[8'he2] = 8'h98;
   assign sbox_lkup_tbl[8'he3] = 8'h11;
   assign sbox_lkup_tbl[8'he4] = 8'h69;
   assign sbox_lkup_tbl[8'he5] = 8'hd9;
   assign sbox_lkup_tbl[8'he6] = 8'h8e;
   assign sbox_lkup_tbl[8'he7] = 8'h94;
   assign sbox_lkup_tbl[8'he8] = 8'h9b;
   assign sbox_lkup_tbl[8'he9] = 8'h1e;
   assign sbox_lkup_tbl[8'hea] = 8'h87;
   assign sbox_lkup_tbl[8'heb] = 8'he9;
   assign sbox_lkup_tbl[8'hec] = 8'hce;
   assign sbox_lkup_tbl[8'hed] = 8'h55;
   assign sbox_lkup_tbl[8'hee] = 8'h28;
   assign sbox_lkup_tbl[8'hef] = 8'hdf;
   assign sbox_lkup_tbl[8'hf0] = 8'h8c;
   assign sbox_lkup_tbl[8'hf1] = 8'ha1;
   assign sbox_lkup_tbl[8'hf2] = 8'h89;
   assign sbox_lkup_tbl[8'hf3] = 8'h0d;
   assign sbox_lkup_tbl[8'hf4] = 8'hbf;
   assign sbox_lkup_tbl[8'hf5] = 8'he6;
   assign sbox_lkup_tbl[8'hf6] = 8'h42;
   assign sbox_lkup_tbl[8'hf7] = 8'h68;
   assign sbox_lkup_tbl[8'hf8] = 8'h41;
   assign sbox_lkup_tbl[8'hf9] = 8'h99;
   assign sbox_lkup_tbl[8'hfa] = 8'h2d;
   assign sbox_lkup_tbl[8'hfb] = 8'h0f;
   assign sbox_lkup_tbl[8'hfc] = 8'hb0;
   assign sbox_lkup_tbl[8'hfd] = 8'h54;
   assign sbox_lkup_tbl[8'hfe] = 8'hbb;
   assign sbox_lkup_tbl[8'hff] = 8'h16;

endmodule 

