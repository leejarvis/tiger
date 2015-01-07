%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "parse.tab.h"

#define TOK(id) return t##id
#define KW(id) return kw##id

%}

%option noyywrap
%option yylineno

%%
func                { KW(FUNC); }

[0-9]+              { yylval.ival = atoi(yytext); TOK(NUMBER); }
[a-z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); TOK(ID); }
\"([^\\\"]|\\.)*\"  { yylval.sval = strdup(yytext); TOK(STRING); }

"(" { TOK(LPAREN); }
")" { TOK(RPAREN); }
"{" { TOK(LCURLY); }
"}" { TOK(RCURLY); }
"," { TOK(COMMA); }

\/\/.*$ {}
\n { ++yylineno; }
[ \t] ;

. {
    fprintf(stderr, "unknown token ('%s').\n", yytext);
    exit(1);
};
%%

int main(int argc, char *argv[]) {
  if (argc > 1) {
    yyin = fopen(argv[1], "r");
  }

  yylex();

  return EXIT_SUCCESS;
}

void yyerror(char const *s) {
  fprintf(stderr, "%s. Unexpected \"%s\" on line %d\n", s, yytext, yylineno);
}
