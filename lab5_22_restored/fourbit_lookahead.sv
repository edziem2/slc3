module fourbit_lookahead (
	input [3:0] C, D,
	input seein,
	output [3:0] T,
	output logic Pg, Gg,
	output seeout);
	
	logic see1, see2, see3;
	logic [3:0] P, G;
	logic Pgin, Ggin;
	
	always_comb
	begin
	
	P[0] = C[0]^D[0];
	P[1] = C[1]^D[1];
	P[2] = C[2]^D[2];
	P[3] = C[3]^D[3];
	
	G[0] = C[0]&D[0];
	G[1] = C[1]&D[1];
	G[2] = C[2]&D[2];
	G[3] = C[3]&D[3];
	
	see1 = (seein&P[0])|G[0];
	see2 = ((seein&P[0]&P[1])|G[0]&P[1])|G[1];
	see3 = (((seein&P[0]&P[1]&P[2])|G[0]&P[1]&P[2])|G[1]&P[2])|G[2];
	
	Pg = P[0]&P[1]&P[2]&P[3];
	Gg = G[3]|G[2]&P[3]|G[1]&P[3]&P[2]|G[0]&P[3]&P[2]&P[1];
	end
	
	// Only last adder has cout port connected
	full_adder fa0(.x(C[0]), .y(D[0]), .z(seein), .s(T[0]));
	full_adder fa1(.x(C[1]), .y(D[1]), .z(see1), .s(T[1]));
	full_adder fa2(.x(C[2]), .y(D[2]), .z(see2), .s(T[2]));  	
	full_adder fa3(.x(C[3]), .y(D[3]), .z(see3), .s(T[3]), .c(seeout)); 
endmodule
