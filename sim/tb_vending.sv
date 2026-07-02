// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: tb_vending.sv
// Descricao: Testbench self-checking com 4 cenarios obrigatorios
// =============================================================

module tb_vending;

// Sinais
logic        clk;
logic        rst;
logic [1:0]  coin_in;
logic [1:0]  sel_item;
logic        confirm;
logic        cancel;
logic        dispense;
logic [7:0]  change_out;
logic        error;
logic [7:0]  display;
logic [2:0]  state_out;

// Sinais de captura para verificacao
logic        dispense_captured;
logic [7:0]  change_captured;

// Instancia do DUT
vending_top dut (
    .clk       (clk),
    .rst       (rst),
    .coin_in   (coin_in),
    .sel_item  (sel_item),
    .confirm   (confirm),
    .cancel    (cancel),
    .dispense  (dispense),
    .change_out(change_out),
    .error     (error),
    .display   (display),
    .state_out (state_out)
);

// Captura de sinais para verificacao pos-estado
always_ff @(posedge clk) begin
    if (rst) begin
        dispense_captured <= 0;
        change_captured   <= 0;
    end else begin
        if (dispense)        dispense_captured <= 1;
        if (change_out != 0) change_captured   <= change_out;
        if (cancel)          change_captured   <= display;
    end
end

// Geracao de clock — periodo 10ns
initial clk = 0;
always #5 clk = ~clk;

// Geracao de waveform
initial begin
    $dumpfile("tb_vending.vcd");
    $dumpvars(0, tb_vending);
end

// ============================================================
// Tarefas
// ============================================================

// Verifica e reporta PASS/FAIL
task check(input logic [7:0] expected, input logic [7:0] actual, input string label);
    if (expected === actual)
        $display("PASS: %s | esperado=%0d atual=%0d", label, expected, actual);
    else
        $display("FAIL: %s | esperado=%0d atual=%0d", label, expected, actual);
endtask

// Aplica uma moeda e aguarda acumulacao
task apply_coin(input logic [1:0] value);
    coin_in = value;
    @(posedge clk);  // IDLE detecta coin_in
    @(posedge clk);  // COLLECT acumula
    coin_in = 2'b00;
    @(posedge clk);  // coin_in zerado
endtask

// ============================================================
// Cenarios de teste
// ============================================================
initial begin

    // Reset inicial
    rst     = 1;
    coin_in = 2'b00;
    sel_item = 2'b00;
    confirm = 0;
    cancel  = 0;
    @(posedge clk);
    @(posedge clk);
    rst = 0;

    // ----------------------------------------------------------
    // Cenario 1 — Compra bem-sucedida com troco
    // Insere R$1,00, compra cafe (R$0,25), troco = R$0,75
    // ----------------------------------------------------------
    sel_item = 2'b00;
    coin_in  = 2'b11;
    @(posedge clk);       // IDLE → COLLECT
    @(posedge clk);       // COLLECT acumula credit=100
    confirm  = 1;
    coin_in  = 2'b00;
    @(posedge clk);       // COLLECT → CHECK
    confirm  = 0;
    repeat(5) @(posedge clk);
    check(8'd1,  dispense_captured, "cenario1 dispense");
    check(8'd75, change_captured,   "cenario1 change_out");

    // Reset entre cenarios
    rst = 1; @(posedge clk); rst = 0; @(posedge clk);

    // ----------------------------------------------------------
    // Cenario 2 — Credito insuficiente
    // Insere R$0,25, tenta comprar snack (R$1,00)
    // ----------------------------------------------------------
    sel_item = 2'b11;
    @(posedge clk);
    apply_coin(2'b01);
    confirm = 1;
    @(posedge clk);
    confirm = 0;
    repeat(5) @(posedge clk);
    check(8'd1, error, "cenario2 error");

    // Reset entre cenarios
    rst = 1; @(posedge clk); rst = 0; @(posedge clk);

    // ----------------------------------------------------------
    // Cenario 3 — Cancelamento
    // Insere 2x R$1,00 e cancela — troco = R$2,00
    // ----------------------------------------------------------
    coin_in = 2'b11;
    @(posedge clk);       // IDLE → COLLECT
    @(posedge clk);       // acumula 100
    @(posedge clk);       // acumula mais 100 = 200
    @(posedge clk);       // ciclo extra
    cancel  = 1;
    @(posedge clk);
    cancel  = 0;
    coin_in = 2'b00;
    repeat(3) @(posedge clk);
    check(8'd200, change_captured, "cenario3 change_out");

    // Reset entre cenarios
    rst = 1; @(posedge clk); rst = 0; @(posedge clk);

    // ----------------------------------------------------------
    // Cenario 4 — Estoque zerado
    // Compra cafe 5 vezes (estoque=5), na 6a deve dar error
    // ----------------------------------------------------------
    sel_item = 2'b00;
    repeat(5) begin
        apply_coin(2'b01);
        confirm = 1;
        @(posedge clk);
        confirm = 0;
        @(posedge clk);
        repeat(5) @(posedge clk);
        rst = 1; @(posedge clk); rst = 0; @(posedge clk);
    end

    // 6a tentativa — estoque zerado
    apply_coin(2'b01);
    confirm = 1;
    @(posedge clk);
    confirm = 0;
    repeat(5) @(posedge clk);
    check(8'd1, error, "cenario4 error estoque zerado");

    $finish;
end

endmodule