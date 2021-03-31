module tb_aes_control_unit ();

/**********************************************************************
* parameter Declaration  
**********************************************************************/
	reg     clk    ; // Clock
	reg     rst_n  ; // Asynchronous reset active low
	reg     i_en   ;
	reg     i_flag ;

/**********************************************************************
* output as wires 
**********************************************************************/
	wire o_busy ;
	wire o_dp_en;
  wire o_ready;
	wire o_valid;

/**********************************************************************
* DUT 
**********************************************************************/
aes_control_unit DUT(
	.clk    (clk    ), // Clock
	.rst_n  (rst_n  ), // Asynchronous reset active low
	.i_en   (i_en   ),
	.i_flag (i_flag ),
	.o_busy (o_busy ),
	.o_dp_en(o_dp_en),
  .o_ready(o_ready),
	.o_valid(o_valid)
);

/**********************************************************************
* Define Clock Cycles
**********************************************************************/

localparam CLK_PRD=10;
initial clk='1;
always #((CLK_PRD)/2) clk = ! clk ; 

task reset_cu();
  rst_n =1'b0;
  @(posedge clk) repeat (5)
  rst_n = 1'b1;
endtask

task run_cu_test();
 i_en    = '1; 
 i_flag  = '0;
endtask 

/**********************************************************************
* Stimulus here
**********************************************************************/

initial
begin 
  reset_cu();
  run_cu_test();
end


endmodule