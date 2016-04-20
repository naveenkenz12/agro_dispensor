----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:12:02 04/03/2016 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller is
    Port ( reset : in  STD_LOGIC;
			  busy : in STD_LOGIC;
			  --humidity updates by sensor
			  humidity_1 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_2 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_3 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_4 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_5 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_6 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_7 : in STD_LOGIC_VECTOR(7 downto 0);
			  humidity_8 : in STD_LOGIC_VECTOR(7 downto 0);
			  -- 4 bits, single bit send to each process
			  enable : out STD_LOGIC_vector(3 downto 0);
			  --the coordinate of the field to be processed
			  field_X: inout STD_LOGIC_VECTOR(5 downto 0);
			  field_Y: inout STD_LOGIC_VECTOR(5 downto 0);
			  --crop density of the field to be processed
			  crop_density : out STD_LOGIC_VECTOR(7 downto 0);
			  -- humidity conditions of the field to be watered
			  present_humidity: out STD_LOGIC_VECTOR(7 downto 0);
			  required_humidity: out STD_LOGIC_VECTOR(7 downto 0);
			  -- power consumption in a year
			  power : out STD_LOGIC_VECTOR(31 downto 0);
           clk : in  STD_LOGIC);
end controller;

architecture Behavioral of controller is

COMPONENT handler
PORT ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       reply : in  STD_LOGIC_VECTOR(2 downto 0);
		 humidity : in STD_LOGIC_VECTOR (7 downto 0);
		 req_humid : in STD_LOGIC_VECTOR (7 downto 0);
		 growth_days : in STD_LOGIC_VECTOR (6 downto 0);
		 fifo_request : out  STD_LOGIC_VECTOR (2 downto 0)
		 );
end COMPONENT;

COMPONENT requests_fifo
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;
--mapping signals
signal fifo_request_1,fifo_request_2,fifo_request_3,fifo_request_4,fifo_request_5,fifo_request_6,fifo_request_7,fifo_request_8, reply_1,reply_2,reply_3,reply_4,reply_5,reply_6,reply_7,reply_8 : STD_LOGIC_VECTOR (2 downto 0);
signal req_humid_1,req_humid_2,req_humid_3,req_humid_4,req_humid_5,req_humid_6,req_humid_7,req_humid_8 : STD_LOGIC_VECTOR(7 downto 0);
signal growth_days_1,growth_days_2,growth_days_3,growth_days_4,growth_days_5,growth_days_6,growth_days_7,growth_days_8 : STD_LOGIC_VECTOR(6 downto 0);
signal crop_density_1, crop_density_2, crop_density_3, crop_density_4, crop_density_5, crop_density_6, crop_density_7, crop_density_8 : STD_LOGIC_VECTOR(7 downto 0);
signal days : INTEGER :=0;

--fifo signals
signal din : STD_LOGIC_VECTOR(2 downto 0) := "111";
signal wr_en : STD_LOGIC := '0';
signal dout : STD_LOGIC_VECTOR(2 downto 0);
signal rd_en : STD_LOGIC := '0';

signal empty : STD_LOGIC;
signal full : STD_LOGIC;
--power
signal p : STD_LOGIC_VECTOR(31 downto 0);
--X,Y
signal part : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
request : requests_fifo
PORT MAP(
			clk => clk,
			srst => reset,
			din => din,
			dout => dout,
			wr_en => wr_en,
			rd_en => rd_en,
			empty => empty,
			full => full

		);
--field 1 state handler ..similarly others
handler_1 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_1,
			humidity => humidity_1,
			req_humid => req_humid_1,
			growth_days => growth_days_1,
			fifo_request => fifo_request_1
		);
handler_2 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_2,
			humidity => humidity_2,
			req_humid => req_humid_2,
			growth_days => growth_days_2,
			fifo_request => fifo_request_2
		);
handler_3 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_3,
			humidity => humidity_3,
			req_humid => req_humid_3,
			growth_days => growth_days_3,
			fifo_request => fifo_request_3
		);
handler_4 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_4,
			humidity => humidity_4,
			req_humid => req_humid_4,
			growth_days => growth_days_4,
			fifo_request => fifo_request_4
		);
handler_5 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_5,
			humidity => humidity_5,
			req_humid => req_humid_5,
			growth_days => growth_days_5,
			fifo_request => fifo_request_5
		);
