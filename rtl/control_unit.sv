// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: control_unit.sv
// Descricao: FSM de Moore com 7 estados — unidade de controle
// =============================================================
import vending_pkg::*;

module control_unit (
    input  logic        clk,
    input  logic        rst,
    input  logic [1:0]  coin_in,
    input  logic [1:0]  sel_item,
    input  logic        confirm,
    input  logic        cancel,
    input  logic        can_sell,
    input  logic [7:0]  change,
    input  logic [7:0]  credit,
    output logic        credit_load,
    output logic        credit_clr,
    output logic        mem_read,
    output logic        mem_write,
    output logic        dispense,
    output logic        error,
    output logic [7:0]  change_out,
    output logic [7:0]  display,
    output logic [2:0]  state_out
);

state_t state, next_state;

// Bloco sequencial — registra o estado atual
always_ff @(posedge clk) begin
    if (rst) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Bloco combinacional — logica de proximo estado e saidas
always_comb begin
    // valores padrao — evita latches
    next_state  = state;
    credit_load = 1'b0;
    credit_clr  = 1'b0;
    mem_read    = 1'b0;
    mem_write   = 1'b0;
    dispense    = 1'b0;
    error       = 1'b0;
    change_out  = 8'd0;
    display     = credit;
    state_out   = state;

    case (state)
        IDLE: begin
            if (cancel)
                next_state = IDLE;
            else if (coin_in != 2'b00)
                next_state = COLLECT;
        end

        COLLECT: begin
            credit_load = 1'b1;
            if (cancel)
                next_state = IDLE;
            else if (confirm)
                next_state = CHECK;
        end

        CHECK: begin
            mem_read = 1'b1;
            if (cancel)
                next_state = IDLE;
            else
                next_state = CHECK_WAIT;
        end

        CHECK_WAIT: begin
            if (cancel)
                next_state = IDLE;
            else if (can_sell)
                next_state = DISPENSE;
            else
                next_state = ERROR;
        end

        DISPENSE: begin
            dispense  = 1'b1;
            mem_write = 1'b1;
            next_state = CHANGE;
        end

        CHANGE: begin
            change_out = change;
            credit_clr = 1'b1;
            next_state = IDLE;
        end

        ERROR: begin
            error = 1'b1;
            if (cancel)
                next_state = IDLE;
        end

        default: next_state = IDLE;
    endcase
end

endmodule