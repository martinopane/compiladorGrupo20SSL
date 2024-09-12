%{
#include <stdio.h>
#include <string.h>
#include "moduloParser.tab.h"

void yyerror(char *s);
int yylex();

extern int yylexerrs;  // Cambiar a extern
char buffer[128];      // Aumentar el tamaño del buffer
%}

digito                  [0-9]
letra                   [a-zA-Z]
identificador           {letra}({letra}|{digito})*
constante               ({digito})+

%%

"inicio"                return INICIO;
"fin"                   return FIN;
"leer"                  return LEER;
"escribir"              return ESCRIBIR;
"imprimir"              return IMPRIMIR;
"veces"                 return VECES;

{identificador}         {yylval.id = strdup(yytext); return ID;} 
{constante}             {yylval.cte = atoi(yytext); return CONSTANTE;}
"("                     return '(';
")"                     return ')';
";"                     return  PUNTOYCOMA;
"+"                     return '+';
"-"                     return '-';
"*"                     return '*';
","                     return ',';
":="                    return ASIGNACION;
[ \t\n]                 ;
.                       {yylexerrs++; sprintf(buffer,"Error Lexico: %s es un caracter invalido", yytext); yyerror(buffer);}

%%

int yywrap(void) {
    return 1;
}
