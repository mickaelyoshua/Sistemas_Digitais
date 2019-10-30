
entity CI7404 is
        port(
                A: in bit_vector(5 downto 0);
                Y: out bit_vector(5 downto 0)
        );
end CI7404;

architecture CI7404 of CI7404 is
begin
        Y<=not A;
end CI7404;


entity testbench is
end testbench;

architecture test of testbench is

component CI7404 is
        port(
                A: in bit_vector(5 downto 0);
                Y: out bit_vector(5 downto 0)
        );
end component;
