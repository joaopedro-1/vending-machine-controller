# ============================================================
# Clock principal
# ============================================================

# 20 ns -> 50 MHz
create_clock -name clk -period 20.0 [get_ports clk]

# Incerteza do clock 
set_clock_uncertainty 0.5 [get_clocks clk]

# ============================================================
# Input delay
# ============================================================

# Atraso de 3 ns para todas as entradas em relação ao clock
set_input_delay 3.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

# ============================================================
# Output delay
# ============================================================

# Atraso de 3 ns para todas as saídas em relação ao clock
set_output_delay 3.0 -clock clk [all_outputs]

# ============================================================
# Carga das saídas e Célula de condução (Ambiente externo)
# ============================================================

# Capacitância de carga típica nas saídas
set_load 0.1 [all_outputs]