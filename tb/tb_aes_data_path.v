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
reg                clk          ;
reg                rst_n        ;
reg                i_dp_en      ;
reg [RND_SIZE-1:0] i_rnd_text   ;
reg [RND_SIZE-1:0] i_rnd_key    ;

/**********************************************************************
* output as wires 
**********************************************************************/
wire [RND_SIZE-1:0]  o_cypher_text;
wire o_flag                       ;
/**********************************************************************
* DUT instantiation 
**********************************************************************/
 aes_data_path #(parameter
  RND_SIZE = 128,
  WRD_SIZE = 32 ,
  NUM_BLK  = 4  ,
  MAX_CNT  = 10 ,
  CNT_SIZE = 4  ,
  NUM_RND  = 10
) DUT(
  // inputs
  .clk       (clk       )   ,
  .rst_n     (rst_n     )   ,
  .i_dp_en   (i_dp_en   )   ,
  .i_rnd_text(i_rnd_text)   ,
  .i_rnd_key (i_rnd_key )   ,
  // outputs
  .o_cypher_text(o_cypher_text),
  .o_flag       (o_flag)
);


/**********************************************************************
* Define Clock Cycles
**********************************************************************/

localparam CLK_PRD=10;
initial clk='1;
always #((CLK_PRD)/2) clk = ! clk ; 


task reset_dp();
  rst_n =1'b0;
  @(posedge clk) repeat (5)
  rst_n = 1'b1;
endtask

task run_dp_test();
 i_dp_en    = 'b1; 
 i_rnd_text = '0;
 i_rnd_key  = '0;
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