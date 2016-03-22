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
