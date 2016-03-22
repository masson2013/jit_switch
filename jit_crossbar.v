`timescale 1ns / 1ps

module jit_crossbar#
(
  parameter integer NUM_ACCs = 2
)
(
  output  wire             sCMD_tready ,
  input   wire             sCMD_tvalid ,
  input   wire  [31 : 0]   sCMD_tdata  ,

  input   wire             mRSP_tready ,
  output  wire             mRSP_tvalid ,
  output  wire  [31 : 0]   mRSP_tdata  ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF1       ,

  output  wire             sC1_tready  ,
  input   wire             sC1_tvalid  ,
  input   wire  [31 : 0]   sC1_tdata   ,

  input   wire             mA1_tready  ,
  output  wire             mA1_tvalid  ,
  output  wire  [31 : 0]   mA1_tdata   ,

  input   wire             mB1_tready  ,
  output  wire             mB1_tvalid  ,
  output  wire  [31 : 0]   mB1_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF2       ,

  output  wire             sC2_tready  ,
  input   wire             sC2_tvalid  ,
  input   wire  [31 : 0]   sC2_tdata   ,

  input   wire             mA2_tready  ,
  output  wire             mA2_tvalid  ,
  output  wire  [31 : 0]   mA2_tdata   ,

  input   wire             mB2_tready  ,
  output  wire             mB2_tvalid  ,
  output  wire  [31 : 0]   mB2_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF3       ,

  output  wire             sC3_tready  ,
  input   wire             sC3_tvalid  ,
  input   wire  [31 : 0]   sC3_tdata   ,

  input   wire             mA3_tready  ,
  output  wire             mA3_tvalid  ,
  output  wire  [31 : 0]   mA3_tdata   ,

  input   wire             mB3_tready  ,
  output  wire             mB3_tvalid  ,
  output  wire  [31 : 0]   mB3_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF4       ,

  output  wire             sC4_tready  ,
  input   wire             sC4_tvalid  ,
  input   wire  [31 : 0]   sC4_tdata   ,

  input   wire             mA4_tready  ,
  output  wire             mA4_tvalid  ,
  output  wire  [31 : 0]   mA4_tdata   ,

  input   wire             mB4_tready  ,
  output  wire             mB4_tvalid  ,
  output  wire  [31 : 0]   mB4_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF5       ,

  output  wire             sC5_tready  ,
  input   wire             sC5_tvalid  ,
  input   wire  [31 : 0]   sC5_tdata   ,

  input   wire             mA5_tready  ,
  output  wire             mA5_tvalid  ,
  output  wire  [31 : 0]   mA5_tdata   ,

  input   wire             mB5_tready  ,
  output  wire             mB5_tvalid  ,
  output  wire  [31 : 0]   mB5_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF6       ,

  output  wire             sC6_tready  ,
  input   wire             sC6_tvalid  ,
  input   wire  [31 : 0]   sC6_tdata   ,

  input   wire             mA6_tready  ,
  output  wire             mA6_tvalid  ,
  output  wire  [31 : 0]   mA6_tdata   ,

  input   wire             mB6_tready  ,
  output  wire             mB6_tvalid  ,
  output  wire  [31 : 0]   mB6_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF7       ,

  output  wire             sC7_tready  ,
  input   wire             sC7_tvalid  ,
  input   wire  [31 : 0]   sC7_tdata   ,

  input   wire             mA7_tready  ,
  output  wire             mA7_tvalid  ,
  output  wire  [31 : 0]   mA7_tdata   ,

  input   wire             mB7_tready  ,
  output  wire             mB7_tvalid  ,
  output  wire  [31 : 0]   mB7_tdata   ,
  // -----------------------------------
  output  wire  [ 3 : 0]   CONF8       ,

  output  wire             sC8_tready  ,
  input   wire             sC8_tvalid  ,
  input   wire  [31 : 0]   sC8_tdata   ,

  input   wire             mA8_tready  ,
  output  wire             mA8_tvalid  ,
  output  wire  [31 : 0]   mA8_tdata   ,

  input   wire             mB8_tready  ,
  output  wire             mB8_tvalid  ,
  output  wire  [31 : 0]   mB8_tdata   ,
  // -----------------------------------
  input   wire             ACLK        ,
  input   wire             ARESETN
);

//       _    ____ ____           ____
//      / \  / ___/ ___|___   _  |___ \
//     / _ \| |  | |   / __| (_)   __) |
//    / ___ \ |__| |___\__ \  _   / __/
//   /_/   \_\____\____|___/ (_) |_____|
//
generate if (NUM_ACCs == 2) begin

  wire              w1t2_tready;
  wire              w1t2_tvalid;
  wire   [31 : 0]   w1t2_tdata ;
  wire   [ 3 : 0]   wACC1_CONFA;
  wire   [ 3 : 0]   wACC1_CONFB;
  wire   [ 3 : 0]   wACC2_CONFA;
  wire   [ 3 : 0]   wACC2_CONFB;

  wire              w111_tready;
  wire              w112_tready;
  wire              w121_tready;
  wire              w122_tready;
  assign            sC1_tready = w111_tready | w112_tready | w121_tready | w122_tready;

  wire              w211_tready;
  wire              w212_tready;
  wire              w221_tready;
  wire              w222_tready;
  assign            sC2_tready = w211_tready | w212_tready | w221_tready | w222_tready;


  jit_cmd #(1) u_acc1_cmd(
    .sR_tready  (sCMD_tready),
    .sR_tvalid  (sCMD_tvalid),
    .sR_tdata   (sCMD_tdata ),
    .mR_tready  (w1t2_tready),
    .mR_tvalid  (w1t2_tvalid),
    .mR_tdata   (w1t2_tdata ),
    .CONFA      (wACC1_CONFA),
    .CONFB      (wACC1_CONFB),
    .CONFC      (CONF1      ),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc1_mA_mux(
    .s1_tready  (w111_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w211_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (sC3_tready ),
    .s3_tvalid  ( 1'd0      ),
    .s3_tdata   (32'd0      ),
    .s4_tready  (sC4_tready ),
    .s4_tvalid  ( 1'd0      ),
    .s4_tdata   (32'd0      ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mA1_tready ),
    .mO_tvalid  (mA1_tvalid ),
    .mO_tdata   (mA1_tdata  ),
    .CONF       (wACC1_CONFA),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc1_mB_mux(
    .s1_tready  (w112_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w212_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (sC3_tready ),
    .s3_tvalid  ( 1'd0      ),
    .s3_tdata   (32'd0      ),
    .s4_tready  (sC4_tready ),
    .s4_tvalid  ( 1'd0      ),
    .s4_tdata   (32'd0      ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mB1_tready ),
    .mO_tvalid  (mB1_tvalid ),
    .mO_tdata   (mB1_tdata  ),
    .CONF       (wACC1_CONFB),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_cmd #(2) u_acc2_cmd(
    .sR_tready  (w1t2_tready),
    .sR_tvalid  (w1t2_tvalid),
    .sR_tdata   (w1t2_tdata ),
    .mR_tready  (mRSP_tready),
    .mR_tvalid  (mRSP_tvalid),
    .mR_tdata   (mRSP_tdata ),
    .CONFA      (wACC2_CONFA),
    .CONFB      (wACC2_CONFB),
    .CONFC      (CONF2      ),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc2_mA_mux(
    .s1_tready  (w121_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w221_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (sC3_tready ),
    .s3_tvalid  ( 1'd0      ),
    .s3_tdata   (32'd0      ),
    .s4_tready  (sC4_tready ),
    .s4_tvalid  ( 1'd0      ),
    .s4_tdata   (32'd0      ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mA2_tready ),
    .mO_tvalid  (mA2_tvalid ),
    .mO_tdata   (mA2_tdata  ),
    .CONF       (wACC2_CONFA),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc2_mB_mux(
    .s1_tready  (w122_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w222_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (sC3_tready ),
    .s3_tvalid  ( 1'd0      ),
    .s3_tdata   (32'd0      ),
    .s4_tready  (sC4_tready ),
    .s4_tvalid  ( 1'd0      ),
    .s4_tdata   (32'd0      ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mB2_tready ),
    .mO_tvalid  (mB2_tvalid ),
    .mO_tdata   (mB2_tdata  ),
    .CONF       (wACC2_CONFB),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

end // NUM_ACCs == 2
endgenerate

//       _    ____ ____           _  _
//      / \  / ___/ ___|___   _  | || |
//     / _ \| |  | |   / __| (_) | || |_
//    / ___ \ |__| |___\__ \  _  |__   _|
//   /_/   \_\____\____|___/ (_)    |_|
//
generate if (NUM_ACCs == 4) begin

  wire              w1t2_tready;
  wire              w1t2_tvalid;
  wire   [31 : 0]   w1t2_tdata ;

  wire              w2t3_tready;
  wire              w2t3_tvalid;
  wire   [31 : 0]   w2t3_tdata ;

  wire              w3t4_tready;
  wire              w3t4_tvalid;
  wire   [31 : 0]   w3t4_tdata ;

  wire   [ 3 : 0]   wACC1_CONFA;
  wire   [ 3 : 0]   wACC1_CONFB;
  wire   [ 3 : 0]   wACC2_CONFA;
  wire   [ 3 : 0]   wACC2_CONFB;
  wire   [ 3 : 0]   wACC3_CONFA;
  wire   [ 3 : 0]   wACC3_CONFB;
  wire   [ 3 : 0]   wACC4_CONFA;
  wire   [ 3 : 0]   wACC4_CONFB;

  wire              w111_tready;
  wire              w112_tready;
  wire              w121_tready;
  wire              w122_tready;
  assign            sC1_tready = w111_tready | w112_tready | w121_tready | w122_tready;

  wire              w211_tready;
  wire              w212_tready;
  wire              w221_tready;
  wire              w222_tready;
  assign            sC2_tready = w211_tready | w212_tready | w221_tready | w222_tready;

  wire              w311_tready;
  wire              w312_tready;
  wire              w321_tready;
  wire              w322_tready;
  assign            sC3_tready = w311_tready | w312_tready | w321_tready | w322_tready;

  wire              w411_tready;
  wire              w412_tready;
  wire              w421_tready;
  wire              w422_tready;
  assign            sC4_tready = w411_tready | w412_tready | w421_tready | w422_tready;

  jit_cmd #(1) u_acc1_cmd(
    .sR_tready  (sCMD_tready),
    .sR_tvalid  (sCMD_tvalid),
    .sR_tdata   (sCMD_tdata ),
    .mR_tready  (w1t2_tready),
    .mR_tvalid  (w1t2_tvalid),
    .mR_tdata   (w1t2_tdata ),
    .CONFA      (wACC1_CONFA),
    .CONFB      (wACC1_CONFB),
    .CONFC      (CONF1      ),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc1_mA_mux(
    .s1_tready  (w111_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w211_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w311_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w411_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mA1_tready ),
    .mO_tvalid  (mA1_tvalid ),
    .mO_tdata   (mA1_tdata  ),
    .CONF       (wACC1_CONFA),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc1_mB_mux(
    .s1_tready  (w112_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w212_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w312_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w412_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mB1_tready ),
    .mO_tvalid  (mB1_tvalid ),
    .mO_tdata   (mB1_tdata  ),
    .CONF       (wACC1_CONFB),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_cmd #(2) u_acc2_cmd(
    .sR_tready  (w1t2_tready),
    .sR_tvalid  (w1t2_tvalid),
    .sR_tdata   (w1t2_tdata ),
    .mR_tready  (w2t3_tready),
    .mR_tvalid  (w2t3_tvalid),
    .mR_tdata   (w2t3_tdata ),
    .CONFA      (wACC2_CONFA),
    .CONFB      (wACC2_CONFB),
    .CONFC      (CONF2      ),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc2_mA_mux(
    .s1_tready  (w121_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w221_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w321_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w421_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mA2_tready ),
    .mO_tvalid  (mA2_tvalid ),
    .mO_tdata   (mA2_tdata  ),
    .CONF       (wACC2_CONFA),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc2_mB_mux(
    .s1_tready  (w122_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w222_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w322_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w422_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mB2_tready ),
    .mO_tvalid  (mB2_tvalid ),
    .mO_tdata   (mB2_tdata  ),
    .CONF       (wACC2_CONFB),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_cmd #(3) u_acc3_cmd(
    .sR_tready  (w2t3_tready),
    .sR_tvalid  (w2t3_tvalid),
    .sR_tdata   (w2t3_tdata ),
    .mR_tready  (w3t4_tready),
    .mR_tvalid  (w3t4_tvalid),
    .mR_tdata   (w3t4_tdata ),
    .CONFA      (wACC3_CONFA),
    .CONFB      (wACC3_CONFB),
    .CONFC      (CONF3      ),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc3_mA_mux(
    .s1_tready  (w131_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w231_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w331_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w431_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mA3_tready ),
    .mO_tvalid  (mA3_tvalid ),
    .mO_tdata   (mA3_tdata  ),
    .CONF       (wACC3_CONFA),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc3_mB_mux(
    .s1_tready  (w132_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w232_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w332_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w432_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mB3_tready ),
    .mO_tvalid  (mB3_tvalid ),
    .mO_tdata   (mB3_tdata  ),
    .CONF       (wACC3_CONFB),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_cmd #(4) u_acc4_cmd(
    .sR_tready  (w3t4_tready),
    .sR_tvalid  (w3t4_tvalid),
    .sR_tdata   (w3t4_tdata ),
    .mR_tready  (mRSP_tready),
    .mR_tvalid  (mRSP_tvalid),
    .mR_tdata   (mRSP_tdata ),
    .CONFA      (wACC4_CONFA),
    .CONFB      (wACC4_CONFB),
    .CONFC      (CONF4      ),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc4_mA_mux(
    .s1_tready  (w141_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w241_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w341_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w441_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mA4_tready ),
    .mO_tvalid  (mA4_tvalid ),
    .mO_tdata   (mA4_tdata  ),
    .CONF       (wACC4_CONFA),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

  jit_mux #(NUM_ACCs) u_acc4_mB_mux(
    .s1_tready  (w142_tready),
    .s1_tvalid  (sC1_tvalid ),
    .s1_tdata   (sC1_tdata  ),
    .s2_tready  (w242_tready),
    .s2_tvalid  (sC2_tvalid ),
    .s2_tdata   (sC2_tdata  ),
    .s3_tready  (w342_tready),
    .s3_tvalid  (sC3_tvalid ),
    .s3_tdata   (sC3_tdata  ),
    .s4_tready  (w442_tready),
    .s4_tvalid  (sC4_tvalid ),
    .s4_tdata   (sC4_tdata  ),
    .s5_tready  (sC5_tready ),
    .s5_tvalid  ( 1'd0      ),
    .s5_tdata   (32'd0      ),
    .s6_tready  (sC6_tready ),
    .s6_tvalid  ( 1'd0      ),
    .s6_tdata   (32'd0      ),
    .s7_tready  (sC7_tready ),
    .s7_tvalid  ( 1'd0      ),
    .s7_tdata   (32'd0      ),
    .s8_tready  (sC8_tready ),
    .s8_tvalid  ( 1'd0      ),
    .s8_tdata   (32'd0      ),
    .mO_tready  (mB4_tready ),
    .mO_tvalid  (mB4_tvalid ),
    .mO_tdata   (mB4_tdata  ),
    .CONF       (wACC4_CONFB),
    .ACLK       (ACLK       ),
    .ARESETN    (ARESETN    )
  );

end // NUM_ACCs == 4
endgenerate




endmodule
