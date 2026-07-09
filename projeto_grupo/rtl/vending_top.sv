// =============================================================
// Módulo: vending_top
// Descrição: Arquivo Top-Level da Máquina de Vendas.
// Funciona como a placa-mãe, instanciando e conectando a 
// Unidade de Controle (Cérebro) ao Datapath (Músculos).
// =============================================================
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
    output vending_pkg::state_t state_out
);

    import vending_pkg::*;

    // =========================================================
    // Sinais Internos (Os fios de cobre da placa-mãe)
    // =========================================================
    logic [7:0] credit, price, stock, change;
    logic       can_sell, credit_load, mem_read, mem_write, change_ena;
    state_t     fsm_state;

    // =========================================================
    // Lógica Direta de Saída
    // =========================================================
    assign display   = credit;    // O visor mostra diretamente o dinheiro em caixa
    assign state_out = fsm_state; // Pino de debug para ver o estado atual

    // Registrador do troco: mantém o valor até o cliente retirar
    always_ff @(posedge clk) begin
        if (rst) begin
            change_out <= 8'd0;         // Reset total zera o troco
        end else if (cancel) begin
            change_out <= credit;       // Botão Cancelar devolve tudo o que foi inserido
        end else if (change_ena) begin
            change_out <= change;       // FSM autorizou a entrega do troco da compra
        end
    end

    // =========================================================
    // Instanciação dos Músculos (Datapath)
    // =========================================================
    credit_reg u_credit_reg (
        .clk           (clk),
        .rst           (rst),
        .cancel        (cancel),
        .credit_load   (credit_load),
        .current_state (fsm_state),
        .coin_in       (coin_in),
        .credit        (credit)
    );

    memory u_memory (
        .clk       (clk),
        .mem_read  (mem_read),
        .mem_write (mem_write),
        .sel_item  (sel_item),
        .price     (price),
        .stock     (stock)
    );

    comparator u_comparator (
        .credit   (credit),
        .price    (price),
        .stock    (stock),
        .can_sell (can_sell)
    );

    subtractor u_subtractor (
        .credit (credit),
        .price  (price),
        .change (change)
    );

    // =========================================================
    // Instanciação do Cérebro (Control Unit)
    // =========================================================
    control_unit u_control_unit (
        .clk         (clk),
        .rst         (rst),
        .cancel      (cancel),
        .coin_in     (coin_in),
        .confirm     (confirm),
        .can_sell    (can_sell),
        
        .credit_load (credit_load),
        .mem_read    (mem_read),
        .mem_write   (mem_write),
        .dispense    (dispense),
        .error       (error),
        .change_ena  (change_ena),
        .state_out   (fsm_state)
    );

endmodule