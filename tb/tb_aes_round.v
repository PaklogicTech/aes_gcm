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
reg                 clk        ;
reg                 rst_n      ;
reg  [RND_SIZE-1:0] i_rnd_text ;
reg  [RND_SIZE-1:0] i_rnd_key  ;
reg                 i_lst_rnd  ;

/**********************************************************************
* output as wires 
**********************************************************************/
wire [RND_SIZE-1:0] o_rnd_key ; 
/**********************************************************************
* DUT instantiation 
**********************************************************************/
aes_round #(parameter
  .RND_SIZE(RND_SIZE),
  .WRD_SIZE(WRD_SIZE),
  .NUM_BLK (NUM_BLK ),    
) (
  // inputs
  .clk       (clk       ),
  .rst_n     (rst_n     ),
  .i_rnd_text(i_rnd_text),
  .i_rnd_key (i_rnd_key ),
  .i_lst_rnd (i_lst_rnd ),
  // outputs
  .o_rnd_key(o_rnd_key)  
);

/**********************************************************************
* Define Clock Cycles
**********************************************************************/
localparam CLK_PRD=10;
initial clk='1;
always #((CLK_PRD)/2) clk = ! clk ; 
task reset_round();
  rst_n =1'b0;
  @(posedge clk) repeat (5)
  rst_n = 1'b1;
endtask

task run_round_test();
i_rnd_text = ; //TODO: 
i_rnd_key  = ; //TODO: 
i_lst_rnd  = ; //TODO: 
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