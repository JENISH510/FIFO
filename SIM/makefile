#makefile

RTL="../RTL/fifo.v"
TB="../TB/tb_fifo.v"
TOP_MODULE=tb_fifo

lib:
	vlib work

comp:
	vlog $(RTL) $(TB)

comp1:
	vlog -coveropt 3 +acc +cover $(RTL) $(TB)

sim_gui:
	vsim -voptargs=+acc $(TOP_MODULE)

sim:
	vsim -voptargs=+acc $(TOP_MODULE) -c -do "run -all; exit"

sim1:
	vsim -coverage -voptargs=+acc $(TOP_MODULE) -c -do "coverage save -onexit -directive -cvg -codeall fifo.ucdb; run -all; exit"

report:
	vcover report -details -html -output fifo fifo.ucdb

runsim: comp1 sim1 report 
