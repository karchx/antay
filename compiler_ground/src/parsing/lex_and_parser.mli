open Core

val parse_program : Lexing.lexbuf -> Ast.Ast_types.expr list Or_error.t

