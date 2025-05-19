---------------------------------------------------------------------------------
--
-- 							Missile Command for DE2-35 
--          			  	     Pinballwiz.org
--								 	    19/05/2025
--
--	DE2-35 toplevel code by pinballwiz all other code from Mister project
--					
-------------------------------------------------------------------------------
-- Keyboard inputs :
--   5 : Add coin
--   2 : Start 2 players
--   1 : Start 1 player
--   Z : Fire Left
--   X : Fire Center
--   C : Fire Right
--   RIGHT arrow : Move Crosshair Right
--   LEFT arrow  : Move Crosshair Left
--   UP arrow    : Move Crosshair Up
--   DOWN arrow  : Move Crosshair Down

---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity missilecommand_top is
port(
 clock_50  : in std_logic;
 key       : in std_logic_vector(3 downto 0);

 ps2_clk : in std_logic;
 ps2_dat : inout std_logic;

 vga_r     : out std_logic_vector(9 downto 0);
 vga_g     : out std_logic_vector(9 downto 0);
 vga_b     : out std_logic_vector(9 downto 0);
 vga_clk   : out std_logic;
 vga_blank : out std_logic;
 vga_sync  : out std_logic;
 vga_hs    : out std_logic;
 vga_vs    : out std_logic;

 i2c_sclk : out std_logic;
 i2c_sdat : inout std_logic;
 
 aud_adclrck : out std_logic;
 aud_adcdat  : in std_logic;
 aud_daclrck : out std_logic;
 aud_dacdat  : out std_logic;
 aud_xck     : out std_logic;
 aud_bclk    : out std_logic
 
 );
end missilecommand_top;
------------------------------------------------------------------------------
architecture struct of missilecommand_top is

 signal clock_20  : std_logic;
 signal clock_10  : std_logic;
 signal clock_5  	: std_logic;

 signal video_r   : std_logic_vector(7 downto 0);
 signal video_g   : std_logic_vector(7 downto 0);
 signal video_b   : std_logic_vector(7 downto 0);
 signal video_clk : std_logic;
 signal csync     : std_logic;
 signal blankn    : std_logic;
 
 signal video_r_x2 : std_logic_vector(5 downto 0);
 signal video_g_x2 : std_logic_vector(5 downto 0);
 signal video_b_x2 : std_logic_vector(5 downto 0);
 signal hsync_x2   : std_logic;
 signal vsync_x2   : std_logic;
 
 signal h_sync    : std_logic;
 signal v_sync	   : std_logic;
 
 signal audio     : std_logic_vector(5 downto 0);
 signal sound_string : std_logic_vector(31 downto 0);
 signal reset     : std_logic;
 
 alias  reset_n   : std_logic is key(0);
 
 signal kbd_intr  : std_logic;
 signal kbd_scancode  : std_logic_vector(7 downto 0);
 signal joy_BBBBFRLDU : std_logic_vector(8 downto 0);
 
 signal vtb_dir1	: std_logic;
 signal vtb_clk1	: std_logic;
 signal htb_dir1	: std_logic;
 signal htb_clk1	: std_logic;
 
 signal flip 		: std_logic;
 signal joystick_analog : std_logic_vector(15 downto 0);
 signal ps2_mouse : std_logic_vector(24 downto 0);
 -----------------------------------------------------------------------------
component missile
    port (
    clk_10M  : in std_logic;
    ce_5M    : in std_logic;
    reset    : in std_logic;
    r 		 : out std_logic_vector (7 downto 0);
    g 		 : out std_logic_vector (7 downto 0);
    b 		 : out std_logic_vector (7 downto 0);
    h_sync   : out std_logic;
    v_sync   : out std_logic;
    audio_o  : out std_logic_vector (5 downto 0);
	 coin		 : in std_logic;
	 p1_start : in std_logic;
--	 p2_start : in std_logic;
	 p1_fire_l: in std_logic;
	 p1_fire_c: in std_logic;
	 p1_fire_r: in std_logic;
	 vtb_dir1 : in std_logic;
	 vtb_clk1 : in std_logic;
	 htb_dir1 : in std_logic;
	 htb_clk1 : in std_logic
  );
end component;
---------------------------------------------------------------------------
  component scandoubler 
    port (
    clk_sys 	: in std_logic;
    scanlines 	: in std_logic_vector (1 downto 0);
    hs_in 		: in std_logic;
    vs_in 		: in std_logic;
    r_in 		: in std_logic_vector (5 downto 0);
    g_in 		: in std_logic_vector (5 downto 0);
    b_in			: in std_logic_vector (5 downto 0);
    hs_out 		: out std_logic;
    vs_out 		: out std_logic;
    r_out 		: out std_logic_vector (5 downto 0);
    g_out 		: out std_logic_vector (5 downto 0);
    b_out 		: out std_logic_vector (5 downto 0)
  );
