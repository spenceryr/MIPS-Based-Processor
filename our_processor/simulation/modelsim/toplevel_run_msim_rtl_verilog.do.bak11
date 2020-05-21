transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {c:/intelfpga_lite/19.1/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {c:/intelfpga_lite/19.1/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {c:/intelfpga_lite/19.1/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {c:/intelfpga_lite/19.1/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {c:/intelfpga_lite/19.1/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {c:/intelfpga_lite/19.1/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/REL_LUT.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/reg_file.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/IF.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/definitions.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/data_mem.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/datapath.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/ALU_FLAGS.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/ABS_LUT.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/InstROM.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/controlpath.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/ALU.sv}
vlog -sv -work work +incdir+C:/141L-Lab-2/our_processor {C:/141L-Lab-2/our_processor/toplevel.sv}

