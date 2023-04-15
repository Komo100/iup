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
        digit_i : in STD_LOGIC_VECTOR (31 downto 0);
        led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
        led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

signal count_led : STD_LOGIC_VECTOR (1 downto 0) := "00";
signal count_clk : integer := 0;
signal kHz_clk : STD_LOGIC := '0';
constant N : integer := 100000;
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) or falling_edge(clk_i) then
            if (count_clk = N - 1) then
                kHz_clk <= not kHz_clk;
                count_clk <= 0;
            else
                count_clk <= count_clk + 1;
            end if;
        end if;
    end process;
    process(kHz_clk, rst_i)
    begin
        if rst_i = '1' then
        led7_an_o <= "0000";
        led7_seg_o <= "00000000";
        elsif rising_edge(kHz_clk) then
            case count_led is
            when "00" => led7_an_o <= "1110"; led7_seg_o <= digit_i (7 downto 0);
            when "01" => led7_an_o <= "1101"; led7_seg_o <= digit_i (15 downto 8);
            when "10" => led7_an_o <= "1011"; led7_seg_o <= digit_i (23 downto 16);
            when "11" => led7_an_o <= "0111"; led7_seg_o <= digit_i (31 downto 24);
            when others => NULL;
            end case;
            count_led <= count_led + "01";
        end if;  
    end process;
end Behavioral;