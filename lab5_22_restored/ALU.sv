module alu (
	input logic [15:0] A, B,
	input logic [1:0] ALUK,
	output logic [15:0] ALU
);

// 00: ADD
// 01: AND
// 10: NOT
// 11: Pass A->ALU_OUT

always_comb 
begin
	ALU = 16'b0;
	if (ALUK == 2'b00)
		ALU = A + B;
	else if (ALUK == 2'b01)
		ALU = A & B;
	else if (ALUK == 2'b10)
		ALU = ~A;
	else if (ALUK == 2'b11)
		ALU = A;
	
end

endmodule 