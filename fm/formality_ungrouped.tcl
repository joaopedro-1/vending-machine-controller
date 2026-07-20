# ============================================================
# formality_ungrouped.tcl — RODADA B (netlist SEM -no_autoungroup)
# Cada netlist usa o SEU PROPRIO SVF (default_ungrouped.svf).
# Rodar de dentro de fm/ :  fm_shell -f formality_ungrouped.tcl
# ============================================================

# 1. Biblioteca de células — a mesma target_library do synth.tcl
read_db ../synth/libs/saed32rvt_tt1p05v25c.db

# 2. auto_setup ANTES do set_svf (exigencia da versao X-2025.06)
set synopsys_auto_setup true

# 3. SVF desta rodada — default_ungrouped.svf (NAO o da rodada A)
set_svf ../synth/reports/default_ungrouped.svf

# 4. Golden (RTL) — igual a rodada A, com read_sverilog
read_sverilog -r { ../rtl/vending_pkg.sv \
                   ../rtl/credit_reg.sv \
                   ../rtl/memory.sv \
                   ../rtl/comparator.sv \
                   ../rtl/subtractor.sv \
                   ../rtl/control_unit.sv \
                   ../rtl/vending_top.sv }
set_top r:/WORK/vending_top

# 5. Revision — netlist ungrouped desta rodada
read_verilog -i ../synth/vending_top_syn_ungrouped.v
set_top i:/WORK/vending_top

# 6. Match guiado por SVF (relatorios _ungrouped)
match
report_svf_operation -status accepted > reports/formality_svf_accepted_ungrouped.rpt
report_svf_operation -status rejected > reports/formality_svf_rejected_ungrouped.rpt
report_matched_points                 > reports/formality_matched_ungrouped.rpt
report_unmatched_points               > reports/formality_unmatched_ungrouped.rpt

# 7. Verify
verify

# 8. Sign-off (relatorios _ungrouped)
report_status           > reports/formality_status_ungrouped.rpt
report_passing_points   > reports/formality_passing_ungrouped.rpt
report_failing_points   > reports/formality_failing_ungrouped.rpt
report_unmatched_points > reports/formality_unmatched_ungrouped.rpt

exit