# ==========================================
# Diretórios
# ==========================================
RTL_DIR   = rtl
SIM_DIR   = sim
SYNTH_DIR = synth

# ==========================================
# Arquivos
# ==========================================
RTL_FILES = \
    $(RTL_DIR)/vending_pkg.sv \
    $(RTL_DIR)/credit_reg.sv \
    $(RTL_DIR)/memory.sv \
    $(RTL_DIR)/comparator.sv \
    $(RTL_DIR)/subtractor.sv \
    $(RTL_DIR)/control_unit.sv \
    $(RTL_DIR)/vending_top.sv

TB_FILES = $(SIM_DIR)/tb_vending.sv

# ==========================================
# Compilação + Simulação
# ==========================================
run:
	cd $(SIM_DIR) && vcs -sverilog \
		$(addprefix ../, $(RTL_FILES)) \
		tb_vending.sv && ./simv

# ==========================================
# Síntese
# ==========================================
synth:
	dc_shell -f $(SYNTH_DIR)/synth.tcl | tee $(SYNTH_DIR)/reports/dc_shell.log

# ==========================================
# Waveform (Verdi)
# ==========================================
wave:
	verdi -ssf $(SIM_DIR)/vending.fsdb &

# ==========================================
# Limpeza
# ==========================================
clean:
	rm -rf \
		$(SIM_DIR)/simv* \
		$(SIM_DIR)/csrc \
		$(SIM_DIR)/*.daidir \
		$(SIM_DIR)/*.vcd \
		$(SIM_DIR)/*.fsdb \
		$(SIM_DIR)/ucli.key \
		alib-52 \
		work \
		command.log \
		default.svf \
		$(SYNTH_DIR)/reports/*.rpt \
		$(SYNTH_DIR)/*.ddc \
		$(SYNTH_DIR)/*_syn.v

.PHONY: run synth wave clean