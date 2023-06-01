%{
#include "java_exception.tab.h"
%}

%%
try                    { return TRY; }
catch                  { return CATCH; }
finally                { return FINALLY; }
throw                  { return THROW; }
"System.out.println"   { return PRINT;}
if                     { return IF;}
[*|/|+|-|>]              { return OPERATOR;}
[a-zA-Z][a-zA-Z0-9_]*  { return IDENTIFIER; }
[0-9]+                 { return INTEGER_LITERAL; }
\"([^\\\"]|\\.)*\"     {  return STRING_LITERAL; }
[ \t]                   ;
.                      { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}


