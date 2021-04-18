//------------------------------------------------------------------------------
// Title       : aes_control_unit
// Project     : AES Encruption
//------------------------------------------------------------------------------
// File        : aes_control_unit.v
// Author      : aamir <fpgaservices@gmail.com>
// Company     : PaklogicTechs
// Created     : Mon Mar 22 09:01:22 2021
// Last update : Mon Mar 22 09:01:22 2021
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


module aes_control_unit (
	input      clk    , // Clock
	input      rst_n  , // Asynchronous reset active low
	input      i_en   ,
	input      i_flag ,
	output reg o_busy ,
	output reg o_dp_en,
  output reg o_ready,
	output reg o_valid
);

/**********************************************************************
* FSM State Declaration
**********************************************************************/

	localparam RESET = 0;
	localparam WAIT  = 1;
	localparam BUSY  = 2;
	localparam DONE  = 3;

/**********************************************************************
* FSM State register Declaration
**********************************************************************/

	reg [1:0] current_state;
	reg [1:0] next_state   ;

/**********************************************************************
* FSM State register Declaration
**********************************************************************/

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			current_state <= RESET;
		end else begin
			current_state <= next_state;
		end
	end

/**********************************************************************
* State Decoder logic
**********************************************************************/

	always@(current_state, i_flag,i_en) begin
		case (current_state)
			RESET   : next_state = WAIT;
			WAIT    : next_state = (i_en) ? BUSY : WAIT;
			BUSY    : next_state = (i_flag) ? DONE : BUSY;
			DONE    : next_state = RESET;
			default : next_state = RESET;
		endcase
	end
/**********************************************************************
* output decoder logic
**********************************************************************/
	always@(*) begin
		case (current_state)
			RESET : begin 
				o_ready = 1'b0;
				o_busy  = 1'b0;
				o_dp_en = 1'b0;
				o_valid = 1'b0;
			end
			WAIT : begin 
				o_ready = 1'b1;
				o_busy  = 1'b0;
				o_dp_en = 1'b0;
				o_valid = 1'b0;
			end

			BUSY : begin 
				o_ready = 1'b0;
				o_busy  = 1'b1;
				o_dp_en = 1'b1;
				o_valid = 1'b0;
			end
			DONE : begin 
				o_ready = 1'b0;
				o_busy  = 1'b0;
				o_dp_en = 1'b0;
				o_valid = 1'b1;
			end
			default : begin
				o_ready = 1'b0;
				o_busy  = 1'b0;
				o_dp_en = 1'b0;
				o_valid = 1'b0;
			end
		endcase
	end
endmodule