handler_6 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_6,
			humidity => humidity_6,
			req_humid => req_humid_6,
			growth_days => growth_days_6,
			fifo_request => fifo_request_6
		);
handler_7 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_7,
			humidity => humidity_7,
			req_humid => req_humid_7,
			growth_days => growth_days_7,
			fifo_request => fifo_request_7
		);
handler_8 : handler
PORT MAP(
			clk => clk,
			reset => reset,
			reply => reply_8,
			humidity => humidity_8,
			req_humid => req_humid_8,
			growth_days => growth_days_8,
			fifo_request => fifo_request_8
		);


--days counting and inserting into fifo.
process(clk,reset)
-- 100000 clks =  day
variable counter : INTEGER :=0;
begin
if reset = '1' then 
	-- reset the days counting
	days <= 0;
	counter := 0;
elsif rising_edge(clk) then
	wr_en <= '0';
	--writing to fifo on the start of day for 8 clocks(8 divisions)
	if counter = 0 then 
		days <= days+1;
		counter := counter+1;
	elsif counter = 100000 then
		counter :=0;
		---handling
	elsif counter = 1 then
		counter := counter + 1;
		--fifo_handler 1
		din <= fifo_request_1;
		wr_en <= '1';
	elsif counter = 2 then
		counter := counter + 1;
		--fifo_handler 2
		din <= fifo_request_2;
		wr_en <= '1';
	elsif counter = 3 then
		counter := counter + 1;
		--fifo_handler 3
		din <= fifo_request_3;
		wr_en <= '1';
	elsif counter = 4 then
		counter := counter + 1;
		--fifo_handler 4
		din <= fifo_request_4;
		wr_en <= '1';
	elsif counter = 5 then
		counter := counter + 1;
		--fifo_handler 5
		din <= fifo_request_5;
		wr_en <= '1';
	elsif counter = 6 then
		counter := counter + 1;
		--fifo_handler 6
		din <= fifo_request_6;
		wr_en <= '1';
	elsif counter = 7 then
		counter := counter + 1;
		--fifo_handler 7
		din <= fifo_request_7;
		wr_en <= '1';
	elsif counter = 8 then
		counter := counter + 1;
		--fifo_handler 8
		din <= fifo_request_8;
		wr_en <= '1';
	else
		counter := counter + 1;
	end if;
end if;
end process;


-- reading from fifo . when its not empty and the machine is not busy.
process(clk,reset)
variable temp :INTEGER := 0;
variable temp2 : INTEGER := 0;
variable counter : INTEGER := 0;
begin
	if reset = '1' then 
		enable <= "0000";
		temp2 := 0;
		temp := 0;
	elsif rising_edge(clk) then
	 rd_en <= '0';
	 -- pop out from fifo
		if (empty = '0' and busy = '0') or (counter = 7 and empty = '1' and busy = '0') then
			if temp = 2 then -- after two clocks process check the dout of fifo and process accordingly
				temp := temp+1;
					if counter = 0 then -- field 1
						field_X <= "000000";
						field_Y <= "000000";
						counter := counter+1;
						crop_density <= crop_density_1;
						
						required_humidity <= req_humid_1;
					elsif counter = 1 then -- field2
						field_Y <= "000000";
						field_X <= "001010";
						counter := counter+1;
						crop_density <= crop_density_2;
						
						required_humidity <= req_humid_2;
					elsif counter = 2 then -- field 3
						field_Y <= "000000";
						field_X <= "010100";
						counter := counter+1;
						crop_density <= crop_density_3;
						
						required_humidity <= req_humid_3;
					elsif counter = 3 then -- field 4
						field_Y <= "000000";
						field_X <= "011110";
						counter := counter+1;
						crop_density <= crop_density_4;
						required_humidity <= req_humid_4;
					elsif counter = 4 then -- field 5
						field_X <= "000000";
						field_Y <= "010100";
						counter := counter+1;
						crop_density <= crop_density_5;
						required_humidity <= req_humid_5;
					elsif counter = 5 then -- field 6
						field_X <= "001010";
						field_Y <= "010100";
						counter := counter+1;
						crop_density <= crop_density_6;
						required_humidity <= req_humid_6;
					elsif counter = 6 then -- field 7
						field_X <= "010100";
						field_Y <= "010100";
						counter := counter+1;
						crop_density <= crop_density_7;
						required_humidity <= req_humid_7;
					elsif counter = 7 then -- field 8
						field_X <= "011110";
						field_Y <= "010100";
						counter := 0;
						crop_density <= crop_density_8;
						required_humidity <= req_humid_8;
					end if;
					--based on fifo assigning work to that component.
					if dout = "000" then
					--tilling
						enable <= "1000";
						part <= "1000";
					elsif dout = "001" then
					--sowing
						enable <= "0100";
						part <= "0100";
					elsif dout = "010" then
					--watering
						enable <= "0010";
						part <= "0010";
					elsif dout = "011" then
					--cutting
						enable <= "0001";
						part <= "0001";
					else 
						part <= "0000";
						enable <= "0000";
					end if;
				
			elsif temp = 0 then
				-- after processing previous make enable 0000
				enable <= "0000";
				part <= "0000";
				rd_en <= '1';
				temp := temp + 1;
			elsif temp = 6 then
				temp := 0;
			else 
				temp := temp + 1;
			end if;
			--last time the work was popped ..from that time wait for 5 clocks
			temp2 := 0;
		elsif empty = '1' and busy = '0' then
			-- after being empty it will wait for 5 clocks to see if it gets busy else
			-- enable 0000.
			if temp2 = 5 then
				temp2 := 0;
				enable <= "0000";
				part <= "0000";
			else
				temp2 := temp2 + 1;
			end if;
			--since the fifo is empty ..
			temp := 0;
			
		end if;
	
	end if;
