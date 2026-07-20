/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP2
// Date      : Fri Jul 10 10:08:39 2026
/////////////////////////////////////////////////////////////


module credit_reg ( clk, rst, cancel, credit_load, current_state, coin_in, 
        credit );
  input [2:0] current_state;
  input [1:0] coin_in;
  output [7:0] credit;
  input clk, rst, cancel, credit_load;
  wire   n7, n8, n9, n10, n11, n12, n13, n14, \intadd_0/B[1] , \intadd_0/B[0] ,
         \intadd_0/CI , \intadd_0/SUM[2] , \intadd_0/SUM[1] ,
         \intadd_0/SUM[0] , \intadd_0/n3 , \intadd_0/n2 , \intadd_0/n1 , n1,
         n2, n3, n4, n5, n6, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32;

  DFFX1_RVT \credit_reg[7]  ( .D(n7), .CLK(clk), .Q(credit[7]) );
  DFFX1_RVT \credit_reg[6]  ( .D(n8), .CLK(clk), .Q(credit[6]), .QN(n32) );
  DFFX1_RVT \credit_reg[5]  ( .D(n9), .CLK(clk), .Q(credit[5]) );
  DFFX1_RVT \credit_reg[4]  ( .D(n10), .CLK(clk), .Q(credit[4]) );
  DFFX1_RVT \credit_reg[3]  ( .D(n11), .CLK(clk), .Q(credit[3]) );
  DFFX1_RVT \credit_reg[2]  ( .D(n12), .CLK(clk), .Q(credit[2]) );
  DFFX1_RVT \credit_reg[1]  ( .D(n13), .CLK(clk), .Q(credit[1]) );
  DFFX1_RVT \credit_reg[0]  ( .D(n14), .CLK(clk), .Q(credit[0]) );
  FADDX1_RVT \intadd_0/U4  ( .A(\intadd_0/B[0] ), .B(credit[3]), .CI(
        \intadd_0/CI ), .CO(\intadd_0/n3 ), .S(\intadd_0/SUM[0] ) );
  FADDX1_RVT \intadd_0/U3  ( .A(\intadd_0/B[1] ), .B(credit[4]), .CI(
        \intadd_0/n3 ), .CO(\intadd_0/n2 ), .S(\intadd_0/SUM[1] ) );
  FADDX1_RVT \intadd_0/U2  ( .A(coin_in[1]), .B(credit[5]), .CI(\intadd_0/n2 ), 
        .CO(\intadd_0/n1 ), .S(\intadd_0/SUM[2] ) );
  INVX0_RVT U3 ( .A(coin_in[0]), .Y(n21) );
  OR2X1_RVT U4 ( .A1(n21), .A2(coin_in[1]), .Y(n23) );
  INVX0_RVT U5 ( .A(n23), .Y(\intadd_0/B[0] ) );
  NAND2X0_RVT U6 ( .A1(coin_in[1]), .A2(coin_in[0]), .Y(n24) );
  AO22X1_RVT U7 ( .A1(coin_in[1]), .A2(n21), .A3(\intadd_0/B[0] ), .A4(
        credit[0]), .Y(n16) );
  NAND2X0_RVT U8 ( .A1(n16), .A2(credit[1]), .Y(n15) );
  NAND2X0_RVT U9 ( .A1(n24), .A2(n15), .Y(n19) );
  NAND2X0_RVT U10 ( .A1(credit[2]), .A2(n19), .Y(n18) );
  INVX0_RVT U11 ( .A(n18), .Y(\intadd_0/CI ) );
  NOR3X0_RVT U12 ( .A1(rst), .A2(cancel), .A3(credit_load), .Y(n31) );
  HADDX1_RVT U13 ( .A0(credit[0]), .B0(\intadd_0/B[0] ), .SO(n6) );
  NOR2X0_RVT U14 ( .A1(rst), .A2(cancel), .Y(n1) );
  AND2X1_RVT U15 ( .A1(credit_load), .A2(n1), .Y(n5) );
  INVX0_RVT U16 ( .A(current_state[1]), .Y(n2) );
  NAND2X0_RVT U17 ( .A1(current_state[2]), .A2(n2), .Y(n3) );
  OR2X1_RVT U18 ( .A1(n3), .A2(current_state[0]), .Y(n4) );
  AND2X1_RVT U19 ( .A1(n5), .A2(n4), .Y(n29) );
  AO22X1_RVT U20 ( .A1(credit[0]), .A2(n31), .A3(n6), .A4(n29), .Y(n14) );
  OA21X1_RVT U21 ( .A1(n16), .A2(credit[1]), .A3(n15), .Y(n17) );
  AO22X1_RVT U22 ( .A1(n29), .A2(n17), .A3(credit[1]), .A4(n31), .Y(n13) );
  OA21X1_RVT U23 ( .A1(credit[2]), .A2(n19), .A3(n18), .Y(n20) );
  AO22X1_RVT U24 ( .A1(n29), .A2(n20), .A3(credit[2]), .A4(n31), .Y(n12) );
  AO22X1_RVT U25 ( .A1(n29), .A2(\intadd_0/SUM[0] ), .A3(n31), .A4(credit[3]), 
        .Y(n11) );
  NAND2X0_RVT U26 ( .A1(coin_in[1]), .A2(n21), .Y(n22) );
  NAND2X0_RVT U27 ( .A1(n23), .A2(n22), .Y(\intadd_0/B[1] ) );
  AO22X1_RVT U28 ( .A1(n29), .A2(\intadd_0/SUM[1] ), .A3(n31), .A4(credit[4]), 
        .Y(n10) );
  AO22X1_RVT U29 ( .A1(n29), .A2(\intadd_0/SUM[2] ), .A3(n31), .A4(credit[5]), 
        .Y(n9) );
  INVX0_RVT U30 ( .A(n24), .Y(n27) );
  AO22X1_RVT U31 ( .A1(n27), .A2(n32), .A3(n24), .A4(credit[6]), .Y(n25) );
  HADDX1_RVT U32 ( .A0(\intadd_0/n1 ), .B0(n25), .SO(n26) );
  AO22X1_RVT U33 ( .A1(n29), .A2(n26), .A3(n31), .A4(credit[6]), .Y(n8) );
  AO222X1_RVT U34 ( .A1(n27), .A2(credit[6]), .A3(n27), .A4(\intadd_0/n1 ), 
        .A5(credit[6]), .A6(\intadd_0/n1 ), .Y(n28) );
  HADDX1_RVT U35 ( .A0(credit[7]), .B0(n28), .SO(n30) );
  AO22X1_RVT U36 ( .A1(credit[7]), .A2(n31), .A3(n30), .A4(n29), .Y(n7) );
