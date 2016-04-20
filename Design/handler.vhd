----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:01:35 04/02/2016 
-- Design Name: 
-- Module Name:    handler - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity handler is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           reply : in  STD_LOGIC_VECTOR(2 downto 0);
			  -- humidity from sensor
			  humidity : in STD_LOGIC_VECTOR (7 downto 0);
			  -- hard coded req humidity from controller
			  req_humid : in STD_LOGIC_VECTOR (7 downto 0);
			  -- total days to keep the crop
			  growth_days : in STD_LOGIC_VECTOR (6 downto 0);
			  -- the request generated for the field to go to next state
			  fifo_request : out  STD_LOGIC_VECTOR (2 downto 0));
end handler;

architecture Behavioral of handler is
-- state maintaining of the division
signal state : STD_LOGIC_VECTOR(2 downto 0) := "000";
-- counting days starting from tilling till Seed Sown
signal tilling_days : INTEGER range 0 to 35 := 0;
-- counting days starting from seed sown
signal sown_days : STD_LOGIC_VECTOR(6 downto 0) := "0000000";
-- days
signal days : INTEGER :=0;

begin
process(tilling_days,sown_days,reset) -- checking current state and generating request for second day

begin
	if reset = '1' then	-- null request
		fifo_request <= "111";
	else 
		if state = "000" and tilling_days = 1 then 
			fifo_request <= "000"; -- tilling request
		elsif state = "001" and tilling_days = 3 then
			fifo_request <= "000"; -- tilling request 3 rd day
		elsif state = "010" and tilling_days = 5 then
			fifo_request <= "000"; -- tilling request - 5th day
		elsif state = "011" and tilling_days = 35 then--watering and sowing request
			fifo_request <= "001";  
		elsif state = "100" and sown_days = growth_days then -- cutting request
			fifo_request <= "011";
		elsif state = "100" and humidity < req_humid and sown_days<growth_days then
			fifo_request <= "010";
		else fifo_request <= "111";
		end if;
		
	end if;

end process;
-- updating tilling days ,sown days based on current state.
process(days, reset)
	variable temp : INTEGER := 0;
	begin
		if reset = '1' then 
			-- reset the days counting
			tilling_days <= 0;
			sown_days <= "0000000";
			temp := 1;
		elsif temp = 1 then
			temp := 0;
		elsif reply = "011" then
			-- crop cut reset tilling days to 0 and sown days
			tilling_days <= 0;
			sown_days <= "0000000";
		elsif state >= "000" and state <= "011" then -- state between barren and sowing
			tilling_days <= tilling_days + 1;
		elsif state = "100" then -- state of sown land => increase sown days
			sown_days <= sown_days + 1;
		end if;
end process;

process(clk,reset)
-- 100000 clks =  day
variable counter : INTEGER :=0;
begin
if reset = '1' then 
	-- reset the days counting
	days <= 0;
	counter := 0;
elsif rising_edge(clk) then
	-- incrementing days every 100000 clcks
	if counter = 0 then 
		days <= days+1;
		counter := counter+1;
	elsif counter = 100000 then
		counter :=0;
	else
		counter := counter + 1;
	end if;

end if;
end process;

process(reply ,reset)
begin
-- when reply changes/ reply sensitive . Change the state of the field according to the reply
	if reset = '1' then
		 state <= "000";
	else
		if reply = "000" and state < "011" then -- tilled 1st , 3rd ,5th day => goto next state
			state <= state + '1';
		elsif reply = "001" and state  = "011" then -- 
			state <= state + '1';
		elsif reply = "011" and state = "100" then -- 
			state <= "000";
		end if;
	end if;

end process;

end Behavioral;
