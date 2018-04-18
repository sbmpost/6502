/******************************************************************************
 ** Logisim goes FPGA automatic generated Verilog code                       **
 **                                                                          **
 ** Component : LogisimToplevelShell                                         **
 **                                                                          **
 ******************************************************************************/

module LogisimToplevelShell( FPGA_GlobalClock,
                             FPGA_INPUT_PIN_0,
                             FPGA_INPUT_PIN_1,
                             FPGA_INPUT_PIN_2,
                             FPGA_INPUT_PIN_3,
                             FPGA_INPUT_PIN_4,
                             FPGA_INPUT_PIN_5,
                             FPGA_INPUT_PIN_6,
                             FPGA_INPUT_PIN_7,
                             FPGA_INPUT_PIN_8,
                             FPGA_OUTPUT_PIN_0,
                             FPGA_OUTPUT_PIN_1,
                             FPGA_OUTPUT_PIN_10,
                             FPGA_OUTPUT_PIN_11,
                             FPGA_OUTPUT_PIN_12,
                             FPGA_OUTPUT_PIN_13,
                             FPGA_OUTPUT_PIN_14,
                             FPGA_OUTPUT_PIN_15,
                             FPGA_OUTPUT_PIN_16,
                             FPGA_OUTPUT_PIN_17,
                             FPGA_OUTPUT_PIN_18,
                             FPGA_OUTPUT_PIN_19,
                             FPGA_OUTPUT_PIN_2,
                             FPGA_OUTPUT_PIN_20,
                             FPGA_OUTPUT_PIN_21,
                             FPGA_OUTPUT_PIN_22,
                             FPGA_OUTPUT_PIN_23,
                             FPGA_OUTPUT_PIN_24,
                             FPGA_OUTPUT_PIN_25,
                             FPGA_OUTPUT_PIN_26,
                             FPGA_OUTPUT_PIN_27,
                             FPGA_OUTPUT_PIN_28,
                             FPGA_OUTPUT_PIN_3,
                             FPGA_OUTPUT_PIN_4,
                             FPGA_OUTPUT_PIN_5,
                             FPGA_OUTPUT_PIN_6,
                             FPGA_OUTPUT_PIN_7,
                             FPGA_OUTPUT_PIN_8,
                             FPGA_OUTPUT_PIN_9);

   /***************************************************************************
    ** Here the inputs are defined                                           **
    ***************************************************************************/
   input  FPGA_GlobalClock;
   input  FPGA_INPUT_PIN_0;
   input  FPGA_INPUT_PIN_1;
   input  FPGA_INPUT_PIN_2;
   input  FPGA_INPUT_PIN_3;
   input  FPGA_INPUT_PIN_4;
   input  FPGA_INPUT_PIN_5;
   input  FPGA_INPUT_PIN_6;
   input  FPGA_INPUT_PIN_7;
   input  FPGA_INPUT_PIN_8;

   /***************************************************************************
    ** Here the outputs are defined                                          **
    ***************************************************************************/
   output FPGA_OUTPUT_PIN_0;
   output FPGA_OUTPUT_PIN_1;
   output FPGA_OUTPUT_PIN_10;
   output FPGA_OUTPUT_PIN_11;
   output FPGA_OUTPUT_PIN_12;
   output FPGA_OUTPUT_PIN_13;
   output FPGA_OUTPUT_PIN_14;
   output FPGA_OUTPUT_PIN_15;
   output FPGA_OUTPUT_PIN_16;
   output FPGA_OUTPUT_PIN_17;
   output FPGA_OUTPUT_PIN_18;
   output FPGA_OUTPUT_PIN_19;
   output FPGA_OUTPUT_PIN_2;
   output FPGA_OUTPUT_PIN_20;
   output FPGA_OUTPUT_PIN_21;
   output FPGA_OUTPUT_PIN_22;
   output FPGA_OUTPUT_PIN_23;
   output FPGA_OUTPUT_PIN_24;
   output FPGA_OUTPUT_PIN_25;
   output FPGA_OUTPUT_PIN_26;
   output FPGA_OUTPUT_PIN_27;
   output FPGA_OUTPUT_PIN_28;
   output FPGA_OUTPUT_PIN_3;
   output FPGA_OUTPUT_PIN_4;
   output FPGA_OUTPUT_PIN_5;
   output FPGA_OUTPUT_PIN_6;
   output FPGA_OUTPUT_PIN_7;
   output FPGA_OUTPUT_PIN_8;
   output FPGA_OUTPUT_PIN_9;

   /***************************************************************************
    ** Here the internal wires are defined                                   **
    ***************************************************************************/
   wire s_CO1;
   wire s_CO2;
   wire s_FPGA_Tick;
   wire[4:0] s_LOGISIM_CLOCK_TREE_0;
   wire s_R;
   wire[15:0] s_mADDR;
   wire s_mCLK;
   wire[7:0] s_mDIN;
   wire[7:0] s_mDOUT;
   wire s_mOEN;
   wire s_mWE;

   /***************************************************************************
    ** Here all signal adaptations are performed                             **
    ***************************************************************************/
   assign s_R = ~FPGA_INPUT_PIN_0;
   assign FPGA_OUTPUT_PIN_0 = s_mCLK;
   assign FPGA_OUTPUT_PIN_1 = s_mOEN;
   assign FPGA_OUTPUT_PIN_2 = s_mWE;
   assign FPGA_OUTPUT_PIN_3 = s_mADDR[0];
   assign FPGA_OUTPUT_PIN_4 = s_mADDR[1];
   assign FPGA_OUTPUT_PIN_5 = s_mADDR[2];
   assign FPGA_OUTPUT_PIN_6 = s_mADDR[3];
   assign FPGA_OUTPUT_PIN_7 = s_mADDR[4];
   assign FPGA_OUTPUT_PIN_8 = s_mADDR[5];
   assign FPGA_OUTPUT_PIN_9 = s_mADDR[6];
   assign FPGA_OUTPUT_PIN_10 = s_mADDR[7];
   assign FPGA_OUTPUT_PIN_11 = s_mADDR[8];
   assign FPGA_OUTPUT_PIN_12 = s_mADDR[9];
   assign FPGA_OUTPUT_PIN_13 = s_mADDR[10];
   assign FPGA_OUTPUT_PIN_14 = s_mADDR[11];
   assign FPGA_OUTPUT_PIN_15 = s_mADDR[12];
   assign FPGA_OUTPUT_PIN_16 = s_mADDR[13];
   assign FPGA_OUTPUT_PIN_17 = s_mADDR[14];
   assign FPGA_OUTPUT_PIN_18 = s_mADDR[15];
   assign FPGA_OUTPUT_PIN_19 = s_mDIN[0];
   assign FPGA_OUTPUT_PIN_20 = s_mDIN[1];
   assign FPGA_OUTPUT_PIN_21 = s_mDIN[2];
   assign FPGA_OUTPUT_PIN_22 = s_mDIN[3];
   assign FPGA_OUTPUT_PIN_23 = s_mDIN[4];
   assign FPGA_OUTPUT_PIN_24 = s_mDIN[5];
   assign FPGA_OUTPUT_PIN_25 = s_mDIN[6];
   assign FPGA_OUTPUT_PIN_26 = s_mDIN[7];
   assign s_mDOUT[0] = FPGA_INPUT_PIN_1;
   assign s_mDOUT[1] = FPGA_INPUT_PIN_2;
   assign s_mDOUT[2] = FPGA_INPUT_PIN_3;
   assign s_mDOUT[3] = FPGA_INPUT_PIN_4;
   assign s_mDOUT[4] = FPGA_INPUT_PIN_5;
   assign s_mDOUT[5] = FPGA_INPUT_PIN_6;
   assign s_mDOUT[6] = FPGA_INPUT_PIN_7;
   assign s_mDOUT[7] = FPGA_INPUT_PIN_8;
   assign FPGA_OUTPUT_PIN_27 = s_CO2;
   assign FPGA_OUTPUT_PIN_28 = s_CO1;
   /***************************************************************************
    ** Here all inlined adaptations are performed                            **
    ***************************************************************************/
   /***************************************************************************
    ** Here the clock tree components are defined                            **
    ***************************************************************************/
   LogisimTickGenerator #(.NrOfBits(1),
                          .ReloadValue(0))
      LogisimTickGenerator_0 (.FPGAClock(FPGA_GlobalClock),
                              .FPGATick(s_FPGA_Tick));

   LogisimClockComponent #(.HighTicks(1),
                           .LowTicks(1),
                           .NrOfBits(1))
      CLOCKGEN_0 (.ClockBus(s_LOGISIM_CLOCK_TREE_0),
                  .ClockTick(s_FPGA_Tick),
                  .GlobalClock(FPGA_GlobalClock));


   /***************************************************************************
    ** Here the toplevel component is connected                              **
    ***************************************************************************/
   cpu      cpu_0 (.CO1(s_CO1),
                   .CO2(s_CO2),
                   .LOGISIM_CLOCK_TREE_0(s_LOGISIM_CLOCK_TREE_0),
                   .R(s_R),
                   .mADDR(s_mADDR),
                   .mCLK(s_mCLK),
                   .mDIN(s_mDIN),
                   .mDOUT(s_mDOUT),
                   .mOEN(s_mOEN),
                   .mWE(s_mWE));


endmodule
