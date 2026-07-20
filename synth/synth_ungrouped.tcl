# ============================================================
# Script de Síntese — Vending Machine Controller
# RODADA B: SEM -no_autoungroup (permite ungroup automatico)
# Saidas com sufixo _ungrouped para NAO sobrescrever a rodada A.
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
puts "CHECK DESIGN (ungrouped)"
puts "=================================================="
redirect synth/reports/check_design_ungrouped.rpt { check_design }

# ============================================================
# SVF proprio desta rodada — nome distinto (default_ungrouped.svf).
# ANTES do compile_ultra.
# ============================================================
set_svf synth/reports/default_ungrouped.svf

# Síntese — SEM -no_autoungroup (esta e a diferenca da rodada B)
puts "=================================================="
puts "INICIANDO SINTESE (ungrouped)"
puts "=================================================="
compile_ultra

# Relatórios (nomes _ungrouped)
redirect synth/reports/area_ungrouped.rpt    { report_area -hierarchy }
redirect synth/reports/timing_ungrouped.rpt  { report_timing -max_paths 10 }
redirect synth/reports/power_ungrouped.rpt   { report_power }
redirect synth/reports/viol_ungrouped.rpt    { report_constraint -all_violators }

# Exportar netlist — nome distinto
write -format verilog -hierarchy -output synth/vending_top_syn_ungrouped.v
write -format ddc     -hierarchy -output synth/vending_top_syn_ungrouped.ddc

puts "=================================================="
puts "SINTESE CONCLUIDA (ungrouped)"
puts "=================================================="