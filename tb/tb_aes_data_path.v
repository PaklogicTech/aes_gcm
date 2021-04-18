module tb_aes_data_path ();

/**********************************************************************
* parameter Declaration
**********************************************************************/
  localparam RND_SIZE = 128;
  localparam WRD_SIZE = 32 ;
  localparam NUM_BLK  = 4  ;
  localparam MAX_CNT  = 10 ;
  localparam CNT_SIZE = 4  ;
  localparam NUM_RND  = 10 ;

/**********************************************************************
* Inputs as registers
**********************************************************************/
  reg                clk       ;
  reg                rst_n     ;
  reg                i_dp_en   ;
  reg [RND_SIZE-1:0] i_rnd_text;
  reg [RND_SIZE-1:0] i_rnd_key ;

/**********************************************************************
* output as wires
**********************************************************************/
  wire [RND_SIZE-1:0] o_cypher_text;
  wire                o_flag       ;
/**********************************************************************
* DUT instantiation
**********************************************************************/
  aes_data_path #(
    .RND_SIZE(RND_SIZE),
    .WRD_SIZE(WRD_SIZE),
    .NUM_BLK (NUM_BLK ),
    .MAX_CNT (MAX_CNT ),
    .CNT_SIZE(CNT_SIZE),
    .NUM_RND (NUM_RND )
  ) DUT (
    // inputs
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .i_dp_en      (i_dp_en      ),
    .i_rnd_text   (i_rnd_text   ),
    .i_rnd_key    (i_rnd_key    ),
    // outputs
    .o_cypher_text(o_cypher_text),
    .o_flag       (o_flag       )
  );


/**********************************************************************
* Define Clock Cycles
**********************************************************************/

  localparam CLK_PRD = 10 ;
  initial    clk     = 'b1;
  always #((CLK_PRD)/2) clk = ! clk ;


  task reset_dp();
    begin
      i_dp_en    = 'b0;
      rst_n =1'b0;
      repeat (5)
        begin
          @(posedge clk)
            rst_n = 1'b0;
        end
      rst_n =1'b1;
    end
  endtask

  task run_dp_test();
    begin
      i_dp_en    = 'b1;
      i_rnd_text = $random();
      i_rnd_key  = $random();
    end
  endtask

/**********************************************************************
* Stimulus here
**********************************************************************/

  initial
    begin
      reset_dp();
      run_dp_test();
    end

endmodule