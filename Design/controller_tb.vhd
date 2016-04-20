--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:26:22 04/04/2016
-- Design Name:   
-- Module Name:   /home/suman/My/SEM4/Sem4/CS226Lab/controller/controller_tb.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
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
 
ENTITY controller_tb IS
END controller_tb;
 
ARCHITECTURE behavior OF controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         reset : IN  std_logic;
			busy : in STD_LOGIC;
         humidity_1 : IN  std_logic_vector(7 downto 0);
         humidity_2 : IN  std_logic_vector(7 downto 0);
         humidity_3 : IN  std_logic_vector(7 downto 0);
         humidity_4 : IN  std_logic_vector(7 downto 0);
         humidity_5 : IN  std_logic_vector(7 downto 0);
         humidity_6 : IN  std_logic_vector(7 downto 0);
         humidity_7 : IN  std_logic_vector(7 downto 0);
         humidity_8 : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal humidity_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_3 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_4 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_5 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_6 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_7 : std_logic_vector(7 downto 0) := (others => '0');
   signal humidity_8 : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
	signal busy : std_logic := '0';
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
          reset => reset,
          humidity_1 => humidity_1,
          humidity_2 => humidity_2,
          humidity_3 => humidity_3,
          humidity_4 => humidity_4,
          humidity_5 => humidity_5,
          humidity_6 => humidity_6,
          humidity_7 => humidity_7,
          humidity_8 => humidity_8,
          clk => clk,
			 busy => busy
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
		wait for 100 ns;	
		reset <= '0';
      wait for 55 ns;
		busy <= '1';
		wait for 200 ns;
		busy <= '0';
	   wait for 45 ns;
		busy <= '1';
		wait for 200 ns;
		busy <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
