# ============================================================
# Script de Síntese — Vending Machine Controller
# ============================================================

source synth/.synopsys_dc.setup

# Ler RTL
analyze -format sverilog rtl/vending_pkg.sv
analyze -format sverilog rtl/credit_reg.sv
analyze -format sverilog rtl/memory.sv
analyze -format sverilog rtl/comparator.sv
analyze -format sverilog rtl/subtractor.sv
analyze -format sverilog rtl/control_unit.sv
analyze -format sverilog rtl/vending_top.sv

# Elaborar
elaborate vending_top
link

# Constraints
read_sdc synth/vending.sdc

# Verificação
puts "=================================================="
puts "CHECK DESIGN"
puts "=================================================="
redirect synth/reports/check_design.rpt { check_design }



set_svf synth/reports/default.svf

# Síntese
puts "=================================================="
puts "INICIANDO SINTESE"
puts "=================================================="
compile_ultra -no_autoungroup

# Relatórios
redirect synth/reports/area_pos.rpt         { report_area -hierarchy }
redirect synth/reports/timing_relatorio.rpt { report_timing -max_paths 10 }
redirect synth/reports/power.rpt            { report_power }
redirect synth/reports/setup_violations.rpt { report_constraint -all_violators -check_type setup }
redirect synth/reports/hold_violations.rpt  { report_constraint -all_violators -check_type hold }
redirect synth/reports/setup_violations.rpt { report_constraint -all_violators }

# Exportar netlist
write -format verilog -hierarchy -output synth/vending_top_syn.v
write -format ddc     -hierarchy -output synth/vending_top_syn.ddc

puts "=================================================="
puts "SINTESE CONCLUIDA"
puts "=================================================="