module credit_reg (
    input  logic        clk,
    input  logic        rst,
    input  logic        cancel,
    input  logic        credit_load,
    input  vending_pkg::state_t current_state,
    input  logic [1:0]  coin_in,
    output logic [7:0]  credit
);
    import vending_pkg::*;
    logic [7:0] coin_value;

    // Decodificador combinacional do valor da moeda
    always_comb begin
        case (coin_in)
            2'b01:   coin_value = 8'd25;
            2'b10:   coin_value = 8'd50;
            2'b11:   coin_value = 8'd100;
            default: coin_value = 8'd0;
        endcase
    end

    // Acumulador síncrono
    always_ff @(posedge clk) begin
        if (rst || cancel) begin
            credit <= 8'd0;
        end else if (credit_load) begin
            if (current_state == CHANGE) begin
                credit <= 8'd0;
            end else begin
                credit <= credit + coin_value;
            end
        end
    end
endmodule