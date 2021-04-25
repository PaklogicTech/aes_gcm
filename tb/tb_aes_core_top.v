module tb_aes_core_top ();

/**********************************************************************
* parameter Declaration
**********************************************************************/

	localparam RND_SIZE = 128;
	localparam WRD_SIZE = 32 ;
	localparam NUM_BLK  = 4  ;
	localparam MAX_CNT  = 12 ;
	localparam CNT_SIZE = 4  ;
	localparam NUM_RND  = 10 ;

/**********************************************************************
* Inputs as registers
**********************************************************************/
	reg                clk  ; // Clock
	reg                rst_n; // Asynchronous reset active low
	reg                i_en ;
	reg [RND_SIZE-1:0] i_msg;
	reg [RND_SIZE-1:0] i_key;

/**********************************************************************
* output as wires
**********************************************************************/
	wire                o_valid ;
	wire [RND_SIZE-1:0] o_cypher;
	wire                o_ready ;
	wire                busy    ;

/**********************************************************************
* DUT instantiation
**********************************************************************/

	aes_core_top #(
		.RND_SIZE(RND_SIZE),
		.WRD_SIZE(WRD_SIZE),
		.NUM_BLK (NUM_BLK ),
		.MAX_CNT (MAX_CNT ),
		.CNT_SIZE(CNT_SIZE),
		.NUM_RND (NUM_RND )
	) DUT (
		.clk     (clk     ), // Clock
		.rst_n   (rst_n   ), // Asynchronous reset active low
		.i_en    (i_en    ),
		.i_msg   (i_msg   ),
		.i_key   (i_key   ),
		.o_valid (o_valid ),
		.o_cypher(o_cypher),
		.o_ready (o_ready ),
		.busy    (busy    )
	);

/**********************************************************************
* Define Clock Cycles
**********************************************************************/

	localparam CLK_PRD = 10 ;
	initial    clk     = 'b1;
	always #((CLK_PRD)/2) clk = ! clk ;


	task reset_aes();
		begin
			i_en  = 'b0;
			i_msg = 'h0;
			i_key = 'h0;
			rst_n =1'b0;
			repeat (5)
				begin
					@(posedge clk)
						rst_n = 1'b0;
				end
		rst_n = 1'b1;
		end
	endtask

	task run_aes_test();
		begin
			i_en  = 'b1;
			i_msg = 'h3243f6a8885a308d313198a2e0370734;
			i_key = 'h2b7e151628aed2a6abf7158809cf4f3c;
		end
	endtask

/**********************************************************************
* Stimulus here
**********************************************************************/

	initial
		begin
			reset_aes();
			run_aes_test();
		end
endmodule