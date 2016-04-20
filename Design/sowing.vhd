----------------------------------------------------------------------------------
-- Company: inficoders
-- Engineer: naveenkenz12
-- 
-- Create Date:    20:27:13 03/24/2016 
-- Design Name: sowing block
-- Module Name:    sowing - Behavioral 
-- Project Name: agro dispensor
-- Target Devices: 
-- Tool versions: 
-- Description: 
-- 
-- each field is 20m(along y-axis) * 10m(along x-axis) 
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
-- use UNISIM.VComponents.all;

entity sowing is
    Port ( x : out  STD_LOGIC_vector(5 downto 0);		-- x cordinate of machine 				: output
           y : out  STD_LOGIC_vector(5 downto 0);		-- y cordinate of machine 				: output
	   initial_x : in std_logic_vector(5 downto 0);		-- initial x cordinate of machine 			: input
           initial_y : in std_logic_vector(5 downto 0);		-- initial y cordinate of machine 			: input
           busy : inout std_logic;				-- busy = 1 when machine starts working and 0 otherwise	: inout
           enable : in  STD_LOGIC;				-- enable = 1 tells the machine to start work		: input
           crop_density : in std_logic_vector(7 downto 0);	-- crop_density = number of crops per 1 sq metre	: input
           sowing_location_x : in  STD_LOGIC_vector(5 downto 0);-- bottom left x coordinate of field crop is to sow	: input
           sowing_location_y : in  STD_LOGIC_vector(5 downto 0);-- bottom left y coordinate of field crop is to cut	: input
           reset : in  STD_LOGIC;				-- reset						: input
	   sow : out std_logic;					-- sow = 1 when seed is sown				: output
           clk : in  STD_LOGIC);				-- clock						: input
end sowing;

architecture Behavioral of sowing is

-- signal definition

signal count_sec : std_logic_vector(5 downto 0):="000000";	-- counter of calculation of minutes
signal flag_x : std_logic := '0';				-- flag_x = 1 when machine reaches bottom x coordinate of field to be sown
signal flag_y : std_logic := '0';				-- flag_y = 1 when machine reaches bottom y coordinate of field to be sown
signal row_gap : std_logic_vector(6 downto 0):="0000000";	-- gap between two rows of crops
signal column_gap : std_logic_vector(6 downto 0):="0000000";	-- gap between two crops in same row
signal x_cm : std_logic_vector(6 downto 0):="0000000";
signal y_cm : std_logic_vector(6 downto 0):="0000000";
signal in_x : std_logic_vector(5 downto 0):="000001";
signal in_y : std_logic_vector(5 downto 0):="000001";
signal fn_x : std_logic_vector(5 downto 0):="000000";
signal fn_y : std_logic_vector(5 downto 0):="000000";
signal one : std_logic := '0';
signal counter : std_logic_vector(1 downto 0):="00";
signal machine_x : std_logic_vector(5 downto 0):="000000";	-- x coordinate of machine
signal machine_y : std_logic_vector(5 downto 0):="000000";	-- y coordinate of machine
signal f : std_logic := '0';

begin

process(enable)							-- process will be called only once at start and all the signal will be set

begin

if enable = '1' then

	in_x <= machine_x;					-- initial x coordinate of machine
	in_y <= machine_y;					-- initial y coordinate of machine
	fn_x <= sowing_location_x + 10;				-- final x coordinate of the machine after the field is sown
	fn_y <= sowing_location_y + 20;				-- final y coordinate of the machine after the field is sown



	if crop_density = 1 or crop_density = 2 or crop_density = 5 then
		row_gap <= "1100100";				-- when crop density = 1 or 2 or 5, set row_gap = 100cm			
		if crop_density = 1 then
			column_gap <= "1100100";		-- crop density = 1, set column_gap = 100cm
		elsif crop_density = 2 then
			column_gap <= "0110010";		-- crop density = 2, set column_gap = 50cm
		else
			column_gap <= "0010100";		-- crop density = 5, set column_gap = 20cm
		end if;
	elsif crop_density = 10 or crop_density = 20 then				
		row_gap <= "0110010";				-- when crop density = 10 or 20, set row_gap = 50cm
		if crop_density = 10 then
			column_gap <= "0010100";		-- crop density = 10, set column_gap = 20cm
		else
			column_gap <= "0001010";		-- crop density = 20, set column_gap = 10cm
		end if;
	elsif crop_density = 25 or crop_density = 50 or crop_density = 100 then
		row_gap <= "0010100";				-- when crop density = 25 or 50 or 100, set row_gap = 20cm
		if crop_density = 25 then
			column_gap <= "0010100";		-- crop density = 25, set column_gap = 20cm
		elsif crop_density = 50 then
			column_gap <= "0001010";		-- crop density = 50, set column_gap = 10cm
		else
			column_gap <= "0000101";		-- crop density = 100, set column_gap = 5cm
		end if;
	elsif crop_density = 200 or crop_density = 250 then	
		row_gap <= "0001010";				-- when crop density = 200 or 250, set row_gap = 10cm
		if crop_density = 200 then
			column_gap <= "0000101";		-- crop density = 200, set column_gap = 5cm
		else
			column_gap <= "0000100";		-- crop density = 250, set column gap = 4cm
		end if;
	end if;

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
	count_sec <= "000000";
	flag_x <= '0';
	flag_y <= '0';
	one <= '0';
	counter <= "00";
	sow <= '0';
	if sowing_location_x = "000000" then
		flag_x <= '1';
	end if;

	if sowing_location_y = "000000" then
		flag_y <= '1';
	end if;
	
