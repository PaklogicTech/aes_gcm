//------------------------------------------------------------------------------
// Title       : round_function
// Project     : Default Project Name
//------------------------------------------------------------------------------
// File        : round_function.vh
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


/**************************************************************************
*
**************************************************************************/
function [127 : 0] shiftrows(input [127 : 0] i_shiftrows);
  reg [31 : 0] i_wrd0, i_wrd1, i_wrd2, i_wrd3;
  reg [31 : 0] o_wrd0, o_wrd1, o_wrd2, o_wrd3;
  begin
    i_wrd0 = i_shiftrows[127 : 096];
    i_wrd1 = i_shiftrows[ 95 :  64];
    i_wrd2 = i_shiftrows[ 63 :  32];
    i_wrd3 = i_shiftrows[ 31 :   0];

     o_wrd0 = {i_wrd0[31 : 24], i_wrd1[23 : 16], i_wrd2[15 : 08], i_wrd3[07 : 00]};
     o_wrd1 = {i_wrd1[31 : 24], i_wrd2[23 : 16], i_wrd3[15 : 08], i_wrd0[07 : 00]};
     o_wrd2 = {i_wrd2[31 : 24], i_wrd3[23 : 16], i_wrd0[15 : 08], i_wrd1[07 : 00]};
     o_wrd3 = {i_wrd3[31 : 24], i_wrd0[23 : 16], i_wrd1[15 : 08], i_wrd2[07 : 00]};
      // o_wrd0 = {i_wrd0[31 : 24], i_wrd0[23 : 16], i_wrd0[15 : 08], i_wrd0[07 : 00]};
      // o_wrd1 = { i_wrd1[23 : 16], i_wrd1[15 : 08], i_wrd1[07 : 00],i_wrd1[31 : 24]};
      // o_wrd2 = { i_wrd2[23 : 16], i_wrd2[15 : 08], i_wrd2[07 : 00],i_wrd2[31 : 24]};
      // o_wrd3 = { i_wrd3[23 : 16], i_wrd3[15 : 08], i_wrd3[07 : 00],i_wrd3[31 : 24]};

    shiftrows = {o_wrd0, o_wrd1, o_wrd2, o_wrd3};
  end
endfunction // shiftrows
/**************************************************************************
*
**************************************************************************/
  function [127 : 0] addroundkey(input [127 : 0] i_data, input [127 : 0] rnd_key);
  begin
    addroundkey = i_data ^ rnd_key;
  end
endfunction // addroundkey
/**************************************************************************
*
**************************************************************************/
  function [7 : 0] gm2(input [7 : 0] op);
    begin
      gm2 = {op[6 : 0], 1'b0} ^ (8'h1b & {8{op[7]}});
    end
  endfunction // gm2
/**************************************************************************
*
**************************************************************************/
  function [7 : 0] gm3(input [7 : 0] op);
    begin
      gm3 = gm2(op) ^ op;
    end
  endfunction // gm3
/**************************************************************************
*
**************************************************************************/

function [31 : 0] mixw(input [31 : 0] i_wrd);
  reg [7 : 0] i_byt_0, i_byt_1, i_byt_2, i_byt_3;
  reg [7 : 0] o_byt_0, o_byt_1, o_byt_2, o_byt_3;
  begin
    i_byt_0 = i_wrd[31 : 24];
    i_byt_1 = i_wrd[23 : 16];
    i_byt_2 = i_wrd[15 : 08];
    i_byt_3 = i_wrd[07 : 00];

    o_byt_0 = gm2(i_byt_0) ^ gm3(i_byt_1) ^     i_byt_2  ^     i_byt_3;
    o_byt_1 = i_byt_0      ^ gm2(i_byt_1) ^ gm3(i_byt_2) ^     i_byt_3;
    o_byt_2 = i_byt_0      ^     i_byt_1  ^ gm2(i_byt_2) ^ gm3(i_byt_3);
    o_byt_3 = gm3(i_byt_0) ^     i_byt_1  ^     i_byt_2  ^ gm2(i_byt_3);

    mixw = {o_byt_0, o_byt_1, o_byt_2, o_byt_3};
  end
endfunction // mixw
/**************************************************************************
*
**************************************************************************/
  function [127 : 0] mixcolumns(input [127 : 0] i_mixcolumns);
    reg [31 : 0] i_wrd0, i_wrd1, i_wrd2, i_wrd3;
    reg [31 : 0] o_wrd0, o_wrd1, o_wrd2, o_wrd3;
    begin
      i_wrd0 = i_mixcolumns[127 : 096];
      i_wrd1 = i_mixcolumns[095 : 064];
      i_wrd2 = i_mixcolumns[063 : 032];
      i_wrd3 = i_mixcolumns[031 : 000];

      o_wrd0 = mixw(i_wrd0);
      o_wrd1 = mixw(i_wrd1);
      o_wrd2 = mixw(i_wrd2);
      o_wrd3 = mixw(i_wrd3);

      mixcolumns = {o_wrd0, o_wrd1, o_wrd2, o_wrd3};
    end
  endfunction
