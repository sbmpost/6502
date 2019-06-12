module MEMORY(
  input CLK,
  input WE,
  input[15:0] Address,
  input[7:0] DataIn,
  output reg[7:0] DataOut
);

  reg [7:0] s_mem_contents[65535:0];
//  reg [7:0] s_mem_contents[1023:0];

  initial begin
      // LDX #07 (x=7)
      s_mem_contents[00] = 8'ha2;
      s_mem_contents[01] = 8'h07;
      // LDY #08 (y=8)
      s_mem_contents[02] = 8'ha0;
      s_mem_contents[03] = 8'h08;
      // LDA $00ff,y (y=8)
      s_mem_contents[04] = 8'hb9;
      s_mem_contents[05] = 8'hff;
      s_mem_contents[06] = 8'h00;
      // LDA $0108,y (y=8)
      s_mem_contents[07] = 8'hb9;
      s_mem_contents[08] = 8'h08;
      s_mem_contents[09] = 8'h01;
      // LDA $01f0,x (x=7)
      s_mem_contents[10] = 8'hbd;
      s_mem_contents[11] = 8'hf0;
      s_mem_contents[12] = 8'h01;
      // LDA $30,x (x=7)
      s_mem_contents[13] = 8'hb5;
      s_mem_contents[14] = 8'h30;
      // LDA $40,x (x=7)
      s_mem_contents[15] = 8'hb5;
      s_mem_contents[16] = 8'h40;
      // LDA $ff,x (x=7), should access $0006
      s_mem_contents[17] = 8'hb5;
      s_mem_contents[18] = 8'hff;
      // LDA $0110
      s_mem_contents[19] = 8'had;
      s_mem_contents[20] = 8'h10;
      s_mem_contents[21] = 8'h01;
      // LDA $37
      s_mem_contents[22] = 8'ha5;
      s_mem_contents[23] = 8'h37;
      // LDA ($1e),y (y=8, $1e=fc, $1f=02), should access $0304
      s_mem_contents[24] = 8'hb1;
      s_mem_contents[25] = 8'h1e;
      // JMP $0021
      s_mem_contents[26] = 8'h4c;
      s_mem_contents[27] = 8'h21;
      s_mem_contents[28] = 8'h00;

      // data
      s_mem_contents[29] = 8'h00;
      s_mem_contents[30] = 8'hfc;
      s_mem_contents[31] = 8'h02;
      s_mem_contents[32] = 8'hfe;

      // STA $0108,y (y=8)
      s_mem_contents[33] = 8'h99;
      s_mem_contents[34] = 8'h08;
      s_mem_contents[35] = 8'h01;
      // LDA #19
      s_mem_contents[36] = 8'ha9;
      s_mem_contents[37] = 8'h19;
      // LDA $0108,y (y=8)
      s_mem_contents[38] = 8'hb9;
      s_mem_contents[39] = 8'h08;
      s_mem_contents[40] = 8'h01;
      // LDA #20
      s_mem_contents[41] = 8'ha9;
      s_mem_contents[42] = 8'h20;
      // STA $00ff,x (x=7) $0106
      s_mem_contents[43] = 8'h9d;
      s_mem_contents[44] = 8'hff;
      s_mem_contents[45] = 8'h00;
      // LDA #21
      s_mem_contents[46] = 8'ha9;
      s_mem_contents[47] = 8'h21;
      // LDA $00ff,x (x=7) $0106
      s_mem_contents[48] = 8'hbd;
      s_mem_contents[49] = 8'hff;
      s_mem_contents[50] = 8'h00;
      // JMP $0305
      s_mem_contents[51] = 8'h4c;
      s_mem_contents[52] = 8'h05;
      s_mem_contents[53] = 8'h03;

      // data
      s_mem_contents[55] = 8'hdd;
      s_mem_contents[71] = 8'hee;
      s_mem_contents[263] = 8'haa;
      s_mem_contents[272] = 8'hbb;
      s_mem_contents[503] = 8'hcc;
      s_mem_contents[512] = 8'h03;

      // LDX $01ab,y
      s_mem_contents[721] = 8'hbe; // $02d1
      s_mem_contents[722] = 8'hab;
      s_mem_contents[723] = 8'h01;
      // STX $77,y
      s_mem_contents[724] = 8'h96;
      s_mem_contents[725] = 8'h77;
      // DEX
      s_mem_contents[726] = 8'hca;
      // LDA ($20,x)
      s_mem_contents[727] = 8'ha1;
      s_mem_contents[728] = 8'h20;
      // BVC $79
      s_mem_contents[729] = 8'h50;
      s_mem_contents[730] = 8'h78; // $02d9

      // data
      s_mem_contents[766] = 8'h33; // $02fe
      s_mem_contents[767] = 8'h10; // $02ff
      s_mem_contents[772] = 8'hff; // $0304

      // INX
      s_mem_contents[773] = 8'he8;
      // INY
      s_mem_contents[774] = 8'hc8;
      // DEX
      s_mem_contents[775] = 8'hca;
      // DEY
      s_mem_contents[776] = 8'h88;
      // JMP ($02ff)
      s_mem_contents[777] = 8'h6c;
      s_mem_contents[778] = 8'hff;
      s_mem_contents[779] = 8'h02;
      s_mem_contents[780] = 8'h00;
      s_mem_contents[781] = 8'h00;
      s_mem_contents[782] = 8'h00;
      s_mem_contents[783] = 8'h00;
      // TXA
      s_mem_contents[784] = 8'h8a;
      // TYA
      s_mem_contents[785] = 8'h98;
      // TAX
      s_mem_contents[786] = 8'haa;
      // INY
      s_mem_contents[787] = 8'hc8;
      // TAY
      s_mem_contents[788] = 8'ha8;
      // INY
      s_mem_contents[789] = 8'hc8;
      // ORA $02f7,x (x=8)
      s_mem_contents[790] = 8'h1d;
      s_mem_contents[791] = 8'hf7;
      s_mem_contents[792] = 8'h02;
      // AND $0b
      s_mem_contents[793] = 8'h25;
      s_mem_contents[794] = 8'h0b;
      // EOR ($1e),y (y=8)
      s_mem_contents[795] = 8'h51;
      s_mem_contents[796] = 8'h1e;
      // ADC #08
      s_mem_contents[797] = 8'h69;
      s_mem_contents[798] = 8'h08;
      // ADC $02fc,x (x=8)
      s_mem_contents[799] = 8'h7d;
      s_mem_contents[800] = 8'hfc;
      s_mem_contents[801] = 8'h02;
      // SBC #44
      s_mem_contents[802] = 8'he9;
      s_mem_contents[803] = 8'h44;
      // CPY $01
      s_mem_contents[804] = 8'hc4;
      s_mem_contents[805] = 8'h01;
      // CPX $0304
      s_mem_contents[806] = 8'hec;
      s_mem_contents[807] = 8'h04;
      s_mem_contents[808] = 8'h03;
      // CMP ($1e),y
      s_mem_contents[809] = 8'hd1;
      s_mem_contents[810] = 8'h1e;
      // INC $02ff
      s_mem_contents[811] = 8'hee;
      s_mem_contents[812] = 8'hff;
      s_mem_contents[813] = 8'h02;
      // LDX $02ff
      s_mem_contents[814] = 8'hae;
      s_mem_contents[815] = 8'hff;
      s_mem_contents[816] = 8'h02;
      // DEC $08,x
      s_mem_contents[817] = 8'hd6;
      s_mem_contents[818] = 8'h08;
      // LDA #81
      s_mem_contents[819] = 8'ha9;
      s_mem_contents[820] = 8'h81;
      // LSR A
      s_mem_contents[821] = 8'h4a;
      // ROL A
      s_mem_contents[822] = 8'h2a;
      // ASL A
      s_mem_contents[823] = 8'h0a;
      // ROR A
      s_mem_contents[824] = 8'h6a;
      // LDY $08,x
      s_mem_contents[825] = 8'hb4;
      s_mem_contents[826] = 8'h08;
      // LSR $08,x
      s_mem_contents[827] = 8'h56;
      s_mem_contents[828] = 8'h08;
      // LDY $08,x
      s_mem_contents[829] = 8'hb4;
      s_mem_contents[830] = 8'h08;
      // ASL $08,x
      s_mem_contents[831] = 8'h16;
      s_mem_contents[832] = 8'h08;
      // LDY $08,x
      s_mem_contents[833] = 8'hb4;
      s_mem_contents[834] = 8'h08;
      // ROR $08,x
      s_mem_contents[835] = 8'h76;
      s_mem_contents[836] = 8'h08;
      // LDY $08,x
      s_mem_contents[837] = 8'hb4;
      s_mem_contents[838] = 8'h08;
      // ROL $08,x
      s_mem_contents[839] = 8'h36;
      s_mem_contents[840] = 8'h08;
      // LDY $08,x
      s_mem_contents[841] = 8'hb4;
      s_mem_contents[842] = 8'h08;
      // SEC
      s_mem_contents[843] = 8'h38;
      // CLC
      s_mem_contents[844] = 8'h18;
      // CLV
      s_mem_contents[845] = 8'hb8;
      // BVS $01
      s_mem_contents[846] = 8'h70; // $034e
      s_mem_contents[847] = 8'h01; // $034f
      // BVC $80
      s_mem_contents[848] = 8'h50; // $0350
      s_mem_contents[849] = 8'h80; // $0351
      // INX
      s_mem_contents[850] = 8'he8;
      // DEX
      s_mem_contents[851] = 8'hca;
      // LDA #01
      s_mem_contents[852] = 8'ha9;
      s_mem_contents[853] = 8'h01;
      // TXA
      s_mem_contents[854] = 8'h8a;
      // TSX
      s_mem_contents[855] = 8'hba;
      // NOP
      s_mem_contents[856] = 8'hea;
      // PHP
      s_mem_contents[857] = 8'h08;
      // PHA
      s_mem_contents[858] = 8'h48;
      // PLP
      s_mem_contents[859] = 8'h28;
      // PLA
      s_mem_contents[860] = 8'h68;
      // NOP
      s_mem_contents[861] = 8'hea;
      // JSR $0364
      s_mem_contents[862] = 8'h20; // $035e
      s_mem_contents[863] = 8'h64; // $035f
      s_mem_contents[864] = 8'h03; // $0360
      // JMP $0366
      s_mem_contents[865] = 8'h4c; // $0361
      s_mem_contents[866] = 8'h66; // $0362
      s_mem_contents[867] = 8'h03; // $0363
      // NOP
      s_mem_contents[868] = 8'hea; // $0364
      // RTS
      s_mem_contents[869] = 8'h60; // $0365
      // NOP
      s_mem_contents[870] = 8'hea; // $0366

// REMAINING:
      // RTS, BRK, RTI
  end

  always @(posedge CLK) begin
    if (WE)
      s_mem_contents[Address] <= DataIn;
    else
      DataOut <= s_mem_contents[Address];
  end

endmodule
