# Z80 Project
[![Build Status](https://ci.mtgames.nl/api/badges/z80/z80/status.svg)](https://ci.mtgames.nl/z80/z80)

The goal of this project is to build a fully functioning Z80 based computer.
This repository acts a a meta repository that contains all the different sub-projects, split into several different catergories:

- **firmware**: The firmware that allows the computer to operate
	- [bootloader](https://git.mtgames.nl/z80/bootloader): I2C Bootloader for the STM32F103
	- [controller](https://git.mtgames.nl/z80/controller): Main controlling microcontroller
	- [hdmi](https://git.mtgames.nl/z80/hdmi): FPGA based graphics card
	- [keyboard](https://git.mtgames.nl/z80/keyboard): Allows PS/2 keyboards to be used as an input device
	- [twiboot](https://git.mtgames.nl/z80/twiboot): I2C bootloader for ATMega based chips

- **hardware**: The schematic and PCB design files for the different components
	- [library](https://git.mtgames.nl/z80/library): Common part that are shared between different schematics and PCB's.
	- [memory](https://git.mtgames.nl/z80/memory): Board containing the computers memory.
	- [keyboard](https://git.mtgames.nl/z80/keyboard): Board containing the keyboard interface (PS/2 connector).

- **software**: The software that actually runs on the Z80 processor
	- [cpm](https://git.mtgames.nl/z80/cpm): Source code for CP/M and the BIOS
	- [crt](https://git.mtgames.nl/z80/crt): Custom C runtime implementation, not based on the standard
	- [loader](https://git.mtgames.nl/z80/loader): Bootloader that loads the rest of CP/M
	- [monitor](https://git.mtgames.nl/z80/monitor): ROM program that contains simple routines including reading and writing disks
	- [putsys](https://git.mtgames.nl/z80/putsys): Write CP/M from memory to disk (Might be outdated)
	- [tetris](https://git.mtgames.nl/z80/tetris): Simple tetris clone written in C as a way of testing various systems

- **tools**: Various tools to aid in the development
	- [convert-font](https://git.mtgames.nl/z80/convert-font): Convert a font image to verilog code for easy inclusion in the gpu
	- [create-disk](https://git.mtgames.nl/z80/create-disk): Create a disk image that contains a bootloader, CP/M and a compatible filesystem including specified files
	- [emulator](https://git.mtgames.nl/z80/emulator): An emulator to allow for easier software development for the computer
	- [mount-cpm](https://git.mtgames.nl/z80/mount-cpm): A tools that can mount the disk images
	- [setup](https://git.mtgames.nl/z80/setup): Setup scripts that builds various required tools
	- [upload](https://git.mtgames.nl/z80/upload): A tool for uploading firmware to the computer

# Development
This sections outlines how to get started with development on this project.

## Cloning
In order to properly clone this repos the tool [meta](https://github.com/mateodelnorte/meta) is required, this can be installed using the following command:
```
$ npm i -g meta
```
The repository can then be cloned using:
```
$ meta git clone https://git.mtgames.nl/z80/z80
```
Some repositories rely on submodules, after navigating into the newly created directory, the following command ensures that these are cloned:
```
$ meta exec "git submodule update --init --recursive"
```
The repository should now be ready for development.

In order to update all sub-projects to the latest version the following command can be used:
```
$ meta git pull
```

During development each of the repositories can be viewed as individual git repositories.

## Requirements
On an Arch Linux the following command will ensure that all the required packages are installed.
```
$ sudo pacman -S base-devel npm git  arm-none-eabi-gcc arm-none-eabi-newlib avr-gcc avr-libc sdcc python3 sdl2 sdl2_image
```

The microblaze compiler is also required to be installed, a script to build this compiler is provided in [tools/setup](https://git.mtgames.nl/z80/setup).
This compiler will automatically get build if you execute the command in the next section.

(You will also need to manually install [zasm](https://aur.archlinux.org/packages/zasm), this will however change in the near future, see: z80/cpm#1, z80/loader#1, z80/monitor#2, z80/putsys#1 .)

## Tools
The following command will make sure that the different tools are available in $PATH:
```
$ source source.sh
```
As stated in the last section, this will also make sure that the microblaze compiler is build and in the path.


## Git
In order to prevent unneeded changes from getting commited when working on schematics the following commands can be used:
```
$ git config --global filter.kicad_project.clean "sed -E 's/^update=.*$/update=Date/'"
$ git config --global filter.kicad_project.smudge cat
$ git config --global filter.kicad_sch.clean "sed -E 's/#(PWR|FLG)[0-9]+/#\1?/'"
$ git config --global filter.kicad_sch.smudge cat
```

(Based on [this](https://jnavila.github.io/plotkicadsch/) blog post.)


## Building
Each of the sub-projects contains a Makefile that allows the project to be build, this is the preferred method during development on a singe sub-project.
After navigating to the sub-projects directory the follwoing command will build it:
```
$ make
```
If instead you want to build all the projects running the same command in the main directory will ensure that each of the sub-projects gets build.
(This does currently exclude the [firmware/hdmi](https://git.mtgames.nl/z80/hdmi) as it requires some additional setup, see z80/z80#4 .)
