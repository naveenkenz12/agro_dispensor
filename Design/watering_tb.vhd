--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:02:52 04/06/2016
-- Design Name:   
-- Module Name:   /home/suman/My/SEM4/Sem4/CS226Lab/controller/watering_tb.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: watering
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
 
ENTITY watering_tb IS
END watering_tb;
 
ARCHITECTURE behavior OF watering_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT watering
    PORT(
         x : OUT  std_logic_vector(5 downto 0);
         y : OUT  std_logic_vector(5 downto 0);
         initial_x : IN  std_logic_vector(5 downto 0);
         initial_y : IN  std_logic_vector(5 downto 0);
         busy : INOUT  std_logic;
         enable : IN  std_logic;
         present_humidity : IN  std_logic_vector(7 downto 0);
         required_humidity : IN  std_logic_vector(7 downto 0);
         watering_location_x : IN  std_logic_vector(5 downto 0);
         watering_location_y : IN  std_logic_vector(5 downto 0);
         reset : IN  std_logic;
         water : OUT  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal initial_x : std_logic_vector(5 downto 0) := (others => '0');
   signal initial_y : std_logic_vector(5 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal present_humidity : std_logic_vector(7 downto 0) := (others => '0');
   signal required_humidity : std_logic_vector(7 downto 0) := (others => '0');
   signal watering_location_x : std_logic_vector(5 downto 0) := (others => '0');
   signal watering_location_y : std_logic_vector(5 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

	--BiDirs
   signal busy : std_logic;

 	--Outputs
   signal x : std_logic_vector(5 downto 0);
   signal y : std_logic_vector(5 downto 0);
   signal water : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: watering PORT MAP (
          x => x,
          y => y,
          initial_x => initial_x,
          initial_y => initial_y,
          busy => busy,
          enable => enable,
          present_humidity => present_humidity,
          required_humidity => required_humidity,
          watering_location_x => watering_location_x,
          watering_location_y => watering_location_y,
          reset => reset,
          water => water,
          clk => clk
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
		wait for 100 ns ;
		reset <= '0';
      wait for clk_period*10;
		enable <= '1';

		required_humidity <= "00111110";
		present_humidity <= "00001000";
		wait for 100 ns;
		present_humidity <= "00111110";
      -- insert stimulus here 

      wait;
   end process;

END;
