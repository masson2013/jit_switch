`timescale 1ns / 1ps

module jit_dispatch #(
  parameter integer NUM_ACCs = 2
)
(
  output  wire            sR_tready   ,
  input   wire            sR_tvalid   ,
  input   wire  [31 : 0]  sR_tdata    ,
  // ---------------------------------------------------------------------------
  input   wire            mR_tready   ,
  output  wire            mR_tvalid   ,
  output  wire  [31 : 0]  mR_tdata    ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc1_A1     ,
  output  wire  [ 3 : 0]  acc1_B1     ,
  output  wire  [ 3 : 0]  acc1_C1     ,
  output  wire  [15 : 0]  acc1_R1     ,
  output  wire  [15 : 0]  acc1_R2     ,
  output  wire  [15 : 0]  acc1_R3     ,
  input   wire            acc1_done   ,
  input   wire            acc1_idle   ,
  input   wire            acc1_ready  ,
  output  wire            acc1_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc2_A1     ,
  output  wire  [ 3 : 0]  acc2_B1     ,
  output  wire  [ 3 : 0]  acc2_C1     ,
  output  wire  [15 : 0]  acc2_R1     ,
  output  wire  [15 : 0]  acc2_R2     ,
  output  wire  [15 : 0]  acc2_R3     ,
  input   wire            acc2_done   ,
  input   wire            acc2_idle   ,
  input   wire            acc2_ready  ,
  output  wire            acc2_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc3_A1     ,
  output  wire  [ 3 : 0]  acc3_B1     ,
  output  wire  [ 3 : 0]  acc3_C1     ,
  output  wire  [15 : 0]  acc3_R1     ,
  output  wire  [15 : 0]  acc3_R2     ,
  output  wire  [15 : 0]  acc3_R3     ,
  input   wire            acc3_done   ,
  input   wire            acc3_idle   ,
  input   wire            acc3_ready  ,
  output  wire            acc3_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc4_A1     ,
  output  wire  [ 3 : 0]  acc4_B1     ,
  output  wire  [ 3 : 0]  acc4_C1     ,
  output  wire  [15 : 0]  acc4_R1     ,
  output  wire  [15 : 0]  acc4_R2     ,
  output  wire  [15 : 0]  acc4_R3     ,
  input   wire            acc4_done   ,
  input   wire            acc4_idle   ,
  input   wire            acc4_ready  ,
  output  wire            acc4_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc5_A1     ,
  output  wire  [ 3 : 0]  acc5_B1     ,
  output  wire  [ 3 : 0]  acc5_C1     ,
  output  wire  [15 : 0]  acc5_R1     ,
  output  wire  [15 : 0]  acc5_R2     ,
  output  wire  [15 : 0]  acc5_R3     ,
  input   wire            acc5_done   ,
  input   wire            acc5_idle   ,
  input   wire            acc5_ready  ,
  output  wire            acc5_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc6_A1     ,
  output  wire  [ 3 : 0]  acc6_B1     ,
  output  wire  [ 3 : 0]  acc6_C1     ,
  output  wire  [15 : 0]  acc6_R1     ,
  output  wire  [15 : 0]  acc6_R2     ,
  output  wire  [15 : 0]  acc6_R3     ,
  input   wire            acc6_done   ,
  input   wire            acc6_idle   ,
  input   wire            acc6_ready  ,
  output  wire            acc6_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc7_A1     ,
  output  wire  [ 3 : 0]  acc7_B1     ,
  output  wire  [ 3 : 0]  acc7_C1     ,
  output  wire  [15 : 0]  acc7_R1     ,
  output  wire  [15 : 0]  acc7_R2     ,
  output  wire  [15 : 0]  acc7_R3     ,
  input   wire            acc7_done   ,
  input   wire            acc7_idle   ,
  input   wire            acc7_ready  ,
  output  wire            acc7_start  ,
  // ---------------------------------------------------------------------------
  output  wire  [ 3 : 0]  acc8_A1     ,
  output  wire  [ 3 : 0]  acc8_B1     ,
  output  wire  [ 3 : 0]  acc8_C1     ,
  output  wire  [15 : 0]  acc8_R1     ,
  output  wire  [15 : 0]  acc8_R2     ,
  output  wire  [15 : 0]  acc8_R3     ,
  input   wire            acc8_done   ,
  input   wire            acc8_idle   ,
  input   wire            acc8_ready  ,
  output  wire            acc8_start  ,
  // ---------------------------------------------------------------------------
  input   wire            ACLK        ,
  input   wire            ARESETN
);
//       _    ____ ____           ____
//      / \  / ___/ ___|___   _  |___ \
//     / _ \| |  | |   / __| (_)   __) |
//    / ___ \ |__| |___\__ \  _   / __/
//   /_/   \_\____\____|___/ (_) |_____|
//
generate if (NUM_ACCs == 2) begin
  parameter [5:0]    FETCH  = 0, // 1
                     DECODE = 1, // 2
                     TYPEA  = 2, // 4
                     TYPEB  = 3, // 8
                     TYPEC  = 4, // 16
                     START  = 5; // 32
  reg       [5:0]    state, next;

  parameter [15:0]   ACC1  = 0, // 1
                     ACC2  = 1, // 2
                     ACC3  = 2, // 4
                     ACC4  = 3, // 8
                     ACC5  = 4, // 16
                     ACC6  = 5, // 32
                     ACC7  = 6, // 64
                     ACC8  = 7, // 128
                     DONE1 = 8,
                     DONE2 = 9,
                     DONE3 = 10,
                     DONE4 = 11,
                     DONE5 = 12,
                     DONE6 = 13,
                     DONE7 = 14,
                     DONE8 = 15;
  reg    [15:0]      state_acc, next_acc;

  reg    [31 : 0]    rcmd       ;
  reg                rmR_tvalid ;
  reg    [31 : 0]    rmR_tdata  ;

  reg    [ 3 : 0]    racc1_A1   ;
  reg    [ 3 : 0]    racc1_B1   ;
  reg    [ 3 : 0]    racc1_C1   ;
  reg    [15 : 0]    racc1_R1   ;
  reg    [15 : 0]    racc1_R2   ;
  reg    [15 : 0]    racc1_R3   ;
  reg                racc1_done ;

  reg    [ 3 : 0]    racc2_A1   ;
  reg    [ 3 : 0]    racc2_B1   ;
  reg    [ 3 : 0]    racc2_C1   ;
  reg    [15 : 0]    racc2_R1   ;
  reg    [15 : 0]    racc2_R2   ;
  reg    [15 : 0]    racc2_R3   ;
  reg                racc2_done ;

  wire   [ 3 : 0]    wOP        ;
  wire   [ 3 : 0]    wACCn      ;
  wire   [ 3 : 0]    wREGn      ;
  wire   [15 : 0]    wVALUE     ;
  wire   [ 3 : 0]    wVA        ;
  wire   [ 3 : 0]    wVB        ;
  wire   [ 3 : 0]    wVC        ;

  wire               w_tvalid   ;
  wire               w_tready   ;
  wire   [31 : 0]    w_tdata    ;

  wire   [1  : 0]    ws1_tready ;
  wire               mR1_tready ;
  wire               mR1_tvalid ;
  wire   [31 : 0]    mR1_tdata  ;
  wire               mR2_tready ;
  wire               mR2_tvalid ;
  wire   [31 : 0]    mR2_tdata  ;

  assign sR_tready = (state[FETCH] == 1);

  assign wOP       = rcmd[31:28] ;
  assign wACCn     = rcmd[27:24] ;
  assign wREGn     = rcmd[23:20] ;
  assign wVALUE    = rcmd[15: 0] ;

  assign wVA       = rcmd[ 3: 0] ;
  assign wVB       = rcmd[ 7: 4] ;
  assign wVC       = {(wVB == 3'b0) ? 2'b01 : 2'b10, (wVA == 3'b0) ? 2'b01 : 2'b10};

  // rcmd-----------------------------------------------------------------------
  always @(posedge ACLK) begin
    if (!ARESETN) begin
        rcmd <= 15'd0;
    end
    else begin
      if (state[FETCH] == 1 && sR_tvalid == 1)
        rcmd <= sR_tdata;
    end
  end
  // ---------------------------------------------------------------------------
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc1_done <= 1'b0;
    end
    else begin
      if (acc1_done)        racc1_done <= 1'b1;
      if (next_acc[DONE1])  racc1_done <= 1'b0;
    end
  end
  // ---------------------------------------------------------------------------
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc2_done <= 1'b0;
    end
    else begin
      if (acc2_done)        racc2_done <= 1'b1;
      if (next_acc[DONE2])  racc2_done <= 1'b0;
    end
  end
  // ---------------------------------------------------------------------------
  assign acc1_start = (state[TYPEA] && wACCn == 4'd1);
  assign acc2_start = (state[TYPEA] && wACCn == 4'd2);
  // ---------------------------------------------------------------------------
  assign acc1_A1 = racc1_A1 ;
  assign acc1_B1 = racc1_B1 ;
  assign acc1_C1 = racc1_C1 ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc1_A1 <= 4'd0;
      racc1_B1 <= 4'd0;
      racc1_C1 <= 4'd0;
    end
    else begin
      if (state[TYPEB] == 1'b1 && wACCn == 4'd1) begin
        racc1_A1 <= wVA;
        racc1_B1 <= wVB;
        racc1_C1 <= wVC;
      end
    end
  end
  // ---------------------------------------------------------------------------
  assign acc2_A1 = racc2_A1 ;
  assign acc2_B1 = racc2_B1 ;
  assign acc2_C1 = racc2_C1 ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc2_A1 <= 4'd0;
      racc2_B1 <= 4'd0;
      racc2_C1 <= 4'd0;
    end
    else begin
      if (state[TYPEB] == 1'b1 && wACCn == 4'd2) begin
        racc2_A1 <= wVA;
        racc2_B1 <= wVB;
        racc2_C1 <= wVC;
      end
    end
  end
  // ---------------------------------------------------------------------------
  assign acc1_R1   = racc1_R1    ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc1_R1 <= 16'd0;
    end
    else begin
      if (state[TYPEC] == 1'b1 && wACCn == 4'd1 && wREGn == 4'd1)
        racc1_R1 <= wVALUE;
    end
  end
  // ---------------------------------------------------------------------------
  assign acc1_R2   = racc1_R2    ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc1_R2 <= 16'd0;
    end
    else begin
      if (state[TYPEC] == 1'b1 && wACCn == 4'd1 && wREGn == 4'd2)
        racc1_R2 <= wVALUE;
    end
  end
  // ---------------------------------------------------------------------------
  assign acc1_R3   = racc1_R3    ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc1_R3 <= 16'd0;
    end
    else begin
      if (state[TYPEC] == 1'b1 && wACCn == 4'd1 && wREGn == 4'd3)
        racc1_R3 <= wVALUE;
    end
  end
  // ---------------------------------------------------------------------------
  assign acc2_R1   = racc2_R1    ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc2_R1 <= 16'd0;
    end
    else begin
      if (state[TYPEC] == 1'b1 && wACCn == 4'd2 && wREGn == 4'd1)
        racc2_R1 <= wVALUE;
    end
  end
  // ---------------------------------------------------------------------------
  assign acc2_R2   = racc2_R2    ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc2_R2 <= 16'd0;
    end
    else begin
      if (state[TYPEC] == 1'b1 && wACCn == 4'd2 && wREGn == 4'd2)
        racc2_R2 <= wVALUE;
    end
  end
  // ---------------------------------------------------------------------------
  assign acc2_R3   = racc2_R3    ;
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      racc2_R3 <= 16'd0;
    end
    else begin
      if (state[TYPEC] == 1'b1 && wACCn == 4'd2 && wREGn == 4'd3)
        racc2_R3 <= wVALUE;
    end
  end
  // FSM ACK--------------------------------------------------------------------
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      state        <=  7'b0;
      state[FETCH] <=  1'b1;
    end
    else state     <= next;
  end
  // FSM LOGICAL----------------------------------------------------------------
  always @(*) begin
    next = 6'b0;

    case (1'b1)
      state[FETCH] : begin
        if (sR_tvalid == 1) next[DECODE] = 1'b1;
        else                next[FETCH]  = 1'b1;
      end

      state[DECODE] : begin
        case(wOP)
          4'hA : begin
            next[TYPEA] = 1'b1;
          end
          4'hB : begin
            next[TYPEB] = 1'b1;
          end
          4'hC : begin
            next[TYPEC] = 1'b1;
          end
          default : begin
            next[FETCH] = 1'b1;
          end
        endcase
      end

      state[TYPEA] : begin
        next[FETCH] = 1'b1;
      end

      state[TYPEB] : begin
        next[FETCH] = 1'b1;
      end

      state[TYPEC] : begin
        next[FETCH] = 1'b1;
      end
    endcase
  end // End Always
  // ACC FSM ACK----------------------------------------------------------------
  always @(posedge ACLK) begin
    if (!ARESETN) begin
      state_acc        <=  16'b0;
      state_acc[ACC1]  <=   1'b1;
    end
    else state_acc     <= next_acc;
  end
  // ACC FSM LOGICAL------------------------------------------------------------
  always @(*) begin
    next_acc  = 16'b0;
    rmR_tdata = 32'h0;

    case (1'b1)
      state_acc[ACC1] : begin
        if (racc1_done) next_acc[DONE1] = 1'b1;
        else            next_acc[ACC2]  = 1'b1;
      end

      state_acc[ACC2] : begin
        if (racc2_done) next_acc[DONE2] = 1'b1;
        else            next_acc[ACC1]  = 1'b1;
      end

      // state_acc[ACC3] : begin
      //   if (acc3_done) next_acc[DONE3] = 1'b1;
      //   else           next_acc[ACC4] = 1'b1;
      // end

      // state_acc[ACC4] : begin
      //   if (acc4_done) next_acc[DONE4] = 1'b1;
      //   else           next_acc[ACC5] = 1'b1;
      // end

      // state_acc[ACC5] : begin
      //   if (acc5_done) next_acc[DONE5] = 1'b1;
      //   else           next_acc[ACC6] = 1'b1;
      // end

      // state_acc[ACC6] : begin
      //   if (acc6_done) next_acc[DONE6] = 1'b1;
      //   else           next_acc[ACC7] = 1'b1;
      // end

      // state_acc[ACC7] : begin
      //   if (acc7_done) next_acc[DONE7] = 1'b1;
      //   else           next_acc[ACC8] = 1'b1;
      // end

      // state_acc[ACC8] : begin
      //   if (acc8_done) next_acc[DONE8] = 1'b1;
      //   else           next_acc[ACC1] = 1'b1;
      // end

      state_acc[DONE1] : begin
        if (w_tready)  next_acc[ACC2]  = 1'b1;
        else           next_acc[DONE1] = 1'b1;
      end

      state_acc[DONE2] : begin
        if (w_tready)  next_acc[ACC1]  = 1'b1;
        else           next_acc[DONE2] = 1'b1;
      end

      // state_acc[DONE3] : begin
      //   next_acc[ACC4] = 1'b1;
      // end

      // state_acc[DONE4] : begin
      //   next_acc[ACC5] = 1'b1;
      // end

      // state_acc[DONE5] : begin
      //   next_acc[ACC6] = 1'b1;
      // end

      // state_acc[DONE6] : begin
      //   next_acc[ACC7] = 1'b1;
      // end

      // state_acc[DONE7] : begin
      //   next_acc[ACC8] = 1'b1;
      // end

      // state_acc[DONE8] : begin
      //   next_acc[ACC1] = 1'b1;
      // end
    endcase
  end
  // ---------------------------------------------------------------------------
  assign w_tdata  = rmR_tdata  ;
  always @(*) begin
    rmR_tdata = 32'd0;

    case (1'b1)
      next_acc[DONE1] : rmR_tdata = 32'hBABE0001;
      next_acc[DONE2] : rmR_tdata = 32'hBABE0002;
      // state_acc[DONE3] : rmR_tdata = 32'hBABE0003;
      // state_acc[DONE4] : rmR_tdata = 32'hBABE0004;
      // state_acc[DONE5] : rmR_tdata = 32'hBABE0005;
      // state_acc[DONE6] : rmR_tdata = 32'hBABE0006;
      // state_acc[DONE7] : rmR_tdata = 32'hBABE0007;
      // state_acc[DONE8] : rmR_tdata = 32'hBABE0008;
    endcase
  end
  // ---------------------------------------------------------------------------
  // assign mR_tvalid  = rmR_tvalid ;
  // assign mR_tvalid = (next_acc[DONE1] || next_acc[DONE2]);
  assign w_tvalid = (next_acc[DONE1] || next_acc[DONE2]);
  // ---------------------------------------------------------------------------

  jit_fifo u_axis_fifo(
    .s_aclk         (ACLK                     ),
    .s_aresetn      (ARESETN                  ),
    .s_axis_tvalid  (w_tvalid                 ),
    .s_axis_tready  (w_tready                 ),
    .s_axis_tdata   (w_tdata                  ),
    .m_axis_tready  (mR_tready                ),
    .m_axis_tvalid  (mR_tvalid                ),
    .m_axis_tdata   (mR_tdata                 )
  );

end // NUM_ACCs == 2
endgenerate

endmodule










  //   case (1'b1)
  //     state[FETCH] : begin
  //       if (sR_tvalid == 0) begin
  //         next[FETCH] = 1'b1;
  //       end
  //       else begin
  //         rcmd       = sR_tdata;
  //         case (sR_tdata[31:28])
  //           4'hA : begin
  //             next[TYPEA] = 1'b1;
  //           end

  //           4'hB : begin
  //             next[TYPEB] = 1'b1;
  //           end

  //           4'hC : begin
  //             next[TYPEC] = 1'b1;
  //           end
  //         endcase

  //       end
  //     end

  //     state[TYPEA] : begin
  //       case (rcmd[27:24])
  //         4'h1 : begin
  //           rCONFD1      = rcmd;
  //           next[START]  = 1'b1;
  //         end

  //         4'h2 : begin
  //           rCONFD2      = rcmd;
  //           next[START]  = 1'b1;
  //         end
  //       endcase
  //     end

  //     state[START] : begin
  //       case (rcmd[27:24])
  //         4'h1 : begin
  //           if (!CDONE1) next[START] = 1'b1;
  //           else begin
  //             rmR_tvalid  = 1'b1;
  //             rmR_tdata   = {16'hBABE, 16'h0001};
  //             next[FETCH] = 1'b1;
  //           end
  //         end

  //         4'h2 : begin
  //           if (!CDONE2) next[START] = 1'b1;
  //           else begin
  //             rmR_tvalid  = 1'b1;
  //             rmR_tdata   = {16'hBABE, 16'h0002};
  //             next[FETCH] = 1'b1;
  //           end
  //         end

  //       endcase
  //     end

  //     state[TYPEB] : begin
  //       case (rcmd[27:24])
  //         4'h1 : begin
  //           rCONFA1 = rcmd[ 3:0];
  //           rCONFB1 = rcmd[ 7:4];
  //           rCONFC1 = {(rcmd[ 7:4] == 3'b0) ? 2'b01 : 2'b10, (rcmd[ 3:0] == 3'b0) ? 2'b01 : 2'b10};
  //           next[FETCH] = 1'b1;
  //         end

  //         4'h2 : begin
  //           rCONFA2 = rcmd[ 3:0];
  //           rCONFB2 = rcmd[ 7:4];
  //           rCONFC2 = {(rcmd[ 7:4] == 3'b0) ? 2'b01 : 2'b10, (rcmd[ 3:0] == 3'b0) ? 2'b01 : 2'b10};
  //           next[FETCH] = 1'b1;
  //         end

  //         default : begin
  //           rCONFA1      = 4'd0;
  //           rCONFB1      = 4'd0;
  //           rCONFC1      = 4'd0;
  //           rCONFA2      = 4'd0;
  //           rCONFB2      = 4'd0;
  //           rCONFC2      = 4'd0;
  //           next[FETCH]  = 1'b1;
  //         end
  //       endcase
  //     end

  //     state[TYPEC] : begin
  //       case (rcmd[27:24])
  //         4'h1 : begin
  //           rCONFD1      = rcmd;
  //           next[FETCH]  = 1'b1;
  //         end

  //         4'h2 : begin
  //           rCONFD2      = rcmd;
  //           next[FETCH]  = 1'b1;
  //         end

  //         default : begin
  //           rCONFD1      = 32'd0;
  //           rCONFD2      = 32'd0;
  //           next[FETCH]  =  1'b1;
  //         end
  //       endcase
  //     end
    // endcase
  // end













/*
`timescale 1ns / 1ps

