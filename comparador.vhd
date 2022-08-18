library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparador is
  generic(N: integer := 4);
  port(A, B: in std_logic_vector(N-1 downto 0);
       Y: out std_logic);
end comparador;

architecture comp of comparador is
begin

  Y <= '1' when A = B else
       '0';

end comp;