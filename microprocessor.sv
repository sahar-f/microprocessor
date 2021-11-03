module microprocessor(
	input clk, reset,
	input[3:0] i_pins,
	output wire[3:0] o_reg
);

wire jump, conditional_jump, zero_flag, i_mux_select, y_reg_select, x_reg_select;

wire[3:0] LS_nibble_ir, source_select, dm, data_bus, data_mem_addr;

wire[7:0] pm_address, pm_data;

wire [8:0] reg_enables;

/*****************
MAKE SYNC_RESET
******************/

reg sync_reset;
always @ (posedge clk)
	sync_reset = reset;
	
/***********************
INSTANTIATIONS
************************/

program_sequencer prog_sequencer(
	.clk(clk),
	.sync_reset(sync_reset),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.jmp_addr(LS_nibble_ir),
	.dont_jmp(zero_flag),
	.pm_addr(pm_address)
);

program_memory prog_mem(
	.clk(~clk), 
	.addr(pm_address), 
	.data(pm_data)
);

instruction_decoder instr_decoder(
	.clk(clk),
	.sync_reset(sync_reset),
	.next_instr(pm_data),
	.jmp(jump),
	.jmp_nz(conditional_jump),
	.ir_nibble(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_sel),
	.source_sel(source_select),
	.reg_en(reg_enables)
);

computational_unit comp_unit(
	.clk(clk),
	.sync_reset(sync_reset),
	.i_pins(i_pins),
	.nibble_ir(LS_nibble_ir),
	.i_sel(i_mux_select),
	.y_sel(y_reg_select),
	.x_sel(x_reg_sel),
	.source_sel(source_select),
	.reg_en({reg_enables[6:0],reg_enables[8]}),
	.dm(dm),
	.r_eq_0(zero_flag),
	.i(data_mem_addr),
	.data_bus(data_bus),
	.o_reg(o_reg)
);

data_memory data_mem(
	.clk(~clk),   
	.addr(data_mem_addr),
	.data_in(data_bus),
	.w_en(reg_enables[7]),
	.data_out(dm)
);

endmodule