module jit_dispatch #(
  parameter integer NUM_ACCs = 2
)
(
  output  wire             sR_tready  ,
  input   wire             sR_tvalid  ,
  input   wire  [31 : 0]   sR_tdata   ,

  input   wire             mR_tready  ,
  output  wire             mR_tvalid  ,
  output  wire  [31 : 0]   mR_tdata   ,

  output  wire  [ 3 : 0]   CONFA1     ,
  output  wire  [ 3 : 0]   CONFB1     ,
  output  wire  [ 3 : 0]   CONFC1     ,
  output  wire  [31 : 0]   CONFD1     ,
  input   wire             CDONE1     ,

  output  wire  [ 3 : 0]   CONFA2     ,
  output  wire  [ 3 : 0]   CONFB2     ,
  output  wire  [ 3 : 0]   CONFC2     ,
  output  wire  [31 : 0]   CONFD2     ,
  input   wire             CDONE2     ,

  output  wire  [ 3 : 0]   CONFA3     ,
  output  wire  [ 3 : 0]   CONFB3     ,
  output  wire  [ 3 : 0]   CONFC3     ,
  output  wire  [31 : 0]   CONFD3     ,
  input   wire             CDONE3     ,

  output  wire  [ 3 : 0]   CONFA4     ,
  output  wire  [ 3 : 0]   CONFB4     ,
  output  wire  [ 3 : 0]   CONFC4     ,
  output  wire  [31 : 0]   CONFD4     ,
  input   wire             CDONE4     ,

  output  wire  [ 3 : 0]   CONFA5     ,
  output  wire  [ 3 : 0]   CONFB5     ,
  output  wire  [ 3 : 0]   CONFC5     ,
  output  wire  [31 : 0]   CONFD5     ,
  input   wire             CDONE5     ,

  output  wire  [ 3 : 0]   CONFA6     ,
  output  wire  [ 3 : 0]   CONFB6     ,
  output  wire  [ 3 : 0]   CONFC6     ,
  output  wire  [31 : 0]   CONFD6     ,
  input   wire             CDONE6     ,

  output  wire  [ 3 : 0]   CONFA7     ,
  output  wire  [ 3 : 0]   CONFB7     ,
  output  wire  [ 3 : 0]   CONFC7     ,
  output  wire  [31 : 0]   CONFD7     ,
  input   wire             CDONE7     ,

  output  wire  [ 3 : 0]   CONFA8     ,
  output  wire  [ 3 : 0]   CONFB8     ,
  output  wire  [ 3 : 0]   CONFC8     ,
  output  wire  [31 : 0]   CONFD8     ,
  input   wire             CDONE8     ,

  input   wire             ACLK       ,
  input   wire             ARESETN
);

  parameter [4:0] FETCH = 0, // 1
                  TYPEA = 1, // 2
                  TYPEB = 2, // 4
                  TYPEC = 3, // 8
                  START = 4; // 16
                  // IDLE  = 5; // 32
  reg       [4:0] state, next;
  reg    [31 : 0] rcmd       ;

  assign          sR_tready = (state[FETCH] == 1);
