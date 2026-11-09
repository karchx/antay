%{
  [@@@coverage exclude_file]
  open Ast.Ast_types
%}

/* Token definitions */
%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token <string> ID
%token LPAREN
%token RPAREN
%token LBRACE
%token RBRACE
%token RBRACKET
%token LBRACKET
%token COLON
%token SEMICOLON
%token COMMA
%token DOT
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
%nonassoc UMINUS
%left DOT

%start <program list> main

%%

main:
| e = list(program) EOF {e}

program:
| FUNC name=ID LPAREN args=params RPAREN LBRACE body=list(stmts) RBRACE {
    Func($startpos, Fn_name.of_string name, args, body)
}

identifier:
| variable=ID { Variable(Var_name.of_string variable)}

stmts:
| e=expr SEMICOLON { ExprStmt($startpos, e) }
| LET var_name=ID EQUAL bound_expr=expr SEMICOLON { Let($startpos, Var_name.of_string var_name, bound_expr) }
| CONST var_name=ID EQUAL bound_expr=expr SEMICOLON { Const($startpos, Var_name.of_string var_name, bound_expr) }

params:
| ids=separated_list(COMMA, ID) { List.map Var_name.of_string ids }

expr:
| LPAREN e=expr RPAREN {e}
| id=identifier { Identifier($startpos, id) }
| i=INT { Int($startpos, i) }
| f=FLOAT { Float($startpos, f) }
| LBRACKET elements=separated_list(COMMA, expr) RBRACKET { Array($startpos, elements) }
| MINUS e=expr %prec UMINUS { Neg($startpos, e) }
| e=expr DOT prop=ID { MemberAccess($startpos, e, prop) }
| e1=expr op=bin_op e2=expr { BinOp($startpos, op, e1, e2) }

%inline bin_op:
| PLUS { BinOpPlus }
| MINUS { BinOpMinus }
| MULT { BinOpMult }
| DIV { BinOpDiv }
| EQUAL { BinOpEq }
