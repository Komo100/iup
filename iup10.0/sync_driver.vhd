----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2023 13:42:39
-- Design Name: 
-- Module Name: sync_driver - Behavioral
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

entity sync_driver is
 Port ( clk_i : in std_logic;
        v_sync : out std_logic;
        h_sync : out std_logic;
        h_position : out integer;
        v_position : out integer;
        clk_25MHz : out std_logic);
end sync_driver;

architecture Behavioral of sync_driver is
constant pixel_time : integer := 4; -- in tens of nanoseconds / pixel freq = 25MHz
-- horizontal timing (in pixels)
constant h_visible : integer := 640; 
constant h_front : integer := 16;
constant h_pulse : integer := 96;
constant h_back : integer := 48;
constant h_total : integer := 800;
signal h_count : integer := 0;
-- vertical timing (in lines)
constant v_visible : integer := 480;
constant v_front : integer := 10;
constant v_pulse : integer := 2;
constant v_back : integer := 33;
constant v_total : integer := 525;
signal v_count : integer := 0;

signal vga_clk : std_logic := '0';
signal vga_clk_count : integer := 0;
begin
    v_sync <= '0' when v_count < v_pulse else '1';
    h_sync <= '0' when h_count < h_pulse else '1';
    clk_25MHz <= vga_clk;
    h_position <= h_count;
    v_position <= v_count;
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if (vga_clk_count = (pixel_time - 1)/2) then
                vga_clk_count <= 0;
                vga_clk <= not vga_clk;
            else
                vga_clk_count <= vga_clk_count + 1;
            end if;
        end if;
    end process;

    process(vga_clk)
    begin
        if rising_edge(vga_clk) then
            if h_count < h_total then
                h_count <= h_count + 1;
            elsif v_count < v_total then
                h_count <= 0;
                v_count <= v_count + 1;
            else
                h_count <= 0;
                v_count <= 0;
            end if;
        end if;
    end process;
    
end Behavioral;
