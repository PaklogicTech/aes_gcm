//------------------------------------------------------------------------------
// Title       : aes_core_top
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_core_top.v
// Author      : aamir <fpgaservices@gmail.com>
// Company     : PaklogicTechs
// Created     : Mon Mar 22 09:19:22 2021
// Last update : Mon Mar 22 09:19:22 2021
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


module aes_core_top #(parameter
	RND_SIZE = 128,
	WRD_SIZE = 32 ,
	NUM_BLK  = 4  ,
	MAX_CNT  = 11 ,
	CNT_SIZE = 4  ,
	NUM_RND  = 10
) (
	input                 clk     , // Clock
	input                 rst_n   , // Asynchronous reset active low
	input                 i_en    ,
	input  [RND_SIZE-1:0] i_msg   ,
	input  [RND_SIZE-1:0] i_key   ,
	output                o_valid ,
	output [RND_SIZE-1:0] o_cypher,
	output                o_ready ,
	output                busy
);


	wire w_dp_en;
	wire w_flag;
/**********************************************************************
* Control Unit instnatiation
**********************************************************************/
	aes_control_unit CU (
		.clk    (clk    ), //input      clk    ,
		.rst_n  (rst_n  ), //input      rst_n  ,
		.i_en   (i_en   ), //input      i_en   ,
		.i_flag (w_flag ), //input      i_flag ,
		.o_ready(o_ready), //output reg o_ready,
		.o_busy (busy   ), //output reg o_busy ,
		.o_dp_en(w_dp_en), //output reg o_dp_en
		.o_valid(o_valid)
	);

/**********************************************************************
* Data Path instnatiation
**********************************************************************/

	aes_data_path #(
		.RND_SIZE(RND_SIZE), // RND_SIZE = 128,
		.WRD_SIZE(WRD_SIZE), // WRD_SIZE = 32 ,
		.NUM_BLK (NUM_BLK ), // NUM_BLK  = 4  ,
		.MAX_CNT (MAX_CNT ), // MAX_CNT  = 10 ,
		.CNT_SIZE(CNT_SIZE), // CNT_SIZE = 4  ,
		.NUM_RND (NUM_RND )  // NUM_RND  = 10
	) DP (
		// inputs
		.clk          (clk     ), // input                 clk          ,
		.rst_n        (rst_n   ), // input                 rst_n        ,
		.i_dp_en      (w_dp_en ), // input                 i_dp_en      ,
		.i_rnd_text   (i_msg   ), // input  [RND_SIZE-1:0] i_rnd_text   ,
		.i_rnd_key    (i_key   ), // input  [RND_SIZE-1:0] i_rnd_key    ,
		// outputs
		.o_cypher_text(o_cypher),
		.o_flag       (w_flag)
	);


endmodule