/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : fsm_next_sig                                                 **
 **                                                                          **
 ******************************************************************************/

module fsm_next_sig( AB,
                     ACI,
                     GR,
                     ID,
                     LOGISIM_CLOCK_TREE_0,
                     OPC,
                     XY,
                     ACC,
                     ALU,
                     CI,
                     IMM,
                     LD,
                     W,
                     ZP,
                     ZPY);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  AB;
   input  ACI;
   input[1:0]  GR;
   input  ID;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input[2:0]  OPC;
   input  XY;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output ACC;
   output ALU;
   output CI;
   output IMM;
   output LD;
   output W;
   output ZP;
   output ZPY;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[2:0] s_LOGISIM_BUS_19;
   wire[2:0] s_LOGISIM_BUS_30;
   wire[1:0] s_LOGISIM_BUS_4;
   wire[1:0] s_LOGISIM_BUS_9;
   wire s_LOGISIM_NET_0;
   wire s_LOGISIM_NET_1;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_13;
   wire s_LOGISIM_NET_14;
   wire s_LOGISIM_NET_15;
   wire s_LOGISIM_NET_16;
   wire s_LOGISIM_NET_18;
   wire s_LOGISIM_NET_2;
   wire s_LOGISIM_NET_21;
   wire s_LOGISIM_NET_22;
   wire s_LOGISIM_NET_23;
   wire s_LOGISIM_NET_24;
   wire s_LOGISIM_NET_25;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_27;
   wire s_LOGISIM_NET_28;
   wire s_LOGISIM_NET_29;
   wire s_LOGISIM_NET_34;
   wire s_LOGISIM_NET_35;
   wire s_LOGISIM_NET_36;
   wire s_LOGISIM_NET_37;
   wire s_LOGISIM_NET_7;
   wire s_LOGISIM_NET_8;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_NET_11                   = ACI;
   assign s_LOGISIM_BUS_9[1:0]               = GR;
   assign s_LOGISIM_NET_16                   = XY;
   assign s_LOGISIM_NET_29                   = AB;
   assign s_LOGISIM_BUS_19[2:0]              = OPC;
   assign s_LOGISIM_NET_15                   = ID;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign ACC                                = s_LOGISIM_NET_27;
   assign LD                                 = s_LOGISIM_NET_12;
   assign ALU                                = s_LOGISIM_NET_28;
   assign W                                  = s_LOGISIM_NET_36;
   assign ZPY                                = s_LOGISIM_NET_8;
   assign CI                                 = s_LOGISIM_NET_26;
   assign ZP                                 = s_LOGISIM_NET_37;
   assign IMM                                = s_LOGISIM_NET_35;

   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_NET_15),
              .Input_2(s_LOGISIM_NET_7),
              .Input_3(s_LOGISIM_NET_18),
              .Result(s_LOGISIM_NET_8));

   NOT_GATE      GATE_2 (.Input_1(s_LOGISIM_NET_25),
                         .Result(s_LOGISIM_NET_34));

   AND_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_3 (.Input_1(s_LOGISIM_NET_2),
              .Input_2(s_LOGISIM_NET_29),
              .Input_3(s_LOGISIM_NET_18),
              .Input_4(s_LOGISIM_NET_24),
              .Result(s_LOGISIM_NET_27));

   AND_GATE #(.BubblesMask(0))
      GATE_4 (.Input_1(s_LOGISIM_NET_21),
              .Input_2(s_LOGISIM_NET_11),
              .Result(s_LOGISIM_NET_26));

   AND_GATE #(.BubblesMask(0))
      GATE_5 (.Input_1(s_LOGISIM_BUS_4[0]),
              .Input_2(s_LOGISIM_BUS_9[1]),
              .Result(s_LOGISIM_NET_24));

   AND_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_6 (.Input_1(s_LOGISIM_BUS_19[1]),
              .Input_2(s_LOGISIM_BUS_19[2]),
              .Input_3(s_LOGISIM_BUS_30[0]),
              .Input_4(s_LOGISIM_NET_1),
              .Result(s_LOGISIM_NET_23));

   NOT_GATE      GATE_7 (.Input_1(s_LOGISIM_NET_16),
                         .Result(s_LOGISIM_NET_18));

   NOT_GATE      GATE_8 (.Input_1(s_LOGISIM_NET_15),
                         .Result(s_LOGISIM_NET_2));

   NOT_GATE      GATE_9 (.Input_1(s_LOGISIM_NET_12),
                         .Result(s_LOGISIM_NET_14));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_10 (.Input_1(s_LOGISIM_NET_7),
               .Input_2(s_LOGISIM_NET_1),
               .Result(s_LOGISIM_NET_0));

   AND_GATE #(.BubblesMask(0))
      GATE_11 (.Input_1(s_LOGISIM_NET_13),
               .Input_2(s_LOGISIM_BUS_30[0]),
               .Result(s_LOGISIM_NET_25));

   NOT_GATE_BUS #(.NrOfBits(2))
      GATE_12 (.Input_1(s_LOGISIM_BUS_9[1:0]),
               .Result(s_LOGISIM_BUS_4[1:0]));

   AND_GATE #(.BubblesMask(0))
      GATE_13 (.Input_1(s_LOGISIM_BUS_19[2]),
               .Input_2(s_LOGISIM_BUS_30[1]),
               .Result(s_LOGISIM_NET_13));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_14 (.Input_1(s_LOGISIM_NET_2),
               .Input_2(s_LOGISIM_NET_18),
               .Input_3(s_LOGISIM_NET_0),
               .Result(s_LOGISIM_NET_35));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_15 (.Input_1(s_LOGISIM_NET_2),
               .Input_2(s_LOGISIM_NET_7),
               .Input_3(s_LOGISIM_NET_16),
               .Result(s_LOGISIM_NET_37));

   AND_GATE #(.BubblesMask(0))
      GATE_16 (.Input_1(s_LOGISIM_BUS_19[0]),
               .Input_2(s_LOGISIM_NET_13),
               .Result(s_LOGISIM_NET_12));

   NOT_GATE      GATE_17 (.Input_1(s_LOGISIM_NET_23),
                          .Result(s_LOGISIM_NET_22));

   AND_GATE #(.BubblesMask(0))
      GATE_18 (.Input_1(s_LOGISIM_BUS_4[1]),
               .Input_2(s_LOGISIM_BUS_9[0]),
               .Result(s_LOGISIM_NET_1));

   NOT_GATE_BUS #(.NrOfBits(3))
      GATE_19 (.Input_1(s_LOGISIM_BUS_19[2:0]),
               .Result(s_LOGISIM_BUS_30[2:0]));

   AND_GATE #(.BubblesMask(0))
      GATE_20 (.Input_1(s_LOGISIM_NET_14),
               .Input_2(s_LOGISIM_NET_22),
               .Result(s_LOGISIM_NET_36));

   AND_GATE #(.BubblesMask(0))
      GATE_21 (.Input_1(s_LOGISIM_NET_14),
               .Input_2(s_LOGISIM_NET_34),
               .Result(s_LOGISIM_NET_28));

   OR_GATE #(.BubblesMask(0))
      GATE_22 (.Input_1(s_LOGISIM_NET_8),
               .Input_2(s_LOGISIM_NET_29),
               .Result(s_LOGISIM_NET_21));

   NOT_GATE      GATE_23 (.Input_1(s_LOGISIM_NET_29),
                          .Result(s_LOGISIM_NET_7));



endmodule
