/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : cpu                                                          **
 **                                                                          **
 ******************************************************************************/

module cpu( LOGISIM_CLOCK_TREE_0,
            R,
            mDOUT,
            CO1,
            CO2,
            mADDR,
            mCLK,
            mDIN,
            mOEN,
            mWE,
            R_OUT);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input  R;
   input[7:0]  mDOUT;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output CO1;
   output CO2;
   output[15:0] mADDR;
   output mCLK;
   output[7:0] mDIN;
   output mOEN;
   output mWE;
   output[7:0] R_OUT;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire[7:0] s_LOGISIM_BUS_0;
   wire[15:0] s_LOGISIM_BUS_10;
   wire[7:0] s_LOGISIM_BUS_12;
   wire[7:0] s_LOGISIM_BUS_14;
   wire[7:0] s_LOGISIM_BUS_15;
   wire[7:0] s_LOGISIM_BUS_16;
   wire[15:0] s_LOGISIM_BUS_18;
   wire[7:0] s_LOGISIM_BUS_2;
   wire[7:0] s_LOGISIM_BUS_21;
   wire[7:0] s_LOGISIM_BUS_32;
   wire[7:0] s_LOGISIM_BUS_33;
   wire[15:0] s_LOGISIM_BUS_34;
   wire[7:0] s_LOGISIM_BUS_36;
   wire[7:0] s_LOGISIM_BUS_37;
   wire[1:0] s_LOGISIM_BUS_38;
   wire[7:0] s_LOGISIM_BUS_4;
   wire[5:0] s_LOGISIM_BUS_43;
   wire[7:0] s_LOGISIM_BUS_44;
   wire[7:0] s_LOGISIM_BUS_47;
   wire[15:0] s_LOGISIM_BUS_5;
   wire[1:0] s_LOGISIM_BUS_50;
   wire[7:0] s_LOGISIM_BUS_52;
   wire[1:0] s_LOGISIM_BUS_53;
   wire[7:0] s_LOGISIM_BUS_54;
   wire s_LOGISIM_NET_1;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_17;
   wire s_LOGISIM_NET_19;
   wire s_LOGISIM_NET_20;
   wire s_LOGISIM_NET_24;
   wire s_LOGISIM_NET_26;
   wire s_LOGISIM_NET_28;
   wire s_LOGISIM_NET_29;
   wire s_LOGISIM_NET_3;
   wire s_LOGISIM_NET_31;
   wire s_LOGISIM_NET_35;
   wire s_LOGISIM_NET_40;
   wire s_LOGISIM_NET_42;
   wire s_LOGISIM_NET_45;
   wire s_LOGISIM_NET_49;
   wire s_LOGISIM_NET_55;
   wire s_LOGISIM_NET_6;
   wire s_LOGISIM_NET_8;


   /***************************************************************************
    ** Here all clock generator connections are defined                      **
    ***************************************************************************/
   assign s_LOGISIM_NET_3                    = LOGISIM_CLOCK_TREE_0[0];

   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_NET_1                    = R;
   // assign s_LOGISIM_BUS_12[7:0]              = mDOUT;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   // assign mWE                                = s_LOGISIM_NET_42;
   assign CO2                                = s_LOGISIM_NET_45;
   assign mADDR                              = s_LOGISIM_BUS_10[15:0];
   // assign mDIN                               = s_LOGISIM_BUS_15[7:0];
   // assign mOEN                               = s_LOGISIM_NET_19;
   assign CO1                                = s_LOGISIM_NET_24;
   // assign mCLK                               = s_LOGISIM_NET_3;
   assign R_OUT = s_LOGISIM_BUS_32;

   /***************************************************************************
    ** Here all in-lined components are defined                              **
    ***************************************************************************/
   assign s_LOGISIM_NET_42 = 1'd0;

   assign s_LOGISIM_NET_19 = 1'd1;

   assign s_LOGISIM_NET_55 = 1'd1;

   assign s_LOGISIM_BUS_37[7:0] = 8'd1;

   assign s_LOGISIM_BUS_44[7:0] = 8'd0;

   assign s_LOGISIM_NET_49 = 1'd0;

   assign s_LOGISIM_NET_11 = 1'd0;

   assign s_LOGISIM_BUS_15[7:0] = 8'd0;

   assign s_LOGISIM_BUS_54[7:0] = 8'd0;

   assign s_LOGISIM_BUS_33[7:0] = 8'd0;


   /***************************************************************************
    ** Here all normal components are defined                                **
    ***************************************************************************/

   MEMORY
      MEMORY_1 (.Address(s_LOGISIM_BUS_10[15:0]),
                .Clock(LOGISIM_CLOCK_TREE_0[4]),
                .DataIn(8'd0),
                .OE(1'd1),                                 
                .Tick(LOGISIM_CLOCK_TREE_0[2]),
                .WE(1'd0),
                .DataOut(s_LOGISIM_BUS_12[7:0]));

   Multiplexer_bus_4 #(.NrOfBits(8))
      MUX_1 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_37[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_52[7:0]),
             .MuxIn_2(s_LOGISIM_BUS_47[7:0]),
             .MuxIn_3(s_LOGISIM_BUS_32[7:0]),
             .MuxOut(s_LOGISIM_BUS_16[7:0]),
             .Sel(s_LOGISIM_BUS_38[1:0]));

   Multiplexer_bus_4 #(.NrOfBits(16))
      MUX_2 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_5[15:0]),
             .MuxIn_1(s_LOGISIM_BUS_34[15:0]),
             .MuxIn_2(s_LOGISIM_BUS_5[15:0]),
             .MuxIn_3(s_LOGISIM_BUS_18[15:0]),
             .MuxOut(s_LOGISIM_BUS_10[15:0]),
             .Sel(s_LOGISIM_BUS_53[1:0]));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_3 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_14[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_2[7:0]),
             .MuxOut(s_LOGISIM_BUS_36[7:0]),
             .Sel(s_LOGISIM_NET_40));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_1 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_20),
                       .D(s_LOGISIM_BUS_2[7:0]),
                       .Q(s_LOGISIM_BUS_52[7:0]),
                       .Reset(s_LOGISIM_NET_1),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   Adder #(.ExtendedBits(9),
           .NrOfBits(8))
      ADDER2C_1 (.CarryIn(s_LOGISIM_BUS_50[0]),
                 .CarryOut(s_LOGISIM_NET_45),
                 .DataA(s_LOGISIM_BUS_54[7:0]),
                 .DataB(s_LOGISIM_BUS_2[7:0]),
                 .Result(s_LOGISIM_BUS_0[7:0]));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_4 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_12[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_4[7:0]),
             .MuxOut(s_LOGISIM_BUS_2[7:0]),
             .Sel(s_LOGISIM_NET_6));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(16))
      REGISTER_FILE_2 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_55),
                       .D(s_LOGISIM_BUS_10[15:0]),
                       .Q(s_LOGISIM_BUS_18[15:0]),
                       .Reset(s_LOGISIM_NET_1),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_3 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_35),
                       .D(s_LOGISIM_BUS_2[7:0]),
                       .Q(s_LOGISIM_BUS_47[7:0]),
                       .Reset(s_LOGISIM_NET_1),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_4 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_40),
                       .D(s_LOGISIM_BUS_2[7:0]),
                       .Q(s_LOGISIM_BUS_14[7:0]),
                       .Reset(s_LOGISIM_NET_1),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   Multiplexer_bus_2 #(.NrOfBits(8))
      MUX_5 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_4[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_2[7:0]),
             .MuxOut(s_LOGISIM_BUS_34[7:0]),
             .Sel(s_LOGISIM_NET_17));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_5 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_28),
                       .D(s_LOGISIM_BUS_2[7:0]),
                       .Q(s_LOGISIM_BUS_32[7:0]),
                       .Reset(s_LOGISIM_NET_1),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));

   Multiplexer_bus_4 #(.NrOfBits(8))
      MUX_6 (.Enable(1'b1),
             .MuxIn_0(s_LOGISIM_BUS_44[7:0]),
             .MuxIn_1(s_LOGISIM_BUS_0[7:0]),
             .MuxIn_2(s_LOGISIM_BUS_2[7:0]),
             .MuxIn_3(s_LOGISIM_BUS_0[7:0]),
             .MuxOut(s_LOGISIM_BUS_34[15:8]),
             .Sel(s_LOGISIM_BUS_50[1:0]));

   REGISTER_FLIP_FLOP #(.ActiveLevel(1),
                        .NrOfBits(8))
      REGISTER_FILE_6 (.Clock(LOGISIM_CLOCK_TREE_0[4]),
                       .ClockEnable(s_LOGISIM_NET_31),
                       .D(s_LOGISIM_BUS_2[7:0]),
                       .Q(s_LOGISIM_BUS_21[7:0]),
                       .Reset(s_LOGISIM_NET_1),
                       .Tick(LOGISIM_CLOCK_TREE_0[2]));


   /***************************************************************************
    ** Here all sub-circuits are defined                                     **
    ***************************************************************************/
   fsm      fsm_1 (.AB(s_LOGISIM_BUS_36[3]),
                   .ACI(s_LOGISIM_NET_8),
                   .ACO(s_LOGISIM_NET_26),
                   .ADR(s_LOGISIM_BUS_53[0]),
                   .ALU(s_LOGISIM_NET_6),
                   .AOP(s_LOGISIM_BUS_43[5:0]),
                   .CLK(s_LOGISIM_NET_3),
                   .GR(s_LOGISIM_BUS_36[1:0]),
                   .ID(s_LOGISIM_BUS_36[4]),
                   .INC(s_LOGISIM_NET_29),
                   .LCO(s_LOGISIM_BUS_50[0]),
                   .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                   .MHI(s_LOGISIM_BUS_50[1]),
                   .MLO(s_LOGISIM_NET_17),
                   .OPC(s_LOGISIM_BUS_36[7:5]),
                   .PRV(s_LOGISIM_BUS_53[1]),
                   .R(s_LOGISIM_NET_1),
                   .XY(s_LOGISIM_BUS_36[2]),
                   .rX(s_LOGISIM_BUS_38[0]),
                   .rY(s_LOGISIM_BUS_38[1]),
                   .wA(s_LOGISIM_NET_28),
                   .wL(s_LOGISIM_NET_31),
                   .wO(s_LOGISIM_NET_40),
                   .wX(s_LOGISIM_NET_20),
                   .wY(s_LOGISIM_NET_35));

   pc      pc_1 (.CI(s_LOGISIM_NET_11),
                 .CLK(s_LOGISIM_NET_3),
                 .CO(s_LOGISIM_NET_24),
                 .HI(s_LOGISIM_BUS_33[7:0]),
                 .INC(s_LOGISIM_NET_29),
                 .LO(s_LOGISIM_BUS_33[7:0]),
                 .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                 .PC(s_LOGISIM_BUS_5[15:0]),
                 .R(s_LOGISIM_NET_1),
                 .WR(s_LOGISIM_NET_49));

   alu8      alu_1 (.A(s_LOGISIM_BUS_16[7:0]),
                    .B(s_LOGISIM_BUS_21[7:0]),
                    .CI(s_LOGISIM_NET_26),
                    .CO(s_LOGISIM_NET_8),
                    .F(s_LOGISIM_BUS_4[7:0]),
                    .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                    .OP(s_LOGISIM_BUS_43[5:0]));



endmodule
