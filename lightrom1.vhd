-- Hannah Soria
-- CS232 fall 22
-- project 4
-- lights file
-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightrom1 is

	port 
	(
		addr	   : in std_logic_vector  (3 downto 0);
		data : out std_logic_vector (2 downto 0)
	);

end entity;

architecture rtl of lightrom1 is 
begin

   data <= 
      "000" when addr = "0000" else -- move 0s to LR  00000000
		"101" when addr = "0001" else -- bit invert LR  11111111
		"010" when addr = "0010" else -- shift LR left  11111110
		"010" when addr = "0011" else -- shift LR left  11111100
		"010" when addr = "0100" else -- shift LR left  11111000
		"010" when addr = "0101" else -- shift LR left  11110000
		"010" when addr = "0110" else -- shift LR left  11100000
		"010" when addr = "0111" else -- shift LR left  11000000
		"010" when addr = "1000" else -- shift LR left  10000000
		"001" when addr = "1001" else -- shift LR right 01000000
		"001" when addr = "1010" else -- rotate LR left 00100000
		"001" when addr = "1011" else -- add 1 to LR    00010000
		"001" when addr = "1100" else -- shift LR left  00001000
		"001" when addr = "1101" else -- add 1 to LR    00000100
`		"001" when addr = "1110" else -- shift LR left  00000010
		"001";

end rtl;