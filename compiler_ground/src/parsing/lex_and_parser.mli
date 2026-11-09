open Core

val parse_program : Lexing.lexbuf -> Ast.Ast_types.program list Or_error.t

