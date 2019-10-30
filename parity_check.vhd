
entity parity_check is
        generic(size: integer:= 9);
        
        port(
                received: in bit_vector(size-1 downto 0);
                error: out bit
        );
end parity_check;

architecture check of parity_check is
component parity_gen is
        generic(len: integer:= size);
        
        port(
                input: in bit_vector(len-1 downto 0);
                output: out bit
        );
end component;

signal temp: bit;

begin
        x: parity_gen port map(received, temp);
        error<= not temp;
end check;



entity testbench is
end testbench;

architecture test of testbench is
component parity_check is
        generic(size: integer:= 9);
        
        port(
                received: in bit_vector(size-1 downto 0);
                error: out bit
        );
end component;

signal hex: bit_vector(8 downto 0);
signal error: bit;

begin
        DUT: parity_check port map(hex, error);
        
        hex<= "111111110" after 10 ns,
                        "110101011" after 20 ns,
                        "100111010" after 30 ns,
                        "101011011" after 40 ns,
                        "000000000" after 50 ns;
end test;
