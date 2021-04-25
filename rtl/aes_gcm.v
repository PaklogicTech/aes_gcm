//------------------------------------------------------------------------------
// Title       : aes_core_top
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_core_top.v
// Author      : aamir <fpgaservices@gmail.com>
// Company     : PaklogicTechs
// Created     : Tue Apr 6 08:32:22 2021
// Last update : Tue Apr 6 08:32:22 2021
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


module aes_gcm #(parameter
	RND_SIZE = 128,
	WRD_SIZE = 32 ,
	NUM_BLK  = 4  ,
	MAX_CNT  = 10 ,
	CNT_SIZE = 4  ,
	NUM_RND  = 10 ,
	NUM_BYTE = 16
) (
	input                    clk       , // Clock
	input                    rst_n     , // Asynchronous reset active low
	input                    i_en      ,
	input  [   RND_SIZE-1:0] i_msg     ,
	input  [   RND_SIZE-1:0] i_key     ,
	input  [NUM_BYTE*16-1:0] i_add_data,
	input                    len_ad    ,
	output                   o_valid   ,
	output [   RND_SIZE-1:0] o_cypher  ,
	output [NUM_BYTE*16-1:0] tag       ,
	output                   o_ready   ,
	output                   busy
);

parameter [95:0] IV = ff	        ;  // TODO: populate exact value 
	wire                w_aes_valid ;
	wire [RND_SIZE-1:0] w_aes_cypher;
	wire                w_aes_ready ;
	wire                w_aes_busy  ;
	wire [RND_SIZE-1:0] w_gcm_j0    ;
	wire [RND_SIZE-1:0] w_gcm_inc0  ;


/**************************************************************
* Initial hash sub key finding H = E(K, 0^128)
**************************************************************/

	aes_core_top #(
		.RND_SIZE(RND_SIZE),
		.WRD_SIZE(WRD_SIZE),
		.NUM_BLK (NUM_BLK ),
		.MAX_CNT (MAX_CNT ),
		.CNT_SIZE(CNT_SIZE),
		.NUM_RND (NUM_RND )
	) InitialHashSubkey (
		.clk     (clk         ), // input                 clk     ,
		.rst_n   (rst_n       ), // input                 rst_n   ,
		.i_en    (i_en        ), // input                 i_en    ,
		.i_msg   ('d0         ), // input  [RND_SIZE-1:0] i_msg   ,
		.i_key   (i_key       ), // input  [RND_SIZE-1:0] i_key   ,
		.o_valid (w_aes_valid ), // output                o_valid ,
		.o_cypher(w_aes_cypher), // output [RND_SIZE-1:0] o_cypher,
		.o_ready (w_aes_ready ), // output                o_ready ,
		.busy    (w_aes_busy  )  // output                busy
	);

/**************************************************************
* J0 is defined. len(IV)=96, then let J0 = IV || 0^31 || 1
**************************************************************/
assign w_gcm_j0 = {IV,'0,'b1};

/**************************************************************
* Incrementing function
**************************************************************/

assign w_gcm_inc0= incremnt_gcm(w_gcm_j0); 
