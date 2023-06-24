-- Hannah Soria
-- CS232 fall 22
-- project 4
-- lightrom extension file
-- Quartus II VHDL Template
-- Unsigned Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightromex is

	port 
	(
		addr	   : in std_logic_vector  (3 downto 0);
		data : out std_logic_vector (3 downto 0)
	);

end entity;

architecture rtl of lightromex is 
begin

   data <= 
		"0000" when addr = "0000" else -- move 0s to LR  00000000
		"0011" when addr = "0001" else -- add 1 to LR    00000001
		"0010" when addr = "0010" else -- shift LR left  00000010
		"1010" when addr = "0011" else -- break loop 1   00001110
		"1000" when addr = "0100" else -- start loop 1
		"0101" when addr = "0101" else -- bit invert LR  11110001
		"0101" when addr = "0110" else -- bit invert LR  00001110
      "0001" when addr = "0111" else -- shift LR right 00000111
      "0100" when addr = "1000" else -- sub 1 from LR  00000110
      "1011" when addr = "1001" else -- break loop 2      
		"1001" when addr = "1010" else -- start loop 2    
		"0101";								 -- invert bits    11111111

end rtl;