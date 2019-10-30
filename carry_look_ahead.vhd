
library ieee;
use ieee.std_logic_1164.all;

entity carry_look_ahead is
        port(
                A, B: in std_logic_vector(3 downto 0);
                cin: in std_logic;
                S: out std_logic_vector(3 downto 0);
                cout: out std_logic
        );
end carry_look_ahead;

architecture cla of carry_look_ahead is

signal P, G: std_logic_vector(3 downto 0);
signal c: std_logic_vector(4 downto 0);

component p_g is
        port(
                A, B: in std_logic;
                P, G: out std_logic
        );
end component;

begin
                laco: for i in 0 to 3 generate
                        x: p_g port map(A(i), B(i), P(i), G(i));
                        S(i)<=c(i) xor P(i);
                end generate;
                
                c(0)<=cin;
                c(1)<=G(0) or (P(0) and c(0));
                c(2)<=G(1) or (P(1) and G(0)) or (P(1) and P(0) and c(0));
                c(3)<=G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and c(0));
                c(4)<=G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and c(0));
                cout<=c(4);
end cla;



library ieee;
use ieee.std_logic_1164.all;

entity p_g is
        port(
                A, B: in std_logic;
                P, G: out std_logic
        );
end p_g;

architecture pg of p_g is
begin
        P<=A xor B;
        G<=A and B;
end pg;
