// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: comparator.sv
// Descricao: Logica combinacional — can_sell = (credit >= price) && (stock > 0)
// =============================================================
import vending_pkg::*;

module comparator (
    input logic [7:0] credit,
    input logic [7:0] price,
    input logic [7:0] stock,
    output logic can_sell
);

assign can_sell = (credit >= price) && (stock > 8'b0);

endmodule