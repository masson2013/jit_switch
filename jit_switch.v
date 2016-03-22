`timescale 1ns / 1ps

module jit_switch #(
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
  output  wire             s1A_tready  ,
  input   wire             s1A_tvalid  ,
  input   wire  [31 : 0]   s1A_tdata   ,

  output  wire             s1B_tready  ,
  input   wire             s1B_tvalid  ,
  input   wire  [31 : 0]   s1B_tdata   ,

  input   wire             m1C_tready  ,
  output  wire             m1C_tvalid  ,
  output  wire  [31 : 0]   m1C_tdata   ,

  output  wire             s1C_tready  ,
  input   wire             s1C_tvalid  ,
  input   wire  [31 : 0]   s1C_tdata   ,

  input   wire             m1A_tready  ,
  output  wire             m1A_tvalid  ,
  output  wire  [31 : 0]   m1A_tdata   ,

  input   wire             m1B_tready  ,
  output  wire             m1B_tvalid  ,
  output  wire  [31 : 0]   m1B_tdata   ,
  // -----------------------------------
  output  wire             s2A_tready  ,
  input   wire             s2A_tvalid  ,
  input   wire  [31 : 0]   s2A_tdata   ,

  output  wire             s2B_tready  ,
  input   wire             s2B_tvalid  ,
  input   wire  [31 : 0]   s2B_tdata   ,

  input   wire             m2C_tready  ,
  output  wire             m2C_tvalid  ,
  output  wire  [31 : 0]   m2C_tdata   ,

  output  wire             s2C_tready  ,
  input   wire             s2C_tvalid  ,
  input   wire  [31 : 0]   s2C_tdata   ,

  input   wire             m2A_tready  ,
  output  wire             m2A_tvalid  ,
  output  wire  [31 : 0]   m2A_tdata   ,

  input   wire             m2B_tready  ,
  output  wire             m2B_tvalid  ,
  output  wire  [31 : 0]   m2B_tdata   ,
  // -----------------------------------
  output  wire             s3A_tready  ,
  input   wire             s3A_tvalid  ,
  input   wire  [31 : 0]   s3A_tdata   ,

  output  wire             s3B_tready  ,
  input   wire             s3B_tvalid  ,
  input   wire  [31 : 0]   s3B_tdata   ,

  input   wire             m3C_tready  ,
  output  wire             m3C_tvalid  ,
  output  wire  [31 : 0]   m3C_tdata   ,

  output  wire             s3C_tready  ,
  input   wire             s3C_tvalid  ,
  input   wire  [31 : 0]   s3C_tdata   ,

  input   wire             m3A_tready  ,
  output  wire             m3A_tvalid  ,
  output  wire  [31 : 0]   m3A_tdata   ,

  input   wire             m3B_tready  ,
  output  wire             m3B_tvalid  ,
  output  wire  [31 : 0]   m3B_tdata   ,
  // -----------------------------------
  output  wire             s4A_tready  ,
  input   wire             s4A_tvalid  ,
  input   wire  [31 : 0]   s4A_tdata   ,

  output  wire             s4B_tready  ,
  input   wire             s4B_tvalid  ,
  input   wire  [31 : 0]   s4B_tdata   ,

  input   wire             m4C_tready  ,
  output  wire             m4C_tvalid  ,
  output  wire  [31 : 0]   m4C_tdata   ,

  output  wire             s4C_tready  ,
  input   wire             s4C_tvalid  ,
  input   wire  [31 : 0]   s4C_tdata   ,

  input   wire             m4A_tready  ,
  output  wire             m4A_tvalid  ,
  output  wire  [31 : 0]   m4A_tdata   ,

  input   wire             m4B_tready  ,
  output  wire             m4B_tvalid  ,
  output  wire  [31 : 0]   m4B_tdata   ,
  // -----------------------------------
  output  wire             s5A_tready  ,
  input   wire             s5A_tvalid  ,
  input   wire  [31 : 0]   s5A_tdata   ,

  output  wire             s5B_tready  ,
  input   wire             s5B_tvalid  ,
  input   wire  [31 : 0]   s5B_tdata   ,

  input   wire             m5C_tready  ,
  output  wire             m5C_tvalid  ,
  output  wire  [31 : 0]   m5C_tdata   ,

  output  wire             s5C_tready  ,
  input   wire             s5C_tvalid  ,
  input   wire  [31 : 0]   s5C_tdata   ,

  input   wire             m5A_tready  ,
  output  wire             m5A_tvalid  ,
  output  wire  [31 : 0]   m5A_tdata   ,

  input   wire             m5B_tready  ,
  output  wire             m5B_tvalid  ,
  output  wire  [31 : 0]   m5B_tdata   ,
  // -----------------------------------
  output  wire             s6A_tready  ,
  input   wire             s6A_tvalid  ,
  input   wire  [31 : 0]   s6A_tdata   ,

  output  wire             s6B_tready  ,
  input   wire             s6B_tvalid  ,
  input   wire  [31 : 0]   s6B_tdata   ,

  input   wire             m6C_tready  ,
  output  wire             m6C_tvalid  ,
  output  wire  [31 : 0]   m6C_tdata   ,

  output  wire             s6C_tready  ,
  input   wire             s6C_tvalid  ,
  input   wire  [31 : 0]   s6C_tdata   ,

  input   wire             m6A_tready  ,
  output  wire             m6A_tvalid  ,
  output  wire  [31 : 0]   m6A_tdata   ,

  input   wire             m6B_tready  ,
  output  wire             m6B_tvalid  ,
  output  wire  [31 : 0]   m6B_tdata   ,
  // -----------------------------------
  output  wire             s7A_tready  ,
  input   wire             s7A_tvalid  ,
  input   wire  [31 : 0]   s7A_tdata   ,

  output  wire             s7B_tready  ,
  input   wire             s7B_tvalid  ,
  input   wire  [31 : 0]   s7B_tdata   ,

  input   wire             m7C_tready  ,
  output  wire             m7C_tvalid  ,
  output  wire  [31 : 0]   m7C_tdata   ,

  output  wire             s7C_tready  ,
  input   wire             s7C_tvalid  ,
  input   wire  [31 : 0]   s7C_tdata   ,

  input   wire             m7A_tready  ,
  output  wire             m7A_tvalid  ,
  output  wire  [31 : 0]   m7A_tdata   ,

  input   wire             m7B_tready  ,
  output  wire             m7B_tvalid  ,
  output  wire  [31 : 0]   m7B_tdata   ,
  // -----------------------------------
  output  wire             s8A_tready  ,
  input   wire             s8A_tvalid  ,
  input   wire  [31 : 0]   s8A_tdata   ,

  output  wire             s8B_tready  ,
  input   wire             s8B_tvalid  ,
  input   wire  [31 : 0]   s8B_tdata   ,

  input   wire             m8C_tready  ,
  output  wire             m8C_tvalid  ,
  output  wire  [31 : 0]   m8C_tdata   ,

  output  wire             s8C_tready  ,
  input   wire             s8C_tvalid  ,
  input   wire  [31 : 0]   s8C_tdata   ,

  input   wire             m8A_tready  ,
  output  wire             m8A_tvalid  ,
  output  wire  [31 : 0]   m8A_tdata   ,

  input   wire             m8B_tready  ,
  output  wire             m8B_tvalid  ,
  output  wire  [31 : 0]   m8B_tdata   ,
  // -----------------------------------
  input   wire             ACLK       ,
  input   wire             ARESETN
);
  wire             w1cA_tready  ;
  wire             w1cA_tvalid  ;
  wire  [31 : 0]   w1cA_tdata   ;
  wire             w1cB_tready  ;
  wire             w1cB_tvalid  ;
  wire  [31 : 0]   w1cB_tdata   ;
  wire             w1cC_tready  ;
  wire             w1cC_tvalid  ;
  wire  [31 : 0]   w1cC_tdata   ;

  wire             w2cA_tready  ;
  wire             w2cA_tvalid  ;
  wire  [31 : 0]   w2cA_tdata   ;
  wire             w2cB_tready  ;
  wire             w2cB_tvalid  ;
  wire  [31 : 0]   w2cB_tdata   ;
  wire             w2cC_tready  ;
  wire             w2cC_tvalid  ;
  wire  [31 : 0]   w2cC_tdata   ;

  wire             w3cA_tready  ;
  wire             w3cA_tvalid  ;
  wire  [31 : 0]   w3cA_tdata   ;
  wire             w3cB_tready  ;
  wire             w3cB_tvalid  ;
  wire  [31 : 0]   w3cB_tdata   ;
  wire             w3cC_tready  ;
  wire             w3cC_tvalid  ;
  wire  [31 : 0]   w3cC_tdata   ;

  wire             w4cA_tready  ;
  wire             w4cA_tvalid  ;
  wire  [31 : 0]   w4cA_tdata   ;
  wire             w4cB_tready  ;
  wire             w4cB_tvalid  ;
  wire  [31 : 0]   w4cB_tdata   ;
  wire             w4cC_tready  ;
  wire             w4cC_tvalid  ;
  wire  [31 : 0]   w4cC_tdata   ;

  wire             w5cA_tready  ;
  wire             w5cA_tvalid  ;
  wire  [31 : 0]   w5cA_tdata   ;
  wire             w5cB_tready  ;
  wire             w5cB_tvalid  ;
  wire  [31 : 0]   w5cB_tdata   ;
  wire             w5cC_tready  ;
  wire             w5cC_tvalid  ;
  wire  [31 : 0]   w5cC_tdata   ;

  wire             w6cA_tready  ;
  wire             w6cA_tvalid  ;
  wire  [31 : 0]   w6cA_tdata   ;
  wire             w6cB_tready  ;
  wire             w6cB_tvalid  ;
  wire  [31 : 0]   w6cB_tdata   ;
  wire             w6cC_tready  ;
  wire             w6cC_tvalid  ;
  wire  [31 : 0]   w6cC_tdata   ;

  wire             w7cA_tready  ;
  wire             w7cA_tvalid  ;
  wire  [31 : 0]   w7cA_tdata   ;
  wire             w7cB_tready  ;
  wire             w7cB_tvalid  ;
  wire  [31 : 0]   w7cB_tdata   ;
  wire             w7cC_tready  ;
  wire             w7cC_tvalid  ;
  wire  [31 : 0]   w7cC_tdata   ;

  wire             w8cA_tready  ;
  wire             w8cA_tvalid  ;
  wire  [31 : 0]   w8cA_tdata   ;
  wire             w8cB_tready  ;
  wire             w8cB_tvalid  ;
  wire  [31 : 0]   w8cB_tdata   ;
  wire             w8cC_tready  ;
  wire             w8cC_tvalid  ;
  wire  [31 : 0]   w8cC_tdata   ;

  wire  [ 3 : 0]   wCONF1       ;
  wire  [ 3 : 0]   wCONF2       ;
  wire  [ 3 : 0]   wCONF3       ;
  wire  [ 3 : 0]   wCONF4       ;
  wire  [ 3 : 0]   wCONF5       ;
  wire  [ 3 : 0]   wCONF6       ;
  wire  [ 3 : 0]   wCONF7       ;
  wire  [ 3 : 0]   wCONF8       ;
//       _    ____ ____           ____
//      / \  / ___/ ___|___   _  |___ \
//     / _ \| |  | |   / __| (_)   __) |
//    / ___ \ |__| |___\__ \  _   / __/
//   /_/   \_\____\____|___/ (_) |_____|
//
generate if (NUM_ACCs == 2) begin

  jit_couple u_acc1_couple (
    .sInA_tready      (s1A_tready   ),
    .sInA_tvalid      (s1A_tvalid   ),
    .sInA_tdata       (s1A_tdata    ),
    .sInB_tready      (s1B_tready   ),
    .sInB_tvalid      (s1B_tvalid   ),
    .sInB_tdata       (s1B_tdata    ),
    .mOutC_tready     (m1C_tready   ),
    .mOutC_tvalid     (m1C_tvalid   ),
    .mOutC_tdata      (m1C_tdata    ),
    .scInA_tready     (w1cA_tready  ),
    .scInA_tvalid     (w1cA_tvalid  ),
    .scInA_tdata      (w1cA_tdata   ),
    .scInB_tready     (w1cB_tready  ),
    .scInB_tvalid     (w1cB_tvalid  ),
    .scInB_tdata      (w1cB_tdata   ),
    .mcOutC_tready    (w1cC_tready  ),
    .mcOutC_tvalid    (w1cC_tvalid  ),
    .mcOutC_tdata     (w1cC_tdata   ),
    .sAccInC_tready   (s1C_tready   ),
    .sAccInC_tvalid   (s1C_tvalid   ),
    .sAccInC_tdata    (s1C_tdata    ),
    .mAccOutA_tready  (m1A_tready   ),
    .mAccOutA_tvalid  (m1A_tvalid   ),
    .mAccOutA_tdata   (m1A_tdata    ),
    .mAccOutB_tready  (m1B_tready   ),
    .mAccOutB_tvalid  (m1B_tvalid   ),
    .mAccOutB_tdata   (m1B_tdata    ),
    .CONF             (wCONF1       ),
    .ACLK             (ACLK         ),
    .ARESETN          (ARESETN      )
  );

  jit_couple u_acc2_couple (
    .sInA_tready      (s2A_tready   ),
    .sInA_tvalid      (s2A_tvalid   ),
    .sInA_tdata       (s2A_tdata    ),
    .sInB_tready      (s2B_tready   ),
    .sInB_tvalid      (s2B_tvalid   ),
    .sInB_tdata       (s2B_tdata    ),
    .mOutC_tready     (m2C_tready   ),
    .mOutC_tvalid     (m2C_tvalid   ),
    .mOutC_tdata      (m2C_tdata    ),
    .scInA_tready     (w2cA_tready  ),
    .scInA_tvalid     (w2cA_tvalid  ),
    .scInA_tdata      (w2cA_tdata   ),
    .scInB_tready     (w2cB_tready  ),
    .scInB_tvalid     (w2cB_tvalid  ),
    .scInB_tdata      (w2cB_tdata   ),
    .mcOutC_tready    (w2cC_tready  ),
    .mcOutC_tvalid    (w2cC_tvalid  ),
    .mcOutC_tdata     (w2cC_tdata   ),
    .sAccInC_tready   (s2C_tready   ),
    .sAccInC_tvalid   (s2C_tvalid   ),
    .sAccInC_tdata    (s2C_tdata    ),
    .mAccOutA_tready  (m2A_tready   ),
    .mAccOutA_tvalid  (m2A_tvalid   ),
    .mAccOutA_tdata   (m2A_tdata    ),
    .mAccOutB_tready  (m2B_tready   ),
    .mAccOutB_tvalid  (m2B_tvalid   ),
    .mAccOutB_tdata   (m2B_tdata    ),
    .CONF             (wCONF2       ),
    .ACLK             (ACLK         ),
    .ARESETN          (ARESETN      )
  );

  jit_crossbar #(2) u_crossbar (
    .sCMD_tready   (sCMD_tready     ),
    .sCMD_tvalid   (sCMD_tvalid     ),
    .sCMD_tdata    (sCMD_tdata      ),
    .mRSP_tready   (mRSP_tready     ),
    .mRSP_tvalid   (mRSP_tvalid     ),
    .mRSP_tdata    (mRSP_tdata      ),
    .CONF1         (wCONF1          ),
    .sC1_tready    (w1cC_tready     ),
    .sC1_tvalid    (w1cC_tvalid     ),
    .sC1_tdata     (w1cC_tdata      ),
    .mA1_tready    (w1cA_tready     ),
    .mA1_tvalid    (w1cA_tvalid     ),
    .mA1_tdata     (w1cA_tdata      ),
    .mB1_tready    (w1cB_tready     ),
    .mB1_tvalid    (w1cB_tvalid     ),
    .mB1_tdata     (w1cB_tdata      ),
    .CONF2         (wCONF2          ),
    .sC2_tready    (w2cC_tready     ),
    .sC2_tvalid    (w2cC_tvalid     ),
    .sC2_tdata     (w2cC_tdata      ),
    .mA2_tready    (w2cA_tready     ),
    .mA2_tvalid    (w2cA_tvalid     ),
    .mA2_tdata     (w2cA_tdata      ),
    .mB2_tready    (w2cB_tready     ),
    .mB2_tvalid    (w2cB_tvalid     ),
    .mB2_tdata     (w2cB_tdata      ),
    .CONF3         (wCONF3          ),
    .sC3_tready    (w3cC_tready     ),
    .sC3_tvalid    ( 1'd0           ),
    .sC3_tdata     (32'd0           ),
    .mA3_tready    ( 1'd0           ),
    .mA3_tvalid    (w3cA_tvalid     ),
    .mA3_tdata     (w3cA_tdata      ),
    .mB3_tready    ( 1'd0           ),
    .mB3_tvalid    (w3cB_tvalid     ),
    .mB3_tdata     (w3cB_tdata      ),
    .CONF4         (wCONF4          ),
    .sC4_tready    (w4cC_tready     ),
    .sC4_tvalid    ( 1'd0           ),
    .sC4_tdata     (32'd0           ),
    .mA4_tready    ( 1'd0           ),
    .mA4_tvalid    (w4cA_tvalid     ),
    .mA4_tdata     (w4cA_tdata      ),
    .mB4_tready    ( 1'd0           ),
    .mB4_tvalid    (w4cB_tvalid     ),
    .mB4_tdata     (w4cB_tdata      ),
    .CONF5         (wCONF5          ),
    .sC5_tready    (w5cC_tready     ),
    .sC5_tvalid    ( 1'd0           ),
    .sC5_tdata     (32'd0           ),
    .mA5_tready    ( 1'd0           ),
    .mA5_tvalid    (w5cA_tvalid     ),
    .mA5_tdata     (w5cA_tdata      ),
    .mB5_tready    ( 1'd0           ),
    .mB5_tvalid    (w5cB_tvalid     ),
    .mB5_tdata     (w5cB_tdata      ),
    .CONF6         (wCONF6          ),
    .sC6_tready    (w6cC_tready     ),
    .sC6_tvalid    ( 1'd0           ),
    .sC6_tdata     (32'd0           ),
    .mA6_tready    ( 1'd0           ),
    .mA6_tvalid    (w6cA_tvalid     ),
    .mA6_tdata     (w6cA_tdata      ),
    .mB6_tready    ( 1'd0           ),
    .mB6_tvalid    (w6cB_tvalid     ),
    .mB6_tdata     (w6cB_tdata      ),
    .CONF7         (wCONF7          ),
    .sC7_tready    (w7cC_tready     ),
    .sC7_tvalid    ( 1'd0           ),
    .sC7_tdata     (32'd0           ),
    .mA7_tready    ( 1'd0           ),
    .mA7_tvalid    (w7cA_tvalid     ),
    .mA7_tdata     (w7cA_tdata      ),
    .mB7_tready    ( 1'd0           ),
    .mB7_tvalid    (w7cB_tvalid     ),
    .mB7_tdata     (w7cB_tdata      ),
    .CONF8         (wCONF8          ),
    .sC8_tready    (w8cC_tready     ),
    .sC8_tvalid    ( 1'd0           ),
    .sC8_tdata     (32'd0           ),
    .mA8_tready    ( 1'd0           ),
    .mA8_tvalid    (w8cA_tvalid     ),
    .mA8_tdata     (w8cA_tdata      ),
    .mB8_tready    ( 1'd0           ),
    .mB8_tvalid    (w8cB_tvalid     ),
    .mB8_tdata     (w8cB_tdata      ),
    .ACLK          (ACLK            ),
    .ARESETN       (ARESETN         )
  );

end
endgenerate // NUM_ACCs == 2

//       _    ____ ____           _  _
//      / \  / ___/ ___|___   _  | || |
//     / _ \| |  | |   / __| (_) | || |_
//    / ___ \ |__| |___\__ \  _  |__   _|
//   /_/   \_\____\____|___/ (_)    |_|
//
generate if (NUM_ACCs == 4) begin

  jit_couple u_acc1_couple (
    .sInA_tready      (s1A_tready   ),
    .sInA_tvalid      (s1A_tvalid   ),
    .sInA_tdata       (s1A_tdata    ),
    .sInB_tready      (s1B_tready   ),
    .sInB_tvalid      (s1B_tvalid   ),
    .sInB_tdata       (s1B_tdata    ),
    .mOutC_tready     (m1C_tready   ),
    .mOutC_tvalid     (m1C_tvalid   ),
    .mOutC_tdata      (m1C_tdata    ),
    .scInA_tready     (w1cA_tready  ),
    .scInA_tvalid     (w1cA_tvalid  ),
    .scInA_tdata      (w1cA_tdata   ),
    .scInB_tready     (w1cB_tready  ),
    .scInB_tvalid     (w1cB_tvalid  ),
    .scInB_tdata      (w1cB_tdata   ),
    .mcOutC_tready    (w1cC_tready  ),
    .mcOutC_tvalid    (w1cC_tvalid  ),
    .mcOutC_tdata     (w1cC_tdata   ),
    .sAccInC_tready   (s1C_tready   ),
    .sAccInC_tvalid   (s1C_tvalid   ),
    .sAccInC_tdata    (s1C_tdata    ),
    .mAccOutA_tready  (m1A_tready   ),
    .mAccOutA_tvalid  (m1A_tvalid   ),
    .mAccOutA_tdata   (m1A_tdata    ),
    .mAccOutB_tready  (m1B_tready   ),
    .mAccOutB_tvalid  (m1B_tvalid   ),
    .mAccOutB_tdata   (m1B_tdata    ),
    .CONF             (wCONF1       ),
    .ACLK             (ACLK         ),
    .ARESETN          (ARESETN      )
  );

  jit_couple u_acc2_couple (
    .sInA_tready      (s2A_tready   ),
    .sInA_tvalid      (s2A_tvalid   ),
    .sInA_tdata       (s2A_tdata    ),
    .sInB_tready      (s2B_tready   ),
    .sInB_tvalid      (s2B_tvalid   ),
    .sInB_tdata       (s2B_tdata    ),
    .mOutC_tready     (m2C_tready   ),
    .mOutC_tvalid     (m2C_tvalid   ),
    .mOutC_tdata      (m2C_tdata    ),
    .scInA_tready     (w2cA_tready  ),
    .scInA_tvalid     (w2cA_tvalid  ),
    .scInA_tdata      (w2cA_tdata   ),
    .scInB_tready     (w2cB_tready  ),
    .scInB_tvalid     (w2cB_tvalid  ),
    .scInB_tdata      (w2cB_tdata   ),
    .mcOutC_tready    (w2cC_tready  ),
    .mcOutC_tvalid    (w2cC_tvalid  ),
    .mcOutC_tdata     (w2cC_tdata   ),
    .sAccInC_tready   (s2C_tready   ),
    .sAccInC_tvalid   (s2C_tvalid   ),
    .sAccInC_tdata    (s2C_tdata    ),
    .mAccOutA_tready  (m2A_tready   ),
    .mAccOutA_tvalid  (m2A_tvalid   ),
    .mAccOutA_tdata   (m2A_tdata    ),
    .mAccOutB_tready  (m2B_tready   ),
    .mAccOutB_tvalid  (m2B_tvalid   ),
    .mAccOutB_tdata   (m2B_tdata    ),
    .CONF             (wCONF2       ),
    .ACLK             (ACLK         ),
    .ARESETN          (ARESETN      )
  );

  jit_couple u_acc3_couple (
    .sInA_tready      (s3A_tready   ),
    .sInA_tvalid      (s3A_tvalid   ),
    .sInA_tdata       (s3A_tdata    ),
    .sInB_tready      (s3B_tready   ),
    .sInB_tvalid      (s3B_tvalid   ),
    .sInB_tdata       (s3B_tdata    ),
    .mOutC_tready     (m3C_tready   ),
    .mOutC_tvalid     (m3C_tvalid   ),
    .mOutC_tdata      (m3C_tdata    ),
    .scInA_tready     (w3cA_tready  ),
    .scInA_tvalid     (w3cA_tvalid  ),
    .scInA_tdata      (w3cA_tdata   ),
    .scInB_tready     (w3cB_tready  ),
    .scInB_tvalid     (w3cB_tvalid  ),
    .scInB_tdata      (w3cB_tdata   ),
    .mcOutC_tready    (w3cC_tready  ),
    .mcOutC_tvalid    (w3cC_tvalid  ),
    .mcOutC_tdata     (w3cC_tdata   ),
    .sAccInC_tready   (s3C_tready   ),
    .sAccInC_tvalid   (s3C_tvalid   ),
    .sAccInC_tdata    (s3C_tdata    ),
    .mAccOutA_tready  (m3A_tready   ),
    .mAccOutA_tvalid  (m3A_tvalid   ),
    .mAccOutA_tdata   (m3A_tdata    ),
    .mAccOutB_tready  (m3B_tready   ),
    .mAccOutB_tvalid  (m3B_tvalid   ),
    .mAccOutB_tdata   (m3B_tdata    ),
    .CONF             (wCONF3       ),
    .ACLK             (ACLK         ),
    .ARESETN          (ARESETN      )
  );

  jit_couple u_acc4_couple (
    .sInA_tready      (s4A_tready   ),
    .sInA_tvalid      (s4A_tvalid   ),
    .sInA_tdata       (s4A_tdata    ),
    .sInB_tready      (s4B_tready   ),
    .sInB_tvalid      (s4B_tvalid   ),
    .sInB_tdata       (s4B_tdata    ),
    .mOutC_tready     (m4C_tready   ),
    .mOutC_tvalid     (m4C_tvalid   ),
    .mOutC_tdata      (m4C_tdata    ),
    .scInA_tready     (w4cA_tready  ),
    .scInA_tvalid     (w4cA_tvalid  ),
    .scInA_tdata      (w4cA_tdata   ),
    .scInB_tready     (w4cB_tready  ),
    .scInB_tvalid     (w4cB_tvalid  ),
    .scInB_tdata      (w4cB_tdata   ),
    .mcOutC_tready    (w4cC_tready  ),
    .mcOutC_tvalid    (w4cC_tvalid  ),
    .mcOutC_tdata     (w4cC_tdata   ),
    .sAccInC_tready   (s4C_tready   ),
    .sAccInC_tvalid   (s4C_tvalid   ),
    .sAccInC_tdata    (s4C_tdata    ),
    .mAccOutA_tready  (m4A_tready   ),
    .mAccOutA_tvalid  (m4A_tvalid   ),
    .mAccOutA_tdata   (m4A_tdata    ),
    .mAccOutB_tready  (m4B_tready   ),
    .mAccOutB_tvalid  (m4B_tvalid   ),
    .mAccOutB_tdata   (m4B_tdata    ),
    .CONF             (wCONF4       ),
    .ACLK             (ACLK         ),
    .ARESETN          (ARESETN      )
  );

  jit_crossbar #(4) u_crossbar (
    .sCMD_tready   (sCMD_tready     ),
    .sCMD_tvalid   (sCMD_tvalid     ),
    .sCMD_tdata    (sCMD_tdata      ),
    .mRSP_tready   (mRSP_tready     ),
    .mRSP_tvalid   (mRSP_tvalid     ),
    .mRSP_tdata    (mRSP_tdata      ),
    .CONF1         (wCONF1          ),
    .sC1_tready    (w1cC_tready     ),
    .sC1_tvalid    (w1cC_tvalid     ),
    .sC1_tdata     (w1cC_tdata      ),
    .mA1_tready    (w1cA_tready     ),
    .mA1_tvalid    (w1cA_tvalid     ),
    .mA1_tdata     (w1cA_tdata      ),
    .mB1_tready    (w1cB_tready     ),
    .mB1_tvalid    (w1cB_tvalid     ),
    .mB1_tdata     (w1cB_tdata      ),
    .CONF2         (wCONF2          ),
    .sC2_tready    (w2cC_tready     ),
    .sC2_tvalid    (w2cC_tvalid     ),
    .sC2_tdata     (w2cC_tdata      ),
    .mA2_tready    (w2cA_tready     ),
    .mA2_tvalid    (w2cA_tvalid     ),
    .mA2_tdata     (w2cA_tdata      ),
    .mB2_tready    (w2cB_tready     ),
    .mB2_tvalid    (w2cB_tvalid     ),
    .mB2_tdata     (w2cB_tdata      ),
    .CONF3         (wCONF3          ),
    .sC3_tready    (w3cC_tready     ),
    .sC3_tvalid    (w3cC_tvalid     ),
    .sC3_tdata     (w3cC_tdata      ),
    .mA3_tready    (w3cA_tready     ),
    .mA3_tvalid    (w3cA_tvalid     ),
    .mA3_tdata     (w3cA_tdata      ),
    .mB3_tready    (w3cB_tready     ),
    .mB3_tvalid    (w3cB_tvalid     ),
    .mB3_tdata     (w3cB_tdata      ),
    .CONF4         (wCONF4          ),
    .sC4_tready    (w4cC_tready     ),
    .sC4_tvalid    (w4cC_tvalid     ),
    .sC4_tdata     (w4cC_tdata      ),
    .mA4_tready    (w4cA_tready     ),
    .mA4_tvalid    (w4cA_tvalid     ),
    .mA4_tdata     (w4cA_tdata      ),
    .mB4_tready    (w4cB_tready     ),
    .mB4_tvalid    (w4cB_tvalid     ),
    .mB4_tdata     (w4cB_tdata      ),
    .CONF5         (wCONF5          ),
    .sC5_tready    (w5cC_tready     ),
    .sC5_tvalid    ( 1'd0           ),
    .sC5_tdata     (32'd0           ),
    .mA5_tready    ( 1'd0           ),
    .mA5_tvalid    (w5cA_tvalid     ),
    .mA5_tdata     (w5cA_tdata      ),
    .mB5_tready    ( 1'd0           ),
    .mB5_tvalid    (w5cB_tvalid     ),
    .mB5_tdata     (w5cB_tdata      ),
    .CONF6         (wCONF6          ),
    .sC6_tready    (w6cC_tready     ),
    .sC6_tvalid    ( 1'd0           ),
    .sC6_tdata     (32'd0           ),
    .mA6_tready    ( 1'd0           ),
    .mA6_tvalid    (w6cA_tvalid     ),
    .mA6_tdata     (w6cA_tdata      ),
    .mB6_tready    ( 1'd0           ),
    .mB6_tvalid    (w6cB_tvalid     ),
    .mB6_tdata     (w6cB_tdata      ),
    .CONF7         (wCONF7          ),
    .sC7_tready    (w7cC_tready     ),
    .sC7_tvalid    ( 1'd0           ),
    .sC7_tdata     (32'd0           ),
    .mA7_tready    ( 1'd0           ),
    .mA7_tvalid    (w7cA_tvalid     ),
    .mA7_tdata     (w7cA_tdata      ),
    .mB7_tready    ( 1'd0           ),
    .mB7_tvalid    (w7cB_tvalid     ),
    .mB7_tdata     (w7cB_tdata      ),
    .CONF8         (wCONF8          ),
    .sC8_tready    (w8cC_tready     ),
    .sC8_tvalid    ( 1'd0           ),
    .sC8_tdata     (32'd0           ),
    .mA8_tready    ( 1'd0           ),
    .mA8_tvalid    (w8cA_tvalid     ),
    .mA8_tdata     (w8cA_tdata      ),
    .mB8_tready    ( 1'd0           ),
    .mB8_tvalid    (w8cB_tvalid     ),
    .mB8_tdata     (w8cB_tdata      ),
    .ACLK          (ACLK            ),
    .ARESETN       (ARESETN         )
  );

end
endgenerate // NUM_ACCs == 4





endmodule
