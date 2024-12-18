	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"testbench"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Block.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/down_counter_3bit.v
	#vlog 	+acc -incr -source  +define+SIM 	$hdl_path/outputs.mem
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/up_counter_2bit.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/registerN.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux_4_to_1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/Mux_2_to_1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/maclauren.v
	# vlog 	+acc -incr -source  +define+SIM 	$inc_path/implementation_option.vh
		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.sv
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	