
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
