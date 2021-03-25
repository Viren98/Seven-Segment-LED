entity mux2in is
    Port ( A   : in  bit_vector (3 downto 0);
           B   : in  bit_vector (3 downto 0);
           X   : out bit_vector (3 downto 0);
			  S : in  bit);
end mux2in;

architecture marc of mux2in is
begin
    X <= A when (S = '1') else B;
end marc;