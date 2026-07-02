// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: subtractor.sv
// Descricao: Logica combinacional — change = credit - price
// =============================================================
import vending_pkg::*;

module subtractor (
    input logic [7:0] credit,
    input logic [7:0] price,
    output logic [7:0] change
);

assign change = credit - price;

endmodule