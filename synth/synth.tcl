# ============================================================
# Script de Sintese — Vending Machine Controller
# ============================================================

source synth/.synopsys_dc.setup

analyze -format sverilog rtl/vending_pkg.sv
analyze -format sverilog rtl/credit_reg.sv
analyze -format sverilog rtl/memory.sv
analyze -format sverilog rtl/comparator.sv
analyze -format sverilog rtl/subtractor.sv
analyze -format sverilog rtl/control_unit.sv
analyze -format sverilog rtl/vending_top.sv

elaborate vending_top
link

read_sdc synth/vending.sdc

puts "=================================================="
puts "CHECK DESIGN"
puts "=================================================="
check_design
redirect synth/reports/check_design.rpt { check_design }

puts "=================================================="
puts "INICIANDO SINTESE"
puts "=================================================="
compile_ultra -no_autoungroup

redirect synth/reports/area.rpt       { report_area -hierarchy }
redirect synth/reports/timing.rpt     { report_timing -max_paths 10 }
redirect synth/reports/power.rpt      { report_power }
redirect synth/reports/violations.rpt { report_constraint -all_violators }

write -format verilog -hierarchy -output synth/vending_syn.v
write -format ddc     -hierarchy -output synth/vending_syn.ddc

puts "=================================================="
puts "SINTESE CONCLUIDA"
puts "=================================================="
puts "Relatorios em synth/reports/"