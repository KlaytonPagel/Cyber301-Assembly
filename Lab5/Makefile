all: Lab5
Lab5: Lab5.o io.o
	gcc -no-pie -o $@ $+ main.c

Lab5.o: Lab5.asm 
	nasm -f elf64 Lab5.asm -o Lab5.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Lab5 *.o
