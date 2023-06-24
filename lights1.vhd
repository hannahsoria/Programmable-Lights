-- Hannah Soria
-- CS232 fall 22
-- project 4
-- lights 1 file
-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lights1 is

	port(
		clk		 : in	std_logic;
		reset	 : in	std_logic;
		lightsig : out std_logic_vector(7 downto 0);
		IRView	 : out	std_logic_vector(2 downto 0);
		rled	: out std_logic;
		gled	: out std_logic
	);

end entity;

architecture rtl of lights1 is

	component lightrom1
	port 
	(
		addr	   : in std_logic_vector  (3 downto 0);
		data : out std_logic_vector (2 downto 0)
	);
	end component;
	
	

	-- Build an enumerated type for the state machine
	type state_type is (sFetch, sExecute);

	-- Register to hold the current state
	signal IR   : std_logic_vector(2 downto 0);
	signal PC	: unsigned(3 downto 0);
	signal LR	: unsigned(7 downto 0);
	signal ROMvalue	: std_logic_vector(2 downto 0);
	signal state: state_type;


begin

	lightrom2: lightrom1
	port map (addr => std_logic_vector(PC), data => ROMvalue);
		
	-- Logic to advance to the next state
	process (clk, reset)
	begin
	--reset
		if reset = '0' then
			PC <= "0000";
			IR <= "000";
			LR <= "00000000";
			--get info
			state <= sFetch;
		elsif (rising_edge(clk)) then
			case state is
				when sFetch=>
				--set info
					IR <= ROMvalue;
					--continue
					PC <= PC + 1;
					state <= sExecute;
					--change binary
				when sExecute =>
					case IR is 
						when "000" => --load "00000000" into IR
						LR <= "00000000";
						state <= sFetch;
							
						when "001" => --shift the LR right by one pos, fill from the left with a '0'
						LR <= shift_right(LR,1);
						state <= sFetch;

						when "010" => --shift the LR left by one pos, fill from the right with a '0'
						LR <= shift_left(LR,1);
						state <= sFetch;
						
						when "011" => --add 1 to the LR
						LR <= LR + 1;
						state <= sFetch;
						
						when "100" => --subtract 1 from the LR
						LR <= LR - 1;
						state <= sFetch;
						
						when "101" => --invert all of the bits of the LR
						LR <= not LR;
						state <= sFetch;
						
						when "110" => --rotate the LR right by one pos (rightmost becomes leftmost bit)
						LR <= rotate_right(LR,1);
						state <= sFetch;
						
						when others => -- rotate the LR left by one position (leftmost becomes rightmost bit)
						LR <= rotate_left(LR,1);
						state <= sFetch;
						

				end case;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	IRview <= IR;
	lightsig <= std_logic_vector(LR);
	
	

end rtl;
