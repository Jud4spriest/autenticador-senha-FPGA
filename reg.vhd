library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
  generic(N: integer := 4;
          D0: integer := 0);
			 
  port(D: in std_logic_vector(N-1 downto 0);
       EN, CLEAR, CLK: in std_logic;
		 Q: out std_logic_vector(N-1 downto 0));
end reg;

architecture comp of reg is

  signal DATA : std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(D0, N));

begin

  Q <= DATA;

  process(CLK, CLEAR)
  begin
  
    if(CLK'event and CLK='1') then
	   if(CLEAR = '1') then
		  DATA <= (others=>'0');
		  
		elsif(EN='1') then
		  DATA <= D;
		  
		end if;
	 end if;
	 
  end process;

end comp;