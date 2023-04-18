----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2023 21:43:05
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
 Port ( clk_i : in std_logic;
        red_o : out std_logic_vector (3 downto 0);
        green_o : out std_logic_vector (3 downto 0);
        blue_o : out std_logic_vector (3 downto 0);
        hsync_o : out std_logic;
        vsync_o : out std_logic;
        sw5_i : in std_logic;
        sw6_i : in std_logic;
        sw7_i : in std_logic;
        btn_i : in std_logic_vector (3 downto 0));
end top;


architecture Behavioral of top is

component sync_driver is
 Port ( clk_i : in std_logic;
        v_sync : out std_logic;
        h_sync : out std_logic;
        h_position : out integer;
        v_position : out integer;
        clk_25MHz : out std_logic);
end component;

component display is
Port ( clk_disp : in std_logic;
       red_o : out std_logic_vector (3 downto 0);
       green_o : out std_logic_vector (3 downto 0);
       blue_o : out std_logic_vector (3 downto 0);
       h_position : in integer;
       v_position : in integer;
       sw5_i : in std_logic;
       sw6_i : in std_logic;
       sw7_i : in std_logic;
       btn_i : in std_logic_vector (3 downto 0);
       v_sync : in std_logic);
end component;

signal h_pos : integer;
signal v_pos : integer;
signal v_sync : std_logic;
signal clk : std_logic;
begin
vsync_o <= v_sync;
f0 : sync_driver
    port map (
        clk_i => clk_i,
        v_sync => v_sync,
        h_sync => hsync_o,
        h_position => h_pos,
        v_position => v_pos,
        clk_25MHz => clk
    );
f1 : display
    port map (
        clk_disp => clk,
        red_o => red_o,
        green_o => green_o,
        blue_o => blue_o,
        h_position => h_pos,
        v_position => v_pos,
        sw5_i => sw5_i,
        sw6_i => sw6_i,
        sw7_i => sw7_i,
        btn_i => btn_i,
        v_sync => v_sync
    );
end Behavioral;