
library ieee;
use ieee.std_logic_1164.all;

entity somador_completo is
        port(
                A, B, Cin: in std_logic;
                S, Cout: out std_logic
        );
end somador_completo;

architecture ci of somador_completo is

signal temp: std_logic;

begin
        temp<=A xor B;
        S<=temp xor Cin;
        Cout<=(A and B) or (temp and Cin);
end ci;



entity testbench is
end testbench;

architecture test of testbench is

component somador_completo is
        port(
                A, B, Cin: in bit;
                S, Cout: out bit
        );
  end component;

signal inputs: bit_vector(2 downto 0):= "000";
signal outputs: bit_vector(1 downto 0);

begin
        DUT: somador_completo port map(inputs(0), inputs(1), inputs(2), outputs(0), outputs(1));
        
        inputs<="001" after 10 ns,
                          "010" after 20 ns,
                          "011" after 30 ns,
                          "100" after 40 ns,
                          "101" after 50 ns,
                          "110" after 60 ns,
                          "111" after 70 ns;
end test;
