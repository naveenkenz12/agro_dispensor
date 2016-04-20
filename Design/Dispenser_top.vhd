----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:22:05 04/04/2016 
-- Design Name: 
-- Module Name:    Dispenser_top - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Inficoders_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  --theser are hummidity of field div reported by sensor
           humidity_1 : in  STD_LOGIC_VECTOR (7 downto 0); 
			  humidity_2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  humidity_3 : in  STD_LOGIC_VECTOR (7 downto 0);
			  humidity_4 : in  STD_LOGIC_VECTOR (7 downto 0);
			  humidity_5 : in  STD_LOGIC_VECTOR (7 downto 0);
			  humidity_6 : in  STD_LOGIC_VECTOR (7 downto 0);
			  humidity_7 : in  STD_LOGIC_VECTOR (7 downto 0);
			  --X, Y coordinate of the machine
			  machine_x,machine_y : inout STD_LOGIC_VECTOR(5 downto 0);
			  -- power consumption in a year. Reset to 0 after 365 days
			  power : out STD_LOGIC_VECTOR(31 downto 0);
			  -- These bits high if that is happening
			  sow: out STD_LOGIC;
	        till: out STD_LOGIC;
	        water: out STD_LOGIC;
			  cut: out STD_LOGIC;
			  dead_report : out STD_LOGIC;
			  health: in STD_LOGIC; -- from the health monitor system This is high when crop is dead
			  humidity_8 : in  STD_LOGIC_VECTOR (7 downto 0)
			  );
end Inficoders_top;

architecture Behavioral of Inficoders_top is
--controller component
COMPONENT controller
PORT(reset : in  STD_LOGIC;
	  busy : in STD_LOGIC;
	  humidity_1 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_2 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_3 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_4 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_5 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_6 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_7 : in STD_LOGIC_VECTOR(7 downto 0);
	  humidity_8 : in STD_LOGIC_VECTOR(7 downto 0);
	  enable : out STD_LOGIC_vector(3 downto 0);
	  --specific to field
	  field_X: inout STD_LOGIC_VECTOR(5 downto 0);
	  field_Y: inout STD_LOGIC_VECTOR(5 downto 0);
	  crop_density: out STD_LOGIC_VECTOR(7 downto 0);
	  present_humidity: out STD_LOGIC_VECTOR(7 downto 0);
	  power : out STD_LOGIC_VECTOR(31 downto 0);
     required_humidity: out STD_LOGIC_VECTOR(7 downto 0);
	  clk : in  STD_LOGIC);
END COMPONENT;
--component tilling
COMPONENT tilling
PORT(
	  x : out  STD_LOGIC_vector(5 downto 0);
     y : out  STD_LOGIC_vector(5 downto 0);
     initial_x : in STD_LOGIC_VECTOR(5 downto 0);
	  initial_y : in STD_LOGIC_VECTOR(5 downto 0);
	  busy : inout std_logic;
     enable : in  STD_LOGIC;
     crop_density : in std_logic_vector(7 downto 0);
     tilling_location_x : in  STD_LOGIC_vector(5 downto 0);
     tilling_location_y : in  STD_LOGIC_vector(5 downto 0);
     reset : in  STD_LOGIC;
	  till : out std_logic;
     clk : in  STD_LOGIC
);
END COMPONENT;
--component sowing
COMPONENT sowing
PORT(
		x : out  STD_LOGIC_vector(5 downto 0);
		y : out  STD_LOGIC_vector(5 downto 0);
      initial_x : in STD_LOGIC_VECTOR(5 downto 0);
	   initial_y : in STD_LOGIC_VECTOR(5 downto 0);
		busy : inout std_logic;
      enable : in  STD_LOGIC;
      crop_density : in std_logic_vector(7 downto 0);
      sowing_location_x : in  STD_LOGIC_vector(5 downto 0);
      sowing_location_y : in  STD_LOGIC_vector(5 downto 0);
      reset : in  STD_LOGIC;
	   sow : out std_logic;
      clk : in  STD_LOGIC
);
END COMPONENT;
----component watering 
COMPONENT watering
PORT(
		x : out  STD_LOGIC_vector(5 downto 0);
		y : out  STD_LOGIC_vector(5 downto 0);
      initial_x : in STD_LOGIC_VECTOR(5 downto 0);
	   initial_y : in STD_LOGIC_VECTOR(5 downto 0);
		busy : inout std_logic;
      enable : in  STD_LOGIC;
      present_humidity : in std_logic_vector(7 downto 0);
		required_humidity : in std_logic_vector(7 downto 0);
      watering_location_x : in  STD_LOGIC_vector(5 downto 0);
      watering_location_y : in  STD_LOGIC_vector(5 downto 0);
      reset : in  STD_LOGIC;
	   water : out std_logic;
      clk : in  STD_LOGIC
	
);
END COMPONENT;

