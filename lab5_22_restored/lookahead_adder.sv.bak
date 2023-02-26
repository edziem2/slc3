module lookahead_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);
    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
		
		logic sea1, sea2, sea3;
		logic [3:0] PG, GG;
		
		always_comb
		begin
		
		sea1 = (cin&PG[0])|GG[0];
		sea2 = ((cin&PG[0]&PG[1])|GG[0]&PG[1])|GG[1];
		sea3 = (((cin&PG[0]&PG[1]&PG[2])|GG[0]&PG[1]&PG[2])|GG[1]&PG[2])|GG[2];
		end
		
		// Only last adder has out port connected
	   fourbit_lookahead cla0(.C(A[3:0]), .D(B[3:0]), .seein(cin), .T(S[3:0]), .Pg(PG[0]), .Gg(GG[0]));
		fourbit_lookahead cla1(.C(A[7:4]), .D(B[7:4]), .seein(sea1), .T(S[7:4]), .Pg(PG[1]), .Gg(GG[1]));
		fourbit_lookahead cla2(.C(A[11:8]), .D(B[11:8]), .seein(sea2), .T(S[11:8]), .Pg(PG[2]), .Gg(GG[2]));
		fourbit_lookahead cla3(.C(A[15:12]), .D(B[15:12]), .seein(sea3), .T(S[15:12]), .Pg(PG[3]), .Gg(GG[3]), .seeout(cout));  		

endmodule
	