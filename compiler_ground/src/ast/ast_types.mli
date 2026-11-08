type loc = Lexing.position

module type ID = sig
    type t

    val of_string : string -> t
    val to_string : t -> string
    val equal : t -> t -> bool
end

module Var_name : ID
module Fn_name : ID

type modifier = MConst (*Immutable *) | MVar (** Mutable *)

type identifier = Variable of Var_name.t

(* Types of expression *)
type type_expr =
    | TEInt
    | TEVoid
[@@deriving equal]

type expr =
    | Int of loc * int
    | Identifier of loc * identifier
    | Func of loc * Fn_name.t * expr list

