%{
#include <stdio.h>

extern int yylex(void);
extern void yyerror(char const *s);
%}

%union {
        int ival;
        float fval;
        char *sval;
}

%token
        kwFUNC

%token
        tNUMBER
        tID
        tSTRING
        tLPAREN
        tRPAREN
        tLCURLY
        tRCURLY
        tCOMMA

%start program

%%

program: expressions

expressions: expressions expression
           | expression

expression: func_definition
          | value

func_definition: kwFUNC tLPAREN tID tRPAREN tLCURLY expressions tRCURLY

value: tNUMBER
