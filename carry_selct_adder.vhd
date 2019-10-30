
library ieee;
use ieee.std_logic_1164.all;

entity csa is
        port(
                A, B: in std_logic_vector(7 downto 0);
                S: out std_logic_vector(7 downto 0);
                cin: in std_logic;
                cout: out std_logic
        );
end csa;

architecture archie of csa is

component som_n_bits is
  generic(len: integer:= 4);
  port(
    n1, n2: in std_logic_vector(len-1 downto 0);
    cin: in std_logic;
    saida: out std_logic_vector(len-1 downto 0);
    cout: out std_logic
  );
end component;
  
component csa_4b is
        port(
                A, B: in std_logic_vector(3 downto 0);
                S: out std_logic_vector(3 downto 0);
                cin: in std_logic;
                cout: out std_logic
        );
end component;

signal c: std_logic;

begin
        X: som_n_bits port map(A(3 downto 0), B(3 downto 0), cin, S(3 downto 0), c);
        Y: csa_4b port map(A(7 downto 4), B(7 downto 4), S(7 downto 4), c, cout);
end archie;
