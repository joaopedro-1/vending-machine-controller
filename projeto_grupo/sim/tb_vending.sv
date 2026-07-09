module tb_vending;
    import vending_pkg::*;

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

    logic        dispense_detected;
    logic        clear_dispense;

    // Instanciação do módulo principal
    vending_top uut (.*);

    // Latch para ajudar a capturar o pulso combinacional de dispense
    always_ff @(posedge clk or posedge rst) begin
        if (rst || clear_dispense) begin
            dispense_detected <= 0;
        end else if (dispense) begin
            dispense_detected <= 1;
        end
    end

    // Geração do clock (Período de 10ns)
    always #5 clk = ~clk;

    // Tarefa: Aplica uma moeda e aguarda 1 ciclo
    task apply_coin(input logic [1:0] value);
        begin
            coin_in = value;
            @(posedge clk) #1 coin_in = 2'b00;
        end
    endtask

    // Tarefa: Reporta PASS/FAIL automaticamente
    task check(input int expected, input int actual, input string label);
        begin
            if (expected === actual) begin
                $display("[PASS] %s | Esperado: %0d, Obtido: %0d", label, expected, actual);
            end else begin
                $display("[FAIL] %s | Esperado: %0d, Obtido: %0d", label, expected, actual);
            end
        end
    endtask

    initial begin
        // Configuração para geração do arquivo de Waveform (útil para o Verdi/DVE)
        $dumpfile("vending.vcd");
        $dumpvars(0, tb_vending);

        // Inicialização de sinais
        clk = 0;
        rst = 0;
        coin_in = 2'b00;
        sel_item = 2'b00;
        confirm = 0;
        cancel = 0;
        clear_dispense = 0;

        // Reset inicial por 2 ciclos de clock
        rst = 1;
        repeat(2) @(posedge clk) begin end
        #1 rst = 0;
        @(posedge clk) begin end

        $display("\n=== CENARIO 1: Compra bem-sucedida com troco (Cafe, R$0.25) ===");
        clear_dispense = 1;
        @(posedge clk) #1 clear_dispense = 0;
        sel_item = 2'b00;  // Seleciona Café (preço: 25)
        apply_coin(2'b11); // Insere R$1.00 (valor: 100)
        confirm = 1;
        @(posedge clk) #1 confirm = 0;
        
        // Espera a FSM processar (CHECK -> DISPENSE -> CHANGE -> IDLE)
        repeat(5) @(posedge clk) begin end
        check(1, dispense_detected, "Dispense deve disparar");
        check(75, change_out, "Troco deve ser 75 centavos");
        check(0, display, "Credito final deve ser 0");

        $display("\n=== CENARIO 2: Credito insuficiente (Snack, R$1.00) ===");
        sel_item = 2'b11;  // Seleciona Snack (preço: 100)
        apply_coin(2'b01); // Insere R$0.25 (valor: 25)
        confirm = 1;
        @(posedge clk) #1 confirm = 0;
        
        repeat(4) @(posedge clk) begin end
        check(1, error, "Sinal de erro deve ser ativado");
        check(3'b101, state_out, "FSM deve travar no estado ERROR");
        
        // Recupera do erro via cancel
        cancel = 1;
        @(posedge clk) #1 cancel = 0;
        repeat(2) @(posedge clk) begin end
        check(3'b000, state_out, "FSM deve voltar para IDLE apos cancel");

        $display("\n=== CENARIO 3: Cancelamento em COLLECT ===");
        apply_coin(2'b11); // Insere R$1.00
        apply_coin(2'b11); // Insere R$1.00 (Total R$2.00)
        cancel = 1;
        @(posedge clk) #1 cancel = 0;
        
        repeat(2) @(posedge clk) begin end
        check(3'b000, state_out, "FSM deve retornar a IDLE imediatamente");
        check(0, display, "Credito deve ser zerado");
        check(200, change_out, "Troco devolvido deve ser R$2.00 (200 centavos)");

        $display("\n=== CENARIO 4: Estoque zerado apos multiplas compras (Cafe) ===");
        // Já comprámos 1 café no cenário 1, restam 4 no estoque.
        // Vamos comprar mais 4 vezes para zerar totalmente o estoque de café.
        for(int i = 0; i < 4; i++) begin
            sel_item = 2'b00;
            apply_coin(2'b01); // Insere R$0.25 exato
            confirm = 1;
            @(posedge clk) #1 confirm = 0;
            repeat(5) @(posedge clk) begin end
        end
        
        $display("Tentando a 6a compra de Cafe (Estoque deve estar em 0)...");
        sel_item = 2'b00;
        apply_coin(2'b01);
        confirm = 1;
        @(posedge clk) #1 confirm = 0;
        
        repeat(4) @(posedge clk) begin end
        check(1, error, "Erro deve disparar por falta de estoque");
        check(3'b101, state_out, "FSM deve ir para o estado ERROR");
        
        // Retorna ao estado normal
        cancel = 1;
        @(posedge clk) #1 cancel = 0;
        
        $display("\n======= FIM DOS TESTES SIMULADOS =======");
        $finish;
    end
endmodule