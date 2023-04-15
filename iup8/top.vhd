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

entity timer is
 Port ( clk_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        ps2_clk_i : in STD_LOGIC;
        ps2_data_i : in STD_LOGIC;
        led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
        led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end timer;

architecture Behavioral of timer is
procedure ps2_to_led (signal input : in STD_LOGIC_VECTOR (7 downto 0);
                         signal digit : out STD_LOGIC_VECTOR (7 downto 0)) is 
begin
    case input is
    when x"45" => digit <= "00000011";
    when x"16" => digit <= "10011111";
    when x"1E" => digit <= "00100101";
    when x"26" => digit <= "00001101";
    when x"25" => digit <= "10011001";
    when x"2E" => digit <= "01001001";
    when x"36" => digit <= "01000001";
    when x"3D" => digit <= "00011111";
    when x"3E" => digit <= "00000001";
    when x"46" => digit <= "00001001";
    when x"1C" => digit <= "00010001";
    when x"32" => digit <= "11000001";
    when x"21" => digit <= "01100011";
    when x"23" => digit <= "10000101";
    when x"24" => digit <= "01100001";
    when x"2B" => digit <= "01110001";
    when others => digit <= "11111111";
    end case;
end procedure;
signal sampled_ps2_clk : STD_LOGIC;
signal sampled_ps2_data : STD_LOGIC;
signal counter : integer := 0;
signal data : STD_LOGIC_VECTOR (8 downto 0);
begin
    led7_an_o <= "1110";
    process(clk_i)
    begin
        sampled_ps2_clk <= ps2_clk_i;
        sampled_ps2_data <= ps2_data_i; 
    end process;
    
    process(sampled_ps2_clk, rst_i)
    begin
        if rst_i = '1' then
            led7_seg_o <= "00000000";
        elsif falling_edge(sampled_ps2_clk) then
            if sampled_ps2_data = '0' and counter = 0 then
                counter <= 1; 
            elsif counter > 0  and counter < 10 then
                data(counter - 1) <= sampled_ps2_data;
                counter <= counter + 1;
            elsif counter = 10 then
                counter <= 0;
                ps2_to_led(data (7 downto 0), led7_seg_o);
            end if;    
        end if;
    end process;

end Behavioral;