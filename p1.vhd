entity p1 is
	port ( a: in bit_vector (15 downto 0);
	       b: out bit_vector (3 downto 0);
			 c: out bit);
end p1;

architecture structure of p1 is

begin
process(a)
begin
 if a = "0000000000000000" then 
 c <= '0' ;
 else
	c <= '1' ;
	end if;
	end process;
	
	b <= "1111" when a(15) = '1' else
	     "1110" when a(14) = '1' else
	     "1101" when a(13) = '1' else
	     "1100" when a(12) = '1' else
	     "1011" when a(11) = '1' else
	     "1010" when a(10) = '1' else
		  "1001" when a(9) = '1' else
		  "1000" when a(8) = '1' else
	     "0111" when a(7) = '1' else
	     "0110" when a(6) = '1' else
	     "0101" when a(5) = '1' else
	     "0100" when a(4) = '1' else
	     "0011" when a(3) = '1' else
		  "0010" when a(2) = '1' else
		  "0001" when a(1) = '1' else
		  "0000" when a(0) = '1';


end structure;

