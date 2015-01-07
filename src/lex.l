%{
#include <stdlib.h>
#include <stdio.h>

#define TYPE(t, value) printf("%s(%s)\n", t, value)
#define TOK(t) printf("%s\n", t)
%}

%option noyywrap

%%
[0-9]+              { TYPE("NUMBER", yytext); }
[a-z_][a-zA-Z0-9_]* { TYPE("ID", yytext); }

\"([^\\\"]|\\.)*\" { TYPE("STRING", yytext); }

"(" { TOK("LPAREN"); }
")" { TOK("RPAREN"); }
"{" { TOK("LCURLY"); }
"}" { TOK("RCURLY"); }
"," { TOK("COMMA"); }

\/\/.*$ {}
\n {}
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

