entity bitsub is
	port(A,B,C : in bit;
			DF, BR : out bit);
		end bitsub;
	architecture bitsubarc of bitsub is
	begin 
	DF <= A xor B xor C;
	BR <= ((not A) and (B or C)) or (B and C);
	end bitsubarc;

entity sub is
     port(  A : in bit_vector(3 downto 0);
				B : in bit_vector(3 downto 0);
				BR : out bit;
				DF : out bit_vector(3 downto 0));
end sub;

architecture subarc of sub is  

Component bitsub is
    port (A : in bit;
          B : in bit;
          C : in bit;
          DF : out bit;
          BR : out bit);
end component;      

signal S : bit_vector(2 downto 0);

begin  
  
    sb0 : bitsub port map (A(0),'1','1',DF(0),S(0));
    sb1 : bitsub port map (A(1),'0',S(0),DF(1),S(1));
    sb2 : bitsub port map (A(2),'0',S(1),DF(2),S(2));
    sb3 : bitsub port map (A(3),'1',S(2),DF(3),BR);    
  

end subarc;            
