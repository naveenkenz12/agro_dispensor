--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:09:29 04/05/2016
-- Design Name:   
-- Module Name:   /home/suman/My/SEM4/Sem4/CS226Lab/controller/top_tb.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Dispenser_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Inficoders_testbench1 IS
END Inficoders_testbench1;
 
ARCHITECTURE behavior OF Inficoders_testbench1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Inficoders_top
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         humidity_1 : IN  std_logic_vector(7 downto 0);
         humidity_2 : IN  std_logic_vector(7 downto 0);
         humidity_3 : IN  std_logic_vector(7 downto 0);
         humidity_4 : IN  std_logic_vector(7 downto 0);
         humidity_5 : IN  std_logic_vector(7 downto 0);
         humidity_6 : IN  std_logic_vector(7 downto 0);
         humidity_7 : IN  std_logic_vector(7 downto 0);
         machine_x : INOUT  std_logic_vector(5 downto 0);
         machine_y : INOUT  std_logic_vector(5 downto 0);
			health : in STD_LOGIC;
			sow: out STD_LOGIC;
	      till: out STD_LOGIC;
	      water: out STD_LOGIC;
			cut: out STD_LOGIC;
			power : out STD_LOGIC_VECTOR(31 downto 0);
			dead_report : out STD_LOGIC;
         humidity_8 : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal humidity_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_3 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_4 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_5 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_6 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_7 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_8 : std_logic_vector(7 downto 0) := (others => '0');
	signal health : std_logic := '0';
	signal cut : std_logic;
	signal till : std_logic;
	signal sow : std_logic;
	signal water : std_logic;
	signal power : STD_LOGIC_VECTOR(31 downto 0);
	signal dead_report :std_logic;
	--BiDirs
   signal machine_x : std_logic_vector(5 downto 0) := "000000";
   signal machine_y : std_logic_vector(5 downto 0) := "000000";

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Inficoders_top PORT MAP (
          clk => clk,
          reset => reset,
          humidity_1 => humidity_1,
          humidity_2 => humidity_2,
          humidity_3 => humidity_3,
          humidity_4 => humidity_4,
          humidity_5 => humidity_5,
          humidity_6 => humidity_6,
          humidity_7 => humidity_7,
          machine_x => machine_x,
          machine_y => machine_y,
			 health => health,
			 till => till,
			 cut => cut,
			 sow => sow,
			 dead_report => dead_report,
			 water => water,
			 power => power,
          humidity_8 => humidity_8
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 10 ns;	
		reset <= '0';
      wait for clk_period*10;
		--the barren lands get sown , after that only watering function starts.
		--useless to water on barren land
		
		--watering sensor simulation
		wait for 3520 us;
		humidity_1 <= "01100100";
		wait for 10 us;
		humidity_2 <= "01100101";
		wait for 10 us;
		humidity_3 <= "01100101";
		wait for 10 us;
		humidity_4 <= "01100100";
		wait for 10 us;
		humidity_5 <= "01100100";
		wait for 5 us;
		humidity_6 <= "01100100";
		wait for 5 us;
		humidity_7 <= "01100100";
		wait for 5 us;
		humidity_8 <= "01100100";
     
		wait for 100 us;
		humidity_2 <= "00010000";
		humidity_3 <= "00010010";
		wait for 70 us;
		humidity_2 <= "01100100";
		humidity_3 <= "01100100";

      wait;
   end process;

END;
