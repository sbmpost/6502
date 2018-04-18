/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : pc                                                           **
 **                                                                          **
 ******************************************************************************/

module pc( CI,
           CLK,
           HI,
           INC,
           LO,
           LOGISIM_CLOCK_TREE_0,
           R,
           WR,
           CO,
           PC);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  CI;
   input  CLK;
   input[7:0]  HI;
   input  INC;
   input[7:0]  LO;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input  R;
   input  WR;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output CO;
   output[15:0] PC;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[7:0] s_LOGISIM_BUS_16;
   wire[7:0] s_LOGISIM_BUS_20;
   wire[7:0] s_LOGISIM_BUS_21;
   wire[7:0] s_LOGISIM_BUS_22;
   wire[15:0] s_LOGISIM_BUS_23;
   wire[7:0] s_LOGISIM_BUS_28;
   wire[7:0] s_LOGISIM_BUS_29;
   wire[7:0] s_LOGISIM_BUS_3;
   wire s_LOGISIM_NET_10;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_13;
   wire s_LOGISIM_NET_14;
   wire s_LOGISIM_NET_15;
   wire s_LOGISIM_NET_17;
   wire s_LOGISIM_NET_18;
   wire s_LOGISIM_NET_2;
   wire s_LOGISIM_NET_24;
   wire s_LOGISIM_NET_25;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_27;
   wire s_LOGISIM_NET_30;
   wire s_LOGISIM_NET_4;
   wire s_LOGISIM_NET_5;
   wire s_LOGISIM_NET_7;
   wire s_LOGISIM_NET_8;
   wire s_LOGISIM_NET_9;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_NET_2                    = R;
   assign s_LOGISIM_NET_7                    = CI;
   assign s_LOGISIM_NET_15                   = CLK;
   assign s_LOGISIM_BUS_29[7:0]              = HI;
   assign s_LOGISIM_NET_4                    = WR;
   assign s_LOGISIM_BUS_28[7:0]              = LO;
   assign s_LOGISIM_NET_10                   = INC;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign CO                                 = s_LOGISIM_NET_5;
   assign PC                                 = s_LOGISIM_BUS_23[15:0];

   /***************************************************************************
    ** Here all in-lined components are defined                              **
    ***************************************************************************/
   assign s_LOGISIM_BUS_20[7:1] = 7'd0;

   assign s_LOGISIM_NET_30 = 1'd1;


   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_1 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_25),
                       .D(s_LOGISIM_BUS_21[7:0]),
                       .Q(s_LOGISIM_BUS_23[15:8]),
                       .Reset(s_LOGISIM_NET_2),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   Adder #(.ExtendedBits(9),
           .NrOfBits(8))
      ADDER2C_1 (.CarryIn(s_LOGISIM_NET_5),
                 .CarryOut(s_LOGISIM_NET_17),
                 .DataA(s_LOGISIM_BUS_16[7:0]),
                 .DataB(s_LOGISIM_BUS_20[7:0]),
                 .Result(s_LOGISIM_BUS_3[7:0]));

   AND_GATE #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_NET_11),
              .Input_2(s_LOGISIM_NET_13),
              .Result(s_LOGISIM_NET_27));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(1))
      REGISTER_FILE_2 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_30),
                       .D(s_LOGISIM_NET_27),
                       .Q(s_LOGISIM_NET_5),
                       .Reset(s_LOGISIM_NET_2),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_1 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_23[15:8]),
             .MuxIn_1(s_LOGISIM_BUS_23[7:0]),
             .MuxOut(s_LOGISIM_BUS_16[7:0]),
             .Sel(s_LOGISIM_BUS_20[0]));

   AND_GATE #(.BubblesMask(0))
      GATE_2 (.Input_1(s_LOGISIM_NET_17),
              .Input_2(s_LOGISIM_NET_14),
              .Result(s_LOGISIM_NET_18));

   Multiplexer_2      MUX_2 (.Enable(1'b1),
                             .MuxIn_0(s_LOGISIM_NET_18),
                             .MuxIn_1(s_LOGISIM_NET_7),
                             .MuxOut(s_LOGISIM_NET_11),
                             .Sel(s_LOGISIM_NET_4));

   NOT_GATE      GATE_3 (.Input_1(s_LOGISIM_NET_5),
                         .Result(s_LOGISIM_NET_14));

   OR_GATE #(.BubblesMask(0))
      GATE_4 (.Input_1(s_LOGISIM_NET_9),
              .Input_2(s_LOGISIM_NET_4),
              .Result(s_LOGISIM_NET_26));

   NOT_GATE      GATE_5 (.Input_1(s_LOGISIM_BUS_20[0]),
                         .Result(s_LOGISIM_NET_8));

   NOT_GATE      GATE_6 (.Input_1(s_LOGISIM_NET_4),
                         .Result(s_LOGISIM_NET_24));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_3 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_3[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_28[7:0]),
             .MuxOut(s_LOGISIM_BUS_22[7:0]),
             .Sel(s_LOGISIM_NET_4));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_4 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_3[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_29[7:0]),
             .MuxOut(s_LOGISIM_BUS_21[7:0]),
             .Sel(s_LOGISIM_NET_4));

   NOT_GATE      GATE_7 (.Input_1(s_LOGISIM_NET_5),
                         .Result(s_LOGISIM_NET_12));

   OR_GATE #(.BubblesMask(0))
      GATE_8 (.Input_1(s_LOGISIM_NET_4),
              .Input_2(s_LOGISIM_NET_10),
              .Result(s_LOGISIM_NET_13));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_3 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_26),
                       .D(s_LOGISIM_BUS_22[7:0]),
                       .Q(s_LOGISIM_BUS_23[7:0]),
                       .Reset(s_LOGISIM_NET_2),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   AND_GATE #(.BubblesMask(0))
      GATE_9 (.Input_1(s_LOGISIM_NET_24),
              .Input_2(s_LOGISIM_NET_12),
              .Result(s_LOGISIM_BUS_20[0]));

   OR_GATE #(.BubblesMask(0))
      GATE_10 (.Input_1(s_LOGISIM_NET_8),
               .Input_2(s_LOGISIM_NET_4),
               .Result(s_LOGISIM_NET_25));

   AND_GATE #(.BubblesMask(0))
      GATE_11 (.Input_1(s_LOGISIM_NET_13),
               .Input_2(s_LOGISIM_BUS_20[0]),
               .Result(s_LOGISIM_NET_9));



endmodule
