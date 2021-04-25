module tb_aes_round ();


/**********************************************************************
* parameter Declaration
**********************************************************************/
  parameter RND_SIZE = 128;
  parameter WRD_SIZE = 32 ;
  parameter CNT_SIZE = 4  ;
  parameter NUM_BLK  = 4  ;
/**********************************************************************
* Inputs as registers
**********************************************************************/
  reg                clk       ;
  reg                rst_n     ;
  reg [RND_SIZE-1:0] i_rnd_text;
  reg [RND_SIZE-1:0] i_rnd_key ;
  reg [CNT_SIZE-1:0] i_rnd_cnt ;
  reg                i_rnd_en  ;

/**********************************************************************
* output as wires
**********************************************************************/
  wire [RND_SIZE-1:0] o_rnd_cypher;
/**********************************************************************
* DUT instantiation
**********************************************************************/
  aes_round #(
    .RND_SIZE(RND_SIZE),
    .WRD_SIZE(WRD_SIZE),
    .CNT_SIZE(CNT_SIZE),
    .NUM_BLK (NUM_BLK )
  ) DUT (
    // inputs
    .clk         (clk         ),
    .rst_n       (rst_n       ),
    .i_rnd_en    (i_rnd_en    ),
    .i_rnd_text  (i_rnd_text  ),
    .i_rnd_key   (i_rnd_key   ),
    .i_rnd_cnt   (i_rnd_cnt   ),
    // outputs
    .o_rnd_cypher(o_rnd_cypher)
  );

/**********************************************************************
* Define Clock Cycles
**********************************************************************/
  localparam CLK_PRD = 10 ;
  initial    clk     = 'b1;
  always #((CLK_PRD)/2) clk = ! clk ;
  task reset_round();
    begin
      i_rnd_text ='h0; //TODO:
      i_rnd_key  ='h0; //TODO:
      i_rnd_cnt  ='h0; //TODO:
      i_rnd_en   ='b0;
      rst_n =1'b0;
      repeat (5)
        begin
          @(posedge clk)
            rst_n = 1'b0;
        end
      rst_n = 1'b1;
    end
  endtask
  integer i=0;
  task run_round_test();
    begin

      for(i=0; i<2; i=i+1)
        begin
          @(posedge clk)
            i_rnd_en ='b1;
          i_rnd_cnt  = i;
          i_rnd_text = (i_rnd_cnt=='h0)?'h3243f6a8885a308d313198a2e0370734:'h193de3bea0f4e22b9ac68d2ae9f84808;
          i_rnd_key  = (i_rnd_cnt=='h0)?'h2b7e151628aed2a6abf7158809cf4f3c:'ha0fafe1788542cb123a339392a6c7605;
        end
    end
  endtask

/**********************************************************************
* Stimulus here
**********************************************************************/

  initial
    begin
      reset_round();
      run_round_test();
    end
endmodule

