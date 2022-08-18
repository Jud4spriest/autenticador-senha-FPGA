library ieee;
use ieee.std_logic_1164.all;

entity decod_7seg is
  port(x: in std_logic_vector(3 downto 0);
		 y: out std_logic_vector(6 downto 0));
end decod_7seg;

architecture comp of decod_7seg is
begin

  y <= "1000000" when x="0000" else
	    "1111001" when x="0001" else
	    "0100100" when x="0010" else
	    "0110000" when x="0011" else
	    "0011001" when x="0100" else
	    "0010010" when x="0101" else
	    "0000010" when x="0110" else
	    "1111000" when x="0111" else
	    "0000000" when x="1000" else
	    "0011000" when x="1001" else
		 "0001000" when x="1010" else
	    "1111111"; 
				 
end comp;
