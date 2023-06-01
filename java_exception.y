%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *);
extern int yylex(void);
%}


%token  IDENTIFIER
%token  INTEGER_LITERAL
%token  STRING_LITERAL
%token TRY CATCH FINALLY THROW PRINT
%left '+' '-'
%left '*' '/'
%left OPERATOR
%left IF

%%
program : //statement_list
           try_statement
         {printf("Accepted"); exit(0);}
        ;   

statement_list : /* empty */
               | statement_list statement
               ;

statement : try_statement
          | simple_statement
          ;

try_statement : TRY block catch_clauses finally_clause
              | TRY block catch_clauses
              ;

catch_clauses : /* empty */
              | catch_clauses catch_clause
              ;

catch_clause : catch_formal_param block
             ;

catch_formal_param : CATCH '(' IDENTIFIER IDENTIFIER ')'
                   | CATCH '(' IDENTIFIER ')'           
                   ;

finally_clause : FINALLY block
               ;

block : '{' statement_list '}'
      ;

simple_statement : expression_statement
                  | print_statement
                 ;

expression_statement : THROW IDENTIFIER ';'
                     | IDENTIFIER IDENTIFIER'=' INTEGER_LITERAL OPERATOR INTEGER_LITERAL ';'
                     | IDENTIFIER '=' INTEGER_LITERAL ';'
                     | IF '(' IDENTIFIER OPERATOR IDENTIFIER ')'block
                     ;
                     
print_statement : PRINT '(' STRING_LITERAL ')' ';'
                    ;

%%

int main(void) {
    printf("Enter your program ");
    yyparse();
    return 0;
}

void yyerror(const char *error) {
    printf("Error: %s\n", error);
}
