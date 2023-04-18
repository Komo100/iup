----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.04.2023 15:42:29
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is
Port ( clk_disp : in std_logic;
       red_o : out std_logic_vector (3 downto 0);
       green_o : out std_logic_vector (3 downto 0);
       blue_o : out std_logic_vector (3 downto 0);
       h_position : in integer;
       v_position : in integer;
       sw5_i : in std_logic;
       sw6_i : in std_logic;
       sw7_i : in std_logic;
       btn_i : in std_logic_vector (3 downto 0);
       v_sync : in std_logic);
end display;
architecture Behavioral of display is

COMPONENT vga_bitmap
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
  );
END COMPONENT;

procedure hex_to_color (signal hex : in std_logic_vector (3 downto 0);
                        signal r : out std_logic_vector (3 downto 0);
                        signal g : out std_logic_vector (3 downto 0);
                        signal b : out std_logic_vector (3 downto 0)) is
begin
    case hex(3 downto 0) is
        when x"0" => r <= "0000"; g <= "0000"; b <= "0000"; --black
        when x"9" => r <= "1111"; g <= "0000"; b <= "0000"; --red
        when x"A" => r <= "0000"; g <= "1111"; b <= "0000"; --green
        when x"B" => r <= "1111"; g <= "1111"; b <= "0000"; --yellow
        when x"C" => r <= "0000"; g <= "0000"; b <= "1111"; --blue
        when x"D" => r <= "1111"; g <= "0000"; b <= "1111"; --magenta
        when x"E" => r <= "0000"; g <= "1111"; b <= "1111"; --cyan
        when x"F" => r <= "1111"; g <= "1111"; b <= "1111"; --white
        when others => NULL;
    end case;
end procedure;

procedure background_color (signal sw5_i : in std_logic;
                            signal sw6_i : in std_logic;
                            signal sw7_i : in std_logic;
                            signal r : out std_logic_vector (3 downto 0);
                            signal g : out std_logic_vector (3 downto 0);
                            signal b : out std_logic_vector (3 downto 0)) is
begin
    if sw5_i = '1' then r <= "1111";
    else r <= "0000";
    end if;
    
    if sw6_i = '1' then g <= "1111";
    else g <= "0000";
    end if;
    
    if sw7_i = '1' then b <= "1111";
    else b <= "0000";
    end if;
end procedure;
signal color_address : std_logic_vector (13 downto 0);
signal color : std_logic_vector (7 downto 0);

constant h_visible : integer := 640;
constant h_front : integer := 16;
constant h_pulse : integer := 96; 
constant h_back : integer := 48;
constant h_total : integer := 800;

constant v_visible : integer := 480;
constant v_front : integer := 10;
constant v_pulse : integer := 2;
constant v_back : integer := 33;
constant v_total : integer := 525;

signal h_pos_vis : integer;
signal v_pos_vis : integer;

signal h_picture_pos : integer := 200; -- upper left corner of the picture
signal v_picture_pos : integer := 100;

constant picture_width : integer := 256;
constant picture_height : integer := 96;
begin
    rom_bitmap : vga_bitmap
        PORT MAP (
            clka => clk_disp,
            addra => color_address,
            douta => color
        );
    process(clk_disp)
    begin
        if rising_edge(clk_disp) then
            if v_position < v_pulse + v_back or v_position >= v_total - v_front or --outside of the visible area
               h_position < h_pulse + h_back or h_position >= h_total - h_front then
                red_o <= "0000"; green_o <= "0000"; blue_o <= "0000";
            else
                if v_position < v_picture_pos or v_position >= v_picture_pos + picture_height then --check if below or above the picture
                    background_color(sw5_i, sw6_i, sw7_i, red_o, green_o, blue_o);
                    color_address <= "10111111110111"; -- starting address
                elsif h_position < h_picture_pos or h_position >= h_picture_pos + picture_width  then --check if to the right or to the left
                    background_color(sw5_i, sw6_i, sw7_i, red_o, green_o, blue_o);
                else
                    if h_position = h_picture_pos + picture_width then --end of a line
                        color_address <= color_address - "00000100000000";
                        background_color(sw5_i, sw6_i, sw7_i, red_o, green_o, blue_o);
                    elsif ((h_position - h_picture_pos) mod 2) = 1 then -- 1 clock cycle before new pixel
                        color_address <= color_address + "00000000000001";
                        hex_to_color(color (7 downto 4), red_o, green_o, blue_o);
                    else
                        hex_to_color(color (3 downto 0), red_o, green_o, blue_o);
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    process(v_sync)
    begin
        if rising_edge(v_sync) then
            if btn_i(0) = '1' then
                if h_picture_pos > h_pulse + h_back then
                    h_picture_pos <= h_picture_pos - 1; -- to the left
                end if;
            end if; 
            if btn_i(3) = '1' then
                if h_picture_pos + picture_width < h_total - h_front then
                    h_picture_pos <= h_picture_pos + 1; -- to the right
                end if;
            end if; 
            if btn_i(2) = '1' then
                if v_picture_pos > v_pulse + v_back then
                    v_picture_pos <= v_picture_pos - 1; -- up
                end if;
            end if;   
            if btn_i(1) = '1' then
                if v_picture_pos + picture_height < v_total - v_front then
                    v_picture_pos <= v_picture_pos + 1; -- down
                end if;
            end if;
        end if;
    end process;
end Behavioral;
