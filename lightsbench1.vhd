
-- Edited by Hannah Soria
-- project 4
-- CS232 fall 22
-- Bruce A. Maxwell
-- Spring 2013
-- test program for the lights1 circuit
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightsbench1 is
end entity;

architecture test of lightsbench1 is
  constant num_cycles : integer := 40;

  -- this circuit just needs a clock and a reset
  signal clk : std_logic := '1';
  signal reset : std_logic;
` signal rled: std_logic;
  signal gled: std_logic;
  
  -- lights component
  component lights1
    port( clk, reset : in std_logic;
          lightsig   : out std_logic_vector(7 downto 0);
          IRView     : out std_logic_vector(2 downto 0);
			 rled	 : out std_logic;
			 gled : out std_logic );
			 
  end component;

  -- output signals
  signal lightsig : std_logic_vector(7 downto 0);
  signal irview : std_logic_vector(2 downto 0);
  signal rled	 : std_logic;
  signal led : std_logic;

begin

  -- start off with a short reset
  reset <= '0', '1' after 5 ns;

  -- create a clock
  process begin
    for i in 1 to num_cycles loop
      clk <= not clk;
      wait for 5 ns;
      clk <= not clk;
      wait for 5 ns;
    end loop;
    wait;
  end process;

  -- port map the circuit
  L0: lights1 port map( clk, reset, lightsig, irview, rled, gled);

end test;
