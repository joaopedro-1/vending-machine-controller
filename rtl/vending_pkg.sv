// =============================================================
// Projeto: Vending Machine Controller
// Arquivo: vending_pkg.sv
// Descricao: Package com tipos, encodings de estados e parametros
// =============================================================


package vending_pkg;

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        COLLECT = 3'b001,
        CHECK = 3'b010,
        DISPENSE = 3'b011,
        CHANGE = 3'b100,
        ERROR = 3'b101,
        CHECK_WAIT = 3'b110
    } state_t;

    //parâmetros de coin_value
    parameter logic [7:0] COIN_25 = 8'd25;
    parameter logic [7:0] COIN_50 = 8'd50;
    parameter logic [7:0] COIN_100 = 8'd100;

    // parâmetros de preço dos itens

    parameter logic [7:0] PRICE_CAFE = 8'd25;
    parameter logic [7:0] PRICE_AGUA = 8'd50;
    parameter logic [7:0] PRICE_SUCO = 8'd75;
    parameter logic [7:0] PRICE_SNACK = 8'd100;

endpackage