endmodule


module memory ( clk, mem_read, mem_write, sel_item, price, stock );
  input [1:0] sel_item;
  output [7:0] price;
  output [7:0] stock;
  input clk, mem_read, mem_write;
  wire   \mem[0][7] , \mem[0][6] , \mem[0][5] , \mem[0][4] , \mem[0][3] ,
         \mem[0][2] , \mem[0][1] , \mem[0][0] , \mem[1][7] , \mem[1][6] ,
         \mem[1][5] , \mem[1][4] , \mem[1][3] , \mem[1][2] , \mem[1][1] ,
         \mem[1][0] , \mem[2][7] , \mem[2][6] , \mem[2][5] , \mem[2][4] ,
         \mem[2][3] , \mem[2][2] , \mem[2][1] , \mem[2][0] , \mem[3][7] ,
         \mem[3][6] , \mem[3][5] , \mem[3][4] , \mem[3][3] , \mem[3][2] ,
         \mem[3][1] , \mem[3][0] , n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81;

  DFFX1_RVT \mem_reg[0][7]  ( .D(n25), .CLK(clk), .Q(\mem[0][7] ) );
  DFFX1_RVT \mem_reg[0][6]  ( .D(n29), .CLK(clk), .Q(\mem[0][6] ) );
  DFFX1_RVT \mem_reg[0][5]  ( .D(n33), .CLK(clk), .Q(\mem[0][5] ) );
  DFFX1_RVT \mem_reg[0][4]  ( .D(n37), .CLK(clk), .Q(\mem[0][4] ) );
  DFFX1_RVT \mem_reg[0][3]  ( .D(n41), .CLK(clk), .Q(\mem[0][3] ) );
  DFFX1_RVT \mem_reg[0][2]  ( .D(n45), .CLK(clk), .Q(\mem[0][2] ) );
  DFFX1_RVT \mem_reg[0][1]  ( .D(n49), .CLK(clk), .Q(\mem[0][1] ) );
  DFFX1_RVT \mem_reg[0][0]  ( .D(n53), .CLK(clk), .Q(\mem[0][0] ) );
  DFFX1_RVT \mem_reg[1][7]  ( .D(n26), .CLK(clk), .Q(\mem[1][7] ) );
  DFFX1_RVT \mem_reg[1][6]  ( .D(n30), .CLK(clk), .Q(\mem[1][6] ) );
  DFFX1_RVT \mem_reg[1][5]  ( .D(n34), .CLK(clk), .Q(\mem[1][5] ) );
  DFFX1_RVT \mem_reg[1][4]  ( .D(n38), .CLK(clk), .Q(\mem[1][4] ) );
  DFFX1_RVT \mem_reg[1][3]  ( .D(n42), .CLK(clk), .Q(\mem[1][3] ) );
  DFFX1_RVT \mem_reg[1][2]  ( .D(n46), .CLK(clk), .Q(\mem[1][2] ) );
  DFFX1_RVT \mem_reg[1][1]  ( .D(n50), .CLK(clk), .Q(\mem[1][1] ) );
  DFFX1_RVT \mem_reg[1][0]  ( .D(n54), .CLK(clk), .Q(\mem[1][0] ) );
  DFFX1_RVT \mem_reg[2][7]  ( .D(n27), .CLK(clk), .Q(\mem[2][7] ) );
  DFFX1_RVT \mem_reg[2][6]  ( .D(n31), .CLK(clk), .Q(\mem[2][6] ) );
  DFFX1_RVT \mem_reg[2][5]  ( .D(n35), .CLK(clk), .Q(\mem[2][5] ) );
  DFFX1_RVT \mem_reg[2][4]  ( .D(n39), .CLK(clk), .Q(\mem[2][4] ) );
  DFFX1_RVT \mem_reg[2][3]  ( .D(n43), .CLK(clk), .Q(\mem[2][3] ) );
  DFFX1_RVT \mem_reg[2][2]  ( .D(n47), .CLK(clk), .Q(\mem[2][2] ) );
  DFFX1_RVT \mem_reg[2][1]  ( .D(n51), .CLK(clk), .Q(\mem[2][1] ) );
  DFFX1_RVT \mem_reg[2][0]  ( .D(n55), .CLK(clk), .Q(\mem[2][0] ) );
  DFFX1_RVT \mem_reg[3][7]  ( .D(n28), .CLK(clk), .Q(\mem[3][7] ) );
  DFFX1_RVT \mem_reg[3][6]  ( .D(n32), .CLK(clk), .Q(\mem[3][6] ) );
  DFFX1_RVT \mem_reg[3][5]  ( .D(n36), .CLK(clk), .Q(\mem[3][5] ) );
  DFFX1_RVT \mem_reg[3][4]  ( .D(n40), .CLK(clk), .Q(\mem[3][4] ) );
  DFFX1_RVT \mem_reg[3][3]  ( .D(n44), .CLK(clk), .Q(\mem[3][3] ) );
  DFFX1_RVT \mem_reg[3][2]  ( .D(n48), .CLK(clk), .Q(\mem[3][2] ) );
  DFFX1_RVT \mem_reg[3][1]  ( .D(n52), .CLK(clk), .Q(\mem[3][1] ) );
  DFFX1_RVT \mem_reg[3][0]  ( .D(n56), .CLK(clk), .Q(\mem[3][0] ) );
  DFFX1_RVT \stock_reg[7]  ( .D(n24), .CLK(clk), .Q(stock[7]) );
  DFFX1_RVT \stock_reg[6]  ( .D(n23), .CLK(clk), .Q(stock[6]) );
  DFFX1_RVT \stock_reg[5]  ( .D(n22), .CLK(clk), .Q(stock[5]) );
  DFFX1_RVT \stock_reg[4]  ( .D(n21), .CLK(clk), .Q(stock[4]) );
  DFFX1_RVT \stock_reg[3]  ( .D(n20), .CLK(clk), .Q(stock[3]) );
  DFFX1_RVT \stock_reg[2]  ( .D(n19), .CLK(clk), .Q(stock[2]) );
  DFFX1_RVT \stock_reg[1]  ( .D(n18), .CLK(clk), .Q(stock[1]) );
  DFFX1_RVT \stock_reg[0]  ( .D(n17), .CLK(clk), .Q(stock[0]) );
  AND2X1_RVT U3 ( .A1(sel_item[0]), .A2(sel_item[1]), .Y(n1) );
  NAND2X0_RVT U4 ( .A1(n1), .A2(mem_write), .Y(n64) );
  INVX0_RVT U5 ( .A(n64), .Y(n65) );
  INVX2_RVT U6 ( .A(sel_item[0]), .Y(n62) );
  INVX0_RVT U7 ( .A(sel_item[1]), .Y(n4) );
  MUX41X1_RVT U8 ( .A1(\mem[3][0] ), .A3(\mem[2][0] ), .A2(\mem[1][0] ), .A4(
        \mem[0][0] ), .S0(n62), .S1(n4), .Y(n81) );
  INVX0_RVT U9 ( .A(n81), .Y(n5) );
  AO22X1_RVT U10 ( .A1(n65), .A2(n5), .A3(n64), .A4(\mem[3][0] ), .Y(n56) );
  AND2X1_RVT U11 ( .A1(sel_item[1]), .A2(n62), .Y(n2) );
  NAND2X0_RVT U12 ( .A1(mem_write), .A2(n2), .Y(n66) );
  INVX0_RVT U13 ( .A(n66), .Y(n67) );
  AO22X1_RVT U14 ( .A1(n67), .A2(n5), .A3(n66), .A4(\mem[2][0] ), .Y(n55) );
  AND2X1_RVT U15 ( .A1(sel_item[0]), .A2(n4), .Y(n3) );
  NAND2X0_RVT U16 ( .A1(mem_write), .A2(n3), .Y(n68) );
  INVX0_RVT U17 ( .A(n68), .Y(n69) );
  AO22X1_RVT U18 ( .A1(n69), .A2(n5), .A3(n68), .A4(\mem[1][0] ), .Y(n54) );
  NAND3X0_RVT U19 ( .A1(mem_write), .A2(n62), .A3(n4), .Y(n70) );
  INVX0_RVT U20 ( .A(n70), .Y(n72) );
  AO22X1_RVT U21 ( .A1(n72), .A2(n5), .A3(n70), .A4(\mem[0][0] ), .Y(n53) );
  MUX41X1_RVT U22 ( .A1(\mem[1][1] ), .A3(\mem[0][1] ), .A2(\mem[3][1] ), .A4(
        \mem[2][1] ), .S0(n62), .S1(sel_item[1]), .Y(n79) );
  OR2X1_RVT U23 ( .A1(n81), .A2(n79), .Y(n9) );
  INVX0_RVT U24 ( .A(n9), .Y(n6) );
  AO21X1_RVT U25 ( .A1(n81), .A2(n79), .A3(n6), .Y(n7) );
  AO22X1_RVT U26 ( .A1(n65), .A2(n7), .A3(n64), .A4(\mem[3][1] ), .Y(n52) );
  AO22X1_RVT U27 ( .A1(n67), .A2(n7), .A3(n66), .A4(\mem[2][1] ), .Y(n51) );
  AO22X1_RVT U28 ( .A1(n69), .A2(n7), .A3(n68), .A4(\mem[1][1] ), .Y(n50) );
  AO22X1_RVT U29 ( .A1(n72), .A2(n7), .A3(n70), .A4(\mem[0][1] ), .Y(n49) );
  MUX41X1_RVT U30 ( .A1(\mem[1][2] ), .A3(\mem[0][2] ), .A2(\mem[3][2] ), .A4(
        \mem[2][2] ), .S0(n62), .S1(sel_item[1]), .Y(n78) );
  OR2X1_RVT U31 ( .A1(n78), .A2(n9), .Y(n12) );
  INVX0_RVT U32 ( .A(n12), .Y(n8) );
  AO21X1_RVT U33 ( .A1(n78), .A2(n9), .A3(n8), .Y(n10) );
  AO22X1_RVT U34 ( .A1(n65), .A2(n10), .A3(n64), .A4(\mem[3][2] ), .Y(n48) );
  AO22X1_RVT U35 ( .A1(n67), .A2(n10), .A3(n66), .A4(\mem[2][2] ), .Y(n47) );
  AO22X1_RVT U36 ( .A1(n69), .A2(n10), .A3(n68), .A4(\mem[1][2] ), .Y(n46) );
  AO22X1_RVT U37 ( .A1(n72), .A2(n10), .A3(n70), .A4(\mem[0][2] ), .Y(n45) );
  MUX41X1_RVT U38 ( .A1(\mem[1][3] ), .A3(\mem[0][3] ), .A2(\mem[3][3] ), .A4(
        \mem[2][3] ), .S0(n62), .S1(sel_item[1]), .Y(n77) );
  OR2X1_RVT U39 ( .A1(n77), .A2(n12), .Y(n15) );
  INVX0_RVT U40 ( .A(n15), .Y(n11) );
  AO21X1_RVT U41 ( .A1(n77), .A2(n12), .A3(n11), .Y(n13) );
  AO22X1_RVT U42 ( .A1(n65), .A2(n13), .A3(n64), .A4(\mem[3][3] ), .Y(n44) );
  AO22X1_RVT U43 ( .A1(n67), .A2(n13), .A3(n66), .A4(\mem[2][3] ), .Y(n43) );
  AO22X1_RVT U44 ( .A1(n69), .A2(n13), .A3(n68), .A4(\mem[1][3] ), .Y(n42) );
  AO22X1_RVT U45 ( .A1(n72), .A2(n13), .A3(n70), .A4(\mem[0][3] ), .Y(n41) );
  MUX41X1_RVT U46 ( .A1(\mem[1][4] ), .A3(\mem[0][4] ), .A2(\mem[3][4] ), .A4(
        \mem[2][4] ), .S0(n62), .S1(sel_item[1]), .Y(n76) );
  OR2X1_RVT U47 ( .A1(n76), .A2(n15), .Y(n58) );
  INVX0_RVT U48 ( .A(n58), .Y(n14) );
  AO21X1_RVT U49 ( .A1(n76), .A2(n15), .A3(n14), .Y(n16) );
  AO22X1_RVT U50 ( .A1(n65), .A2(n16), .A3(n64), .A4(\mem[3][4] ), .Y(n40) );
  AO22X1_RVT U51 ( .A1(n67), .A2(n16), .A3(n66), .A4(\mem[2][4] ), .Y(n39) );
  AO22X1_RVT U52 ( .A1(n69), .A2(n16), .A3(n68), .A4(\mem[1][4] ), .Y(n38) );
  AO22X1_RVT U53 ( .A1(n72), .A2(n16), .A3(n70), .A4(\mem[0][4] ), .Y(n37) );
  MUX41X1_RVT U54 ( .A1(\mem[1][5] ), .A3(\mem[0][5] ), .A2(\mem[3][5] ), .A4(
        \mem[2][5] ), .S0(n62), .S1(sel_item[1]), .Y(n75) );
  OR2X1_RVT U55 ( .A1(n75), .A2(n58), .Y(n60) );
  INVX0_RVT U56 ( .A(n60), .Y(n57) );
  AO21X1_RVT U57 ( .A1(n75), .A2(n58), .A3(n57), .Y(n59) );
  AO22X1_RVT U58 ( .A1(n65), .A2(n59), .A3(n64), .A4(\mem[3][5] ), .Y(n36) );
  AO22X1_RVT U59 ( .A1(n67), .A2(n59), .A3(n66), .A4(\mem[2][5] ), .Y(n35) );
  AO22X1_RVT U60 ( .A1(n69), .A2(n59), .A3(n68), .A4(\mem[1][5] ), .Y(n34) );
  AO22X1_RVT U61 ( .A1(n72), .A2(n59), .A3(n70), .A4(\mem[0][5] ), .Y(n33) );
  MUX41X1_RVT U62 ( .A1(\mem[1][6] ), .A3(\mem[0][6] ), .A2(\mem[3][6] ), .A4(
        \mem[2][6] ), .S0(n62), .S1(sel_item[1]), .Y(n74) );
  NOR2X0_RVT U63 ( .A1(n74), .A2(n60), .Y(n63) );
  AO21X1_RVT U64 ( .A1(n74), .A2(n60), .A3(n63), .Y(n61) );
  AO22X1_RVT U65 ( .A1(n65), .A2(n61), .A3(n64), .A4(\mem[3][6] ), .Y(n32) );
  AO22X1_RVT U66 ( .A1(n67), .A2(n61), .A3(n66), .A4(\mem[2][6] ), .Y(n31) );
  AO22X1_RVT U67 ( .A1(n69), .A2(n61), .A3(n68), .A4(\mem[1][6] ), .Y(n30) );
  AO22X1_RVT U68 ( .A1(n72), .A2(n61), .A3(n70), .A4(\mem[0][6] ), .Y(n29) );
  MUX41X1_RVT U69 ( .A1(\mem[1][7] ), .A3(\mem[0][7] ), .A2(\mem[3][7] ), .A4(
        \mem[2][7] ), .S0(n62), .S1(sel_item[1]), .Y(n73) );
  HADDX1_RVT U70 ( .A0(n63), .B0(n73), .SO(n71) );
  AO22X1_RVT U71 ( .A1(n65), .A2(n71), .A3(n64), .A4(\mem[3][7] ), .Y(n28) );
  AO22X1_RVT U72 ( .A1(n67), .A2(n71), .A3(n66), .A4(\mem[2][7] ), .Y(n27) );
  AO22X1_RVT U73 ( .A1(n69), .A2(n71), .A3(n68), .A4(\mem[1][7] ), .Y(n26) );
  AO22X1_RVT U74 ( .A1(n72), .A2(n71), .A3(n70), .A4(\mem[0][7] ), .Y(n25) );
  INVX0_RVT U75 ( .A(mem_read), .Y(n80) );
  AO22X1_RVT U76 ( .A1(mem_read), .A2(n73), .A3(n80), .A4(stock[7]), .Y(n24)
         );
  AO22X1_RVT U77 ( .A1(mem_read), .A2(n74), .A3(n80), .A4(stock[6]), .Y(n23)
         );
  AO22X1_RVT U78 ( .A1(mem_read), .A2(n75), .A3(n80), .A4(stock[5]), .Y(n22)
         );
  AO22X1_RVT U79 ( .A1(mem_read), .A2(n76), .A3(n80), .A4(stock[4]), .Y(n21)
         );
  AO22X1_RVT U80 ( .A1(mem_read), .A2(n77), .A3(n80), .A4(stock[3]), .Y(n20)
         );
  AO22X1_RVT U81 ( .A1(mem_read), .A2(n78), .A3(n80), .A4(stock[2]), .Y(n19)
         );
  AO22X1_RVT U82 ( .A1(mem_read), .A2(n79), .A3(n80), .A4(stock[1]), .Y(n18)
         );
  AO22X1_RVT U83 ( .A1(mem_read), .A2(n81), .A3(n80), .A4(stock[0]), .Y(n17)
         );
