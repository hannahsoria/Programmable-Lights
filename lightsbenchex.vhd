-- Edited by Hannah Soria
-- project 4
-- CS232 fall 22
-- Bruce A. Maxwell
-- Spring 2013
-- test program for the lights extension circuit
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lightsbenchex is
end entity;

architecture test of lightsbenchex is
  constant num_cycles : integer := 120;

  -- this circuit just needs a clock and a reset
  signal clk : std_logic := '1';
  signal reset : std_logic;
  signal speed: std_logic;
` signal rled: std_logic;
  signal gled: std_logic;

  
  -- lights component
  component lightsEx
    port( clk, reset, speed : in std_logic;
          lightsig   : out std_logic_vector(7 downto 0);
          IRView     : out std_logic_vector(3 downto 0);
			 rled	 : out std_logic;
			 gled : out std_logic
			  );
			 
  end component;

  -- output signals
  signal lightsig : std_logic_vector(7 downto 0);
  signal irview : std_logic_vector(3 downto 0);
  signal rled	 : std_logic;
  signal led : std_logic;

begin

  -- start off with a short reset
  reset <= '0', '1' after 5 ns;
  -- change the speed at 500 ns
  speed <= '1', '0' after 200 ns, '1' after 1500 ns;

  -- create a clock
  process begin
    for i in 1 to num_cycles loop
      clk <= not clk;
		if speed = '1' then
			wait for 5 ns;
		else
		--slower
			wait for 100 ns;
		end if;
      clk <= not clk;
		if speed = '1' then
			wait for 5 ns;
		else
		--slower
			wait for 100 ns;
		end if;
    end loop;
    wait;
  end process;

  -- port map the circuit
  L0: lightsEx port map( clk, reset, speed, lightsig, irview, rled, gled);

end test;
