library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topo is

	port(CLOCK_50: in std_logic;
		SW: in std_logic_vector(17 downto 0);
		KEY: in std_logic_vector(2 downto 0);
		HEX0, HEX1, HEX2: out std_logic_vector(6 downto 0);
		LEDR: out std_logic_vector(17 downto 0));
	
end topo;

architecture behavior of topo is

signal E: std_logic_vector(5 downto 0);
signal divisor_clock, clear, led, status: std_logic;


component divisorFrequencia

	generic(freqIn : integer := 50000000;
	       freqOut : integer := 1);
	port(clockIn : in std_logic;
	    clockOut: out std_logic);	

end component;

component bloco_controle

	port(INICIO, OK, MUDA_SENHA: in std_logic;
			CLK, STATUS: in std_logic;
			EN1, EN2, EN3, ENS1, ENS2, ENS3: out std_logic;
			CMD_PISCA_LED, CLEAR : out std_logic;
			LED_ESTADO: out std_logic_vector(3 downto 0));

end component;

component bloco_operativo

	port(DATA: in std_logic_vector(3 downto 0);
		CLK, CLEAR: in std_logic;
		EN1, EN2, EN3: in std_logic;
		ENS1, ENS2, ENS3: in std_logic;
		CMD_PISCA_LED: in std_logic;
		LED_SENHA_ERRADA: out std_logic;
		STATUS_SENHA: out std_logic;
		DISPLAY1, DISPLAY2, DISPLAY3: out std_logic_vector(6 downto 0));
		
end component;

begin

	CL: divisorFrequencia generic map(freqIn=>50000000, freqOut=>1000)
								  port map(clockIn=>CLOCK_50, clockOut=>divisor_clock);
			 
	CT: bloco_controle port map(INICIO=> KEY(0), OK=> KEY(1), MUDA_SENHA=> KEY(2),
										CLK=>divisor_clock, STATUS=>status,
										EN1=>E(0), EN2=>E(1), EN3=>E(2), ENS1=>E(3), ENS2=>E(4), ENS3=>E(5),
										CMD_PISCA_LED=>led, CLEAR=>clear, LED_ESTADO=>LEDR(17 downto 14));
	
	OP: bloco_operativo port map(DATA=>SW(3 downto 0),
										CLK=>divisor_clock, CLEAR=>clear,
										EN1=>E(0), EN2=>E(1), EN3=>E(2),
										ENS1=>E(3), ENS2=>E(4), ENS3=>E(5),
										CMD_PISCA_LED=>led,
										LED_SENHA_ERRADA=>LEDR(0),
										STATUS_SENHA=>status,
										DISPLAY1=>HEX2, DISPLAY2=>HEX1, DISPLAY3=>HEX0);

	LEDR(1)<=status;
end behavior;