/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : fsm                                                          **
 **                                                                          **
 ******************************************************************************/

module fsm( AB,
            ACI,
            CLK,
            GR,
            ID,
            LOGISIM_CLOCK_TREE_0,
            OPC,
            R,
            XY,
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
   input  ACI;
   input  CLK;
   input[1:0]  GR;
   input  ID;
   input[4:0]  LOGISIM_CLOCK_TREE_0;
   input[2:0]  OPC;
   input  R;
   input  XY;

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
   wire[1:0] s_LOGISIM_BUS_0;
   wire[5:0] s_LOGISIM_BUS_14;
   wire[2:0] s_LOGISIM_BUS_6;
   wire s_LOGISIM_NET_1;
   wire s_LOGISIM_NET_10;
   wire s_LOGISIM_NET_11;
   wire s_LOGISIM_NET_12;
   wire s_LOGISIM_NET_13;
   wire s_LOGISIM_NET_15;
   wire s_LOGISIM_NET_16;
   wire s_LOGISIM_NET_17;
   wire s_LOGISIM_NET_18;
   wire s_LOGISIM_NET_19;
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
   wire s_LOGISIM_NET_29;
   wire s_LOGISIM_NET_3;
   wire s_LOGISIM_NET_30;
   wire s_LOGISIM_NET_31;
   wire s_LOGISIM_NET_32;
   wire s_LOGISIM_NET_33;
   wire s_LOGISIM_NET_34;
   wire s_LOGISIM_NET_35;
   wire s_LOGISIM_NET_4;
   wire s_LOGISIM_NET_5;
   wire s_LOGISIM_NET_7;
   wire s_LOGISIM_NET_8;
   wire s_LOGISIM_NET_9;


   /***************************************************************************
    ** Here all input connections are defined                                **
    ***************************************************************************/
   assign s_LOGISIM_NET_11                   = ID;
   assign s_LOGISIM_NET_29                   = CLK;
   assign s_LOGISIM_BUS_6[2:0]               = OPC;
   assign s_LOGISIM_NET_5                    = R;
   assign s_LOGISIM_NET_13                   = XY;
   assign s_LOGISIM_NET_26                   = ACI;
   assign s_LOGISIM_NET_16                   = AB;
   assign s_LOGISIM_BUS_0[1:0]               = GR;

   /***************************************************************************
    ** Here all output connections are defined                               **
    ***************************************************************************/
   assign ADR                                = s_LOGISIM_NET_3;
   assign rY                                 = s_LOGISIM_NET_25;
   assign ALU                                = s_LOGISIM_NET_21;
   assign LCO                                = s_LOGISIM_NET_10;
   assign wY                                 = s_LOGISIM_NET_9;
   assign MHI                                = s_LOGISIM_NET_12;
   assign wL                                 = s_LOGISIM_NET_15;
   assign AOP                                = s_LOGISIM_BUS_14[5:0];
   assign wA                                 = s_LOGISIM_NET_28;
   assign wO                                 = s_LOGISIM_NET_34;
   assign MLO                                = s_LOGISIM_NET_24;
   assign PRV                                = s_LOGISIM_NET_27;
   assign wX                                 = s_LOGISIM_NET_17;
   assign INC                                = s_LOGISIM_NET_8;
   assign ACO                                = s_LOGISIM_NET_19;
   assign rX                                 = s_LOGISIM_NET_4;

   /***************************************************************************
    ** Here all sub-circuits are defined                                     **
    ***************************************************************************/
   fsm_out      fsm_out_1 (.AB(s_LOGISIM_NET_16),
                           .ACO(s_LOGISIM_NET_19),
                           .ADR(s_LOGISIM_NET_3),
                           .ALU(s_LOGISIM_NET_21),
                           .AOP(s_LOGISIM_BUS_14[5:0]),
                           .CI(s_LOGISIM_NET_2),
                           .GR(s_LOGISIM_BUS_0[1:0]),
                           .ID(s_LOGISIM_NET_11),
                           .INC(s_LOGISIM_NET_8),
                           .LCO(s_LOGISIM_NET_10),
                           .LD(s_LOGISIM_NET_18),
                           .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                           .MHI(s_LOGISIM_NET_12),
                           .MLO(s_LOGISIM_NET_24),
                           .OPC(s_LOGISIM_BUS_6[2:0]),
                           .PRV(s_LOGISIM_NET_27),
                           .S0(s_LOGISIM_NET_32),
                           .SCO(s_LOGISIM_NET_23),
                           .SHI(s_LOGISIM_NET_30),
                           .SIN(s_LOGISIM_NET_20),
                           .SLO(s_LOGISIM_NET_33),
                           .SLR(s_LOGISIM_NET_31),
                           .SOP(s_LOGISIM_NET_22),
                           .XY(s_LOGISIM_NET_13),
                           .ZP(s_LOGISIM_NET_7),
                           .ZPY(s_LOGISIM_NET_1),
                           .rX(s_LOGISIM_NET_4),
                           .rY(s_LOGISIM_NET_25),
                           .wA(s_LOGISIM_NET_28),
                           .wL(s_LOGISIM_NET_15),
                           .wO(s_LOGISIM_NET_34),
                           .wX(s_LOGISIM_NET_17),
                           .wY(s_LOGISIM_NET_9));

   fsm_next      fsm_next_1 (.CI(s_LOGISIM_NET_2),
                             .CLK(s_LOGISIM_NET_29),
                             .IMM(s_LOGISIM_NET_35),
                             .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                             .R(s_LOGISIM_NET_5),
                             .S0(s_LOGISIM_NET_32),
                             .SCO(s_LOGISIM_NET_23),
                             .SHI(s_LOGISIM_NET_30),
                             .SIN(s_LOGISIM_NET_20),
                             .SLO(s_LOGISIM_NET_33),
                             .SLR(s_LOGISIM_NET_31),
                             .SOP(s_LOGISIM_NET_22),
                             .ZP(s_LOGISIM_NET_7),
                             .ZPY(s_LOGISIM_NET_1));

   fsm_next_sig      fsm_next_sig_1 (.AB(s_LOGISIM_NET_16),
                                     .ACC(),
                                     .ACI(s_LOGISIM_NET_26),
                                     .ALU(),
                                     .CI(s_LOGISIM_NET_2),
                                     .GR(s_LOGISIM_BUS_0[1:0]),
                                     .ID(s_LOGISIM_NET_11),
                                     .IMM(s_LOGISIM_NET_35),
                                     .LD(s_LOGISIM_NET_18),
                                     .LOGISIM_CLOCK_TREE_0(LOGISIM_CLOCK_TREE_0),
                                     .OPC(s_LOGISIM_BUS_6[2:0]),
                                     .W(),
                                     .XY(s_LOGISIM_NET_13),
                                     .ZP(s_LOGISIM_NET_7),
                                     .ZPY(s_LOGISIM_NET_1));



endmodule
