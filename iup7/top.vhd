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
 Port ( clk_i : in STD_LOGIC;
 rst_i : in STD_LOGIC;
 start_stop_button_i : in STD_LOGIC;
 led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
 led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

component display is
 Port ( clk_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        digit_i : in STD_LOGIC_VECTOR (31 downto 0);
        led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
        led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component timer is
 Port ( clk_i : in STD_LOGIC;
        start_stop_button_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        digit_i : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal digits : STD_LOGIC_VECTOR (31 downto 0);
begin
f0: display port map(clk_i, '0', digits, led7_an_o, led7_seg_o);
f1: timer port map(clk_i, start_stop_button_i, rst_i, digits);
end Behavioral;