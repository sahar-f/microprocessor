module program_sequencer(
	input clk, sync_reset,jmp,jmp_nz,dont_jmp,
	input[3:0] jmp_addr,
	output wire [7:0] pm_addr
);

reg [7:0] pc;	//program counter register

// program counter
always @ (posedge clk)
	if(pc == 8'hff)
		pc <= 8'h00;
	else if (jmp == 1'b1 || (jmp_nz == 1'b1 && dont_jmp == 1'b0))
		pc <= pm_addr;
	else
		pc <= pc + 8'h01;
	
// Next address 
always @ (*)
	if(sync_reset == 1'b1)
		pm_addr = 8'h00;
	else if (jmp == 1'b1)
		pm_addr = {jmp_addr,4'h0};
	else if (jmp_nz == 1'b1 && dont_jmp == 1'b0)
		pm_addr = {jmp_addr,4'h0};
	else if (dont_jmp == 1'b1 || jmp_nz == 1'b0)
		if(pc == 8'hff)
			pm_addr = 8'h00;
		else
			pm_addr = pc + 8'h01;
	else 
		pm_addr = pm_addr;	 

endmodule
