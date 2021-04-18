module tb_aes_round ();


/**********************************************************************
* parameter Declaration
**********************************************************************/
  parameter RND_SIZE = 128;
  parameter WRD_SIZE = 32 ;
  parameter NUM_BLK  = 4  ;
/**********************************************************************
* Inputs as registers
**********************************************************************/
  reg                clk       ;
  reg                rst_n     ;
  reg [RND_SIZE-1:0] i_rnd_text;
  reg [RND_SIZE-1:0] i_rnd_key ;
  reg                i_lst_rnd ;

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
    .NUM_BLK (NUM_BLK )
  ) DUT(
    // inputs
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .i_rnd_text(i_rnd_text),
    .i_rnd_key (i_rnd_key ),
    .i_lst_rnd (i_lst_rnd ),
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
      i_lst_rnd  ='b0; //TODO:
      rst_n =1'b0;
      repeat (5)
        begin
          @(posedge clk)
            rst_n = 1'b0;
        end
      rst_n = 1'b1;
    end
  endtask

  task run_round_test();
    begin
      i_rnd_text = $random(); //TODO:
      i_rnd_key  = $random(); //TODO:
      i_lst_rnd  ='b0; //TODO:
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