entity pencoder is
	port ( a: in bit_vector (15 downto 0);
	       b: out bit_vector (3 downto 0);
			 c: out bit);
end pencoder;

architecture spencoder of pencoder is

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

end spencoder;

entity segdisplay is
	port (bcd: in bit_vector (3 downto 0);
		   sevseg: out bit_vector (6 downto 0); 
			m: in bit);
end segdisplay;

architecture arcsegdisplay of segdisplay is

	signal leds: bit_vector (6 downto 0);
	
begin
	process(bcd,m)
	begin
	if m = '0' then leds <= "1111111";
	else
	case bcd is
		         when "0000" =>leds <= "0000001";
				   when "0001" =>leds <= "1001111";
				   when "0010" =>leds <= "0010010";
				   when "0011" =>leds <= "0000110";
				   when "0100" =>leds <= "1001100";
				   when "0101" =>leds <= "0100100";
				   when "0110" =>leds <= "0100000";
				   when "0111" =>leds <= "0001111";
				   when "1000" =>leds <= "0000000";
				   when "1001" =>leds <= "0000100";
				   when others =>leds <= "1111111";
					end case;
					end if;
					end process;		
	sevseg <= not(leds);
end arcsegdisplay;

entity comp is
port (  compin : in bit_vector (3 downto 0);
        compop : out bit);   
end comp;

architecture Comparator of comp is

begin
    compop <= '1'when (compin>"1001") else '0'; 
end Comparator;

entity bitsub is
	port(A0,B0,C0 : in bit;
			DF, BR : out bit);
	end bitsub;
	
	architecture bitsubarc of bitsub is
	begin 
	DF <= A0 xor B0 xor C0;
	BR <= ((not A0) and (B0 or C0)) or (B0 and C0);
	end bitsubarc;
	
entity sub is
     port(  A0 : in bit_vector(3 downto 0);
				B0 : in bit_vector(3 downto 0);
				BR : out bit;
				DF : out bit_vector(3 downto 0));
end sub;

architecture subarc of sub is  

Component bitsub is
    port (A0 : in bit;
          B0 : in bit;
          C0 : in bit;
          DF : out bit;
          BR : out bit);
end component;      

signal S0 : bit_vector(2 downto 0);

begin  
  
    sb0 : bitsub port map (A0(0),'1','1',DF(0),S0(0));
    sb1 : bitsub port map (A0(1),'0',S0(0),DF(1),S0(1));
    sb2 : bitsub port map (A0(2),'0',S0(1),DF(2),S0(2));
    sb3 : bitsub port map (A0(3),'1',S0(2),DF(3),BR);    
  

end subarc;            

entity mux2in is
    Port ( A1,B1   : in  bit_vector (3 downto 0);
         --  B1   : in  bit_vector (3 downto 0);
			  S1 : in  bit;
           X1   : out bit_vector (3 downto 0));
end mux2in;

architecture marc of mux2in is
begin
    X1 <= A1 when (S1 = '0') else B1;
end marc;



entity seg7 is
	port ( I: in bit_vector (15 downto 0);
			 Fout1: out bit_vector (6 downto 0);
			 Fout2: out bit_vector (6 downto 0));
end seg7;

architecture main of seg7 is

component pencoder is
	port ( a: in bit_vector (15 downto 0);
	       b: out bit_vector (3 downto 0);
			 c: out bit);
end component;

component segdisplay is
	port (bcd: in bit_vector (3 downto 0);
		   sevseg: out bit_vector (6 downto 0);
			m: in bit);
end component;

component comp is
port (  compin : in bit_vector (3 downto 0);
        compop : out bit);   
end component;

component sub is
     port(  A0 : in bit_vector(3 downto 0);
				B0 : in bit_vector(3 downto 0);
				BR : out bit;
				DF : out bit_vector(3 downto 0));
end component;

component mux2in is
    Port ( A1   : in  bit_vector (3 downto 0);
           B1   : in  bit_vector (3 downto 0);
			  S1 : in  bit;
           X1   : out bit_vector (3 downto 0));
end component;

signal F1,F2,F4,F5 : bit_vector (3 downto 0); 
signal F3,F6,t1 : bit;

begin

en1 : pencoder port map (I,F1,F6);

subtrac : sub port map (F1,"1001",t1,F2);

comparator : comp port map (F1,F3);

mx1 : mux2in port map (F1,F2,F3,F4);
mx2 : mux2in port map ("0000","0001",F3,F5);

SeO1 : segdisplay port map (F5,Fout1,F3);
SeO2 : segdisplay port map (F4,Fout2,F6);

end main;
