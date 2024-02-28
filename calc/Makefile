all: calc
calc: calc.o io.o
	gcc -no-pie -o $@ $+ main.c

calc.o: calc.asm 
	nasm -f elf64 calc.asm -o calc.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm calc *.o
