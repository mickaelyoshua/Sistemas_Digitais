
library ieee;
use ieee.std_logic_1164.all;

entity c_save_a is
        generic(len: integer:=4);
        port(
                A, B: in std_logic_vector(len-1 downto 0);
                S: out std_logic_vector(len downto 0);
                cout: out std_logic;
                cin: in std_logic
   );
end c_save_a;

architecture csa of c_save_a is

component somador_completo is
        port(
                A, B, Cin: in std_logic;
      S, Cout: out std_logic
   );
end component;

signal cin_top: std_logic_vector(len-1 downto 0);
signal cout_top: std_logic_vector(len-1 downto 0);
signal cout_down: std_logic_vector(len downto 0);
signal s_top: std_logic_vector(len downto 0);

begin
        cin_top<=(0=>cin, others=>'0');
        cout_down(0)<='0';
        s_top(len)<='0';
        
        laco: for i in 0 to len-1 generate
                top: somador_completo port map(A(i), B(i), cin_top(i), s_top(i), cout_top(i));
                down: somador_completo port map(cout_top(i), s_top(i+1), cout_down(i), S(i+1), cout_down(i+1));
        end generate;
        /
        S(0)<=s_top(0);
        cout<=cout_down(len);
end csa;
