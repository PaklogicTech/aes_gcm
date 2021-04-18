module tb_gcm_ghash ();

/**********************************************************************
* Inputs as registers
**********************************************************************/
  reg         clk    ;
  reg         reset_n;
  reg         init   ;
  reg         next   ;
  reg [127:0] h0     ;
  reg [127:0] x      ;

/**********************************************************************
* output as wires
**********************************************************************/
  wire [127:0] y    ;
  wire         ready;

/**********************************************************************
* DUT instantiation
**********************************************************************/
  gcm_ghash DUT (
    .clk    (clk    ),
    .reset_n(reset_n),
    .init   (init   ),
    .next   (next   ),
    .h0     (h0     ),
    .x      (x      ),
    .y      (y      ),
    .ready  (ready  )
  );

/**********************************************************************
* Define Clock Cycles
**********************************************************************/
  localparam CLK_PRD = 10 ;
  initial    clk     = 'b1;
  always #((CLK_PRD)/2) clk = ! clk ;

  task reset_ghash();
    begin
      reset_n =1'b0;
      @(posedge clk) repeat (5)
        reset_n = 1'b1;
    end
  endtask

  task run_ghash_test();
    begin
      h0    = $random();
      x     = $random();
    end
  endtask

/**********************************************************************
* Stimulus here
**********************************************************************/

  initial
    begin
      reset_ghash();
      run_ghash_test();
    end

endmodule