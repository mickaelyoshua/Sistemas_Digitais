
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
