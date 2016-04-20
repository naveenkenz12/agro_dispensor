----------------------------------------------------------------------------------
-- Company: inficoders
-- Engineer: naveenkenz12 
-- 
-- Create Date:    20:30:05 03/22/2016 
-- Design Name: 
-- Module Name:    watering - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;



-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
-- use UNISIM.VComponents.all;

entity watering is
    Port ( x : out  STD_LOGIC_vector(5 downto 0);		-- x cordinate of machine 				: output
           y : out  STD_LOGIC_vector(5 downto 0);		-- y cordinate of machine 				: output
	   initial_x : in std_logic_vector(5 downto 0);		-- initial x cordinate of machine 			: input
	   initial_y : in std_logic_vector(5 downto 0);		-- initial y cordinate of machine 			: input
           busy : inout std_logic;				-- busy = 1 when machine starts working and 0 otherwise	: inout
           enable : in  STD_LOGIC;				-- enable = 1 tells the machine to start work		: input
	   present_humidity : in std_logic_vector(7 downto 0);	-- present humidity of the field 			: input
	   required_humidity : in std_logic_vector(7 downto 0);	-- required humidity of the field			: input
           watering_location_x : in  STD_LOGIC_vector(5 downto 0);-- bottom left x coordinate of field crop is to water	: input
           watering_location_y : in  STD_LOGIC_vector(5 downto 0);-- bottom left y coordinate of field crop is to water	: input
           reset : in  STD_LOGIC;				-- reset						: input
	   water : out std_logic;				-- water = 1 when crop is watered else 0		: output
           clk : in  STD_LOGIC);				-- clock						: input
end watering;

architecture Behavioral of watering is
--signal
signal count_sec : std_logic_vector(5 downto 0):="000000";	-- counter of calculation of minutes
signal flag_x : std_logic := '0';				-- flag_x = 1 when machine reaches bottom x coordinate of field to be cut
signal flag_y : std_logic := '0';				-- flag_y = 1 when machine reaches bottom y coordinate of field to be cut
signal in_x : std_logic_vector(5 downto 0):="000001";
signal in_y : std_logic_vector(5 downto 0):="000001";
signal one : std_logic := '0';
signal counter : std_logic_vector(1 downto 0):="00";
signal machine_x : std_logic_vector(5 downto 0):="000000";
signal machine_y : std_logic_vector(5 downto 0):="000000";


begin

process(enable)

begin

if enable = '1' then

	in_x <= machine_x;					-- initial x coordinate of machine
	in_y <= machine_y;					-- initial y coordinate of machine


end if;

end process;

process(clk,reset)
--var
begin
x <= machine_x;						-- at every clock set output x coordinate of machine
y <= machine_y;						-- at every clock set output y coordinate of machine

if reset = '1' then
	machine_x <= "000000";				-- at reset, set all value to initialized value
	machine_y <= "000000";
	busy <= '0';
	one <= '0';
	counter <= "00";
	count_sec <= "000000";
	flag_x <= '0';
	flag_y <= '0';
	water <= '0';
	
	if watering_location_x = "000000" then
		flag_x <= '1';
	end if;

	if watering_location_y = "000000" then
		flag_y <= '1';
	end if;
	
elsif clk = '1' and clk'event then			-- called at every clock event
	if enable = '1' then
		if busy = '0' then
			counter <= counter + 1;
		end if;
		if counter = "11" then
			counter <= "00";
			busy <= '1';
			machine_x <= initial_x;
			machine_y <= initial_y;
		end if;
		if one = '0' then				-- signal one is set 1 so that after the finish of work, it 
			one <= '1';				-- does not restart again, it will give a window of 3 clocks
								-- for the control to accordingly change enable
			if watering_location_x = machine_x then	-- check if machine is alredy present at the watering location
				flag_x <= '1';
			end if;

			if machine_y = watering_location_y then
				flag_y <= '1';
			end if;

		elsif (flag_x = '0' or flag_y = '0') and busy = '1' then	-- if machine is not present at the cutting location
										-- then first move the machine from initial position
										-- to watering location @ 1m/min, update flag_x and 
										-- flag_y accordingly
			if count_sec = 4 and machine_x < watering_location_x and flag_x = '0' then
				if machine_x + 1 = watering_location_x then
					flag_x <= '1';
				end if;
				count_sec <= "000000";
				machine_x <= machine_x + 1;
			elsif count_sec = 4 and machine_x > watering_location_x and flag_x = '0' then
				count_sec <= "000000";
				machine_x <= machine_x - 1;
				if machine_x - 1 = watering_location_x then
					flag_x <= '1';
				end if;
			elsif count_sec = 4 and machine_y < watering_location_y and flag_y = '0' then
				count_sec <= "000000";
				machine_y <= machine_y +1;
				if machine_y + 1 = watering_location_y then
					flag_y <= '1';
				end if;
			elsif count_sec = 4 and machine_y > watering_location_y and flag_y = '0' then
				count_sec <= "000000";
				machine_y <= machine_y - 1;
				if machine_y - 1= watering_location_y then
					flag_y <= '1';
				end if;
			elsif true then
				count_sec <= count_sec + 1;
			end if;
	
		elsif busy = '1' then
			if required_humidity < present_humidity or required_humidity = present_humidity then
				water <= '0';				-- no watering if req humidity <= present humidity
				busy <= '0';
			else
				water <= '1';				-- water only if req humidity > present humidity
				busy <= '1';
			end if;
		
		end if;
	elsif enable = '0' then				-- when enable = 0, initialize one and counter to 0.
		one <= '0';
		counter <= "00";
	end if;
end if;	
end process;


end Behavioral;
