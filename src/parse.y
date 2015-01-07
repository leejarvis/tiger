%{
#include <stdio.h>
extern int yylex(void);
void yyerror(char const *s) { fprintf(stderr, "%s\n", s); }
%}

%token
        identifier

%start program

%%

program: expressions

expressions: expressions expression
           | expression

expression: identifier { printf("PARSED(%d)\n", $1); }