end component; 
---------------------------------------------------------------------------
  component trackball 
    port (
	clk				: in std_logic;
	flip				: in std_logic;
	joystick			: in std_logic_vector (3 downto 0);
	joystick_mode	: in std_logic;
	joystick_analog: in std_logic_vector (15 downto 0);
	joystick_sensitivity	: in std_logic;
	mouse_speed		: in std_logic_vector (1 downto 0);
	ps2_mouse		: in std_logic_vector (24 downto 0);
	v_dir				: out std_logic;
	v_clk				: out std_logic;
	h_dir				: out std_logic;
	h_clk				: out std_logic
);
end component; 
---------------------------------------------------------------------------

begin

reset <= not reset_n;

clocks : entity work.missilecommand_clocks
port map(
 inclk0 	=> clock_50,
 c0 		=> clock_20,
 c1 		=> clock_10,
 locked 	=> open --pll_locked
);

process (clock_10)
begin
 if rising_edge(clock_10) then
  clock_5  <= not clock_5;
 end if;
end process;
--------------------------------------------------------------
missile_inst :  missile
  port map (
 clk_10M => clock_10,
 ce_5M   => clock_5,
 reset   => reset,
 r      	=> video_r,
 g      	=> video_g,
 b      	=> video_b,
 h_sync  => h_sync,
 v_sync 	=> v_sync,
 audio_o => audio,
 coin    	=> joy_BBBBFRLDU(7), 	-- 5 : Add coin
 p1_start  	=> joy_BBBBFRLDU(5), 	-- 1 : Start 1 Player
-- p2_start  	=> joy_BBBBFRLDU(6), -- 2 : Start 2 Players
 p1_fire_l 	=> joy_BBBBFRLDU(4), 	-- Z : P1 left fire
 p1_fire_c 	=> joy_BBBBFRLDU(8), 	-- X : P1 center fire
 p1_fire_r 	=> joy_BBBBFRLDU(6), 	-- C : P1 right fire
 vtb_dir1 	=>	vtb_dir1,
 vtb_clk1 	=>	vtb_clk1,
 htb_dir1 	=>	htb_dir1,
 htb_clk1 	=>	htb_clk1
   );
---------------------------------------------------------------------------  
  trackball_inst : trackball
    port map (
		clk  						=>	clock_10,
		flip 						=>	flip,
		joystick					=>	joy_BBBBFRLDU(0)&joy_BBBBFRLDU(1)&joy_BBBBFRLDU(2)&joy_BBBBFRLDU(3),
		joystick_mode			=>	'0',
		joystick_analog		=>	joystick_analog,
		joystick_sensitivity	=>	'0',
		mouse_speed				=>	"00",
		ps2_mouse				=>	ps2_mouse,
		v_dir						=>	vtb_dir1,
		v_clk						=>	vtb_clk1,
		h_dir						=>	htb_dir1,
		h_clk						=>	htb_clk1
	);	
---------------------------------------------------------------------------  
  u_dblscan : scandoubler
    port map (
		clk_sys => clock_20,
		r_in => video_r(7 downto 2),
		g_in => video_g(7 downto 2),
		b_in => video_b(7 downto 2),
		hs_in => h_sync,
		vs_in => v_sync,
		r_out => video_r_x2,
		g_out => video_g_x2,
		b_out => video_b_x2,
		hs_out => hsync_x2,
		vs_out => vsync_x2,
		scanlines => "00"
	);
-------------------------------------------------------------------------
-- to output

	vga_r 	<= video_r_x2 & "0000";
	vga_g 	<= video_g_x2 & "0000";
	vga_b 	<= video_b_x2 & "0000";
	vga_hs   <= hsync_x2;
	vga_vs   <= vsync_x2;

	vga_clk   <= clock_20;
	vga_sync  <= '0';
	vga_blank <= '1';

	sound_string <= "00000" & audio & "00000" & "00000" & audio & "00000";
------------------------------------------------------------------------------
wm8731_dac : entity work.wm8731_dac
port map(
 clk18MHz => clock_20,
 sampledata => sound_string,
 i2c_sclk => i2c_sclk,
 i2c_sdat => i2c_sdat,
 aud_bclk => aud_bclk,
 aud_daclrck => aud_daclrck,
 aud_dacdat => aud_dacdat,
 aud_xck => aud_xck
); 
------------------------------------------------------------------------------
-- get scancode from keyboard
keyboard : entity work.io_ps2_keyboard
port map (
  clk       => clock_10,
  kbd_clk   => ps2_clk,
  kbd_dat   => ps2_dat,
  interrupt => kbd_intr,
  scancode  => kbd_scancode
);
------------------------------------------------------------------------------
-- translate scancode to joystick
joystick : entity work.kbd_joystick
port map (
  clk         => clock_10,
  kbdint      => kbd_intr,
  kbdscancode => std_logic_vector(kbd_scancode), 
  joy_BBBBFRLDU  => joy_BBBBFRLDU 
);
------------------------------------------------------------------------------
end struct;