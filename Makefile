.PHONY: all clean

all:
	$(MAKE) -C software/cpm
	$(MAKE) -C software/crt
	$(MAKE) -C software/loader
	$(MAKE) -C software/monitor
	$(MAKE) -C software/putsys
	$(MAKE) -C software/tetris

	$(MAKE) -C firmware/bootloader
	$(MAKE) -C firmware/controller
	$(MAKE) -C firmware/keyboard

	$(MAKE) -C tools/emulator
	$(MAKE) -C tools/upload

clean:
	$(MAKE) -C software/cpm clean
	$(MAKE) -C software/crt clean
	$(MAKE) -C software/loader clean
	$(MAKE) -C software/monitor clean
	$(MAKE) -C software/putsys clean
	$(MAKE) -C software/tetris clean

	$(MAKE) -C firmware/bootloader clean
	$(MAKE) -C firmware/controller clean
	$(MAKE) -C firmware/keyboard clean

	$(MAKE) -C tools/emulator clean
	$(MAKE) -C tools/upload clean
