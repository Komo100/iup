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
use IEEE.numeric_std.all;
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
        start_stop_button_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        digit_i : out STD_LOGIC_VECTOR (31 downto 0) );
end timer;

architecture Behavioral of timer is
procedure binary_to_led (signal sw : in STD_LOGIC_VECTOR (3 downto 0);
                         signal digit : out STD_LOGIC_VECTOR (6 downto 0)) is 
begin
    case sw is
    when "0000" => digit <= "0000001";
    when "0001" => digit <= "1001111";
    when "0010" => digit <= "0010010";
    when "0011" => digit <= "0000110";
    when "0100" => digit <= "1001100";
    when "0101" => digit <= "0100100";
    when "0110" => digit <= "0100000";
    when "0111" => digit <= "0001111";
    when "1000" => digit <= "0000000";
    when "1001" => digit <= "0000100";
    when "1010" => digit <= "0000010";
    when "1011" => digit <= "1100000";
    when "1100" => digit <= "0110001";
    when "1101" => digit <= "1000010";
    when "1110" => digit <= "0110000";
    when "1111" => digit <= "0111000";
    when others => NULL;
    end case;
end procedure;


signal count_clk : integer := 0;
signal ms10_clk : STD_LOGIC := '0'; --100Hz clock
constant N : integer := 1000000;
signal q1, q2, debounced_btn : std_logic := '0';
signal debouncing_counter : integer := 0;
constant debouncing_wait_time : integer := 5; --in tens of miliseconds
signal start_stop_reset_flag : STD_LOGIC_VECTOR (1 downto 0) := "00"; --00: reset 01: start 10: stop 
signal ms10_ct : std_logic_vector (15 downto 0) := (others => '0');
begin
    --100MHz to 100Hz clock (N = 1000000)
    process(clk_i, rst_i)
    begin
        if rising_edge(clk_i) then
            if (count_clk = (N-1)/2) then
                count_clk <= 0;
                ms10_clk <= not ms10_clk;
            else
                count_clk <= count_clk + 1;
            end if;
        end if;
    end process;
    
    process(ms10_clk)
    begin
        if rising_edge(ms10_clk) then
            q1 <= start_stop_button_i;
            q2 <= q1;
            if q1 = q2 then
                debouncing_counter <= debouncing_counter + 1;
            else 
                debouncing_counter <= 0;
            end if;
            if debouncing_counter >= debouncing_wait_time then
                debounced_btn <= q2;
                debouncing_counter <= 0;
            end if;        
        end if;
    end process;
    
    process(debounced_btn, rst_i, start_stop_reset_flag)
    begin
        if rising_edge(debounced_btn) then
            start_stop_reset_flag <= start_stop_reset_flag + "01";
        end if;
        if rst_i = '1' or start_stop_reset_flag = "11" then
            start_stop_reset_flag <= "00";
        end if;
    end process;
    
    process(ms10_clk)
    begin
        if rising_edge(ms10_clk) then
        if start_stop_reset_flag = "00" then
            ms10_ct <= (others => '0');
        elsif start_stop_reset_flag = "01" then
            if ms10_ct (3 downto 0) < "1001" then
                ms10_ct (3 downto 0) <= ms10_ct (3 downto 0) + "0001";
            elsif  ms10_ct (7 downto 4) < "1001" then
                ms10_ct (7 downto 4) <= ms10_ct (7 downto 4) + "0001";
                ms10_ct (3 downto 0) <= (others => '0');
            elsif ms10_ct (11 downto 8) < "1001" then
                ms10_ct (11 downto 8) <= ms10_ct (11 downto 8) + "0001";
                ms10_ct (7 downto 0) <= (others => '0');
            else
                ms10_ct (15 downto 12) <= ms10_ct (15 downto 12) + "0001";
                ms10_ct (11 downto 0) <= (others => '0');
            end if;
            if ms10_ct (15 downto 12) >= "0110" then
                ms10_ct (15 downto 12) <= "0110";
                ms10_ct (11 downto 0) <= (others => '0');
            end if;
        end if;
        if ms10_ct (15 downto 12) >= "0110" then
            digit_i <= "11111101111111001111110111111101";
        else  
            binary_to_led(ms10_ct (3 downto 0), digit_i (7 downto 1));
            binary_to_led(ms10_ct (7 downto 4), digit_i (15 downto 9));
            binary_to_led(ms10_ct (11 downto 8), digit_i (23 downto 17));
            binary_to_led(ms10_ct (15 downto 12), digit_i (31 downto 25));
            digit_i(0) <= '1';
            digit_i(8) <= '1';
            digit_i (16) <= '0';
            digit_i (24) <= '1';
            end if;
       end if;
    end process;
end Behavioral;