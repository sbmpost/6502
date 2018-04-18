/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : alu4                                                         **
 **                                                                          **
 ******************************************************************************/

module alu4( A,
             B,
             CI,
             LOGISIM_CLOCK_TREE_0,
             M,
             S,
             CO,
             F,
             G,
             P);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input[3:0]  A;
   input[3:0]  B;
   input  CI;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input  M;
   input[3:0]  S;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output CO;
   output[3:0] F;
   output G;
   output P;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[3:0] s_LOGISIM_BUS_13;
   wire[3:0] s_LOGISIM_BUS_21;
   wire[3:0] s_LOGISIM_BUS_28;
   wire[3:0] s_LOGISIM_BUS_39;
   wire s_LOGISIM_NET_0;
   wire s_LOGISIM_NET_1;
   wire s_LOGISIM_NET_10;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_14;
   wire s_LOGISIM_NET_15;
   wire s_LOGISIM_NET_16;
   wire s_LOGISIM_NET_17;
   wire s_LOGISIM_NET_2;
   wire s_LOGISIM_NET_20;
   wire s_LOGISIM_NET_22;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_27;
   wire s_LOGISIM_NET_30;
   wire s_LOGISIM_NET_31;
   wire s_LOGISIM_NET_32;
   wire s_LOGISIM_NET_33;
   wire s_LOGISIM_NET_34;
   wire s_LOGISIM_NET_35;
   wire s_LOGISIM_NET_36;
   wire s_LOGISIM_NET_37;
   wire s_LOGISIM_NET_38;
   wire s_LOGISIM_NET_4;
   wire s_LOGISIM_NET_41;
   wire s_LOGISIM_NET_42;
   wire s_LOGISIM_NET_43;
   wire s_LOGISIM_NET_44;
   wire s_LOGISIM_NET_45;
   wire s_LOGISIM_NET_46;
   wire s_LOGISIM_NET_48;
   wire s_LOGISIM_NET_5;
   wire s_LOGISIM_NET_6;
   wire s_LOGISIM_NET_9;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_BUS_21[3:0]              = A;
   assign s_LOGISIM_NET_12                   = CI;
   assign s_LOGISIM_BUS_28[3:0]              = B;
   assign s_LOGISIM_BUS_13[3:0]              = S;
   assign s_LOGISIM_NET_17                   = M;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign P                                  = s_LOGISIM_NET_27;
   assign G                                  = s_LOGISIM_NET_33;
   assign F                                  = s_LOGISIM_BUS_39[3:0];
   assign CO                                 = s_LOGISIM_NET_38;

   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   AND_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_NET_2),
              .Input_2(s_LOGISIM_NET_15),
              .Input_3(s_LOGISIM_NET_14),
              .Input_4(s_LOGISIM_NET_9),
              .Result(s_LOGISIM_NET_27));

   AND_GATE_5_INPUTS #(.BubblesMask(0))
      GATE_2 (.Input_1(s_LOGISIM_NET_12),
              .Input_2(s_LOGISIM_NET_2),
              .Input_3(s_LOGISIM_NET_15),
              .Input_4(s_LOGISIM_NET_14),
              .Input_5(s_LOGISIM_NET_9),
              .Result(s_LOGISIM_NET_43));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_3 (.Input_1(s_LOGISIM_NET_31),
              .Input_2(s_LOGISIM_NET_9),
              .Result(s_LOGISIM_NET_45));

   OR_GATE #(.BubblesMask(0))
      GATE_4 (.Input_1(s_LOGISIM_NET_43),
              .Input_2(s_LOGISIM_NET_33),
              .Result(s_LOGISIM_NET_38));

   AND_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_5 (.Input_1(s_LOGISIM_NET_17),
              .Input_2(s_LOGISIM_NET_10),
              .Input_3(s_LOGISIM_NET_15),
              .Input_4(s_LOGISIM_NET_14),
              .Result(s_LOGISIM_NET_0));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_6 (.Input_1(s_LOGISIM_NET_17),
              .Input_2(s_LOGISIM_NET_10),
              .Input_3(s_LOGISIM_NET_15),
              .Result(s_LOGISIM_NET_48));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_7 (.Input_1(s_LOGISIM_NET_4),
              .Input_2(s_LOGISIM_NET_14),
              .Input_3(s_LOGISIM_NET_9),
              .Result(s_LOGISIM_NET_34));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_8 (.Input_1(s_LOGISIM_NET_45),
              .Input_2(s_LOGISIM_NET_16),
              .Result(s_LOGISIM_BUS_39[3]));

   AND_GATE #(.BubblesMask(0))
      GATE_9 (.Input_1(s_LOGISIM_NET_17),
              .Input_2(s_LOGISIM_NET_12),
              .Result(s_LOGISIM_NET_35));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_10 (.Input_1(s_LOGISIM_NET_41),
               .Input_2(s_LOGISIM_NET_30),
               .Result(s_LOGISIM_BUS_39[1]));

   AND_GATE #(.BubblesMask(0))
      GATE_11 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_10),
               .Result(s_LOGISIM_NET_1));

   AND_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_12 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_12),
               .Input_3(s_LOGISIM_NET_15),
               .Input_4(s_LOGISIM_NET_2),
               .Result(s_LOGISIM_NET_32));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_13 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_12),
               .Input_3(s_LOGISIM_NET_2),
               .Result(s_LOGISIM_NET_5));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_14 (.Input_1(s_LOGISIM_NET_46),
               .Input_2(s_LOGISIM_NET_37),
               .Result(s_LOGISIM_BUS_39[2]));

   AND_GATE_5_INPUTS #(.BubblesMask(0))
      GATE_15 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_12),
               .Input_3(s_LOGISIM_NET_2),
               .Input_4(s_LOGISIM_NET_15),
               .Input_5(s_LOGISIM_NET_14),
               .Result(s_LOGISIM_NET_36));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_16 (.Input_1(s_LOGISIM_NET_6),
               .Input_2(s_LOGISIM_NET_35),
               .Result(s_LOGISIM_BUS_39[0]));

   AND_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_17 (.Input_1(s_LOGISIM_NET_10),
               .Input_2(s_LOGISIM_NET_15),
               .Input_3(s_LOGISIM_NET_14),
               .Input_4(s_LOGISIM_NET_9),
               .Result(s_LOGISIM_NET_44));

   AND_GATE #(.BubblesMask(0))
      GATE_18 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_20),
               .Result(s_LOGISIM_NET_11));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_19 (.Input_1(s_LOGISIM_NET_4),
               .Input_2(s_LOGISIM_NET_15),
               .Result(s_LOGISIM_NET_41));

   OR_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_20 (.Input_1(s_LOGISIM_NET_44),
               .Input_2(s_LOGISIM_NET_34),
               .Input_3(s_LOGISIM_NET_26),
               .Input_4(s_LOGISIM_NET_31),
               .Result(s_LOGISIM_NET_33));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_21 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_4),
               .Input_3(s_LOGISIM_NET_14),
               .Result(s_LOGISIM_NET_42));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_22 (.Input_1(s_LOGISIM_NET_10),
               .Input_2(s_LOGISIM_NET_2),
               .Result(s_LOGISIM_NET_6));

   OR_GATE #(.BubblesMask(0))
      GATE_23 (.Input_1(s_LOGISIM_NET_5),
               .Input_2(s_LOGISIM_NET_1),
               .Result(s_LOGISIM_NET_30));

   AND_GATE #(.BubblesMask(0))
      GATE_24 (.Input_1(s_LOGISIM_NET_20),
               .Input_2(s_LOGISIM_NET_9),
               .Result(s_LOGISIM_NET_26));

   OR_GATE_4_INPUTS #(.BubblesMask(0))
      GATE_25 (.Input_1(s_LOGISIM_NET_36),
               .Input_2(s_LOGISIM_NET_0),
               .Input_3(s_LOGISIM_NET_42),
               .Input_4(s_LOGISIM_NET_11),
               .Result(s_LOGISIM_NET_16));

   AND_GATE #(.BubblesMask(0))
      GATE_26 (.Input_1(s_LOGISIM_NET_17),
               .Input_2(s_LOGISIM_NET_4),
               .Result(s_LOGISIM_NET_22));

   XOR_GATE_ONEHOT #(.BubblesMask(0))
      GATE_27 (.Input_1(s_LOGISIM_NET_20),
               .Input_2(s_LOGISIM_NET_14),
               .Result(s_LOGISIM_NET_46));

   OR_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_28 (.Input_1(s_LOGISIM_NET_32),
               .Input_2(s_LOGISIM_NET_48),
               .Input_3(s_LOGISIM_NET_22),
               .Result(s_LOGISIM_NET_37));


   /***************************************************************************
    ** Here all sub-circuits are defined                                     **
    ***************************************************************************/
   pg      pg_2 (.A(s_LOGISIM_BUS_21[2]),
                 .B(s_LOGISIM_BUS_28[2]),
                 .G(s_LOGISIM_NET_20),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .P(s_LOGISIM_NET_14),
                 .S(s_LOGISIM_BUS_13[3:0]));

   pg      pg_1 (.A(s_LOGISIM_BUS_21[1]),
                 .B(s_LOGISIM_BUS_28[1]),
                 .G(s_LOGISIM_NET_4),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .P(s_LOGISIM_NET_15),
                 .S(s_LOGISIM_BUS_13[3:0]));

   pg      pg_3 (.A(s_LOGISIM_BUS_21[3]),
                 .B(s_LOGISIM_BUS_28[3]),
                 .G(s_LOGISIM_NET_31),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .P(s_LOGISIM_NET_9),
                 .S(s_LOGISIM_BUS_13[3:0]));

   pg      pg_0 (.A(s_LOGISIM_BUS_21[0]),
                 .B(s_LOGISIM_BUS_28[0]),
                 .G(s_LOGISIM_NET_10),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .P(s_LOGISIM_NET_2),
                 .S(s_LOGISIM_BUS_13[3:0]));



endmodule
