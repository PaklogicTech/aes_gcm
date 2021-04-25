module tb_aes_key_gen ();

/**********************************************************************
* Inputs as registers
**********************************************************************/
	wire [127:0] pre_rnd_key ;
	reg         i_en_key_gen;
	reg [  3:0] round_num   ;
	reg         clk         ;
	reg         rst_n       ;
/**********************************************************************
* output as wires
**********************************************************************/
	wire [127:0] next_rnd_key;

/**********************************************************************
* DUT instantiation
**********************************************************************/

	aes_key_gen DUT (
		.clk         (clk         ),
		.rst_n       (rst_n       ),
		.pre_rnd_key (pre_rnd_key ),
		.i_en_key_gen(i_en_key_gen),
		.round_num   (round_num   ),
		.next_rnd_key(next_rnd_key)
	);

	integer i=0;
	assign pre_rnd_key    = (i==0)?'h2b7e151628aed2a6abf7158809cf4f3c:next_rnd_key;
	/**********************************************************************
* Define Clock Cycles
**********************************************************************/

	localparam CLK_PRD = 10 ;
	initial    clk     = 'b1;
	always #((CLK_PRD)/2) clk = ! clk ;

	task reset_key_gen();
		begin
			i_en_key_gen  = 'b0;
			round_num = 'h0;
			rst_n =1'b0;
			repeat (5)
				begin
					@(posedge clk)
						rst_n = 1'b0;
				end
			rst_n = 1'b1;
		end
	endtask

	task run_key_gen();
		begin
			for ( i = 0; i < 11; i=i+1)
				begin
					@(posedge clk)
					i_en_key_gen   = 'b1;
					round_num      =  i;
						
				end
		end
	endtask : run_key_gen
/**********************************************************************
* Stimulus here
**********************************************************************/
	initial
		begin
			reset_key_gen();
			@(posedge clk)
			run_key_gen();
		end
endmodule