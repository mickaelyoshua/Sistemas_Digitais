
entity parity_gen is
        generic(len: integer:= 8); --#DEFINE LEN 8
        
        port(
                input: in bit_vector(len-1 downto 0);
                output: out bit
        );
end parity_gen;

architecture pg of parity_gen is
        signal box: bit_vector(len downto 0);

begin
        box(0)<='0';

        laco: for i in 0 to len-1 generate
                box(i+1)<=input(i) xor box(i);
        end generate;
        
        output<=box(len);
end pg;
