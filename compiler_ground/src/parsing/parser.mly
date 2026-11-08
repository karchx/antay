%{
  [@@@coverage exclude_file]
  open Ast.Ast_types
%}

/* Token definitions */
%token <int> INT
%token <string> STRING
%token <string> ID
%token LPAREN
%token RPAREN
%token LBRACE
%token RBRACE
%token COLON
%token SEMICOLON
%token COMMA
%token EQUAL
%token PLUS
%token MINUS
%token CONST
%token LET
%token MULT
%token DIV
%token FUNC
%token IF
%token ELSE
%token LOOP
%token EOF

%right EQUAL
%left PLUS MINUS
%left MULT DIV

%start <expr list> main

%%

main:
| e = list(expr) EOF {e}


stmts:
| e=expr SEMICOLON {e}

expr:
| LPAREN e=expr RPAREN {e}
| id=identifier { Identifier($startpos, id) }
| i=INT { Int($startpos, i) }
| FUNC name=ID LPAREN RPAREN LBRACE body=list(stmts) RBRACE {
    Func($startpos, Fn_name.of_string name, body)
}

identifier:
| variable=ID { Variable(Var_name.of_string variable)}

