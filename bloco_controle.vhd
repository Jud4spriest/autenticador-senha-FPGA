library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bloco_controle is

	port(INICIO, OK, MUDA_SENHA: in std_logic;
			CLK, STATUS: in std_logic;
			EN1, EN2, EN3, ENS1, ENS2, ENS3: out std_logic;
			CMD_PISCA_LED, CLEAR : out std_logic;
			LED_ESTADO: out std_logic_vector(3 downto 0));
		
		
end bloco_controle;

architecture comp of bloco_controle is
signal C,C2 : integer :=0; --Inicializar como zero só por boas praticas
type classes_estados is(ini,libera_ini,wait1,wait2,wait3,dig1,dig2,dig3,digs1,
								digs2,digs3,verifica,correta,incorreta,bloqueio);
signal estado : classes_estados;


begin

process(CLK)
begin
		
			
	if(CLK' event and CLK ='1') then
		
		case estado is
		
			when ini =>
				LED_ESTADO <= "0000";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '1';
				CMD_PISCA_LED <= '0';

				if(INICIO = '1') then
				estado <= libera_ini;
				end if;
				
				
			when libera_ini =>
				LED_ESTADO <= "0001";
				
				if(INICIO = '0') then
					estado <= wait1;
				end if;
				
				
			when wait1 =>
				LED_ESTADO <= "0010";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if (INICIO = '1') then
					estado <= ini;
				elsif (OK = '1' and STATUS = '0') then 
					estado <= dig1;
				elsif (OK = '1' and STATUS = '1') then
					estado <= digs1;
				else
					estado<=wait1;
				end if;
					
			when wait2 =>
				LED_ESTADO <= "0011";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if (INICIO = '1') then
					estado <= ini;
				elsif (OK = '1' and STATUS = '0') then 
					estado <= dig2;
				elsif (OK = '1' and STATUS = '1') then
					estado <= digs2;
				else
					estado<=wait2;
				end if;
					
			when wait3 =>
				LED_ESTADO <= "0100";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if (INICIO = '1') then
					estado <= ini;
				elsif (OK = '1' and STATUS = '0') then 
					estado <= dig3;
				elsif (OK = '1' and STATUS = '1') then
					estado <= digs3;
				else
					estado<=wait3;
				end if;
				
				
			when dig1=>
				LED_ESTADO <= "0101";
				EN1 <= '1';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if (OK = '0') then 
				estado <= wait2;
				end if;

				
			when dig2=>
				LED_ESTADO <= "0110";
				EN1 <= '0';
				EN2 <= '1';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if (OK = '0') then 
				estado <= wait3;
				end if;

				
			when dig3=>
				LED_ESTADO <= "0111";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '1';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';

				if (OK = '0') then 
				estado <= verifica;
				end if;		

			when digs1=>
				LED_ESTADO <= "1000";
				EN1 <= '1';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '1';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
								
				if (OK = '0') then 
				estado <= wait2;
				end if;	
			

			when digs2=>
				LED_ESTADO <= "1001";
				EN1 <= '0';
				EN2 <= '1';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '1';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';			
				
				if (OK = '0') then 
				estado <= wait3;
				end if;	
				
				
			when digs3=>
				LED_ESTADO <= "1010";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '1';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '1';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
								
				if (OK = '0') then 
				estado <= ini;
				end if;
				
			
			when verifica =>
				LED_ESTADO <= "1011";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if(STATUS = '0') then
					C<=C+1;
					estado <= incorreta;
				else
					C<=0;
					estado <= correta;
				end if;
					
			when incorreta =>
				LED_ESTADO <= "1100";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '1';
				
				if (C = 3) then
					estado <= bloqueio;
				elsif(INICIO = '1' OR OK = '1') then
					estado <= ini;
				end if;
				
				
			when correta =>
				LED_ESTADO <= "1101";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '0';
				
				if(MUDA_SENHA = '1') then
					estado <= wait1;
				elsif(INICIO = '1') then
					estado <= ini;
				end if;
				
			when bloqueio =>
				LED_ESTADO <= "1110";
				EN1 <= '0';
				EN2 <= '0';
				EN3 <= '0';
				ENS1 <= '0';
				ENS2 <= '0';
				ENS3 <= '0';
				CLEAR <= '0';
				CMD_PISCA_LED <= '1';
				
				if(C2 < 30000) then
					C2 <= C2+1;
				else 
					C2 <= 0;
					C<=0;
					estado<=ini;
				end if;
				
				
			end case;
		end if;
	end process;
end comp;