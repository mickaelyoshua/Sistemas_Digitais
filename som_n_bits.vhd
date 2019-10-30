
library ieee;
use ieee.std_logic_1164.all;

entity som_n_bits is
  generic(len: integer:= 8);
  port(
    n1, n2: in std_logic_vector(len-1 downto 0);
    cin: in std_logic;
    saida: out std_logic_vector(len-1 downto 0);
    cout: out std_logic
    );
end som_n_bits;

architecture nb of som_n_bits is

component somador_completo is
        port(
                        A, B, Cin: in std_logic;
                        S, Cout: out std_logic
    );
end component;

signal carry: std_logic_vector(len downto 0);

begin
    laco: for i in 0 to len-1 generate
          x: somador_completo port map(n1(i), n2(i), carry(i), saida(i), carry(i+1));
    end generate;
    
    carry(0)<=cin;
    cout<=carry(len);
end nb;



library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture test of testbench is

component som_n_bits is
  generic(len: integer:= 8);
  port(
    n1, n2: in std_logic_vector(len-1 downto 0);
    cin: in std_logic;
    saida: out std_logic_vector(len-1 downto 0);
    cout: out std_logic
    );
end component;

signal n1, n2, saida: std_logic_vector(8-1 downto 0);
signal cin: std_logic:='0';
signal cout: std_logic;

begin

        DUT: som_n_bits port map(n1, n2, cin, saida, cout);
    
    n1<="00000000",
             "01001100" after 10 ns,
             "11110001" after 20 ns,
             "00011100" after 30 ns;
         
         n2<="11111000",
             "01111100" after 10 ns,
             "11000001" after 20 ns,
             "00101100" after 30 ns;

end test;
