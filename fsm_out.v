/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : fsm_out                                                      **
 **                                                                          **
 ******************************************************************************/

module fsm_out( AB,
                CI,
                GR,
                ID,
                LD,
                LOGISIM_CLOCK_TREE_0,
                OPC,
                S0,
                SCO,
                SHI,
                SIN,
                SLO,
                SLR,
                SOP,
                XY,
                ZP,
                ZPY,
                ACO,
                ADR,
                ALU,
                AOP,
                INC,
                LCO,
                MHI,
                MLO,
                PRV,
                rX,
                rY,
                wA,
                wL,
                wO,
                wX,
                wY);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  AB;
   input  CI;
   input[1:0]  GR;
   input  ID;
   input  LD;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input[2:0]  OPC;
   input  S0;
   input  SCO;
   input  SHI;
   input  SIN;
   input  SLO;
   input  SLR;
   input  SOP;
   input  XY;
   input  ZP;
   input  ZPY;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output ACO;
   output ADR;
   output ALU;
   output[5:0] AOP;
   output INC;
   output LCO;
   output MHI;
   output MLO;
   output PRV;
   output rX;
   output rY;
   output wA;
   output wL;
   output wO;
   output wX;
   output wY;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[1:0] s_LOGISIM_BUS_15;
   wire[5:0] s_LOGISIM_BUS_29;
   wire[5:0] s_LOGISIM_BUS_32;
   wire[1:0] s_LOGISIM_BUS_45;
   wire[5:0] s_LOGISIM_BUS_46;
   wire s_LOGISIM_NET_0;
   wire s_LOGISIM_NET_1;
   wire s_LOGISIM_NET_10;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_13;
   wire s_LOGISIM_NET_14;
   wire s_LOGISIM_NET_16;
   wire s_LOGISIM_NET_17;
   wire s_LOGISIM_NET_18;
   wire s_LOGISIM_NET_2;
   wire s_LOGISIM_NET_20;
   wire s_LOGISIM_NET_21;
   wire s_LOGISIM_NET_22;
   wire s_LOGISIM_NET_23;
   wire s_LOGISIM_NET_24;
   wire s_LOGISIM_NET_25;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_27;
   wire s_LOGISIM_NET_28;
   wire s_LOGISIM_NET_3;
   wire s_LOGISIM_NET_30;
   wire s_LOGISIM_NET_34;
   wire s_LOGISIM_NET_35;
   wire s_LOGISIM_NET_36;
   wire s_LOGISIM_NET_37;
   wire s_LOGISIM_NET_38;
   wire s_LOGISIM_NET_39;
   wire s_LOGISIM_NET_4;
   wire s_LOGISIM_NET_40;
   wire s_LOGISIM_NET_41;
   wire s_LOGISIM_NET_42;
   wire s_LOGISIM_NET_43;
   wire s_LOGISIM_NET_44;
   wire s_LOGISIM_NET_5;
   wire s_LOGISIM_NET_6;
   wire s_LOGISIM_NET_7;
   wire s_LOGISIM_NET_8;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_NET_2                    = SHI;
   assign s_LOGISIM_NET_14                   = XY;
   assign s_LOGISIM_NET_21                   = SCO;
   assign s_LOGISIM_NET_26                   = SLO;
   assign s_LOGISIM_NET_18                   = S0;
   assign s_LOGISIM_NET_23                   = CI;
   assign s_LOGISIM_NET_16                   = SOP;
   assign s_LOGISIM_NET_5                    = ZPY;
   assign s_LOGISIM_NET_17                   = SIN;
   assign s_LOGISIM_NET_13                   = LD;
   assign s_LOGISIM_NET_4                    = ID;
   assign s_LOGISIM_BUS_15[1:0]              = GR;
   assign s_LOGISIM_NET_3                    = AB;
   assign s_LOGISIM_NET_25                   = SLR;
   assign s_LOGISIM_NET_30                   = ZP;


   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign ACO                                = s_LOGISIM_NET_28;
   assign wY                                 = s_LOGISIM_NET_11;
   assign rY                                 = s_LOGISIM_NET_35;
   assign ALU                                = s_LOGISIM_NET_36;
   assign wA                                 = s_LOGISIM_NET_27;
   assign AOP                                = s_LOGISIM_BUS_29[5:0];
   assign MLO                                = s_LOGISIM_NET_1;
   assign wO                                 = s_LOGISIM_NET_16;
   assign LCO                                = s_LOGISIM_NET_21;
   assign MHI                                = s_LOGISIM_NET_10;
   assign rX                                 = s_LOGISIM_NET_34;
   assign INC                                = s_LOGISIM_NET_12;
   assign PRV                                = s_LOGISIM_NET_38;
   assign wX                                 = s_LOGISIM_NET_42;
   assign ADR                                = s_LOGISIM_NET_43;
   assign wL                                 = s_LOGISIM_NET_37;

   /***************************************************************************
    ** Here all in-lined components are defined                              **
    ***************************************************************************/
   assign s_LOGISIM_NET_28 = 1'd0;

   assign s_LOGISIM_BUS_32[5:0] = 6'd5;

   assign s_LOGISIM_NET_36 = 1'd0;

   assign s_LOGISIM_BUS_46[5:0] = 6'd25;


   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   OR_GATE #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_NET_7),
              .Input_2(s_LOGISIM_NET_41),
              .Result(s_LOGISIM_NET_20));

   AND_GATE #(.BubblesMask(0))
      GATE_2 (.Input_1(s_LOGISIM_NET_14),
              .Input_2(s_LOGISIM_NET_8),
              .Result(s_LOGISIM_NET_34));

   Multiplexer_bus_2 #(.NrOfBits(6))
      MUX_1 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_46[5:0]),
             .MuxIn_1(s_LOGISIM_BUS_32[5:0]),
             .MuxOut(s_LOGISIM_BUS_29[5:0]),
             .Sel(s_LOGISIM_NET_0));

   AND_GATE #(.BubblesMask(0))
      GATE_3 (.Input_1(s_LOGISIM_NET_2),
              .Input_2(s_LOGISIM_NET_40),
              .Result(s_LOGISIM_NET_10));

   AND_GATE #(.BubblesMask(0))
      GATE_4 (.Input_1(s_LOGISIM_NET_26),
              .Input_2(s_LOGISIM_NET_6),
              .Result(s_LOGISIM_NET_1));

   AND_GATE #(.BubblesMask(0))
      GATE_5 (.Input_1(s_LOGISIM_NET_24),
              .Input_2(s_LOGISIM_NET_44),
              .Result(s_LOGISIM_NET_0));

   AND_GATE #(.BubblesMask(0))
      GATE_6 (.Input_1(s_LOGISIM_NET_25),
              .Input_2(s_LOGISIM_NET_13),
              .Result(s_LOGISIM_NET_7));

   OR_GATE #(.BubblesMask(0))
      GATE_7 (.Input_1(s_LOGISIM_NET_30),
              .Input_2(s_LOGISIM_NET_5),
              .Result(s_LOGISIM_NET_6));

   NOT_GATE      GATE_8 (.Input_1(s_LOGISIM_NET_14),
                         .Result(s_LOGISIM_NET_39));

   NOT_GATE      GATE_9 (.Input_1(s_LOGISIM_NET_4),
                         .Result(s_LOGISIM_NET_44));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_10 (.Input_1(s_LOGISIM_NET_20),
               .Input_2(s_LOGISIM_BUS_45[0]),
               .Input_3(s_LOGISIM_BUS_15[1]),
               .Result(s_LOGISIM_NET_42));

   AND_GATE #(.BubblesMask(0))
      GATE_11 (.Input_1(s_LOGISIM_NET_23),
               .Input_2(s_LOGISIM_NET_2),
               .Result(s_LOGISIM_NET_38));

   OR_GATE #(.BubblesMask(0))
      GATE_12 (.Input_1(s_LOGISIM_NET_3),
               .Input_2(s_LOGISIM_NET_5),
               .Result(s_LOGISIM_NET_40));

   AND_GATE #(.BubblesMask(0))
      GATE_13 (.Input_1(s_LOGISIM_NET_2),
               .Input_2(s_LOGISIM_NET_3),
               .Result(s_LOGISIM_NET_22));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_14 (.Input_1(s_LOGISIM_NET_20),
               .Input_2(s_LOGISIM_BUS_45[1]),
               .Input_3(s_LOGISIM_BUS_15[0]),
               .Result(s_LOGISIM_NET_27));

   NOT_GATE_BUS #(.NrOfBits(2))
      GATE_15 (.Input_1(s_LOGISIM_BUS_15[1:0]),
               .Result(s_LOGISIM_BUS_45[1:0]));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_16 (.Input_1(s_LOGISIM_BUS_45[0]),
               .Input_2(s_LOGISIM_BUS_45[1]),
               .Input_3(s_LOGISIM_NET_20),
               .Result(s_LOGISIM_NET_11));

   NOT_GATE      GATE_17 (.Input_1(s_LOGISIM_NET_17),
                          .Result(s_LOGISIM_NET_8));

   OR_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_18 (.Input_1(s_LOGISIM_NET_18),
               .Input_2(s_LOGISIM_NET_22),
               .Input_3(s_LOGISIM_NET_16),
               .Input_4(s_LOGISIM_NET_25),
               .Result(s_LOGISIM_NET_12));

   AND_GATE #(.BubblesMask(0))
      GATE_19 (.Input_1(s_LOGISIM_NET_8),
               .Input_2(s_LOGISIM_NET_39),
               .Result(s_LOGISIM_NET_35));

   OR_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_20 (.Input_1(s_LOGISIM_NET_2),
               .Input_2(s_LOGISIM_NET_17),
               .Input_3(s_LOGISIM_NET_1),
               .Input_4(s_LOGISIM_NET_21),
               .Result(s_LOGISIM_NET_43));

   OR_GATE #(.BubblesMask(0))
      GATE_21 (.Input_1(s_LOGISIM_NET_2),
               .Input_2(s_LOGISIM_NET_21),
               .Result(s_LOGISIM_NET_24));

   AND_GATE #(.BubblesMask(0))
      GATE_22 (.Input_1(s_LOGISIM_NET_26),
               .Input_2(s_LOGISIM_NET_5),
               .Result(s_LOGISIM_NET_41));

   OR_GATE #(.BubblesMask(0))
      GATE_23 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_26),
               .Result(s_LOGISIM_NET_37));



endmodule
