all: HW2
HW2: HW2.o io.o
	gcc -no-pie -o $@ $+ main.c

HW2.o: HW2.asm 
	nasm -f elf64 HW2.asm -o HW2.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm HW2 *.o
