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
 led_o : out STD_LOGIC_VECTOR (2 downto 0));
end top;

architecture Behavioral of top is

signal count : STD_LOGIC_VECTOR (2 downto 0);

begin
    led_o(2) <= count(2);
    led_o(1) <= count(2) xor count(1);
    led_o(0) <= count(1) xor count(0);
    process(clk_i, rst_i)
    begin
        if (rst_i = '1') then
            count <= "000";
        elsif rising_edge(clk_i) then
            count <= count + "001";
        end if;
    end process;
end Behavioral;
