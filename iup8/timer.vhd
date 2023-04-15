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
        ps2_clk_i : in STD_LOGIC;
        ps2_data_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        digit_i : out STD_LOGIC_VECTOR (31 downto 0));
end timer;

architecture Behavioral of timer is
procedure ps2_to_led (signal input : in STD_LOGIC_VECTOR (7 downto 0);
                         signal digit : out STD_LOGIC_VECTOR (6 downto 0)) is 
begin
    case input is
    when x"45" => digit <= "0000001";
    when x"16" => digit <= "1001111";
    when x"1E" => digit <= "0010010";
    when x"26" => digit <= "0000110";
    when x"25" => digit <= "1001100";
    when x"2E" => digit <= "0100100";
    when x"36" => digit <= "0100000";
    when x"3D" => digit <= "0001111";
    when x"3E" => digit <= "0000000";
    when x"46" => digit <= "0000100";
    when x"1C" => digit <= "0000010";
    when x"32" => digit <= "1100000";
    when x"21" => digit <= "0110001";
    when x"23" => digit <= "1000010";
    when x"24" => digit <= "0110000";
    when x"2B" => digit <= "0111000";
    when others => NULL;
    end case;
end procedure;
signal sampled_ps2_clk : STD_LOGIC;
signal sampled_ps2_data : STD_LOGIC;
signal counter : integer := 0;
signal data : STD_LOGIC_VECTOR (8 downto 0);
begin
    
    process(clk_i)
    begin
        sampled_ps2_clk <= ps2_clk_i;
        sampled_ps2_data <= ps2_data_i; 
    end process;
    
    process(sampled_ps2_clk)
    begin
        if falling_edge(sampled_ps2_clk) then
            if sampled_ps2_data = '0' and counter = 0 then
                counter <= 1; 
            elsif counter > 0  and counter < 10 then
                data(counter - 1) <= sampled_ps2_data;
                counter <= counter + 1;
            elsif counter = 10 then
                counter <= 0;
            end if;    
        end if;
    end process;

end Behavioral;