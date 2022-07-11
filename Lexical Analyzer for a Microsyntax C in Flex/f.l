%{
 #include<stdio.h>
 #include "tokdefs.h"
 #define LexemeCountLimit 1000
  //we can recognize only a 1000 tokens, for simplicity's sake
 int count = 0;
 
 int size = 4;
 int line = 0; 
 int pos = 0; 


 struct Token allTokens[LexemeCountLimit];
/**Functions*/

char* returnAndStoreSring() {
  size = yyleng;
  char *tmpStr = (char *)malloc(sizeof(char)*size);

  for (int i = 0; i<size; ++i) {
   *(tmpStr + i) = yytext[i];
  }

 return tmpStr;
}
int convertStringToChar(char * tmpSt) {
  int i;
sscanf(tmpSt, "%d", &i);
return i;
} //   recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_IF);}

void recognizeToken(char *tmpSt, int sizeOfString, enum SyntacticCategory tmpCategory, enum Operation operation, int id) {
 enum SyntacticCategory tmpType = tmpCategory;
 enum Operation tmpOp = operation;
 int tmpLineNo = line; 
 int tmpPos = pos;
 char *tmpSymbol = returnAndStoreSring();
 
 struct Token tmpToken = {id, tmpType, operation, tmpLineNo, tmpPos, tmpSymbol, yyleng};
  
  allTokens[count++] = tmpToken;

}

void printSymbol (struct Token tmpToken) {
  
  for (int i = 0; i<tmpToken.size; ++i) {
    printf("%c", *(tmpToken.symbol + i));
  }
  printf("\n");
}
void printOperatorType(enum Operation op) {
 switch(op) {
   case Add: 
    printf("Operator Type: Add\n");
    return;
   case Sub: 
    printf("Operator Type: Subtract\n");
    return;
  case Mul:   
   printf("Operator Type: Multiply\n");
    return;
  case Assign: 
   printf("Operator Type: Assign\n");
    return;    
  case Div: 
    printf("Operator Type: Divide\n");
    return; 
  
 };
}
// SyntacticCategory {IDENTIFIER, KEYWORD, INTEGER,FLOATING_POINT, OPERATOR,
// OpeningCurlyBracket, ClosingCurlyBracket, OpeningBracket, ClosingBracket,
// SEMICOLON}; 
void printSyntacticCategory (enum SyntacticCategory category) {
  switch(category) {
    case IDENTIFIER: 
     printf("Syntactic Category: Identifier\n");
    return;
    case KEYWORD: 
    printf("Syntactic Category: KEYWORD\n");
    return;
    case INTEGER: 
    printf("Syntactic Category: INTEGER\n");
    return;
      case FLOATING_POINT: 
     printf("Syntactic Category: FLOATING_POINT\n");
    return;
      case OpeningCurlyBracket: 
     printf("Syntactic Category: OpeningCurlyBracket\n");
    return;
      case ClosingCurlyBracket: 
     printf("Syntactic Category: ClosingCurlyBracket\n");
    return;
      case OpeningBracket: 
     printf("Syntactic Category: OpeningBracket\n");
    return;
      case ClosingBracket: 
     printf("Syntactic Category: ClosingBracket\n");
    return;
      case SEMICOLON: 
     printf("Syntactic Category: SEMICOLON\n");
    return;  //SEMICOLON, LT, GT, EQ, LTE, GTE, NE
    case LT:
    printf("Syntactic Category: Less Than\n");
    return; 
    case GT: 
     printf("Syntactic Category: Greater Than\n");
     return; 
    case EQ:
     printf("Syntactic Category: Equal\n");
     return;
    case LTE: 
      printf("Syntactic Category: Less Than or Equal to\n");
      return;
    case GTE: 
      printf("Syntactic Category: Greater Than or Equal to \n");
      return; 
    case NE: 
      printf("Syntactic category: Not Equal To \n");
      return;      
    case COMMA: 
       printf("Syntactic category: Comma/Separator \n");
      return;      
  }
}

void writeToOutputFile () {
 
FILE *f = fopen("output.txt", "w");
if (f == NULL)
{
    printf("Error opening file!\n");
    exit(1);
}
for (int i =0; i<count; ++i) {
  
  fprintf(f, "Token name: ");
  for (int z = 0; z <allTokens[i].size; ++z) {
        fprintf(f,"%c", *(allTokens[i].symbol + z));
  }
  fprintf(f, "  TokenID: %d\n", allTokens[i].id);
}

fclose(f);
system("cls");
printf("Output has been produced into the file called output.txt in the current directory\n\n");
}
void printAllTokens (){

  for (int i = 0; i<count; ++i) {
    printf("\n------------------------\n");
    printSymbol(allTokens[i]);
    printf("Size: %d \n", allTokens[i].size);
    printf("Line no: %d \n", allTokens[i].lineNo);
    printf("Position no: %d \n", allTokens[i].pos);
    if (allTokens[i].Operation != NONE) {
      printf("SyntacticCategory: OPERATOR");
      printOperatorType(allTokens[i].Operation);
    }
    else  {
      printSyntacticCategory(allTokens[i].tokType);
    }
   printf("\nToken ID: %d", allTokens[i].id);
   }
  printf("\n------------------------");


}

void printManual () {
  printf("\n------------Printing Manual-------------- \n");
   printf("This language is like a microsyntax of C\n");
   printf("You may use any of the commands below: \n\n"); 
   printf("Command: print \nUsage: Prints out the details all the tokens recognized so far in the input. \n\n");
      printf("Command: cls \nUsage: Clears the console window\n\n");
   printf("Command: exit \nUsage: exits the program\n\n");
   printf("Command: out() \nUsage: outputs the token into an output.txt file");
   printf("Note, you may type your program here, in the console and when you want to tokenize your entire program, simply type the print command.");

  
  printf("\n------------------------------------------\n");

}
//recognizeToken(char *tmpSt, int sizeOfString, enum SyntacticCategory tmpCategory, int operation) 
%}
let [a-zA-z]
digit [0-9]
del [ \t]
%%
\n {line++; pos = 0;}
{del}+ {pos =0;}
"cls" {system("cls");}
"if" {
                      pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_IF);}

