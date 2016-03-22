`timescale 1ns / 1ps

module jit_cmd #(
  parameter integer ACC_KEY = 0
)
(
  output  wire             sR_tready  ,
  input   wire             sR_tvalid  ,
  input   wire  [31 : 0]   sR_tdata   ,

  input   wire             mR_tready  ,
  output  wire             mR_tvalid  ,
  output  wire  [31 : 0]   mR_tdata   ,

  output  wire  [ 3 : 0]   CONFA      ,
  output  wire  [ 3 : 0]   CONFB      ,
  output  wire  [ 3 : 0]   CONFC      ,

  input   wire             ACLK       ,
  input   wire             ARESETN
);
  //     ____________________________
  //     |                          |
  // <---| sRx_tready    mRx_tready |<---
  // --->| sRx_tvalid    mRx_tvalid |--->
  // --->| sRx_tdata     mRx_tdata  |--->
  //     |__________________________|
  reg  [3 : 0]  rCONFA;
  reg  [3 : 0]  rCONFB;
  reg  [3 : 0]  rCONFC;
  wire          mine;

  assign        mine      = (sR_tdata[11 : 8] == ACC_KEY);
  assign        mR_tdata  = mine ? ACC_KEY : sR_tdata;
  assign        sR_tready = state[GET];
  assign        mR_tvalid = state[PUT];

  assign        CONFA     = rCONFA;
  assign        CONFB     = rCONFB;
  assign        CONFC     = rCONFC;

  parameter [1:0] GET  = 0,
                  PUT  = 1;
  reg [1:0]       state, next;

  always @(posedge ACLK) begin
    if (!ARESETN) begin
      state       <= 2'b0;
      state[GET]  <= 1'b1;
    end
    else state    <= next;
  end

  always @(*) begin
    next = 2'b0;

    case (1'b1)
      state[GET]: begin
        if (sR_tvalid)  next[PUT]  = 1'b1;
        else            next[GET]  = 1'b1;
      end

      state[PUT]: begin
        if (mR_tready)  next[GET]  = 1'b1;
        else            next[PUT]  = 1'b1;
      end
    endcase
  end

  always @(posedge ACLK) begin
    if (!ARESETN) begin
      rCONFA <= 4'd0;
      rCONFB <= 4'd0;
      rCONFC <= 4'd0;
    end
    else begin
      if (mine && state[PUT]) begin
        rCONFA <= sR_tdata[ 3:0];
        rCONFB <= sR_tdata[ 7:4];
        rCONFC <= {(sR_tdata[ 7:4] == 3'b0) ? 2'b01 : 2'b10, (sR_tdata[ 3:0] == 3'b0) ? 2'b01 : 2'b10};
      end
    end
  end

endmodule
