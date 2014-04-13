PRISM_Wooden
============
Documentation: Captain Silva helped me figure out what to do for the less and equal to zero output wires for the 
Datapath code.


The PRISM lab is designed to better understand what is going on in the PRISM program made for us to use and know
how assembly code works.


##The ALU!!!!!!!!!

The ALU was made to do all the operands that PRISM was designed to use.

The operands for the Accumulator include:

            ```
            --  0     : AND (ands the accumulator with the data bus)
            --  1     : NEG (2s complement)
            --  2     : NOT (invert)
            --  3     : ROR (rotate the bits in the Accumulator to the right
            --  4     : OR (or together the accumulator and data bus)
            --  5     : IN (take in from the data bus)
            --  6     : ADD (add the number from the data bus to the A)
            --  7     : LD (load the number from the data bus to the A)
            ```
            
To do this we simply coded them all together. The code for these operands should be self explanatory except for
the `Ror`, which the code for that is here: 

          ```elsif OpSel <= 3 then Result <= std_logic_vector(unsigned(Accumulator) ror 1);```
          
To make sure that this is correct we were given a testbench to make sure that the code written for the ALU was correct.

The results from the simulation are below:

![alt text](https://raw.githubusercontent.com/JarrodWooden/PRISM_Wooden/master/ALU_Sim.PNG "Simulation for the ALU")

As you can see from above the code does what it is supposed to do! Especially pay close attention to "0011" operand
to make sure that the ROR is working correctly.

##Datapath Work

The shell for the Datapath VHDL was given to us. All the Ins and Outs for the Datapath are below:

          ```
          IRLd : in STD_LOGIC;
		      MARLoLd : in STD_LOGIC;
		      MARHiLd : in STD_LOGIC;
		      JmpSel : in STD_LOGIC;
		      PCLd : in STD_LOGIC;
		      AddrSel : in STD_LOGIC;
		      AccLd : in STD_LOGIC;
		      EnAccBuffer : in STD_LOGIC;
		      OpSel : in STD_LOGIC_VECTOR(2 downto 0);
		      Addr : out STD_LOGIC_VECTOR(7 downto 0);
		      AeqZero : out STD_LOGIC;
		      AlessZero : out STD_LOGIC;
		      IR : out STD_LOGIC_VECTOR(3 downto 0);
		      Reset_L : in STD_LOGIC;
		      Clock : in STD_LOGIC;
		      Data : inout STD_LOGIC_VECTOR(3 downto 0)
          ```
          
In the architecture for the Datapth I needed to copy the declaration for the ALU I made in the section above
that functions correclty remember?

After that there are some internal signals in the Datapath that can be seen below.

          ```
          signal  MARHi, MARLo, Accumulator, ALU_Result : std_logic_vector(3 downto 0);
	        signal PC : std_logic_vector(7 downto 0);
	        ```
	        
Finally we are able to begin the processes to complete the datapath for the PRISM program

The JmpSel and the program counter process was already made in the shell that was given to us.

The next process was for the Instruction Register (IR), which was asynchronous reset and will only upload the databus
to the IR if IRLd is a one.

Next was the Memory Address Register (Hi) or (MARHi) where MARHi only equals the data bus if `MARHiLd = '1'`

Do the same with MARLow.

Need to implement the Address Selector (multiplexer)

Where if it is the sising edge of the clock and the address select wire is a one then put marhi to the upper four digits
of the Address wire (Addr) and MarHi to the lower four digits.

If `AddrSel = '0'` then just set the address to the PC

Instantiate the ALU and connect the appropriate wires (See below):

          ```
          alu: ALU_shell PORT MAP (
	        OpSel, Data, Accumulator, ALU_Result);
	        ```
	        
After that implement an Accumulator which if AccLd(accumulator load) is a one then the accumulator equals the alu result

Finally, the Data bus will be sent the accumulator only if the buffer is active, otherwise don't send it anything
or "ZZZZ"

Finally if do this for Accumulator less than zero or equal to zero:

          ```
          AlessZero <= '1' when Accumulator(3) = '1' else '0'; 	--Uses MSB as a sign bit
  	      AeqZero <= '1' when Accumulator = "0000" else '0';
  	      ```
  	      
#End of PRISM_Wooden

            
