`timescale 1us / 1ns
module p_sequencer_tb();
reg clk;
reg sync_reset;
reg jump;
reg zero_flag;
reg conditional_jump;
reg correct_address;
reg [3:0] count;
reg [3:0] LS_nibble_ir;
wire [7:0] pm_address;

initial 
#50 $stop; // suspend the simulation after 50 clock cycles

initial 
#0 clk = 1'b0;

always 
#0.5 clk = ~clk;

initial 
#0 count = 4'h0;

always @ (posedge clk)
if (count == 4'b1111)
#0.005 count <= 4'b0000; // hold count for 5 ns
				 // after clock edge to model
else
#0.005 count <= count + 4'h1; // hold count for 5 ns
				      // after clock edge to model
				      // a hardware counter
always @ *
case (count)
4'b0000:
	begin
	sync_reset = 1'b1;
	jump = 1'b0;
	zero_flag = 1'b1;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'h0;
	// on first time through the loop pc = 0
	if (pm_address == 8'h00) correct_address = 1'b1;
	else correct_address =1'b0; // pm_address is wrong
	end
4'b0001:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b1;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'hA;
	if (pm_address == 8'h01) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b0010:
	begin
	sync_reset = 1'b0;
	jump = 1'b1;
	zero_flag = 1'b1;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'hA;
	if (pm_address == 8'hA0) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b0011:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'hA;
	if (pm_address == 8'hA1) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b0100:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b1;
	LS_nibble_ir = 4'h1;
	if (pm_address == 8'h10) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b0101:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b1;
	conditional_jump = 1'b1;
	LS_nibble_ir = 4'h1;
	if (pm_address == 8'h11) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b0110:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b1;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'hB;
	if (pm_address == 8'h12) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b0111:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'h3;
	if (pm_address == 8'h13) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1000:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'h3;
	if (pm_address == 8'h14) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1001:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'h3;
	if (pm_address == 8'h15) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1010:
	begin
	sync_reset = 1'b1;
	jump = 1'b1;
	zero_flag = 1'b1;
	conditional_jump = 1'b1;
	LS_nibble_ir = 4'h9;
	if (pm_address == 8'h00) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1011:
	begin
	sync_reset = 1'b0;
	jump = 1'b1;
	zero_flag = 1'b1;
	conditional_jump = 1'b1;
	LS_nibble_ir = 4'h9;
	if (pm_address == 8'h90) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1100:
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'hf;
	if (pm_address == 8'h91) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1101:
	begin
	sync_reset = 1'b0;
	jump = 1'b1;
	zero_flag = 1'b0;
	conditional_jump = 1'b1;
	LS_nibble_ir = 4'hf;
	if (pm_address == 8'hf0) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1110:
	begin
	sync_reset = 1'b0;
	jump = 1'b1;
	zero_flag = 1'b0;
	conditional_jump = 1'b1;
	LS_nibble_ir = 4'hb;
	if (pm_address == 8'hb0) correct_address =1'b1;
	else correct_address =1'b0;
	end
4'b1111:
	begin
	sync_reset = 1'b1;
	jump = 1'b1;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'hb;
	if (pm_address == 8'h00) correct_address =1'b1;
	else correct_address =1'b0;
	end

default: // this should never happen
	begin
	sync_reset = 1'b0;
	jump = 1'b0;
	zero_flag = 1'b0;
	conditional_jump = 1'b0;
	LS_nibble_ir = 4'h0;
	correct_address = 1'b0;
	end
endcase

program_sequencer prog_sequencer(
		.clk(clk),
		.sync_reset(sync_reset),
		.dont_jmp(zero_flag),
		.jmp(jump),
		.jmp_nz(conditional_jump),
		.jmp_addr(LS_nibble_ir),
		.pm_addr(pm_address)
		);

endmodule


