--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:21:01 04/03/2016
-- Design Name:   
-- Module Name:   /home/suman/My/SEM4/Sem4/CS226Lab/controller/handler_tb.vhd
-- Project Name:  controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: handler
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
 
ENTITY handler_tb IS
END handler_tb;
 
ARCHITECTURE behavior OF handler_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT handler
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         reply : IN  std_logic_vector(2 downto 0);
         humidity : IN  std_logic_vector(7 downto 0);
         req_humid : IN  std_logic_vector(7 downto 0);
         growth_days : IN  std_logic_vector(6 downto 0);
         fifo_request : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal reply : std_logic_vector(2 downto 0) := (others => '1');
   signal humidity : std_logic_vector(7 downto 0) := (others => '0');
   signal req_humid : std_logic_vector(7 downto 0) := (others => '0');
   signal growth_days : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal fifo_request : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: handler PORT MAP (
          clk => clk,
          reset => reset,
          reply => reply,
          humidity => humidity,
          req_humid => req_humid,
          growth_days => growth_days,
          fifo_request => fifo_request
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
		wait for 10 ns;
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
      wait for clk_period*10;
		reply <= "000";
		wait for clk_period;
		reply <= "111";
		wait for clk_period*20;
		reply <= "000";

      -- insert stimulus here 

      wait;
   end process;

END;
