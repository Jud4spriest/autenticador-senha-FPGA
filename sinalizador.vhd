library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sinalizador is
  port(EN, CLK: in std_logic;
       Y: out std_logic);
end sinalizador;

architecture comp of sinalizador is

  component divisorFrequencia
    generic(freqIn : integer := 50000000;
	         freqOut : integer := 1);
    port(clockIn : in std_logic;
	      clockOut: out std_logic);
  end component;

  signal AUX: std_logic;
  
begin

 Y <= AUX when EN='1' else
      '0';

 L0: divisorFrequencia generic map(freqIn=>1000, freqOut=>1)
     port map(clockIn=>CLK, clockOut=>AUX);

end comp;