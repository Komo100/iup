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
 led_o : out STD_LOGIC);
end top;

architecture Behavioral of top is

signal count : integer;
signal output : STD_LOGIC;
constant N : integer := 5;
begin
led_o <= output;
    process(clk_i, rst_i)
    begin
        if (rst_i = '1') then
            count <= 0;
            output <= '0';
        elsif rising_edge(clk_i) or falling_edge(clk_i) then
            if (count = N - 1) then
                output <= not output;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
end Behavioral;