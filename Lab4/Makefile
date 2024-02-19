all: Lab4
Lab4: Lab4.o io.o
	gcc -no-pie -o $@ $+ main.c

Lab4.o: Lab4.asm 
	nasm -f elf64 Lab4.asm -o Lab4.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Lab4 *.o
