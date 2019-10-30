
library ieee;
use ieee.std_logic_1164.all;

entity som_sub_nb is
  generic(len: integer:= 8);
  port(
    n1, n2: in std_logic_vector(len-1 downto 0);
    M: in std_logic;
    saida: out std_logic_vector(len-1 downto 0);
    cout: out std_logic
    );
end som_sub_nb;

architecture nb of som_sub_nb is

component somador_completo is
        port(
                A, B, Cin: in std_logic;
                S, Cout: out std_logic
    );
end component;

signal carry: std_logic_vector(len downto 0);
signal n: std_logic_vector(len-1 downto 0);

begin
        laco: for i in 0 to len-1 generate
                n(i)<=n2(i) xor M;
                x: somador_completo port map(n1(i), n(i), carry(i), saida(i), carry(i+1));
        end generate;
    
        carry(0)<=M;
        cout<=carry(len);
end nb;
