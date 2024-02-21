all: Lab2
Lab2: Lab2.o io.o
	gcc -no-pie -o $@ $+ main.c

Lab2.o: Lab2.asm 
	nasm -f elf64 Lab2.asm -o Lab2.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Lab2 *.o
