all: Lab6
Lab6: Lab6.o io.o
	gcc -no-pie -o $@ $+ main.c

Lab6.o: Lab6.asm 
	nasm -f elf64 Lab6.asm -o Lab6.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Lab6 *.o
