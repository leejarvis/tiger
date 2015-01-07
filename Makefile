TARGET=bin/tiger
SRC=src/parse.tab.c src/lex.yy.c

LEX=flex
YACC=bison -y

all: tiger

tiger: $(SRC)
	$(CC) -o $(TARGET) $(SRC)

src/lex.yy.c: src/lex.l
	$(LEX) -o src/lex.yy.c src/lex.l

src/parse.tab.c src/parse.tab.h: src/parse.y
	$(YACC) -o src/parse.tab.c -d src/parse.y

clean:
	rm -f $(TARGET) src/lex.yy.c
	rm -f src/parse.tab.*
	rm -f src/*.o
