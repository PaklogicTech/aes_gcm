module tb_aes_key_gen ();

/**********************************************************************
* Inputs as registers
**********************************************************************/
	reg [127:0] pre_rnd_key ;
	reg         i_en_key_gen;
	reg [  3:0] round_num   ;

/**********************************************************************
* output as wires
**********************************************************************/
	wire [127:0] next_rnd_key;

/**********************************************************************
* DUT instantiation
**********************************************************************/

	aes_key_gen DUT (
		.pre_rnd_key (pre_rnd_key ),
		.i_en_key_gen(i_en_key_gen),
		.round_num   (round_num   ),
		.next_rnd_key(next_rnd_key)
	);
	task run_key_gen();
		begin
			pre_rnd_key  = $random();// TODO: ADD as per spects.
			i_en_key_gen = 'b1;
			round_num    = $random();
		end
	endtask : run_key_gen
/**********************************************************************
* Stimulus here
**********************************************************************/
	initial
		begin
			repeat (10)
				begin
					run_key_gen();
					#5;
				end
		end
endmodule