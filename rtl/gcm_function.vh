function incremnt_gcm (input [127:0] j0);
	begin 
		incremnt_gcm = j0 + 1 ; 
	end
endfunction 


function [127:0] gcm_mul_128 (input [127:0] x, input [127:0] y, input [127:0] r);
		integer      i;
		reg [127:0] z;
		reg [127:0] v;
	begin
		// 1. copy x into  v and z as 0
		 z='h0;
		 v=x;

		for (i = 0; i < 127; i=i+1) begin
			if (y[i]) begin
				// do bit wise xor
				z=z^v;
			end
			if (!v[127]) begin
				// right shift once
				v=v>>1'b1;
			end
			else
				v= (v>>1'b1) ^ r;
		end
		gcm_mul_128 = z; 
	end
endfunction  
