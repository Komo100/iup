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
 led_o : out STD_LOGIC_VECTOR (2 downto 0));
end component top;

signal clk_i : STD_LOGIC;
signal rst_i : STD_LOGIC;
signal led_o : STD_LOGIC_VECTOR (2 downto 0);

begin

dut: top port map (
    clk_i => clk_i,
    rst_i => rst_i,
    led_o => led_o
 );
    
stim: process
begin
rst_i <= '1';
clk_i <= '0';
wait for 100ms;
rst_i <= '0';
wait for 200ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
wait for 100ms;
clk_i <= not clk_i;
end process;

end Behavioral;