//       _    ____ ____           ____
//      / \  / ___/ ___|___   _  |___ \
//     / _ \| |  | |   / __| (_)   __) |
//    / ___ \ |__| |___\__ \  _   / __/
//   /_/   \_\____\____|___/ (_) |_____|
//
generate if (NUM_ACCs == 2) begin

  reg           rmR_tvalid;
  reg  [31: 0]  rmR_tdata;
  reg  [3 : 0]  rCONFA1;
  reg  [3 : 0]  rCONFB1;
  reg  [3 : 0]  rCONFC1;
  reg  [31: 0]  rCONFD1;

  reg  [3 : 0]  rCONFA2;
  reg  [3 : 0]  rCONFB2;
  reg  [3 : 0]  rCONFC2;
  reg  [31: 0]  rCONFD2;

  assign mR_tvalid = rmR_tvalid;
  assign mR_tdata  = rmR_tdata;

  assign CONFA1 = rCONFA1;
  assign CONFB1 = rCONFB1;
  assign CONFC1 = rCONFC1;
  assign CONFD1 = rCONFD1;

  assign CONFA2 = rCONFA2;
  assign CONFB2 = rCONFB2;
  assign CONFC2 = rCONFC2;
  assign CONFD2 = rCONFD2;

  always @(posedge ACLK) begin
    if (!ARESETN) begin
      state        <=  5'b0;
      state[FETCH] <=  1'b1;
      rcmd         <= 32'd0;
      rmR_tvalid   <=  1'b0;
      rmR_tdata    <= 32'd0;

      rCONFA1      <=  4'd0;
      rCONFB1      <=  4'd0;
      rCONFC1      <=  4'd0;
      rCONFD1      <= 32'd0;

      rCONFA2      <=  4'd0;
      rCONFB2      <=  4'd0;
      rCONFC2      <=  4'd0;
      rCONFD2      <= 32'd0;
    end
    else state     <= next;
  end

  always @(*) begin
    next = 5'b0;

    case (1'b1)
      state[FETCH] : begin
        if (sR_tvalid == 0) begin
          next[FETCH] = 1'b1;
        end
        else begin
          rcmd       = sR_tdata;
          case (sR_tdata[31:28])
            4'hA : begin
              next[TYPEA] = 1'b1;
            end

            4'hB : begin
              next[TYPEB] = 1'b1;
            end

            4'hC : begin
              next[TYPEC] = 1'b1;
            end
          endcase

        end
      end

      state[TYPEA] : begin
        case (rcmd[27:24])
          4'h1 : begin
            rCONFD1      = rcmd;
            next[START]  = 1'b1;
          end

          4'h2 : begin
            rCONFD2      = rcmd;
            next[START]  = 1'b1;
          end
        endcase
      end

      state[START] : begin
        case (rcmd[27:24])
          4'h1 : begin
            if (!CDONE1) next[START] = 1'b1;
            else begin
              rmR_tvalid  = 1'b1;
              rmR_tdata   = {16'hBABE, 16'h0001};
              next[FETCH] = 1'b1;
            end
          end

          4'h2 : begin
            if (!CDONE2) next[START] = 1'b1;
            else begin
              rmR_tvalid  = 1'b1;
              rmR_tdata   = {16'hBABE, 16'h0002};
              next[FETCH] = 1'b1;
            end
          end

        endcase
      end

      state[TYPEB] : begin
        case (rcmd[27:24])
          4'h1 : begin
            rCONFA1 = rcmd[ 3:0];
            rCONFB1 = rcmd[ 7:4];
            rCONFC1 = {(rcmd[ 7:4] == 3'b0) ? 2'b01 : 2'b10, (rcmd[ 3:0] == 3'b0) ? 2'b01 : 2'b10};
            next[FETCH] = 1'b1;
          end

          4'h2 : begin
            rCONFA2 = rcmd[ 3:0];
            rCONFB2 = rcmd[ 7:4];
            rCONFC2 = {(rcmd[ 7:4] == 3'b0) ? 2'b01 : 2'b10, (rcmd[ 3:0] == 3'b0) ? 2'b01 : 2'b10};
            next[FETCH] = 1'b1;
          end

          default : begin
            rCONFA1      = 4'd0;
            rCONFB1      = 4'd0;
            rCONFC1      = 4'd0;
            rCONFA2      = 4'd0;
            rCONFB2      = 4'd0;
            rCONFC2      = 4'd0;
            next[FETCH]  = 1'b1;
          end
        endcase
      end

      state[TYPEC] : begin
        case (rcmd[27:24])
          4'h1 : begin
            rCONFD1      = rcmd;
            next[FETCH]  = 1'b1;
          end

          4'h2 : begin
            rCONFD2      = rcmd;
            next[FETCH]  = 1'b1;
          end

          default : begin
            rCONFD1      = 32'd0;
            rCONFD2      = 32'd0;
            next[FETCH]  =  1'b1;
          end
        endcase
      end

    endcase
  end












end // NUM_ACCs == 2
endgenerate

endmodule

*/
