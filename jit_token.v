`timescale 1ns / 1ps

module jit_token(
  input  wire  [31 : 0]  cmd      ,
  output wire            done     ,
  input  wire            ap_done  ,
  input  wire            ap_idle  ,
  input  wire            ap_ready ,

  output wire            ap_start ,
  output wire  [15 : 0]  arg1_V   ,
  output wire  [15 : 0]  arg2_V   ,
  output wire  [15 : 0]  arg3_V   ,

  input  wire            ap_clk   ,
  input  wire            ap_rst_n
);

  parameter [5:0] FETCH = 0, // 1
                  ARG1  = 1, // 2
                  ARG2  = 2, // 4
                  ARG3  = 3, // 8
                  START = 4, // 16
                  IDLE  = 5; // 32
  reg       [5:0] state, next;
  reg  [31 : 0]   rcmd   ;
  reg  [15 : 0]   rarg1_V;
  reg  [15 : 0]   rarg2_V;
  reg  [15 : 0]   rarg3_V;

  assign done     = ap_done ;
  assign ap_start = ((state[START] == 1'b1) || (state[IDLE] == 1'b1));
  // ---------------------------------------------------------------------------
  assign arg1_V   = rarg1_V;
  // always @(posedge ap_clk) begin
  //   if (!ap_rst_n) begin
  //     rarg1_V <= 15'd0;
  //   end
  //   else begin
  //     if (state[ARG1]) rarg1_V <= rcmd[15:0];
  //     else             rarg1_V <= rarg1_V;
  //   end
  // end
  // // ---------------------------------------------------------------------------
  assign arg2_V   = rarg2_V;
  // always @(posedge ap_clk) begin
  //   if (!ap_rst_n) begin
  //     rarg2_V <= 15'd0;
  //   end
  //   else begin
  //     if (state[ARG2]) rarg2_V <= rcmd[15:0];
  //     else             rarg2_V <= rarg2_V;
  //   end
  // end
  // // ---------------------------------------------------------------------------
  assign arg3_V   = rarg3_V;
  // always @(posedge ap_clk) begin
  //   if (!ap_rst_n) begin
  //     rarg3_V <= 15'd0;
  //   end
  //   else begin
  //     if (state[ARG3]) rarg3_V <= rcmd[15:0];
  //     else             rarg3_V <= rarg3_V;
  //   end
  // end
  // ---------------------------------------------------------------------------
  always @(posedge ap_clk) begin
    if (!ap_rst_n) begin
      state        <= 5'b0;
      state[FETCH] <= 1'b1;
      rcmd         <= 32'd0;
      rarg1_V      <= 16'd0;
      rarg2_V      <= 16'd0;
      rarg3_V      <= 16'd0;
    end
    else state     <= next;
  end

  always @(*) begin
    next = 5'b0;

    case (1'b1)
      state[FETCH] : begin
        if (!cmd)  next[FETCH] = 1'b1;
        else begin
          case (cmd[31:28])
            4'hA : begin //Go Command
              if (ap_idle) begin
                next[START]    = 1'b1;
              end
              else begin
                next[IDLE]     = 1'b1;
              end
            end

            4'hB : begin // Configue Switch
            // Not gona happend
            end

            4'hC : begin // setup Args
              rcmd             = cmd ;
              next[cmd[23:20]] = 1'b1;
            end
          endcase
        end
      end

      state[START] : begin
        if (!ap_done) next[START] = 1'b1;
        else begin
          rcmd        = 32'd0;
          next[FETCH] = 1'b1;
        end
      end

      state[IDLE] : begin
        if (ap_idle)  next[START] = 1'b1;
        else          next[IDLE]  = 1'b1;
      end

      state[ARG1] : begin
        rarg1_V = rcmd[15:0];
        next[FETCH] = 1'b1;
      end

      state[ARG2] : begin
        rarg2_V = rcmd[15:0];
        next[FETCH] = 1'b1;
      end

      state[ARG3] : begin
        rarg3_V = rcmd[15:0];
        next[FETCH] = 1'b1;
      end

    endcase
  end

endmodule
