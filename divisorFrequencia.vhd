library ieee;
use ieee.std_logic_1164.all;
			
entity divisorFrequencia is
  generic(freqIn : integer := 50000000;
	       freqOut : integer := 1);
  port(clockIn : in std_logic;
	    clockOut: out std_logic);
end divisorFrequencia;
			
architecture behavior of divisorFrequencia is
  signal clock : std_logic := '0';
  constant COUNT_MAX : integer := ((freqIn/freqOut)/2) - 1;
begin
			
  clockOut <= clock;
			
  process(clockIn)
    variable counter : integer range 0 to COUNT_MAX := 0;
  begin
    if (clockIn'event and clockIn='1') then
	   if (counter < COUNT_MAX) then
		  counter := counter + 1;
		else
		  counter := 0;
		  clock <= NOT clock;
	   end if;
	  end if;
  end process;
			
end behavior;