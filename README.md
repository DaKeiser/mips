<h1 align="center">MIPS Simulator 👨‍💻</h1>
<p>
  <a href="https://github.com/DaKeiser/mips/blob/master/LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
</p>

> A simple non-pipelined 32-bit MIPS Simulator in Verilog

## Install

```sh
git clone https://github.com/DaKeiser/mips.git
```

## Dependencies

- [iVerilog](http://iverilog.icarus.com/) HDL.
- [GTKWave](http://gtkwave.sourceforge.net/).

  * [Installation](http://inf­server.inf.uth.gr/~konstadel/resources/Icarus_Verilog_GTKWave_guide.pdf) Guide for iverilog and GTKWave

## Usage

```sh
~/mips$ iverilog mipsProcessor.v
~/mips$ ./a.out
```

## Run tests

```sh
~/mips$ gtkwave mips.vcd
```

## Description 

We have created separate modules for fetch, decode, execute, memory and writeback operations.

- Instructions are given in the file _fact.dat_. To convert the instructions into 32-bit binary codes, use [this](https://www.eg.bucknell.edu/~csci320/mips_web/).
- Dont forget to add `11111111111111111111111111111111` at the end of the set of instructions
- The value N for which the factorial must be found must be passed in it.
- Changes that you need to make once you gave a specified set of instructions:
    * Change the `parameter instruction_count` in _fetch.v_
    * Similarly change the `parameter INSTRUCTION_COUNT` in _mipsProcessor.v_ 
- Now run the following command `iverilog mipsProcessor.v` (You need to have iverilog and GTKWave installed)
- Then do an `./a.out`
- And find the response to your instruction set in either _registers.dat_ file or _mainMemory.dat_ file (Changes happening depends on the type of instruction you give)
- In our premade _fact.dat_ file our output is visible in _registers.dat_ file in line number 20 or in _mainMemory.dat_ in line number 3.
- If you want to see the number of cycles the instruction took, head over to GTKWave by running `gtkwave mips.vcd` and click on `mipsTb -> mainModule`
- Drag and drop `clock` and `curInstruction[31:0]`. You will get an estimate of the number of cycles it is taking.
- You can also check for any intermediate signal at any module to understand which signals are high or low in a particular instruction.


## Preview

- Instructions are written here. We have implemented a code to find the factorial of 5.

![Instructions File](https://github.com/DaKeiser/mips/blob/master/assets/Instructions_file.png)

- All changes in Registers are found here

![Registers File](https://github.com/DaKeiser/mips/blob/master/assets/Registers_file.png)

- All the data in main memory is stored and written back here

![Main Memory file](https://github.com/DaKeiser/mips/blob/master/assets/Data_Memory_file.png)

- Check out the stages on how the instructions are executed here

![Clock Cycles in GTKWave](https://github.com/DaKeiser/mips/blob/master/assets/Clock_cycle%20Count.png)

## Authors

👤 **Sai Rithwik M**

* Github: [@DaKeiser](https://github.com/DaKeiser)

👤 **Sama Sai Kartik**

* Github: [@Kartik-Sama](https://github.com/Kartik-Sama)

👤 **Soham Joshi**

* Github: [@soham-joshi](https://github.com/soham-joshi)


## 📝 License

Copyright © 2019 [Sai Rithwik M](https://github.com/DaKeiser).<br />
This project is [MIT](https://github.com/DaKeiser/mips/blob/master/LICENSE) licensed.
_
