// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: vending_top.sv
// Descricao: Top-level — instancia e interconecta todos os modulos
// =============================================================
import vending_pkg::*;

module vending_top (
    input  logic        clk,
    input  logic        rst,
    input  logic [1:0]  coin_in,
    input  logic [1:0]  sel_item,
    input  logic        confirm,
    input  logic        cancel,
    output logic        dispense,
    output logic [7:0]  change_out,
    output logic        error,
    output logic [7:0]  display,
    output logic [2:0]  state_out
);

// Sinais internos
logic [7:0] credit;
logic [7:0] price;
logic [7:0] stock;
logic [7:0] change;
logic       can_sell;
logic       credit_load;
logic       credit_clr;
logic       mem_read;
logic       mem_write;

// Instancias
credit_reg credit_reg_inst (
    .clk         (clk),
    .rst         (rst),
    .coin_in     (coin_in),
    .credit_load (credit_load),
    .credit_clr  (credit_clr),
    .cancel      (cancel),
    .credit      (credit)
);

memory memory_inst (
    .clk       (clk),
    .sel_item  (sel_item),
    .mem_read  (mem_read),
    .mem_write (mem_write),
    .price     (price),
    .stock     (stock)
);

comparator comparator_inst (
    .credit   (credit),
    .price    (price),
    .stock    (stock),
    .can_sell (can_sell)
);

subtractor subtractor_inst (
    .credit (credit),
    .price  (price),
    .change (change)
);

control_unit control_unit_inst (
    .clk         (clk),
    .rst         (rst),
    .coin_in     (coin_in),
    .sel_item    (sel_item),
    .confirm     (confirm),
    .cancel      (cancel),
    .can_sell    (can_sell),
    .change      (change),
    .credit      (credit),
    .credit_load (credit_load),
    .credit_clr  (credit_clr),
    .mem_read    (mem_read),
    .mem_write   (mem_write),
    .dispense    (dispense),
    .error       (error),
    .change_out  (change_out),
    .display     (display),
    .state_out   (state_out)
);

endmodule