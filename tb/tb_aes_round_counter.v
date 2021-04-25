module tb_aes_round_counter ();

/**********************************************************************
* parameter Declaration
**********************************************************************/
	localparam MAX_CNT  = 11;
	localparam CNT_SIZE = 4 ;
/**********************************************************************
* Inputs as registers
**********************************************************************/
	reg clk     ;
	reg rst_n   ;
	reg i_cnt_en;
/**********************************************************************
* output as wires
**********************************************************************/
	wire                o_flag ;
	wire [CNT_SIZE-1:0] o_count;
/**********************************************************************
* DUT instantiation
**********************************************************************/
	aes_round_counter #(
		.MAX_CNT (MAX_CNT ),
		.CNT_SIZE(CNT_SIZE)
	) DUT (
		// inputs
		.clk     (clk     ),
		.rst_n   (rst_n   ),
		.i_cnt_en(i_cnt_en),
		.o_flag  (o_flag  ),
		.o_count (o_count )
	);

/**********************************************************************
* Define Clock Cycles
**********************************************************************/
	localparam CLK_PRD = 10 ;
	initial    clk     = 'b1;
	always #((CLK_PRD)/2) clk = ! clk ;

	task reset_cntr();
		begin
			rst_n 	 = 1'b0;
			i_cnt_en = 1'b0;
			repeat (5)
				begin
					@(posedge clk)
						rst_n = 1'b0;
				end
			rst_n = 1'b1;

		end
	endtask

	task run_cntr_test();
		i_cnt_en =1'b1;
	endtask

/**********************************************************************
* Stimulus here
**********************************************************************/

	initial
		begin
			reset_cntr();
			@(posedge clk);
			run_cntr_test();
		end
endmodule