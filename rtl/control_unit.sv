module control_unit (
    input  logic        clk,
    input  logic        rst,
    input  logic        cancel,
    input  logic [1:0]  coin_in,
    input  logic        confirm,
    input  logic        can_sell,
    
    output logic        credit_load,
    output logic        mem_read,
    output logic        mem_write,
    output logic        dispense,
    output logic        error,
    output logic        change_ena,
    output vending_pkg::state_t state_out
);

    import vending_pkg::*;

    // Variáveis internas para rastrear o estado
    state_t estado_atual, proximo_estado;
    logic read_done;

    // -------------------------------------------------------------
    // BLOCO 1: Memória da FSM (Sequencial)
    // Responsável por atualizar o estado e a flag de leitura na batida do clock.
    // -------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (rst || cancel) begin
            estado_atual <= IDLE;
            read_done    <= 1'b0;
        end else begin
            estado_atual <= proximo_estado;
            if (estado_atual == CHECK) begin
                read_done <= ~read_done;
            end else begin
                read_done <= 1'b0;
            end
        end
    end

    // -------------------------------------------------------------
    // BLOCO 2: Lógica de Decisão (Combinacional)
    // Analisa as entradas e decide o que a máquina fará a seguir.
    // -------------------------------------------------------------
    always_comb begin
        // 1. Valores padrão de segurança (Evita comportamentos inesperados)
        proximo_estado = estado_atual;
        credit_load    = 1'b0;
        mem_read       = 1'b0;
        mem_write      = 1'b0;
        dispense       = 1'b0;
        error          = 1'b0;
        change_ena     = 1'b0;
        
        // Saída contínua de monitoramento
        state_out = estado_atual;

        // 2. Comportamento específico de cada estado
        case (estado_atual)
            
            // Estado 0: Esperando o cliente inserir moeda
            IDLE: begin
                if (coin_in != 2'b00) begin
                    credit_load = 1'b1;
                    proximo_estado = COLLECT;
                end
            end

            COLLECT: begin
                if (coin_in != 2'b00) begin
                    credit_load = 1'b1;
                end
                if (confirm) begin
                    proximo_estado = CHECK;
                end
            end

            // Estado 2: Dispara o sinal de leitura da RAM e aguarda 1 ciclo
            CHECK: begin
                mem_read = 1'b1;
                if (!read_done) begin
                    proximo_estado = CHECK;
                end else begin
                    if (can_sell) begin
                        proximo_estado = DISPENSE; // Tem crédito e estoque!
                    end else begin
                        proximo_estado = ERROR;    // Falta crédito ou estoque vazio
                    end
                end
            end

            // Estado 4: Libera o produto e debita 1 do estoque na RAM
            DISPENSE: begin
                dispense  = 1'b1;
                mem_write = 1'b1;
                proximo_estado = CHANGE;
            end

            // Estado 5: Sinaliza a devolução do troco e zera o crédito
            CHANGE: begin
                credit_load = 1'b1; // Reaproveitamos para zerar o registrador
                change_ena  = 1'b1; // Libera o troco para a saída
                proximo_estado = IDLE;
            end

            // Estado 6: Trava a máquina se algo der errado (ex: saldo insuficiente)
            ERROR: begin
                error = 1'b1;
                // O retorno para IDLE é tratado pelo 'cancel' no bloco Sequencial
            end
            
            // Proteção contra falhas no circuito
            default: proximo_estado = IDLE;
            
        endcase
    end

endmodule