end process;
--when the component work is completed replying to handler to update the status of each fields
-- according to the reply
process(busy, part)
begin
	if busy = '0' then
		if part = "1000" then  -- tilling reply
			if field_X = "000000" and field_Y = "000000" then --field 1
				reply_1 <= "000";			
			elsif field_X = "001010" and field_Y = "000000" then --2
				reply_2 <= "000";
			elsif field_X = "010100" and field_Y = "000000" then --3
				reply_3 <= "000";
			elsif field_X = "011110" and field_Y = "000000" then --4
				reply_4 <= "000";
			elsif field_X = "000000" and field_Y = "010100" then --5
				reply_5 <= "000";
			elsif field_X = "001010" and field_Y = "010100" then --6
				reply_6 <= "000";
			elsif field_X = "010100" and field_Y = "010100" then --7
				reply_7 <= "000";
			elsif field_X = "011110" and field_Y = "010100" then --8
				reply_8 <= "000";
			end if;--sowing reply
			-- field locations according to divisions
		elsif part = "0100" then
			if field_X = "000000" and field_y = "000000" then
				reply_1 <= "001";			
			elsif field_X = "001010" and field_Y = "000000" then
				reply_2 <= "001";
			elsif field_X = "010100" and field_Y = "000000" then
				reply_3 <= "001";
			elsif field_X = "011110" and field_Y = "000000" then
				reply_4 <= "001";
			elsif field_X = "000000" and field_Y = "010100" then
				reply_5 <= "001";
			elsif field_X = "001010" and field_Y = "010100" then
				reply_6 <= "001";
			elsif field_X = "010100" and field_Y = "010100" then
				reply_7 <= "001";
			elsif field_X = "011110" and field_Y = "010100" then
				reply_8 <= "001";
			end if;
			--watering process completed ,replying to the particular handler
		elsif part = "0010" then
			if field_X = "000000" and field_Y = "000000" then
				reply_1 <= "010";			
			elsif field_X = "001010" and field_Y = "000000" then
				reply_2 <= "010";
			elsif field_X = "010100" and field_Y = "000000" then
				reply_3 <= "010";
			elsif field_X = "011110" and field_Y = "000000" then
				reply_4 <= "010";
			elsif field_X = "000000" and field_Y = "010100" then
				reply_5 <= "010";
			elsif field_X = "001010" and field_Y = "010100" then
				reply_6 <= "010";
			elsif field_X = "010100" and field_Y = "010100" then
				reply_7 <= "010";
			elsif field_X = "011110" and field_Y = "010100" then
				reply_8 <= "010";
			end if;
			--cutting process completed , replying to the particular field
		elsif part = "0001" then
			if field_X = "000000" and field_Y = "000000" then
				reply_1 <= "011";			
			elsif field_X = "001010" and field_Y = "000000" then
				reply_2 <= "011";
			elsif field_X = "010100" and field_Y = "000000" then
				reply_3 <= "011";
			elsif field_X = "011110" and field_Y = "000000" then
				reply_4 <= "011";
			elsif field_X = "000000" and field_Y = "010100" then
				reply_5 <= "011";
			elsif field_X = "001010" and field_Y = "010100" then
				reply_6 <= "011";
			elsif field_X = "010100" and field_Y = "010100" then
				reply_7 <= "011";
			elsif field_X = "011110" and field_Y = "010100" then
				reply_8 <= "011";
			end if;
			-- no work on that field replying null value(111) // reply sensitivity updates
		elsif part <= "0000" then 
			if field_X = "000000" and field_Y = "000000" then
				reply_1 <= "111";			
			elsif field_X = "001010" and field_Y = "000000" then
				reply_2 <= "111";
			elsif field_X = "010100" and field_Y = "000000" then
				reply_3 <= "111";
			elsif field_X = "011110" and field_Y = "000000" then
				reply_4 <= "111";
			elsif field_X = "000000" and field_Y = "010100" then
				reply_5 <= "111";
			elsif field_X = "001010" and field_Y = "010100" then
				reply_6 <= "111";
			elsif field_X = "010100" and field_Y = "010100" then
				reply_7 <= "111";
			elsif field_X = "011110" and field_Y = "010100" then
				reply_8 <= "111";
			end if;
		end if;
	end if;
