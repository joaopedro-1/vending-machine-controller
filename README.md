# Vending Machine Controller — SystemVerilog

Projeto da Residência em Microeletrônica do CI Expert — Trilha RTL Design.

## Descrição

Controlador digital de uma vending machine com 4 itens (café, água, suco e snack) implementado em SystemVerilog, integrando FSM de Moore, memória síncrona e datapath separado.

## FSM — 6 estados

IDLE → COLLECT → CHECK → DISPENSE → CHANGE → IDLE

Desvio de erro: CHECK → ERROR → IDLE (via cancel)

A latência da memória síncrona é tratada internamente no estado CHECK via flag `read_done`, que aguarda 1 ciclo antes de avaliar `can_sell`.

## Estrutura

    vending-machine-controller/
    ├── rtl/
    │   ├── vending_pkg.sv    # Package: tipos e parâmetros
    │   ├── credit_reg.sv     # Registrador de crédito (usa current_state)
    │   ├── memory.sv         # Memória 4x16 bits
    │   ├── comparator.sv     # can_sell combinacional
    │   ├── subtractor.sv     # Cálculo de troco
    │   ├── control_unit.sv   # FSM de Moore com read_done
    │   └── vending_top.sv    # Top-level com change_out registrado
    ├── sim/
    │   └── tb_vending.sv     # Testbench — 4 cenários
    └── synth/
        ├── synth.tcl         # Script de síntese — Design Compiler
        ├── vending.sdc       # Constraints de timing (50 MHz)
        ├── .synopsys_dc.setup
        └── reports/
            ├── area_pos.rpt
            ├── timing_relatorio.rpt
            └── power.rpt

## Como simular

```bash
source /Tools/synopsys/snps.sh
make run
```

## Como sintetizar

```bash
source /Tools/synopsys/snps.sh
make synth
```

## Resultado dos testes

    [PASS] Dispense deve disparar          | Esperado: 1,   Obtido: 1
    [PASS] Troco deve ser 75 centavos      | Esperado: 75,  Obtido: 75
    [PASS] Credito final deve ser 0        | Esperado: 0,   Obtido: 0
    [PASS] Sinal de erro deve ser ativado  | Esperado: 1,   Obtido: 1
    [PASS] FSM deve travar no estado ERROR | Esperado: 5,   Obtido: 5
    [PASS] FSM deve voltar para IDLE       | Esperado: 0,   Obtido: 0
    [PASS] FSM deve retornar a IDLE        | Esperado: 0,   Obtido: 0
    [PASS] Credito deve ser zerado         | Esperado: 0,   Obtido: 0
    [PASS] Troco devolvido R$2.00          | Esperado: 200, Obtido: 200
    [PASS] Erro deve disparar por estoque  | Esperado: 1,   Obtido: 1
    [PASS] FSM deve ir para ERROR          | Esperado: 5,   Obtido: 5

## Resultados de síntese — SAED32 (50 MHz)

| Métrica | Valor |
|---------|-------|
| Área total | 908.76 µm² |
| Slack (caminho crítico) | 16.34 ns |
| Caminho crítico | estado_atual_reg → AND3 → dispense |
| Nenhuma violação de timing |

## Tecnologias

- SystemVerilog (IEEE 1800)
- Synopsys VCS — compilação e simulação
- Synopsys Verdi — depuração de waveforms
- Synopsys Design Compiler — síntese lógica com SAED32
