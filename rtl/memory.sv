// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: memory.sv
// Descricao: Memoria sincrona 4x16 bits com preco e estoque
// =============================================================
import vending_pkg::*;

module memory (
    input logic clk,
    input logic [1:0] sel_item,
    input logic mem_read,
    input logic mem_write,
    output logic [7:0] price,
    output logic [7:0] stock
);

reg [15:0] mem [0:3];

// Inicializacao: bits[15:8] = preco, bits[7:0] = estoque
// mem[0] = cafe  (preco=25, estoque=5)
// mem[1] = agua  (preco=50, estoque=5)
// mem[2] = suco  (preco=75, estoque=3)
// mem[3] = snack (preco=100, estoque=2)
initial begin
    mem[0] = 16'h1905;
    mem[1] = 16'h3205;
    mem[2] = 16'h4B03;
    mem[3] = 16'h6402;
end

always @(posedge clk) begin
    if (mem_read) begin
        price <= mem[sel_item][15:8];
        stock <= mem[sel_item][7:0];
    end
    if (mem_write) begin
        mem[sel_item][7:0] <= mem[sel_item][7:0] - 1;
    end
end

endmodule