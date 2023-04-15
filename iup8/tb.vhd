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

component timer is
 Port ( clk_i : in STD_LOGIC;
        rst_i : in STD_LOGIC;
        ps2_clk_i : in STD_LOGIC;
        ps2_data_i : in STD_LOGIC;
        led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
        led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

 signal clk_i : STD_LOGIC := '0';
 signal rst_i : STD_LOGIC := '0';
 signal ps2_clk_i : STD_LOGIC := '1';
 signal ps2_data_i : STD_LOGIC := '0';
 signal led7_an_o : STD_LOGIC_VECTOR (3 downto 0);
 signal led7_seg_o : STD_LOGIC_VECTOR (7 downto 0);
 signal data : STD_LOGIC_VECTOR (8 downto 0) := "000100101";
 signal counter : integer := 0;
begin

dut: timer port map (
    clk_i => clk_i,
    rst_i => rst_i,
    led7_an_o => led7_an_o,
    led7_seg_o => led7_seg_o,
    ps2_clk_i => ps2_clk_i,
    ps2_data_i => ps2_data_i
 );
 clk_i <= not clk_i after 5ns;
 ps2_clk_i <= not ps2_clk_i after 50us;
stim: process
begin
    wait until rising_edge(ps2_clk_i);
        wait for 35us;
        if counter < 9 then
            ps2_data_i <= data(counter);
            counter <= counter + 1;
        else
            ps2_data_i <= '1';
        end if;
end process;

end Behavioral;