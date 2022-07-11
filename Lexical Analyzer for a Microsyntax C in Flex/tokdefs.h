#include<stdio.h>
#define TOK_VOID 1
#define TOK_INT 2
#define TOK_FLOAT 99
#define TOK_IF 3
#define TOK_ELSE 4
#define TOK_WHILE 5
#define TOK_LE 6
#define TOK_LT 33
#define TOK_GT 34 
#define TOK_GE 7
#define TOK_EQ 8
#define TOK_NE 9
#define TOK_ID 111
#define TOK_MAIN 55
#define TOK_ADD 97
#define TOK_SUB 96
#define TOK_MUL 95
#define TOK_DIV 94
#define TOK_OPENING_BRACKET 93
#define TOK_CLOSING_BRACKET 92
#define TOK_CURL_OPEN_BRACKET 93
#define TOK_CURL_CLOSE_BRACKET 91
#define TOK_SEMICOLON 90
#define TOK_FOR 45
#define TOK_COMMA 49







/**DATA TYPES**/  
 enum  Operation { Add, Sub, Mul, Div, Assign, NONE};
 enum SyntacticCategory {IDENTIFIER, KEYWORD, INTEGER,FLOATING_POINT, OPERATOR,
 OpeningCurlyBracket, ClosingCurlyBracket, OpeningBracket, ClosingBracket,
 SEMICOLON, LT, GT, EQ, LTE, GTE, NE, COMMA}; 

 struct Token {
    int id; 
   SyntacticCategory tokType; 
   Operation Operation; 
   int lineNo;
   int pos; 
   char *symbol;
   int size; 
  
 };
