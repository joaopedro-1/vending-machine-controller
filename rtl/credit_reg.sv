// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: credit_reg.sv
// Descricao: Registrador sincrono de credito acumulado
// =============================================================
import vending_pkg::*;

module credit_reg (
    input logic clk,
    input logic rst,
    input logic [1:0] coin_in,
    input logic credit_load,
    input logic cancel,
    input logic credit_clr,
    output logic [7:0] credit
);

logic [7:0] coin_value;

always_comb begin
    case (coin_in)
        2'b00: coin_value = 8'd0;
        2'b01: coin_value = COIN_25;
        2'b10: coin_value = COIN_50;
        2'b11: coin_value = COIN_100;
    endcase
end

always_ff @(posedge clk) begin
    if (rst || cancel) begin
        credit <= 8'd0;
    end else if (credit_load) begin
        credit <= credit + coin_value;
    end
end

endmodule