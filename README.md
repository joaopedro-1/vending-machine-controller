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
- Verificação de equivalência formal (RTL × netlist) com Synopsys Formality e guidance de SVF

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
│   ├── synth.tcl                 # síntese principal (-no_autoungroup) + set_svf
│   ├── synth_ungrouped.tcl       # síntese sem -no_autoungroup (comparação)
│   ├── vending.sdc
│   ├── vending_top_syn.v         # netlist sintetizada (revision)
│   └── reports/
│
├── fm/
│   ├── formality.tcl             # equivalência da netlist principal
│   ├── formality_ungrouped.tcl   # equivalência da netlist sem -no_autoungroup
│   └── reports/                  # relatórios de sign-off (status, accepted/rejected, etc.)
│
├── Makefile
├── README.md
├── Relatorio_Vending_Machine_RTL.pdf
└── Relatorio_Vending_Machine_Formality.pdf
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
- Arquivo de guidance SVF (`synth/reports/default.svf`), usado depois pelo Formality

---

## Equivalência Formal (Formality)

Além da simulação gate-level, a netlist sintetizada é verificada formalmente contra o RTL
original usando o **Synopsys Formality**. A verificação prova matematicamente (via BDDs e SAT)
que cada saída e cada flip-flop da netlist calcula o mesmo valor que o RTL para qualquer
entrada — não apenas para os vetores testados.

Como guidance de casamento é utilizado o arquivo **SVF** gerado pelo próprio Design Compiler
durante a síntese (`set_svf` antes do `compile_ultra`), formando um trilho de auditoria contínuo
da síntese até o sign-off de equivalência.

Execute (a partir de `fm/`):

```bash
cd fm/
fm_shell -f formality.tcl
```

O script carrega a biblioteca de células (a mesma da síntese), lê o SVF como guidance
(com `set synopsys_auto_setup true`), lê o RTL golden e a netlist revision, e roda `match` e
`verify`, gerando os relatórios de sign-off em `fm/reports/`.

Para a comparação com/sem `-no_autoungroup`, use `formality_ungrouped.tcl` com a netlist e o
SVF da rodada correspondente.

### Resultado

| Métrica | Rodada A (`-no_autoungroup`) | Rodada B (ungroup livre) |
|---------|:----------------------------:|:------------------------:|
| Compare points | 81 | 81 |
| Unmatched points | 0 | 0 |
| Operações SVF aceitas | 18 | 23 |
| Operações SVF rejeitadas | 0 | 0 |
| Veredito final | **SUCCEEDED** | **SUCCEEDED** |

Ambas as netlists foram provadas sequencialmente equivalentes ao RTL golden (81 pontos:
21 portas + 60 flip-flops), sem nenhum ponto não casado ou divergente, e sem necessidade de
casamento manual — o guidance do SVF resolveu todo o casamento automaticamente.

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
- Synopsys Formality
- GNU Make

---
