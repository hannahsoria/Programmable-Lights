-- Hannah Soria
-- CS232 fall 22
-- project 4
-- lights extension file
-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightsEx is

	port(
		clk		 : in	std_logic;
		reset	 : in	std_logic;
		speed	 : in std_logic;
		lightsig : out std_logic_vector(7 downto 0);
		IRView	 : out	std_logic_vector(3 downto 0);
		rled	: out std_logic;
		gled	: out std_logic
	);

end entity;

architecture rtl of lightsEx is

	component lightromex
	port 
	(
		addr	   : in std_logic_vector  (3 downto 0);
		data : out std_logic_vector (3 downto 0)
	);
	end component;
	
	

	-- Build an enumerated type for the state machine
	type state_type is (sFetch, sExecute);

	-- Register to hold the current state
	signal IR   : std_logic_vector(3 downto 0);
	signal PC	: unsigned(3 downto 0);
	signal LR	: unsigned(7 downto 0);
	signal ROMvalue	: std_logic_vector(3 downto 0);
	signal state: state_type;


begin

	lightrom1: lightromex
	port map (addr => std_logic_vector(PC), data => ROMvalue);
		
	-- Logic to advance to the next state
	process (clk, reset)
	begin
	--reset
		if reset = '0' then
			PC <= "0000";
			IR <= "0000";
			LR <= "00000000";
			--retrieve info
			state <= sFetch;
		elsif (rising_edge(clk)) then
			case state is
				when sFetch=>
				--the value
					IR <= ROMvalue;
					--continue
					PC <= PC + 1;
					state <= sExecute;
					--change the binary
				when sExecute =>
					case IR is 
						when "0000" => --load "00000000" into IR
						LR <= "00000000";
						state <= sFetch;
							
						when "0001" => --shift the LR right by one pos, fill from the left with a '0'
						LR <= shift_right(LR,1);
						state <= sFetch;

						when "0010" => --shift the LR left by one pos, fill from the right with a '0'
						LR <= shift_left(LR,1);
						state <= sFetch;
						
						when "0011" => --add 1 to the LR
						LR <= LR + 1;
						state <= sFetch;
						
						when "0100" => --subtract 1 from the LR
						LR <= LR - 1;
						state <= sFetch;
						
						when "0101" => --invert all of the bits of the LR
						LR <= not LR;
						state <= sFetch;
						
						when "0110" => --rotate the LR right by one pos (rightmost becomes leftmost bit)
						LR <= rotate_right(LR,1);
						state <= sFetch;
						
						when "0111" => -- rotate the LR left by one position (leftmost becomes rightmost bit)
						LR <= rotate_left(LR,1);
						state <= sFetch;
						
						when "1000" => -- start loop 1
						if LR /= "00001110" then
						PC <= PC - 4; 
						end if;
						state <= sFetch;
						
						when "1001" => -- start loop 2
						if LR /= "00000000" then
						PC <= PC - 4; 
						--PC <= PC + 1;
						end if;
						state <= sFetch;
						
						when "1010" => -- break loop 1
						if LR = "00001110" then
						PC <= PC + 1;
						end if;
						state <= sFetch;
						
						when others => -- break loop 2
						if LR = "00000000" then
						PC <= PC + 1;
						end if;
						state <= sFetch;
					
				end case;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	IRview <= IR;
	lightsig <= std_logic_vector(LR);
	
	

end rtl;
