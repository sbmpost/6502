/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : alu8                                                         **
 **                                                                          **
 ******************************************************************************/

module alu8( A,
             B,
             CI,
             LOGISIM_CLOCK_TREE_0,
             OP,
             CO,
             F);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input[7:0]  A;
   input[7:0]  B;
   input  CI;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input[5:0]  OP;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output CO;
   output[7:0] F;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[7:0] s_LOGISIM_BUS_0;
   wire[7:0] s_LOGISIM_BUS_1;
   wire[7:0] s_LOGISIM_BUS_18;
   wire[5:0] s_LOGISIM_BUS_21;
   wire[7:0] s_LOGISIM_BUS_7;
   wire[7:0] s_LOGISIM_BUS_8;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_15;
   wire s_LOGISIM_NET_16;
   wire s_LOGISIM_NET_19;
   wire s_LOGISIM_NET_2;
   wire s_LOGISIM_NET_20;
   wire s_LOGISIM_NET_23;
   wire s_LOGISIM_NET_24;
   wire s_LOGISIM_NET_25;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_27;
   wire s_LOGISIM_NET_28;
   wire s_LOGISIM_NET_29;


   /***************************************************************************
    ** Here all wiring is defined                                            **
    ***************************************************************************/
   assign s_LOGISIM_NET_23                   = s_LOGISIM_BUS_0[7];
   assign s_LOGISIM_BUS_1[6]                 = s_LOGISIM_NET_23;
   assign s_LOGISIM_NET_24                   = s_LOGISIM_BUS_0[6];
   assign s_LOGISIM_BUS_1[5]                 = s_LOGISIM_NET_24;
   assign s_LOGISIM_NET_25                   = s_LOGISIM_BUS_0[5];
   assign s_LOGISIM_BUS_1[4]                 = s_LOGISIM_NET_25;
   assign s_LOGISIM_NET_26                   = s_LOGISIM_BUS_0[4];
   assign s_LOGISIM_BUS_1[3]                 = s_LOGISIM_NET_26;
   assign s_LOGISIM_NET_27                   = s_LOGISIM_BUS_0[3];
   assign s_LOGISIM_BUS_1[2]                 = s_LOGISIM_NET_27;
   assign s_LOGISIM_NET_28                   = s_LOGISIM_BUS_0[2];
   assign s_LOGISIM_BUS_1[1]                 = s_LOGISIM_NET_28;
   assign s_LOGISIM_NET_29                   = s_LOGISIM_BUS_0[1];
   assign s_LOGISIM_BUS_1[0]                 = s_LOGISIM_NET_29;

   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_BUS_21[5:0]              = OP;
   assign s_LOGISIM_BUS_7[7:0]               = B;
   assign s_LOGISIM_BUS_1[7]                 = CI;
   assign s_LOGISIM_BUS_0[7:0]               = A;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign F                                  = s_LOGISIM_BUS_18[7:0];
   assign CO                                 = s_LOGISIM_NET_19;

   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/
   AND_GATE #(.BubblesMask(0))
      GATE_1 (.Input_1(s_LOGISIM_NET_15),
              .Input_2(s_LOGISIM_BUS_1[7]),
              .Result(s_LOGISIM_NET_20));

   OR_GATE #(.BubblesMask(0))
      GATE_2 (.Input_1(s_LOGISIM_NET_2),
              .Input_2(s_LOGISIM_NET_20),
              .Result(s_LOGISIM_NET_11));

   Multiplexer_2      MUX_1 (.Enable(1'b1),
                             .MuxIn_0(s_LOGISIM_NET_16),
                             .MuxIn_1(s_LOGISIM_BUS_0[0]),
                             .MuxOut(s_LOGISIM_NET_19),
                             .Sel(s_LOGISIM_BUS_21[5]));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_2 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_8[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_1[7:0]),
             .MuxOut(s_LOGISIM_BUS_18[7:0]),
             .Sel(s_LOGISIM_BUS_21[5]));


   /***************************************************************************
    ** Here all sub-circuits are defined                                     **
    ***************************************************************************/
   alu4      hi (.A(s_LOGISIM_BUS_0[7:4]),
                 .B(s_LOGISIM_BUS_7[7:4]),
                 .CI(s_LOGISIM_NET_11),
                 .CO(s_LOGISIM_NET_16),
                 .F(s_LOGISIM_BUS_8[7:4]),
                 .G(),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .M(s_LOGISIM_BUS_21[4]),
                 .P(),
                 .S(s_LOGISIM_BUS_21[3:0]));

   alu4      lo (.A(s_LOGISIM_BUS_0[3:0]),
                 .B(s_LOGISIM_BUS_7[3:0]),
                 .CI(s_LOGISIM_BUS_1[7]),
                 .CO(),
                 .F(s_LOGISIM_BUS_8[3:0]),
                 .G(s_LOGISIM_NET_2),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .M(s_LOGISIM_BUS_21[4]),
                 .P(s_LOGISIM_NET_15),
                 .S(s_LOGISIM_BUS_21[3:0]));



endmodule
