%{
  [@@@coverage exclude_file]
  open Ast.Ast_types
%}

/* Token definitions */
%token <string> ID
%token LPAREN
%token RPAREN
%token LBRACE
%token RBRACE
%token COLON
%token FUNC
%token EOF

%start <expr> main

%%

main:
| e = expr EOF {e}

expr:
| LPAREN e=expr RPAREN {e}
| id=identifier { Identifier($startpos, id) }
| FUNC name=ID LPAREN RPAREN LBRACE body=expr RBRACE {
    Func($startpos, Fn_name.of_string name, body)
}

identifier:
| variable=ID { Variable(Var_name.of_string variable)}

