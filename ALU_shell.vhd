-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : ALU
-- Author      : Jarrod Wooden
-- Company     : usafa
--
-------------------------------------------------------------------------------
--
-- File        : ALU_shell.vhd
-- Generated   : 7 April 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : Designing the ALU in PRISM using VHDL
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ALU} architecture {ALU}}

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	 port(
		 OpSel : in STD_LOGIC_VECTOR(2 downto 0);
		 Data : in STD_LOGIC_VECTOR(3 downto 0);
		 Accumulator : in STD_LOGIC_VECTOR(3 downto 0);
		 Result : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is	   


begin
	
-- fill in details to create result as a function of Data and Accumulator, based on OpSel.
 -- e.g : Build a multiplexer choosing between the eight ALU operations.  Either use a case statement (and thus a process)
 --       or a conditional signal assignment statement ( x <= Y when <condition> else . . .)
 -- ALU Operations are defined as:
 -- OpSel : Function
--  0     : AND
--  1     : NEG (2s complement)
--  2     : NOT (invert)
--  3     : ROR
--  4     : OR
--  5     : IN
--  6     : ADD
--  7     : LD
aluswitch: process (Accumulator, Data, OpSel)
        begin
		-- enter your if/then/else or case statements here
		
		if OpSel <= 0 then Result <= Accumulator and Data;
		elsif OpSel <= 1 then Result <= std_logic_vector(unsigned(not Accumulator + 1));
		elsif OpSel <= 2 then Result <= not Accumulator;
		elsif OpSel <= 3 then Result <= std_logic_vector(unsigned(Accumulator) ror 1);
		elsif OpSel <= 4 then Result <= Data or Accumulator;
		elsif OpSel <= 5 then Result <= Data;
		elsif OpSel <= 6 then Result <= Accumulator + Data;
		else Result <= Data;
		end if;
	 
		end process;

-- OR, enter your conditional signal statement here

end ALU;

