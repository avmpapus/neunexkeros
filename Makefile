CXX = i686-elf-g++
CXXFLAGS = -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld -nostdlib -lgcc

all: kernel.bin

kernel.bin: kernel.o
	$(CXX) $(LDFLAGS) -o $@ $^

kernel.o: kernel.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

iso: all
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/
	cp grub.cfg iso/boot/grub/
	grub-mkrescue -o myfirstos.iso iso

run: iso
	# Command for QEMU (if needed in the future)
	qemu-system-i386 -cdrom myfirstos.iso

clean:
	rm -rf *.o kernel.bin myfirstos.iso iso
