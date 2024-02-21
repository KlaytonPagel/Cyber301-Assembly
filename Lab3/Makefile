all: Lab3
Lab3: Lab3.o io.o
	gcc -no-pie -o $@ $+ main.c

Lab3.o: Lab3.asm 
	nasm -f elf64 Lab3.asm -o Lab3.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Lab3 *.o
