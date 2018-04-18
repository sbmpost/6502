/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : fsm_next                                                     **
 **                                                                          **
 ******************************************************************************/

module fsm_next( CI,
                 CLK,
                 IMM,
                 LOGISIM_CLOCK_TREE_0,
                 R,
                 ZP,
                 ZPY,
                 S0,
                 SCO,
                 SHI,
                 SIN,
                 SLO,
                 SLR,
                 SOP);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  CI;
   input  CLK;
   input  IMM;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input  R;
   input  ZP;
   input  ZPY;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output S0;
   output SCO;
   output SHI;
   output SIN;
   output SLO;
   output SLR;
   output SOP;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[5:0] s_LOGISIM_BUS_28;
   wire[5:0] s_LOGISIM_BUS_34;
   wire s_LOGISIM_NET_0;
   wire s_LOGISIM_NET_10;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_13;
   wire s_LOGISIM_NET_14;
   wire s_LOGISIM_NET_15;
   wire s_LOGISIM_NET_16;
   wire s_LOGISIM_NET_17;
   wire s_LOGISIM_NET_18;
   wire s_LOGISIM_NET_20;
   wire s_LOGISIM_NET_21;
   wire s_LOGISIM_NET_22;
   wire s_LOGISIM_NET_23;
   wire s_LOGISIM_NET_24;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_29;
   wire s_LOGISIM_NET_31;
   wire s_LOGISIM_NET_32;
   wire s_LOGISIM_NET_33;
   wire s_LOGISIM_NET_35;
   wire s_LOGISIM_NET_8;
   wire s_LOGISIM_NET_9;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_NET_29                   = R;
   assign s_LOGISIM_NET_0                    = ZPY;
   assign s_LOGISIM_NET_24                   = CI;
   assign s_LOGISIM_NET_15                   = CLK;
   assign s_LOGISIM_NET_8                    = ZP;
   assign s_LOGISIM_NET_20                   = IMM;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign SLR                                = s_LOGISIM_BUS_28[5];
   assign SHI                                = s_LOGISIM_BUS_28[3];
   assign SCO                                = s_LOGISIM_BUS_28[4];
   assign S0                                 = s_LOGISIM_NET_21;
   assign SLO                                = s_LOGISIM_BUS_28[1];
   assign SOP                                = s_LOGISIM_BUS_28[0];
   assign SIN                                = s_LOGISIM_BUS_28[2];

   /***************************************************************************
    ** Here all in-lined components are defined                              **
    ***************************************************************************/
   assign s_LOGISIM_NET_35 = 1'd1;


   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   OR_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_BUS_28[4]),
              .Input_2(s_LOGISIM_NET_9),
              .Input_3(s_LOGISIM_NET_12),
              .Input_4(s_LOGISIM_NET_10),
              .Result(s_LOGISIM_BUS_34[5]));

   OR_GATE #(.BubblesMask(0))
      GATE_2 (.Input_1(s_LOGISIM_BUS_28[2]),
              .Input_2(s_LOGISIM_NET_26),
              .Result(s_LOGISIM_BUS_34[3]));

   AND_GATE #(.BubblesMask(0))
      GATE_3 (.Input_1(s_LOGISIM_BUS_28[1]),
              .Input_2(s_LOGISIM_NET_8),
              .Result(s_LOGISIM_NET_12));

   NOT_GATE      GATE_4 (.Input_1(s_LOGISIM_NET_8),
                         .Result(s_LOGISIM_NET_17));

   NOT_GATE      GATE_5 (.Input_1(s_LOGISIM_BUS_28[5]),
                         .Result(s_LOGISIM_NET_22));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(6))
      REGISTER_FILE_1 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_35),
                       .D(s_LOGISIM_BUS_34[5:0]),
                       .Q(s_LOGISIM_BUS_28[5:0]),
                       .Reset(s_LOGISIM_NET_29),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   NOT_GATE      GATE_6 (.Input_1(s_LOGISIM_BUS_28[4]),
                         .Result(s_LOGISIM_NET_13));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_7 (.Input_1(s_LOGISIM_BUS_28[1]),
              .Input_2(s_LOGISIM_NET_33),
              .Input_3(s_LOGISIM_NET_17),
              .Result(s_LOGISIM_NET_26));

   NOT_GATE      GATE_8 (.Input_1(s_LOGISIM_BUS_28[1]),
                         .Result(s_LOGISIM_NET_14));

   AND_GATE_6_INPUTS #(.BubblesMask(0))
      GATE_9 (.Input_1(s_LOGISIM_NET_32),
              .Input_2(s_LOGISIM_NET_14),
              .Input_3(s_LOGISIM_NET_23),
              .Input_4(s_LOGISIM_NET_31),
              .Input_5(s_LOGISIM_NET_13),
              .Input_6(s_LOGISIM_NET_22),
              .Result(s_LOGISIM_NET_21));

   OR_GATE #(.BubblesMask(0))
      GATE_10 (.Input_1(s_LOGISIM_NET_21),
               .Input_2(s_LOGISIM_BUS_28[5]),
               .Result(s_LOGISIM_BUS_34[0]));

   NOT_GATE      GATE_11 (.Input_1(s_LOGISIM_BUS_28[0]),
                          .Result(s_LOGISIM_NET_32));

   NOT_GATE      GATE_12 (.Input_1(s_LOGISIM_NET_20),
                          .Result(s_LOGISIM_NET_18));

   NOT_GATE      GATE_13 (.Input_1(s_LOGISIM_BUS_28[3]),
                          .Result(s_LOGISIM_NET_31));

   AND_GATE #(.BubblesMask(0))
      GATE_14 (.Input_1(s_LOGISIM_BUS_28[0]),
               .Input_2(s_LOGISIM_NET_20),
               .Result(s_LOGISIM_NET_10));

   AND_GATE #(.BubblesMask(0))
      GATE_15 (.Input_1(s_LOGISIM_BUS_28[3]),
               .Input_2(s_LOGISIM_NET_24),
               .Result(s_LOGISIM_BUS_34[4]));

   AND_GATE #(.BubblesMask(0))
      GATE_16 (.Input_1(s_LOGISIM_BUS_28[0]),
               .Input_2(s_LOGISIM_NET_18),
               .Result(s_LOGISIM_BUS_34[1]));

   NOT_GATE      GATE_17 (.Input_1(s_LOGISIM_NET_0),
                          .Result(s_LOGISIM_NET_33));

   AND_GATE #(.BubblesMask(0))
      GATE_18 (.Input_1(s_LOGISIM_BUS_28[3]),
               .Input_2(s_LOGISIM_NET_16),
               .Result(s_LOGISIM_NET_9));

   NOT_GATE      GATE_19 (.Input_1(s_LOGISIM_NET_24),
                          .Result(s_LOGISIM_NET_16));

   NOT_GATE      GATE_20 (.Input_1(s_LOGISIM_BUS_28[2]),
                          .Result(s_LOGISIM_NET_23));

   AND_GATE #(.BubblesMask(0))
      GATE_21 (.Input_1(s_LOGISIM_BUS_28[1]),
               .Input_2(s_LOGISIM_NET_0),
               .Result(s_LOGISIM_BUS_34[2]));



endmodule
