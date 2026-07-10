# Vending Machine Controller — SystemVerilog

Projeto desenvolvido para a **Residência em Microeletrônica – CI Expert**, na trilha **RTL Design**, implementando um controlador digital de uma máquina de vendas (Vending Machine) utilizando **SystemVerilog**.

---

## Visão Geral

O projeto implementa um controlador para uma vending machine com quatro produtos (café, água, suco e snack), utilizando uma arquitetura baseada na separação entre **Unidade de Controle (FSM de Moore)** e **Datapath**.

O sistema permite:

- Inserção de moedas
- Seleção de produto
- Validação de crédito
- Controle de estoque
- Liberação do produto
- Devolução de troco
- Cancelamento da operação

---

## Principais Características

- FSM de Moore com 6 estados
- Separação entre Controle e Datapath
- Memória síncrona 4 × 16 bits
- Controle de estoque
- Cálculo automático de troco
- Cancelamento da compra
- Testbench self-checking
- Síntese lógica utilizando Synopsys Design Compiler

---

## Máquina de Estados

Fluxo principal:

```
IDLE
  ↓
COLLECT
  ↓
CHECK
  ↓
DISPENSE
  ↓
CHANGE
  ↓
IDLE
```

Fluxo de erro:

```
CHECK
  ↓
ERROR
  ↓
IDLE (cancel)
```

A memória síncrona possui latência de um ciclo, tratada internamente através da flag **read_done**.

---

## Estrutura do Projeto

```
vending-machine-controller/
│
├── rtl/
│   ├── vending_pkg.sv
│   ├── credit_reg.sv
│   ├── memory.sv
│   ├── comparator.sv
│   ├── subtractor.sv
│   ├── control_unit.sv
│   └── vending_top.sv
│
├── sim/
│   └── tb_vending.sv
│
├── synth/
│   ├── synth.tcl
│   ├── vending.sdc
│   ├── reports/
│   └── netlist/
│
└── Makefile
└── README.md
└── Relatório_ Vending Machine RTL.pdf
```

---

## Simulação

Carregue o ambiente Synopsys:

```bash
source /Tools/synopsys/snps.sh
```

Execute a simulação:

```bash
make run
```

---

## Síntese

Execute:

```bash
make synth
```

O script gera automaticamente:

- Report de área
- Report de timing
- Report de potência
- Report de constraints
- Netlist sintetizada

---

## Cenários de Teste

O testbench verifica automaticamente:

- Compra bem-sucedida com troco
- Crédito insuficiente
- Cancelamento da operação
- Estoque esgotado

Exemplo da saída:

```
[PASS] Dispense deve disparar
[PASS] Troco deve ser 75 centavos
[PASS] Crédito final deve ser 0
[PASS] Sinal de erro deve ser ativado
[PASS] FSM deve retornar ao IDLE
[PASS] Troco devolvido = R$2,00
```

---

## Resultados de Síntese

Biblioteca utilizada:

**SAED32 RVT (tt1p05v25c)**

| Métrica | Resultado |
|---------|----------:|
| Frequência de projeto | 50 MHz |
| Frequência máxima estimada | ≈ 200 MHz |
| Área de células | 769.04 µm² |
| Área total | 908.76 µm² |
| Slack @50 MHz | +15.60 ns |
| Violações de setup | Nenhuma |
| Violações de hold | Nenhuma |

O caminho crítico identificado pelo Design Compiler está associado ao somador do registrador de crédito (`credit_reg`), utilizado durante o estado **COLLECT**.

---

## Ferramentas Utilizadas

- SystemVerilog (IEEE 1800)
- Synopsys VCS
- Synopsys WaveView / Verdi
- Synopsys Design Compiler
- GNU Make

---
