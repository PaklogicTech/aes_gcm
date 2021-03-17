
/**********************************************************************************
//  Title       : Subtitute Byte Inverse
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
//  Description: In cryptography, an S-box (substitution-box) is a basic component
                 of symmetric key algorithms which performs substitution. In block 
                 ciphers, they are typically used to obscure the relationship 
                 between the key and the ciphertext — Shannon's property of 
                 confusion. {Reference: https://en.wikipedia.org/wiki/S-box}
// ------------------------------------------------------------------------------
//  Revisions:  Revisions and documentation are controlled by
//  the revision control system (RCS).  The RCS should be consulted
//  on revision history.
**********************************************************************************/
module aes_inv_sbox(
                    input  [31 : 0] i_inv_wrd_sbox,
                    output [31 : 0] o_inv_wrd_sbox
                   );


  //----------------------------------------------------------------
  // The inverse sbox array.
  //----------------------------------------------------------------
  reg [7 : 0] inv_sbox_lkup_tbl [0 : 255];


  //----------------------------------------------------------------
  // Four parallel muxes.
  //----------------------------------------------------------------
  assign o_inv_wrd_sbox[31 : 24] = inv_sbox_lkup_tbl[i_inv_wrd_sbox[31 : 24]];
  assign o_inv_wrd_sbox[23 : 16] = inv_sbox_lkup_tbl[i_inv_wrd_sbox[23 : 16]];
  assign o_inv_wrd_sbox[15 : 08] = inv_sbox_lkup_tbl[i_inv_wrd_sbox[15 : 08]];
  assign o_inv_wrd_sbox[07 : 00] = inv_sbox_lkup_tbl[i_inv_wrd_sbox[07 : 00]];


  //----------------------------------------------------------------
  // Creating the contents of the array.
  //----------------------------------------------------------------
  always@(*)
  begin
   inv_sbox_lkup_tbl[8'h00] = 8'h52;
   inv_sbox_lkup_tbl[8'h01] = 8'h09;
   inv_sbox_lkup_tbl[8'h02] = 8'h6a;
   inv_sbox_lkup_tbl[8'h03] = 8'hd5;
   inv_sbox_lkup_tbl[8'h04] = 8'h30;
   inv_sbox_lkup_tbl[8'h05] = 8'h36;
   inv_sbox_lkup_tbl[8'h06] = 8'ha5;
   inv_sbox_lkup_tbl[8'h07] = 8'h38;
   inv_sbox_lkup_tbl[8'h08] = 8'hbf;
   inv_sbox_lkup_tbl[8'h09] = 8'h40;
   inv_sbox_lkup_tbl[8'h0a] = 8'ha3;
   inv_sbox_lkup_tbl[8'h0b] = 8'h9e;
   inv_sbox_lkup_tbl[8'h0c] = 8'h81;
   inv_sbox_lkup_tbl[8'h0d] = 8'hf3;
   inv_sbox_lkup_tbl[8'h0e] = 8'hd7;
   inv_sbox_lkup_tbl[8'h0f] = 8'hfb;
   inv_sbox_lkup_tbl[8'h10] = 8'h7c;
   inv_sbox_lkup_tbl[8'h11] = 8'he3;
   inv_sbox_lkup_tbl[8'h12] = 8'h39;
   inv_sbox_lkup_tbl[8'h13] = 8'h82;
   inv_sbox_lkup_tbl[8'h14] = 8'h9b;
   inv_sbox_lkup_tbl[8'h15] = 8'h2f;
   inv_sbox_lkup_tbl[8'h16] = 8'hff;
   inv_sbox_lkup_tbl[8'h17] = 8'h87;
   inv_sbox_lkup_tbl[8'h18] = 8'h34;
   inv_sbox_lkup_tbl[8'h19] = 8'h8e;
   inv_sbox_lkup_tbl[8'h1a] = 8'h43;
   inv_sbox_lkup_tbl[8'h1b] = 8'h44;
   inv_sbox_lkup_tbl[8'h1c] = 8'hc4;
   inv_sbox_lkup_tbl[8'h1d] = 8'hde;
   inv_sbox_lkup_tbl[8'h1e] = 8'he9;
   inv_sbox_lkup_tbl[8'h1f] = 8'hcb;
   inv_sbox_lkup_tbl[8'h20] = 8'h54;
   inv_sbox_lkup_tbl[8'h21] = 8'h7b;
   inv_sbox_lkup_tbl[8'h22] = 8'h94;
   inv_sbox_lkup_tbl[8'h23] = 8'h32;
   inv_sbox_lkup_tbl[8'h24] = 8'ha6;
   inv_sbox_lkup_tbl[8'h25] = 8'hc2;
   inv_sbox_lkup_tbl[8'h26] = 8'h23;
   inv_sbox_lkup_tbl[8'h27] = 8'h3d;
   inv_sbox_lkup_tbl[8'h28] = 8'hee;
   inv_sbox_lkup_tbl[8'h29] = 8'h4c;
   inv_sbox_lkup_tbl[8'h2a] = 8'h95;
   inv_sbox_lkup_tbl[8'h2b] = 8'h0b;
   inv_sbox_lkup_tbl[8'h2c] = 8'h42;
   inv_sbox_lkup_tbl[8'h2d] = 8'hfa;
   inv_sbox_lkup_tbl[8'h2e] = 8'hc3;
   inv_sbox_lkup_tbl[8'h2f] = 8'h4e;
   inv_sbox_lkup_tbl[8'h30] = 8'h08;
   inv_sbox_lkup_tbl[8'h31] = 8'h2e;
   inv_sbox_lkup_tbl[8'h32] = 8'ha1;
   inv_sbox_lkup_tbl[8'h33] = 8'h66;
   inv_sbox_lkup_tbl[8'h34] = 8'h28;
   inv_sbox_lkup_tbl[8'h35] = 8'hd9;
   inv_sbox_lkup_tbl[8'h36] = 8'h24;
   inv_sbox_lkup_tbl[8'h37] = 8'hb2;
   inv_sbox_lkup_tbl[8'h38] = 8'h76;
   inv_sbox_lkup_tbl[8'h39] = 8'h5b;
   inv_sbox_lkup_tbl[8'h3a] = 8'ha2;
   inv_sbox_lkup_tbl[8'h3b] = 8'h49;
   inv_sbox_lkup_tbl[8'h3c] = 8'h6d;
   inv_sbox_lkup_tbl[8'h3d] = 8'h8b;
   inv_sbox_lkup_tbl[8'h3e] = 8'hd1;
   inv_sbox_lkup_tbl[8'h3f] = 8'h25;
   inv_sbox_lkup_tbl[8'h40] = 8'h72;
   inv_sbox_lkup_tbl[8'h41] = 8'hf8;
   inv_sbox_lkup_tbl[8'h42] = 8'hf6;
   inv_sbox_lkup_tbl[8'h43] = 8'h64;
   inv_sbox_lkup_tbl[8'h44] = 8'h86;
   inv_sbox_lkup_tbl[8'h45] = 8'h68;
   inv_sbox_lkup_tbl[8'h46] = 8'h98;
   inv_sbox_lkup_tbl[8'h47] = 8'h16;
   inv_sbox_lkup_tbl[8'h48] = 8'hd4;
   inv_sbox_lkup_tbl[8'h49] = 8'ha4;
   inv_sbox_lkup_tbl[8'h4a] = 8'h5c;
   inv_sbox_lkup_tbl[8'h4b] = 8'hcc;
   inv_sbox_lkup_tbl[8'h4c] = 8'h5d;
   inv_sbox_lkup_tbl[8'h4d] = 8'h65;
   inv_sbox_lkup_tbl[8'h4e] = 8'hb6;
   inv_sbox_lkup_tbl[8'h4f] = 8'h92;
   inv_sbox_lkup_tbl[8'h50] = 8'h6c;
   inv_sbox_lkup_tbl[8'h51] = 8'h70;
   inv_sbox_lkup_tbl[8'h52] = 8'h48;
   inv_sbox_lkup_tbl[8'h53] = 8'h50;
   inv_sbox_lkup_tbl[8'h54] = 8'hfd;
   inv_sbox_lkup_tbl[8'h55] = 8'hed;
   inv_sbox_lkup_tbl[8'h56] = 8'hb9;
   inv_sbox_lkup_tbl[8'h57] = 8'hda;
   inv_sbox_lkup_tbl[8'h58] = 8'h5e;
   inv_sbox_lkup_tbl[8'h59] = 8'h15;
   inv_sbox_lkup_tbl[8'h5a] = 8'h46;
   inv_sbox_lkup_tbl[8'h5b] = 8'h57;
   inv_sbox_lkup_tbl[8'h5c] = 8'ha7;
   inv_sbox_lkup_tbl[8'h5d] = 8'h8d;
   inv_sbox_lkup_tbl[8'h5e] = 8'h9d;
   inv_sbox_lkup_tbl[8'h5f] = 8'h84;
   inv_sbox_lkup_tbl[8'h60] = 8'h90;
   inv_sbox_lkup_tbl[8'h61] = 8'hd8;
   inv_sbox_lkup_tbl[8'h62] = 8'hab;
   inv_sbox_lkup_tbl[8'h63] = 8'h00;
   inv_sbox_lkup_tbl[8'h64] = 8'h8c;
   inv_sbox_lkup_tbl[8'h65] = 8'hbc;
   inv_sbox_lkup_tbl[8'h66] = 8'hd3;
   inv_sbox_lkup_tbl[8'h67] = 8'h0a;
   inv_sbox_lkup_tbl[8'h68] = 8'hf7;
   inv_sbox_lkup_tbl[8'h69] = 8'he4;
   inv_sbox_lkup_tbl[8'h6a] = 8'h58;
   inv_sbox_lkup_tbl[8'h6b] = 8'h05;
   inv_sbox_lkup_tbl[8'h6c] = 8'hb8;
   inv_sbox_lkup_tbl[8'h6d] = 8'hb3;
   inv_sbox_lkup_tbl[8'h6e] = 8'h45;
   inv_sbox_lkup_tbl[8'h6f] = 8'h06;
   inv_sbox_lkup_tbl[8'h70] = 8'hd0;
   inv_sbox_lkup_tbl[8'h71] = 8'h2c;
   inv_sbox_lkup_tbl[8'h72] = 8'h1e;
   inv_sbox_lkup_tbl[8'h73] = 8'h8f;
   inv_sbox_lkup_tbl[8'h74] = 8'hca;
   inv_sbox_lkup_tbl[8'h75] = 8'h3f;
   inv_sbox_lkup_tbl[8'h76] = 8'h0f;
   inv_sbox_lkup_tbl[8'h77] = 8'h02;
   inv_sbox_lkup_tbl[8'h78] = 8'hc1;
   inv_sbox_lkup_tbl[8'h79] = 8'haf;
   inv_sbox_lkup_tbl[8'h7a] = 8'hbd;
   inv_sbox_lkup_tbl[8'h7b] = 8'h03;
   inv_sbox_lkup_tbl[8'h7c] = 8'h01;
   inv_sbox_lkup_tbl[8'h7d] = 8'h13;
   inv_sbox_lkup_tbl[8'h7e] = 8'h8a;
   inv_sbox_lkup_tbl[8'h7f] = 8'h6b;
   inv_sbox_lkup_tbl[8'h80] = 8'h3a;
   inv_sbox_lkup_tbl[8'h81] = 8'h91;
   inv_sbox_lkup_tbl[8'h82] = 8'h11;
   inv_sbox_lkup_tbl[8'h83] = 8'h41;
   inv_sbox_lkup_tbl[8'h84] = 8'h4f;
   inv_sbox_lkup_tbl[8'h85] = 8'h67;
   inv_sbox_lkup_tbl[8'h86] = 8'hdc;
   inv_sbox_lkup_tbl[8'h87] = 8'hea;
   inv_sbox_lkup_tbl[8'h88] = 8'h97;
   inv_sbox_lkup_tbl[8'h89] = 8'hf2;
   inv_sbox_lkup_tbl[8'h8a] = 8'hcf;
   inv_sbox_lkup_tbl[8'h8b] = 8'hce;
   inv_sbox_lkup_tbl[8'h8c] = 8'hf0;
   inv_sbox_lkup_tbl[8'h8d] = 8'hb4;
   inv_sbox_lkup_tbl[8'h8e] = 8'he6;
   inv_sbox_lkup_tbl[8'h8f] = 8'h73;
   inv_sbox_lkup_tbl[8'h90] = 8'h96;
   inv_sbox_lkup_tbl[8'h91] = 8'hac;
   inv_sbox_lkup_tbl[8'h92] = 8'h74;
   inv_sbox_lkup_tbl[8'h93] = 8'h22;
   inv_sbox_lkup_tbl[8'h94] = 8'he7;
   inv_sbox_lkup_tbl[8'h95] = 8'had;
   inv_sbox_lkup_tbl[8'h96] = 8'h35;
   inv_sbox_lkup_tbl[8'h97] = 8'h85;
   inv_sbox_lkup_tbl[8'h98] = 8'he2;
   inv_sbox_lkup_tbl[8'h99] = 8'hf9;
   inv_sbox_lkup_tbl[8'h9a] = 8'h37;
   inv_sbox_lkup_tbl[8'h9b] = 8'he8;
   inv_sbox_lkup_tbl[8'h9c] = 8'h1c;
   inv_sbox_lkup_tbl[8'h9d] = 8'h75;
   inv_sbox_lkup_tbl[8'h9e] = 8'hdf;
   inv_sbox_lkup_tbl[8'h9f] = 8'h6e;
   inv_sbox_lkup_tbl[8'ha0] = 8'h47;
   inv_sbox_lkup_tbl[8'ha1] = 8'hf1;
   inv_sbox_lkup_tbl[8'ha2] = 8'h1a;
   inv_sbox_lkup_tbl[8'ha3] = 8'h71;
   inv_sbox_lkup_tbl[8'ha4] = 8'h1d;
   inv_sbox_lkup_tbl[8'ha5] = 8'h29;
   inv_sbox_lkup_tbl[8'ha6] = 8'hc5;
   inv_sbox_lkup_tbl[8'ha7] = 8'h89;
   inv_sbox_lkup_tbl[8'ha8] = 8'h6f;
   inv_sbox_lkup_tbl[8'ha9] = 8'hb7;
   inv_sbox_lkup_tbl[8'haa] = 8'h62;
   inv_sbox_lkup_tbl[8'hab] = 8'h0e;
   inv_sbox_lkup_tbl[8'hac] = 8'haa;
   inv_sbox_lkup_tbl[8'had] = 8'h18;
   inv_sbox_lkup_tbl[8'hae] = 8'hbe;
   inv_sbox_lkup_tbl[8'haf] = 8'h1b;
   inv_sbox_lkup_tbl[8'hb0] = 8'hfc;
   inv_sbox_lkup_tbl[8'hb1] = 8'h56;
   inv_sbox_lkup_tbl[8'hb2] = 8'h3e;
   inv_sbox_lkup_tbl[8'hb3] = 8'h4b;
   inv_sbox_lkup_tbl[8'hb4] = 8'hc6;
   inv_sbox_lkup_tbl[8'hb5] = 8'hd2;
   inv_sbox_lkup_tbl[8'hb6] = 8'h79;
   inv_sbox_lkup_tbl[8'hb7] = 8'h20;
   inv_sbox_lkup_tbl[8'hb8] = 8'h9a;
   inv_sbox_lkup_tbl[8'hb9] = 8'hdb;
   inv_sbox_lkup_tbl[8'hba] = 8'hc0;
   inv_sbox_lkup_tbl[8'hbb] = 8'hfe;
   inv_sbox_lkup_tbl[8'hbc] = 8'h78;
   inv_sbox_lkup_tbl[8'hbd] = 8'hcd;
   inv_sbox_lkup_tbl[8'hbe] = 8'h5a;
   inv_sbox_lkup_tbl[8'hbf] = 8'hf4;
   inv_sbox_lkup_tbl[8'hc0] = 8'h1f;
   inv_sbox_lkup_tbl[8'hc1] = 8'hdd;
   inv_sbox_lkup_tbl[8'hc2] = 8'ha8;
   inv_sbox_lkup_tbl[8'hc3] = 8'h33;
   inv_sbox_lkup_tbl[8'hc4] = 8'h88;
   inv_sbox_lkup_tbl[8'hc5] = 8'h07;
   inv_sbox_lkup_tbl[8'hc6] = 8'hc7;
   inv_sbox_lkup_tbl[8'hc7] = 8'h31;
   inv_sbox_lkup_tbl[8'hc8] = 8'hb1;
   inv_sbox_lkup_tbl[8'hc9] = 8'h12;
   inv_sbox_lkup_tbl[8'hca] = 8'h10;
   inv_sbox_lkup_tbl[8'hcb] = 8'h59;
   inv_sbox_lkup_tbl[8'hcc] = 8'h27;
   inv_sbox_lkup_tbl[8'hcd] = 8'h80;
   inv_sbox_lkup_tbl[8'hce] = 8'hec;
   inv_sbox_lkup_tbl[8'hcf] = 8'h5f;
   inv_sbox_lkup_tbl[8'hd0] = 8'h60;
   inv_sbox_lkup_tbl[8'hd1] = 8'h51;
   inv_sbox_lkup_tbl[8'hd2] = 8'h7f;
   inv_sbox_lkup_tbl[8'hd3] = 8'ha9;
   inv_sbox_lkup_tbl[8'hd4] = 8'h19;
   inv_sbox_lkup_tbl[8'hd5] = 8'hb5;
   inv_sbox_lkup_tbl[8'hd6] = 8'h4a;
   inv_sbox_lkup_tbl[8'hd7] = 8'h0d;
   inv_sbox_lkup_tbl[8'hd8] = 8'h2d;
   inv_sbox_lkup_tbl[8'hd9] = 8'he5;
   inv_sbox_lkup_tbl[8'hda] = 8'h7a;
   inv_sbox_lkup_tbl[8'hdb] = 8'h9f;
   inv_sbox_lkup_tbl[8'hdc] = 8'h93;
   inv_sbox_lkup_tbl[8'hdd] = 8'hc9;
   inv_sbox_lkup_tbl[8'hde] = 8'h9c;
   inv_sbox_lkup_tbl[8'hdf] = 8'hef;
   inv_sbox_lkup_tbl[8'he0] = 8'ha0;
   inv_sbox_lkup_tbl[8'he1] = 8'he0;
   inv_sbox_lkup_tbl[8'he2] = 8'h3b;
   inv_sbox_lkup_tbl[8'he3] = 8'h4d;
   inv_sbox_lkup_tbl[8'he4] = 8'hae;
   inv_sbox_lkup_tbl[8'he5] = 8'h2a;
   inv_sbox_lkup_tbl[8'he6] = 8'hf5;
   inv_sbox_lkup_tbl[8'he7] = 8'hb0;
   inv_sbox_lkup_tbl[8'he8] = 8'hc8;
   inv_sbox_lkup_tbl[8'he9] = 8'heb;
   inv_sbox_lkup_tbl[8'hea] = 8'hbb;
   inv_sbox_lkup_tbl[8'heb] = 8'h3c;
   inv_sbox_lkup_tbl[8'hec] = 8'h83;
   inv_sbox_lkup_tbl[8'hed] = 8'h53;
   inv_sbox_lkup_tbl[8'hee] = 8'h99;
   inv_sbox_lkup_tbl[8'hef] = 8'h61;
   inv_sbox_lkup_tbl[8'hf0] = 8'h17;
   inv_sbox_lkup_tbl[8'hf1] = 8'h2b;
   inv_sbox_lkup_tbl[8'hf2] = 8'h04;
   inv_sbox_lkup_tbl[8'hf3] = 8'h7e;
   inv_sbox_lkup_tbl[8'hf4] = 8'hba;
   inv_sbox_lkup_tbl[8'hf5] = 8'h77;
   inv_sbox_lkup_tbl[8'hf6] = 8'hd6;
   inv_sbox_lkup_tbl[8'hf7] = 8'h26;
   inv_sbox_lkup_tbl[8'hf8] = 8'he1;
   inv_sbox_lkup_tbl[8'hf9] = 8'h69;
   inv_sbox_lkup_tbl[8'hfa] = 8'h14;
   inv_sbox_lkup_tbl[8'hfb] = 8'h63;
   inv_sbox_lkup_tbl[8'hfc] = 8'h55;
   inv_sbox_lkup_tbl[8'hfd] = 8'h21;
   inv_sbox_lkup_tbl[8'hfe] = 8'h0c;
   inv_sbox_lkup_tbl[8'hff] = 8'h7d;
end 
endmodule