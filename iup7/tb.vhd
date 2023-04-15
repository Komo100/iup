----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2023 20:45:13
-- Design Name: 
-- Module Name: tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

component top is
 Port ( clk_i : in STD_LOGIC;
 rst_i : in STD_LOGIC;
 start_stop_button_i : in STD_LOGIC;
 led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
 led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component top;

signal clk_i : STD_LOGIC := '0';
signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
signal start_stop_button_i : STD_LOGIC := '0';
signal rst_i : STD_LOGIC := '0';

begin

dut: top port map (
    clk_i => clk_i,
    led7_an_o => led7_an_o,
    led7_seg_o => led7_seg_o,
    rst_i => rst_i,
    start_stop_button_i => start_stop_button_i
 );
    
stim: process
begin
wait for 5ns;
clk_i <= not clk_i;
wait for 5ns;
clk_i <= not clk_i;
start_stop_button_i <= '1';
wait for 5ns;
clk_i <= not clk_i;
wait for 5ns;
clk_i <= not clk_i;
wait for 5ns;
clk_i <= not clk_i;
wait for 5ns;
clk_i <= not clk_i;
wait for 5ns;
clk_i <= not clk_i;
wait for 5ns;
clk_i <= not clk_i;
end process;

end Behavioral;