"else" {
  pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_ELSE);
}

"main" {
  pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_MAIN);
}

"int" {
    pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_INT);
}
"," {
     pos += yyleng;
                      enum SyntacticCategory tmpSCategory = COMMA;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_COMMA);

}
"void" {
    pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_VOID);
}


"float" {
    pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_FLOAT);
}
"while" {
  pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_WHILE);
}
"for" {pos += yyleng;
                      enum SyntacticCategory tmpSCategory = KEYWORD;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_FOR);} 

"print" {printAllTokens();}   
"out()" {writeToOutputFile();}     
"exit" {return 0;}              
"manual" {printManual();}
{let}({let}|{digit})* {
                      pos += yyleng;
                      enum SyntacticCategory tmpSCategory = IDENTIFIER;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_ID);
                       } 

"+" { pos += yyleng;
                      enum SyntacticCategory tmpSCategory = OPERATOR;
                      enum Operation tmpOP = Add;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_ADD);}
"-" { pos += yyleng;
                      enum SyntacticCategory tmpSCategory = OPERATOR;
                      enum Operation tmpOP = Sub;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_SUB);}
"*" { pos += yyleng;
                      enum SyntacticCategory tmpSCategory = IDENTIFIER;
                      enum Operation tmpOP = Mul;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_MUL);}
"/" { pos += yyleng;
                      enum SyntacticCategory tmpSCategory = IDENTIFIER;
                      enum Operation tmpOP = Div;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_DIV);}

"{" {pos += yyleng; enum SyntacticCategory tmpSCategory = OpeningCurlyBracket;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_CURL_OPEN_BRACKET);}
"}" {pos += yyleng; enum SyntacticCategory tmpSCategory = ClosingCurlyBracket;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_CURL_CLOSE_BRACKET);}
";" { pos += yyleng; enum SyntacticCategory tmpSCategory = SEMICOLON;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_SEMICOLON);}
"(" {pos += yyleng; enum SyntacticCategory tmpSCategory = OpeningBracket;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_OPENING_BRACKET);}
")" {pos += yyleng;
      enum SyntacticCategory tmpSCategory = ClosingBracket;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_CLOSING_BRACKET);}
  
"<" {
     pos += yyleng;
     enum SyntacticCategory tmpSCategory = LT;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_LT);
}
">" {
      pos += yyleng;
     enum SyntacticCategory tmpSCategory = GT;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_GT);
}
"=" {
      pos += yyleng;
     enum SyntacticCategory tmpSCategory = EQ;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_EQ);
}
"!=" {
      pos += yyleng;
     enum SyntacticCategory tmpSCategory = NE;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_NE);                      
}
"<=" {
      pos += yyleng;
     enum SyntacticCategory tmpSCategory = LTE;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_LE);
}
">=" {
      pos += yyleng;
     enum SyntacticCategory tmpSCategory = GTE;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_GE);
}

{digit}+ {pos += yyleng;
          enum SyntacticCategory tmpSCategory = INTEGER;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_INT);}


{digit}+"."{digit}+ {
  {pos += yyleng;
          enum SyntacticCategory tmpSCategory = FLOATING_POINT;
                      enum Operation tmpOP = NONE;
                       recognizeToken(yytext, yyleng, tmpSCategory, tmpOP, TOK_FLOAT);}

}
.  {pos += yyleng; printf("Error! Unrecognized input %c , at line %d and position\n", yytext,line, pos); return 0;}
%%

int yywrap(void){} 


int main() 
{

  printManual();
  printf("Enter Your Program in the Console (in C format): \n");
  int tc = yylex(); 
  
  do {
    tc = yylex();
  } while (tc != 0);

  printf("\nExited from the input. Total number of lexemes identified: \n");
  printAllTokens();
  return 0; 
}