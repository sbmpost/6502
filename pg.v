/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : pg                                                           **
 **                                                                          **
 ******************************************************************************/

module pg( A,
           B,
           LOGISIM_CLOCK_TREE_0,
           S,
           G,
           P);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  A;
   input  B;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input[3:0]  S;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output G;
   output P;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[3:0] s_LOGISIM_BUS_1;
   wire s_LOGISIM_NET_0;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_2;
   wire s_LOGISIM_NET_4;
   wire s_LOGISIM_NET_5;
   wire s_LOGISIM_NET_6;
   wire s_LOGISIM_NET_7;
   wire s_LOGISIM_NET_8;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_BUS_1[3:0]               = S;
   assign s_LOGISIM_NET_7                    = A;
   assign s_LOGISIM_NET_0                    = B;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign P                                  = s_LOGISIM_NET_12;
   assign G                                  = s_LOGISIM_NET_11;

   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   AND_GATE #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_BUS_1[0]),
              .Input_2(s_LOGISIM_NET_0),
              .Result(s_LOGISIM_NET_5));

   OR_GATE #(.BubblesMask(0))
      GATE_2 (.Input_1(s_LOGISIM_NET_2),
              .Input_2(s_LOGISIM_NET_4),
              .Result(s_LOGISIM_NET_11));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_3 (.Input_1(s_LOGISIM_NET_0),
              .Input_2(s_LOGISIM_BUS_1[3]),
              .Input_3(s_LOGISIM_NET_7),
              .Result(s_LOGISIM_NET_2));

   AND_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_4 (.Input_1(s_LOGISIM_NET_7),
              .Input_2(s_LOGISIM_BUS_1[2]),
              .Input_3(s_LOGISIM_NET_8),
              .Result(s_LOGISIM_NET_4));

   NOT_GATE      GATE_5 (.Input_1(s_LOGISIM_NET_0),
                         .Result(s_LOGISIM_NET_8));

   OR_GATE_3_INPUTS #(.BubblesMask(0))
      GATE_6 (.Input_1(s_LOGISIM_NET_6),
              .Input_2(s_LOGISIM_NET_7),
              .Input_3(s_LOGISIM_NET_5),
              .Result(s_LOGISIM_NET_12));

   AND_GATE #(.BubblesMask(0))
      GATE_7 (.Input_1(s_LOGISIM_NET_8),
              .Input_2(s_LOGISIM_BUS_1[1]),
              .Result(s_LOGISIM_NET_6));



endmodule
