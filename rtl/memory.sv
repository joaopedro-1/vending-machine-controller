// =============================================================
// Módulo: memory
// Descrição: Memória síncrona 4x16 bits.
// Armazena {Preço, Estoque}. O uso de parâmetros do pacote
// torna este módulo fácil de atualizar sem precisar de calculadora.
// =============================================================
module memory (
    input  logic        clk,
    input  logic        mem_read,
    input  logic        mem_write,
    input  logic [1:0]  sel_item,
    output logic [7:0]  price,
    output logic [7:0]  stock
);

    import vending_pkg::*;

    // Memória: 4 posições de 16 bits
    logic [15:0] mem [0:3];

    // Inicialização usando os parâmetros do pacote (Single Source of Truth)
    initial begin
        mem[0] = {PRICE_CAFE,  8'd5}; 
        mem[1] = {PRICE_AGUA,  8'd5};
        mem[2] = {PRICE_SUCO,  8'd3};
        mem[3] = {PRICE_SNACK, 8'd2};
    end

    // Leitura e Escrita Síncronas
    always @(posedge clk) begin
        if (mem_read) begin
            price <= mem[sel_item][15:8];
            stock <= mem[sel_item][7:0];
        end
        
        if (mem_write) begin
            // Decrementa estoque com segurança
            mem[sel_item][7:0] <= mem[sel_item][7:0] - 8'd1;
        end
    end

endmodule