end process;

-- database of crops(req humidity, crop_density, growth period)
--required humidity
process(clk ,reset)
begin
	if reset = '1' then
		--crop_density
		crop_density_1 <= "01100100";
		crop_density_2 <= "01100100";
		crop_density_3 <= "01100100";
		crop_density_4 <= "01100100";
		crop_density_5 <= "01100100";
		crop_density_6 <= "01100100";
		crop_density_7 <= "01100100";
		crop_density_8 <= "01100100";
		-- growth days
		growth_days_1 <= "0000101";
		growth_days_2 <= "0000111";
		growth_days_3 <= "0000101";
		growth_days_4 <= "0001010";
		growth_days_5 <= "0000100";
		growth_days_6 <= "0000111";
		growth_days_7 <= "0001110";
		growth_days_8 <= "0000100";
		--optimal humidity
		req_humid_1 <= "01100100";
		req_humid_2 <= "01100100";
		req_humid_3 <= "01100100";
		req_humid_4 <= "01100100";
		req_humid_5 <= "01100100";
		req_humid_6 <= "01100100";
		req_humid_7 <= "01100100";
		req_humid_8 <= "01100100";
	end if;
end process;
--updating present humidity
process(clk, reset)
begin
if reset = '1' then
	present_humidity <= "00000000";
elsif rising_edge(clk) then
-- at each clock take the input from the sensor
-- the field that is being watered is chosen
-- controller passess the present_humidity of that field to watering system
	if part = "0010" then
		if field_X = "000000" and field_Y = "000000" then -- if 1
			present_humidity <= humidity_1;
		elsif field_X = "001010" and field_Y = "000000" then -- if 2
			present_humidity <= humidity_2;
		elsif field_X = "010100" and field_Y = "000000" then -- if 3
			present_humidity <= humidity_3;
		elsif field_X = "011110" and field_Y = "000000" then -- if 4
			present_humidity <= humidity_4;
		elsif field_X = "000000" and field_Y = "010100" then -- if 5
			present_humidity <= humidity_5;
		elsif field_X = "001010" and field_Y = "010100" then -- if 6
			present_humidity <= humidity_6;
		elsif field_X = "010100" and field_Y = "010100" then -- if 7
			present_humidity <= humidity_7;
		elsif field_X = "011110" and field_Y = "010100" then -- if 8
			present_humidity <= humidity_8;
		end if;
	end if;
end if;
end process;

-- power calcluation
process(clk,reset)
begin
if reset  = '1' then
	-- resetting power to 0
	power <= (others => '0');
	p <= (others => '0');
elsif rising_edge(clk) then
-- increasing power by one if process going on every clk
	if busy = '1' then
	p <= p + '1';
	elsif days >= 365 then -- if 365 days completed and not busy
		p <= (others => '0');
	end if;
	power <= p;

end if;
end process;
end Behavioral;

