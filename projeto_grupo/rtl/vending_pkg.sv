package vending_pkg;

    typedef enum logic [2:0] {
        IDLE       = 3'b000, // 0: Aguardando cliente
        COLLECT    = 3'b001, // 1: Recebendo moedas
        CHECK      = 3'b010, // 2: Solicitando leitura da RAM
        DISPENSE   = 3'b011, // 3: Entregando o produto
        CHANGE     = 3'b100, // 4: Devolvendo o troco
        ERROR      = 3'b101  // 5: Erro (Estoque vazio ou saldo insuficiente)
    } state_t;

    parameter logic [7:0] COIN_25  = 8'd25;
    parameter logic [7:0] COIN_50  = 8'd50;
    parameter logic [7:0] COIN_100 = 8'd100;

    parameter logic [7:0] PRICE_CAFE  = 8'd25;
    parameter logic [7:0] PRICE_AGUA  = 8'd50;
    parameter logic [7:0] PRICE_SUCO  = 8'd75;
    parameter logic [7:0] PRICE_SNACK = 8'd100;

endpackage