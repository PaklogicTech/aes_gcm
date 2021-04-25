module tb_aes_sbox ();

	parameter RND_SIZE = 128;
  parameter WRD_SIZE = 32 ;
  parameter CNT_SIZE = 4  ;
  parameter NUM_BLK  = 4  ;
/**********************************************************************
* Inputs as registers
**********************************************************************/
	reg [31:0] i_wrd_sbox;

/**********************************************************************
* output as wires
**********************************************************************/
	wire [31:0] o_wrd_sbox;


wire [WRD_SIZE-1:0] i_rnd_text_blk[NUM_BLK-1:0];
reg [WRD_SIZE-1:0]  o_rnd_text_blk[NUM_BLK-1:0];
wire [RND_SIZE-1:0] i_rnd_text;
reg [RND_SIZE-1:0] o_rnd_text;

	assign i_rnd_text =  'h193de3bea0f4e22b9ac68d2ae9f84808;//'h19a09ae93df4c6f8e3e28d48be2b2a08; 
   


  assign i_rnd_text_blk[0] = i_rnd_text[127 :  96];
  assign i_rnd_text_blk[1] = i_rnd_text[ 95 :  64];
  assign i_rnd_text_blk[2] = i_rnd_text[ 63 :  32];
  assign i_rnd_text_blk[3] = i_rnd_text[ 31 :   0];

/**********************************************************************
* DUT instantiation
**********************************************************************/

	aes_sbox DUT (
		.i_wrd_sbox(i_wrd_sbox),
		.o_wrd_sbox(o_wrd_sbox)
	);
/**********************************************************************
* Stimulus here
**********************************************************************/
integer i;
	initial
		begin
	//		repeat (5)
		for (i = 0; i < 4; i=i+1) 
		begin
				 i_wrd_sbox			 =i_rnd_text_blk[i];
			#5 o_rnd_text_blk[i]=o_wrd_sbox;			
			
		end
		o_rnd_text ={o_rnd_text_blk[0],o_rnd_text_blk[1],o_rnd_text_blk[2],o_rnd_text_blk[3]};
		end
endmodule