elsif clk = '1' and clk'event then			-- called at every clock event
	if enable = '1' then
		if busy = '0' then
			counter <= counter +1;
		end if;
		if counter = "11" then			-- make sure that enable remain high for three clocks for busy to be 1
			counter <= "00";
			busy <= '1';
			machine_x <= initial_x;
			machine_y <= initial_y;
		end if;
		if one = '0' and busy = '1' then		-- signal one is set 1 so that after the finish of work, it 
			one <= '1';				-- does not restart again, it will give a window of 3 clocks
								-- for the control to accordingly change enable
			if sowing_location_x = machine_x then
				flag_x <= '1';			-- check if machine is alredy present at the sowing location
			end if;

			if machine_y = sowing_location_y then
				flag_y <= '1';
			end if;
		elsif (flag_x = '0' or flag_y = '0') and busy = '1' then	-- if machine is not present at the sowing location
										-- then first move the machine from initial position
										-- to sowing location @ 1m/min, update flag_x and 
										-- flag_y accordingly
			if count_sec = 4 and machine_x < sowing_location_x and flag_x = '0' then
				if machine_x + 1 = sowing_location_x then
					flag_x <= '1';
				end if;
				count_sec <= "000000";
				machine_x <= machine_x + 1;
			elsif count_sec = 4 and machine_x > sowing_location_x and flag_x = '0' then
				count_sec <= "000000";
				machine_x <= machine_x - 1;
				if machine_x - 1 = sowing_location_x then
					flag_x <= '1';
				end if;
			elsif count_sec = 4 and machine_y < sowing_location_y and flag_y = '0' then
				count_sec <= "000000";
				machine_y <= machine_y +1;
				if machine_y + 1 = sowing_location_y then
					flag_y <= '1';
				end if;
			elsif count_sec = 4 and machine_y > sowing_location_y and flag_y = '0' then
				count_sec <= "000000";
				machine_y <= machine_y - 1;
				if machine_y - 1= sowing_location_y then
					flag_y <= '1';
				end if;
			elsif true then
				count_sec <= count_sec + 1;
			end if;
	
		elsif busy = '1' then			-- when machine has reached the sowing location
							-- sowing of crop
							-- sowing start from the bottom left position of sowing
							-- and sow seeds in each row, based on crop density 

							-- first a row is sown from bottom to up, and when the machine 
							-- reaches uppermost portion of field, it then sow seed in next row 
							-- from top to bottom

			if f = '0' and busy = '1' then	-- f = 0, when machine is sowing seed from bottom to up
				sow <= '1';		-- when machine starts sowing the seed , sow = 1
				if count_sec = 4 then
					count_sec <= "000000";
					if machine_y + 1 = fn_y then
						if x_cm + row_gap = "1100100" then
							if machine_x + 1 = fn_x then
								busy <= '0';
								sow <= '0';
								x_cm <= "0000000";
								machine_x <= machine_x + 1;
							else
								x_cm <= "0000000";
								machine_x <= machine_x + 1;
							end if;
						else
							x_cm <= x_cm + row_gap;
						end if;
						machine_y <= fn_y;
						f <= '1';
					else
						machine_y <= machine_y + 1;
					end if;
				else
					count_sec <= count_sec + 1;
				end if;
			elsif f = '1' and busy = '1' then	-- f = 1, sowing seed from top to bottom
				sow <= '1';
				if count_sec = 4 then
					count_sec <= "000000";
					if machine_y - 1 = in_y then
						if x_cm + row_gap = "1100100" then
							if machine_x + 1 = fn_x then	-- when machine reaches final point, cut and sow = 0
								busy <= '0';
								sow <= '0';
								x_cm <= "0000000";
								machine_x <= machine_x + 1;
							else
								x_cm <= "0000000";
								machine_x <= machine_x + 1;
							end if;
						else
							x_cm <= x_cm + row_gap;
						end if;
						machine_y <= in_y;
						f <= '0';
					else
						machine_y <= machine_y - 1;
					end if;
				else
					count_sec <= count_sec + 1;
				end if;
			end if;
							-- x_cm and y_cm are updated according to the column_gap and 
							-- row_gap, and when x_cm and y_cm = 100cm or 0, then
							-- machine_x and machine_y are updated accordingly, as they 
							-- or calculated in metre
		
		end if;
	elsif enable = '0' then				-- when enable = 0, one and counter are again initialised to 0
		one <= '0';
		counter <= "00";
	end if;

end if;	
end process;


end Behavioral;