COMPONENT cutting
PORT(
		x : out  STD_LOGIC_vector(5 downto 0);
		y : out  STD_LOGIC_vector(5 downto 0);
      initial_x : in STD_LOGIC_VECTOR(5 downto 0);
	   initial_y : in STD_LOGIC_VECTOR(5 downto 0);
		busy : inout std_logic;
      enable : in  STD_LOGIC;
      crop_density : in std_logic_vector(7 downto 0);
      cutting_location_x : in  STD_LOGIC_vector(5 downto 0);
      cutting_location_y : in  STD_LOGIC_vector(5 downto 0);
      reset : in  STD_LOGIC;
		health: in STD_LOGIC;
	   cut : out std_logic;
		dead_report : out std_logic;
      clk : in  STD_LOGIC
);
END COMPONENT;
--controller signals
signal busy1,busy2,busy3,busy4 : STD_LOGIC := '0' ;
signal enable : STD_LOGIC_VECTOR(3 downto 0);
signal field_X,field_Y : STD_LOGIC_VECTOR(5 downto 0);
signal present_humidity : STD_LOGIC_VECTOR (7 downto 0);
signal required_humidity : STD_LOGIC_VECTOR (7 downto 0);
signal crop_density: STD_LOGIC_VECTOR(7 downto 0);
-- machine X, Y maintainence
-- all four components can update the x,y cordinates
signal x1,y1,x2,y2,x3,y3,x4,y4 : STD_LOGIC_VECTOR(5 downto 0):="000000";


begin
--port mapping
controller_main : controller
PORT MAP(
	reset => reset,
	clk => clk,
	humidity_1 => humidity_1,
	humidity_2 => humidity_2,
	humidity_3 => humidity_3,
	humidity_4 => humidity_4,
	humidity_5 => humidity_5,
	humidity_6 => humidity_6,
	humidity_7 => humidity_7,
	humidity_8 => humidity_8,
	enable => enable,
	busy => (busy1 or busy2 or busy3 or busy4),
	field_X => field_X,
	field_Y => field_Y,
	crop_density => crop_density,
	power => power,
	required_humidity => required_humidity,
	present_humidity => present_humidity
); 

tilling_main: tilling
PORT MAP(
	reset => reset,
	clk => clk,
	busy => busy1,
	enable => enable(3),
	tilling_location_X => field_X,
	tilling_location_Y => field_Y,
	crop_density => crop_density,
	till => till,
	initial_x => machine_x,
	initial_y => machine_y,
	x => x1,
	y => y1
	
);
sowing_main : sowing
PORT MAP(
	reset => reset,
	clk => clk,
	busy => busy2,
	enable => enable(2),
	sowing_location_X => field_X,
	sowing_location_Y => field_Y,
	crop_density => crop_density,
	sow => sow,
	initial_x => machine_x,
	initial_y => machine_y,
	x => x2,
	y => y2
);
watering_main : watering
PORT MAP(
	reset => reset,
	clk => clk,
	busy => busy3,
	enable => enable(1),
	watering_location_X => field_X,
	watering_location_Y => field_Y,
	present_humidity => present_humidity,		-- modify
	required_humidity => required_humidity,
	water => water,
	initial_x => machine_x,
	initial_y => machine_y,
	x => x3,
	y => y3

);

cutting_main : cutting
PORT MAP(
	reset => reset,
	clk => clk,
	busy => busy4,
	enable => enable(0),
	cutting_location_X => field_X,
	cutting_location_Y => field_Y,
	crop_density => crop_density,
	cut => cut,
	dead_report => dead_report,
	initial_x => machine_x,
	initial_y => machine_y,
	health => health,
	x => x4,
	y => y4
);



process(clk,reset)
begin
if reset = '1' then
	--resetting all components starting positions to 0 0
	machine_x <= "000000";  -- this is machines current position
	machine_y <= "000000";
elsif rising_edge(clk) then
	if enable = "1000" then
		-- 1000  therefore tilling active.
		--updating x,y coordinates of machine according to changes in x1,y1(tilling process changes)
		machine_x <= x1;
		machine_y <= y1;
		
	elsif enable = "0100" then
	--similarly changes by sowing
		machine_x <= x2;
		machine_y <= y2;
		
	elsif enable = "0010" then
		--similarly changes by watering
		machine_x <= x3;
		machine_y <= y3;
		
	elsif enable = "0001" then
		--similarly changes by cutting
		machine_x <= x4;
		machine_y <= y4;
		
	
	end if;
end if;
end process;



end Behavioral;

