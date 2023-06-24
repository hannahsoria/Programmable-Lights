-- Hannah Soria
-- CS232 fall 22
-- project 4
-- lights file
-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightrom2 is

	port 
	(
		addr	   : in std_logic_vector  (3 downto 0);
		data : out std_logic_vector (2 downto 0)
	);

end entity;

architecture rtl of lightrom2 is 
begin

   data <= 
      "000" when addr = "0000" else -- move 0s to LR  00000000
      "101" when addr = "0001" else -- bit invert LR  11111111
      "100" when addr = "0010" else -- sub 1 from LR  11111110
      "101" when addr = "0011" else -- bit invert LR  00000001
      "011" when addr = "0100" else -- add 1 to LR    00000010
      "011" when addr = "0101" else -- add 1 to LR    00000011
      "111" when addr = "0110" else -- rotate LR left 00000110
      "111" when addr = "0111" else -- rotate LR left 00001100
      "111" when addr = "1000" else -- rotate LR left 00011000
      "011" when addr = "1001" else -- add 1 to LR    00011001
      "010" when addr = "1010" else -- shift LR left  00110010
      "011" when addr = "1011" else -- add 1 to LR    00110011
      "010" when addr = "1100" else -- shift LR left  01100110
      "101" when addr = "1101" else -- bit invert LR  10011001
      "100" when addr = "1110" else -- sub 1 from LR  10011000
      "010";                        -- shift LR left  00110000

end rtl;