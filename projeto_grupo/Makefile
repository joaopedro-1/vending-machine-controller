SHELL := /bin/bash

# ==========================================
# Diretórios
# ==========================================
RTL_DIR   = rtl
TB_DIR    = sim
SYNTH_DIR = synth

# ==========================================
# Arquivos
# ==========================================
PKG_FILES = $(RTL_DIR)/vending_pkg.sv

RTL_FILES = \
    $(RTL_DIR)/credit_reg.sv \
    $(RTL_DIR)/memory.sv \
    $(RTL_DIR)/comparator.sv \
    $(RTL_DIR)/subtractor.sv \
    $(RTL_DIR)/control_unit.sv \
    $(RTL_DIR)/vending_top.sv

TB_FILES = $(TB_DIR)/tb_vending.sv

TOP = tb_vending

TIMESCALE = 1ns/1ps

VLOGAN_FLAGS = -full64 -sverilog -kdb +lint=all
VCS_FLAGS    = -full64 -timescale=$(TIMESCALE) -debug_access+all -kdb

# ==========================================
# Targets
# ==========================================
run:
	source /Tools/synopsys/snps.sh && \
	vlogan $(VLOGAN_FLAGS) $(PKG_FILES) $(RTL_FILES) $(TB_FILES) && \
	vcs $(VCS_FLAGS) -top $(TOP) && \
	./simv

wave:
	verdi -ssf vending.vcd &

synth:
	source /Tools/synopsys/snps.sh && \
	dc_shell -f $(SYNTH_DIR)/synth.tcl | tee $(SYNTH_DIR)/reports/dc_shell.log

clean:
	rm -rf csrc simv* *.daidir AN.DB ucli.key \
		*.vcd *.fsdb *.log novas* verdi* DVEfiles \
		.vlogan* work alib-52 command.log default.svf \
		$(SYNTH_DIR)/reports/*.rpt $(SYNTH_DIR)/*.ddc \
		$(SYNTH_DIR)/*_syn.v

.PHONY: run wave synth clean