//==============================================================================
//== Logisim goes FPGA automatic generated VHDL code                          ==
//==                                                                          ==
//==                                                                          ==
//== Project   : 6502_k                                                       ==
//== Component : Mem                                                          ==
//==                                                                          ==
//==============================================================================

module MEMORY(
  Address,
  Clock,
  DataIn,
  OE,
  Tick,
  WE,
  DataOut
);

input [15:0] Address;
input Clock;
input [7:0] DataIn;
input OE;
input Tick;
input WE;
output [7:0] DataOut;

wire [15:0] Address;
wire Clock;
wire [7:0] DataIn;
wire OE;
wire Tick;
wire WE;
reg [7:0] DataOut;

  //---------------------------------------------------------------------------
  // Here all used signals are defined                                       --
  //---------------------------------------------------------------------------
  wire s_RAM_enable;
  wire s_oe;
  reg [7:0] s_ram_data_out;
  wire s_we;
  reg [15:0] s_Address_reg;
  reg [7:0] s_DataInReg;
  reg s_OEReg;
  reg [1:0] s_TickDelayLine;
  reg s_WEReg;
  reg [7:0] s_mem_contents[65535:0];

  //---------------------------------------------------------------------------
  // Here the control signals are defined                                    --
  //---------------------------------------------------------------------------
  assign s_RAM_enable = s_TickDelayLine[0];
  assign s_oe = s_TickDelayLine[1] & s_OEReg;
  assign s_we = s_TickDelayLine[0] & s_WEReg;
  
  initial begin
      s_mem_contents[00] = {8'ha2};
      s_mem_contents[01] = {8'h07};
      s_mem_contents[02] = {8'ha0};
      s_mem_contents[03] = {8'h08};
      s_mem_contents[04] = {8'hb9};
      s_mem_contents[05] = {8'hff};
      s_mem_contents[06] = {8'h00};
      s_mem_contents[07] = {8'hb9};
      s_mem_contents[08] = {8'h08};
      s_mem_contents[09] = {8'h01};
      s_mem_contents[10] = {8'hbd};
      s_mem_contents[11] = {8'hf0};
      s_mem_contents[12] = {8'h01};
      s_mem_contents[13] = {8'hb5};
      s_mem_contents[14] = {8'h30};
      s_mem_contents[15] = {8'hb5};
      s_mem_contents[16] = {8'h40};
      s_mem_contents[17] = {8'hb5};
      s_mem_contents[18] = {8'hff};
      s_mem_contents[19] = {8'had};
      s_mem_contents[20] = {8'h10};
      s_mem_contents[21] = {8'h01};
      s_mem_contents[22] = {8'ha5};
      s_mem_contents[23] = {8'h37};
      s_mem_contents[24] = {8'ha9};
      s_mem_contents[25] = {8'h18};
      s_mem_contents[26] = {8'hb1};
      s_mem_contents[27] = {8'h1e};
      s_mem_contents[28] = {8'h00};
      s_mem_contents[29] = {8'h00};
      s_mem_contents[30] = {8'hfc};
      s_mem_contents[31] = {8'h02};

      s_mem_contents[55] = {8'hdd};
      s_mem_contents[71] = {8'hee};
      s_mem_contents[263] = {8'haa};
      s_mem_contents[272] = {8'hbb};
      s_mem_contents[503] = {8'hcc};
      s_mem_contents[772] = {8'hff};
  end

  //---------------------------------------------------------------------------
  // Here the input registers are defined                                    --
  //---------------------------------------------------------------------------
  always @(posedge Clock) begin
    if((Tick == 1'b 1)) begin
      s_DataInReg <= DataIn;
      s_Address_reg <= Address;
      s_WEReg <= WE;
      s_OEReg <= OE;
    end
  end

  always @(posedge Clock) begin
    s_TickDelayLine[0] <= Tick;
    s_TickDelayLine[1] <= s_TickDelayLine[0];
  end

  //---------------------------------------------------------------------------
  // Here the actual memorie(s) is(are) defined                              --
  //---------------------------------------------------------------------------
  always @(posedge Clock) begin
    if((s_RAM_enable == 1'b 1)) begin
      if((s_we == 1'b 1)) begin
        s_mem_contents[(s_Address_reg)] <= s_DataInReg;
      end
      s_ram_data_out <= s_mem_contents[(s_Address_reg)];
    end
  end

  //---------------------------------------------------------------------------
  // Here the output register is defined                                     --
  //---------------------------------------------------------------------------
  always @(posedge Clock) begin
    if((s_oe == 1'b 1)) begin
      DataOut <= s_ram_data_out;
    end
  end

endmodule
