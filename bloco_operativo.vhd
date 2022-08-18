library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bloco_operativo is

  port(DATA: in std_logic_vector(3 downto 0);
       CLK, CLEAR: in std_logic;
		 EN1, EN2, EN3: in std_logic;
		 ENS1, ENS2, ENS3: in std_logic;
		 CMD_PISCA_LED: in std_logic;
		 LED_SENHA_ERRADA: out std_logic;
		 STATUS_SENHA: out std_logic;
		 DISPLAY1, DISPLAY2, DISPLAY3: out std_logic_vector(6 downto 0));

end bloco_operativo;

architecture comp of bloco_operativo is
  
  component reg
    generic(N: integer := 4;
            D0: integer := 0);
    port(D: in std_logic_vector(N-1 downto 0);
         EN, CLEAR, CLK: in std_logic;
		   Q: out std_logic_vector(N-1 downto 0));
  end component;

  
  component comparador
    generic(N: integer := 4);
    port(A, B: in std_logic_vector(N-1 downto 0);
         Y: out std_logic);
  end component;

  
  component decod_7seg
    port(x: in std_logic_vector(3 downto 0);
		   y: out std_logic_vector(6 downto 0));
  end component;

  
  component sinalizador
    port(EN, CLK: in std_logic;
         Y: out std_logic);
  end component;
  
  
  component contador is
    generic(max : integer := 30000);
    port(X, CLK: in std_logic;
         Y: out std_logic);
  end component;
  
  
  signal F1, F2, F3, F1S, F2S, F3S: std_logic_vector(3 downto 0);
  signal F1C, F2C, F3C: std_logic;
  signal F1D, F2D, F3D: std_logic_vector(3 downto 0);
  
begin


  R1: reg generic map(N=>4, D0=>0)
          port map(D=>DATA, EN=>EN1, CLEAR=>CLEAR, CLK=>CLK, Q=>F1);

  R2: reg generic map(N=>4, D0=>0)
          port map(D=>DATA, EN=>EN2, CLEAR=>CLEAR, CLK=>CLK, Q=>F2);
			 
  R3: reg generic map(N=>4, D0=>0)
          port map(D=>DATA, EN=>EN3, CLEAR=>CLEAR, CLK=>CLK, Q=>F3);

  RS1: reg generic map(N=>4, D0=>1)
           port map(D=>DATA, EN=>ENS1, CLEAR=>'0', CLK=>CLK, Q=>F1S);	
		
  RS2: reg generic map(N=>4, D0=>2)
           port map(D=>DATA, EN=>ENS2, CLEAR=>'0', CLK=>CLK, Q=>F2S);

  RS3: reg generic map(N=>4, D0=>3)
           port map(D=>DATA, EN=>ENS3, CLEAR=>'0', CLK=>CLK, Q=>F3S);
			 
  C1: comparador generic map(N=>4)
                 port map(A=>F1, B=>F1S, Y=>F1C);
  
  C2: comparador generic map(N=>4)
                 port map(A=>F2, B=>F2S, Y=>F2C);
  
  C3: comparador generic map(N=>4)
                 port map(A=>F3, B=>F3S, Y=>F3C);
					  
				 
  D1: decod_7seg port map(X=>F1, Y=>DISPLAY1);				 
  
  D2: decod_7seg port map(X=>F2, Y=>DISPLAY2);	
  
  D3: decod_7seg port map(X=>F3, Y=>DISPLAY3);	
  
  S1: sinalizador port map(EN=>CMD_PISCA_LED, CLK=>CLK, Y=>LED_SENHA_ERRADA);
  
  
  STATUS_SENHA <= F1C and F2C and F3C;
  		 
end comp;