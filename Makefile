TARGET=bin/tiger
SRC=src/parse.tab.c src/lex.yy.c

LEX=flex
YACC=bison

all: tiger

tiger: $(SRC)
	$(CC) -o $(TARGET) $(SRC)

src/lex.yy.c: src/lex.l
	$(LEX) -o src/lex.yy.c src/lex.l

src/parse.tab.c: src/parse.y
	$(YACC) -o src/parse.tab.c src/parse.y

clean:
	rm -f $(TARGET) src/lex.yy.c
	rm -f src/*.o