endmodule


module comparator ( credit, price, stock, can_sell );
  input [7:0] credit;
  input [7:0] price;
  input [7:0] stock;
  output can_sell;
  wire   n1, n2;

  NOR4X1_RVT U2 ( .A1(stock[7]), .A2(stock[6]), .A3(stock[5]), .A4(stock[4]), 
        .Y(n2) );
  NOR4X1_RVT U3 ( .A1(stock[3]), .A2(stock[2]), .A3(stock[1]), .A4(stock[0]), 
        .Y(n1) );
  NAND2X0_RVT U4 ( .A1(n2), .A2(n1), .Y(can_sell) );
endmodule


module control_unit ( clk, rst, cancel, coin_in, confirm, can_sell, 
        credit_load, mem_read, mem_write, dispense, error, change_ena, 
        state_out );
  input [1:0] coin_in;
  output [2:0] state_out;
  input clk, rst, cancel, confirm, can_sell;
  output credit_load, mem_read, mem_write, dispense, error, change_ena;
  wire   mem_write, read_done, n20, n21, n22, n1, n2, n3, n4, n5, n6, n8, n9,
         n10, n11, n12, n13, n14, n15;
  assign dispense = mem_write;

  DFFX1_RVT \estado_atual_reg[0]  ( .D(n22), .CLK(clk), .Q(state_out[0]), .QN(
        n13) );
  DFFX1_RVT \estado_atual_reg[2]  ( .D(n20), .CLK(clk), .Q(state_out[2]), .QN(
        n11) );
  DFFX1_RVT \estado_atual_reg[1]  ( .D(n21), .CLK(clk), .Q(state_out[1]), .QN(
        n12) );
  DFFX1_RVT read_done_reg ( .D(n15), .CLK(clk), .Q(n14), .QN(read_done) );
  AND3X1_RVT U3 ( .A1(state_out[1]), .A2(n13), .A3(n11), .Y(mem_read) );
  NOR2X0_RVT U4 ( .A1(rst), .A2(cancel), .Y(n10) );
  NAND3X0_RVT U5 ( .A1(n10), .A2(mem_read), .A3(n14), .Y(n15) );
  NAND2X0_RVT U6 ( .A1(state_out[0]), .A2(confirm), .Y(n6) );
  INVX0_RVT U7 ( .A(n6), .Y(n1) );
  NAND4X0_RVT U8 ( .A1(n10), .A2(n1), .A3(n12), .A4(n11), .Y(n3) );
  NAND3X0_RVT U9 ( .A1(n10), .A2(mem_read), .A3(can_sell), .Y(n2) );
  NAND3X0_RVT U10 ( .A1(n15), .A2(n3), .A3(n2), .Y(n21) );
  AND3X1_RVT U11 ( .A1(state_out[2]), .A2(n13), .A3(n12), .Y(change_ena) );
  AND2X1_RVT U12 ( .A1(n11), .A2(n12), .Y(n4) );
  AO221X1_RVT U13 ( .A1(n4), .A2(coin_in[1]), .A3(n4), .A4(coin_in[0]), .A5(
        change_ena), .Y(credit_load) );
  AND3X1_RVT U14 ( .A1(state_out[2]), .A2(state_out[0]), .A3(n12), .Y(error)
         );
  AO221X1_RVT U16 ( .A1(n11), .A2(coin_in[1]), .A3(n11), .A4(coin_in[0]), .A5(
        state_out[0]), .Y(n5) );
  OA221X1_RVT U17 ( .A1(1'b0), .A2(n12), .A3(n6), .A4(error), .A5(n5), .Y(n8)
         );
  OA221X1_RVT U18 ( .A1(n8), .A2(read_done), .A3(n8), .A4(mem_read), .A5(n10), 
        .Y(n22) );
  AND3X1_RVT U19 ( .A1(state_out[0]), .A2(state_out[1]), .A3(n11), .Y(
        mem_write) );
  NOR4X1_RVT U20 ( .A1(state_out[2]), .A2(can_sell), .A3(n12), .A4(n14), .Y(n9) );
  AO222X1_RVT U21 ( .A1(n10), .A2(mem_write), .A3(n10), .A4(error), .A5(n10), 
        .A6(n9), .Y(n20) );
endmodule


module vending_top ( clk, rst, coin_in, sel_item, confirm, cancel, dispense, 
        change_out, error, display, state_out );
  input [1:0] coin_in;
  input [1:0] sel_item;
  output [7:0] change_out;
  output [7:0] display;
  output [2:0] state_out;
  input clk, rst, confirm, cancel;
  output dispense, error;
  wire   change_ena, credit_load, mem_read, mem_write, can_sell, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, net880, net881, net882, net883,
         net884, net885, net886, net887;
  wire   [7:0] stock;

  credit_reg u_credit_reg ( .clk(clk), .rst(rst), .cancel(cancel), 
        .credit_load(credit_load), .current_state(state_out), .coin_in(coin_in), .credit(display) );
  memory u_memory ( .clk(clk), .mem_read(mem_read), .mem_write(mem_write), 
        .sel_item(sel_item), .stock(stock) );
  comparator u_comparator ( .credit(display), .price({net880, net881, net882, 
        net883, net884, net885, net886, net887}), .stock(stock), .can_sell(
        can_sell) );
  control_unit u_control_unit ( .clk(clk), .rst(rst), .cancel(cancel), 
        .coin_in(coin_in), .confirm(confirm), .can_sell(can_sell), 
        .credit_load(credit_load), .mem_read(mem_read), .mem_write(mem_write), 
        .dispense(dispense), .error(error), .change_ena(change_ena), 
        .state_out(state_out) );
  DFFX1_RVT \change_out_reg[7]  ( .D(n13), .CLK(clk), .Q(change_out[7]) );
  DFFX1_RVT \change_out_reg[6]  ( .D(n12), .CLK(clk), .Q(change_out[6]) );
  DFFX1_RVT \change_out_reg[5]  ( .D(n11), .CLK(clk), .Q(change_out[5]) );
  DFFX1_RVT \change_out_reg[4]  ( .D(n10), .CLK(clk), .Q(change_out[4]) );
  DFFX1_RVT \change_out_reg[3]  ( .D(n9), .CLK(clk), .Q(change_out[3]) );
  DFFX1_RVT \change_out_reg[2]  ( .D(n8), .CLK(clk), .Q(change_out[2]) );
  DFFX1_RVT \change_out_reg[1]  ( .D(n7), .CLK(clk), .Q(change_out[1]) );
  DFFX1_RVT \change_out_reg[0]  ( .D(n6), .CLK(clk), .Q(change_out[0]) );
  INVX0_RVT U16 ( .A(rst), .Y(n14) );
  OA21X1_RVT U17 ( .A1(cancel), .A2(change_ena), .A3(n14), .Y(n16) );
  NOR3X0_RVT U18 ( .A1(rst), .A2(cancel), .A3(change_ena), .Y(n15) );
  AO22X1_RVT U19 ( .A1(n16), .A2(display[7]), .A3(n15), .A4(change_out[7]), 
        .Y(n13) );
  AO22X1_RVT U20 ( .A1(n16), .A2(display[6]), .A3(n15), .A4(change_out[6]), 
        .Y(n12) );
  AO22X1_RVT U21 ( .A1(n16), .A2(display[5]), .A3(n15), .A4(change_out[5]), 
        .Y(n11) );
  AO22X1_RVT U22 ( .A1(n16), .A2(display[4]), .A3(n15), .A4(change_out[4]), 
        .Y(n10) );
  AO22X1_RVT U23 ( .A1(n16), .A2(display[3]), .A3(n15), .A4(change_out[3]), 
        .Y(n9) );
  AO22X1_RVT U24 ( .A1(n16), .A2(display[2]), .A3(n15), .A4(change_out[2]), 
        .Y(n8) );
  AO22X1_RVT U25 ( .A1(n16), .A2(display[1]), .A3(n15), .A4(change_out[1]), 
        .Y(n7) );
  AO22X1_RVT U26 ( .A1(n16), .A2(display[0]), .A3(n15), .A4(change_out[0]), 
        .Y(n6) );
endmodule

