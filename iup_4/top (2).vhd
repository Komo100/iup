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
 led_o : out STD_LOGIC_VECTOR (3 downto 0));
end top;

architecture Behavioral of top is

signal count : STD_LOGIC_VECTOR (3 downto 0);
signal load : STD_LOGIC;
begin
    led_o(3) <= count(3);
    led_o(2) <= count(2);
    led_o(1) <= count(1);
    led_o(0) <= count(0);
    process(clk_i, rst_i)
    begin
        if (rst_i = '1') or (rising_edge(clk_i) and (count = "1000"))then
            count <= "0000";
        elsif rising_edge(clk_i) then 
        if count = "1111" then
            count <= count - 1;
        elsif count(3)= '1' then 
            count(3 downto 1) <= count(2 downto 0);
        else              
            count <= count + "0001";
            count(3 downto 1) <= count(2 downto 0);
            count(0) <= '1'; 
       end if;
       end if;
    end process;
end Behavioral;
