all: Final
Final: Final.o io.o
	gcc -no-pie -o $@ $+ main.c

Final.o: Final.asm 
	nasm -f elf64 Final.asm -o Final.o

io.o: io.asm 
	nasm -f elf64 -d ELF_TYPE io.asm -o io.o

clean:
	rm Final *.o
