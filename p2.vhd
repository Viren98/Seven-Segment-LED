
entity p2 is
	port (bcd: in bit_vector (3 downto 0);
		   sevseg: out bit_vector (6 downto 0);
			c: in bit);
			
end p2;

architecture structure of p2 is

	signal leds: bit_vector (6 downto 0);
	
begin
	process(bcd,c)
	begin
	if c = '0' then leds <= "1111111";
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
end structure;

