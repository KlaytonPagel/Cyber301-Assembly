all: Lab7
Lab7: Lab7.o io.o
	gcc -no-pie -o $@ $+ main.c

Lab7.o: Lab7.asm 
	nasm -f elf64 Lab7.asm -o Lab7.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Lab7 *.o
