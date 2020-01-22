library ieee;
use ieee.std_logic_1164.all;

entity flash is
	port(
		SW			: in std_logic_vector(9 downto 0);
		KEY		: in std_logic_vector(3 downto 0);
		LEDR		: out std_logic_vector(9 downto 0);
		LEDG		: out std_logic_vector(7 downto 0);
		HEX0		: out std_logic_vector(6 downto 0);
		FL_ADDR	: out std_logic_vector(21 downto 0); --ENDEREÇO
		FL_DQ		: in std_logic_vector(7 downto 0); --ARMAZENADO
		FL_OE_N	: out std_logic; --LER
		FL_RST_N	: out std_logic; --RESET
		FL_WE_N	: out std_logic; --ESCRVER
		PS2_CLK 		: in std_logic; --CLOCK TECLADO
		PS2_DAT		: in std_logic --DATA DO TECLADO
	);
end entity;

architecture arch of flash is

	component PS2_KEYBOARD is
		port(
			PS2_CLK 		: in std_logic; --CLOCK DO TECLADO
			PS2_DAT		: in std_logic; --DATA DO TECLADO
			ps2_code		: out std_logic_vector(7 downto 0); --DATA COMPLETO DO TECLADO
			has_data		: out std_logic --CONFERE DATA
		);
	end component;
	
	signal ps2_code : std_logic_vector(7 downto 0);
	signal has_data : std_logic;
	
	signal ADD : std_logic_vector(7 downto 0);
	
begin

	PS2: PS2_KEYBOARD
		port map(
			PS2_CLK,
			PS2_DAT,
			ps2_code,
			has_data
		);

	LEDG <= ps2_code;
	
	with ps2_code select 
		ADD <=
			x"00" when "01000101",
			x"01" when "00010110",
			x"02" when "00011110",
			x"03" when "00100110",
			x"04" when "00100101",
			x"05" when "00101110",
			x"06" when "00110110",
			x"07" when "00111101",
			x"08" when "00111110",
			x"09" when "01000110",
			x"0A" when OTHERS;
------------------------------------------------------------------------------------

	--FL_ADDR <= "000000000000" & SW;
	FL_ADDR <= "00000000000000" & ADD;
	LEDR(7 downto 0) <= FL_DQ;

	HEX0(0)<=FL_DQ(6);
	HEX0(1)<=FL_DQ(5);
	HEX0(2)<=FL_DQ(4);
	HEX0(3)<=FL_DQ(3);
	HEX0(4)<=FL_DQ(2);
	HEX0(5)<=FL_DQ(1);
	HEX0(6)<=FL_DQ(0);

	FL_OE_N	<= '0';--KEY(0);
	FL_RST_N	<= '1';
	FL_WE_N	<= '1';
	
end arch;
