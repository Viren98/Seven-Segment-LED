entity comp is
port (  compin : in bit_vector (3 downto 0);
        compop : out bit
       );   
end comp;

architecture Comparator of comp is

begin
    compop <= '1'when (compin>"1001") else '0'; 
end Comparator;