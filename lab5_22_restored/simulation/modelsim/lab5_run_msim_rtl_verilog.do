transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/datapath.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/mux2_1_16.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/mux4_1_16.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/reg_16.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/reg_3.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/reg_1.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/lookahead_adder.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/fourbit_lookahead.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/full_adder.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/alu.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/reg_file.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/mux8_1_16.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/slc3.sv}
vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/slc3_testtop.sv}

vlog -sv -work work +incdir+C:/Users/user1/Desktop/ECE\ 385/Lab_5/lab5_22_restored {C:/Users/user1/Desktop/ECE 385/Lab_5/lab5_22_restored/slc3Test.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  slc3Test

add wave *
view structure
view signals
run 20000 ns
