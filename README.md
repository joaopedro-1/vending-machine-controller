# Vending Machine Controller — SystemVerilog

Projeto da Residência do CiExpert — Trilha RTL Design.

## Descrição

Controlador digital de uma vending machine com 4 itens implementado em SystemVerilog, integrando FSM de Moore, memória síncrona e datapath separado.

## FSM — 7 estados

IDLE → COLLECT → CHECK → CHECK_WAIT → DISPENSE → CHANGE → IDLE

Desvio de erro: CHECK_WAIT → ERROR → IDLE

## Estrutura

    grupo_NN_vending/
    ├── rtl/
    │   ├── vending_pkg.sv    # Package: tipos e parâmetros
    │   ├── credit_reg.sv     # Registrador de crédito
    │   ├── memory.sv         # Memória 4x16 bits
    │   ├── comparator.sv     # can_sell combinacional
    │   ├── subtractor.sv     # Cálculo de troco
    │   ├── control_unit.sv   # FSM de Moore
    │   └── vending_top.sv    # Top-level
    ├── sim/
    │   └── tb_vending.sv     # Testbench — 4 cenários
    └── synth/
        ├── synth.tcl         # Script de síntese — Design Compiler
        ├── vending.sdc       # Constraints de timing (50 MHz)
        ├── .synopsys_dc.setup # Configuração da biblioteca SAED32
        └── reports/
            ├── area.rpt      # Relatório de área
            ├── timing.rpt    # Relatório de timing e caminho crítico
            ├── power.rpt     # Relatório de potência
            └── violations.rpt # Violações de constraints

## Como simular

```bash
cd sim
vcs -sverilog ../rtl/vending_pkg.sv ../rtl/credit_reg.sv ../rtl/memory.sv \
    ../rtl/comparator.sv ../rtl/subtractor.sv ../rtl/control_unit.sv \
    ../rtl/vending_top.sv tb_vending.sv && ./simv
```

## Como sintetizar

```bash
cd grupo_NN_vending
dc_shell -f synth/synth.tcl | tee synth/reports/dc_shell.log
```

## Resultado dos testes

    PASS: cenario1 dispense         | esperado=1   atual=1
    PASS: cenario1 change_out       | esperado=75  atual=75
    PASS: cenario2 error            | esperado=1   atual=1
    PASS: cenario3 change_out       | esperado=200 atual=200
    PASS: cenario4 estoque zerado   | esperado=1   atual=1

## Resultados de síntese — SAED32 (50 MHz)

| Métrica | Valor |
|---------|-------|
| Área total | 842.96 µm² |
| Slack (caminho crítico) | 16.25 ns |
| Potência dinâmica | 21.27 µW |
| Potência de leakage | 77.08 µW |

## Tecnologias

- SystemVerilog (IEEE 1800)
- Synopsys VCS — compilação e simulação
- Synopsys Verdi — depuração de waveforms
- Synopsys Design Compiler — síntese lógica com SAED32
