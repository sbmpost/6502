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

  always @(posedge CLK) begin
    if (WE) begin
      s_mem_contents[Address] <= DataIn;
    end
    DataOut <= s_mem_contents[Address];
  end

endmodule
