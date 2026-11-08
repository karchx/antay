open Base

type loc = Lexing.position

module type ID = sig
    type t

    val of_string : string -> t
    val to_string : t -> string
    val equal : t -> t -> bool
end

module String_id = struct
    type t = string

    let of_string x = x
    let to_string x = x
    let equal = String.(=)
end

module Var_name : ID = String_id
module Fn_name : ID = String_id

type modifier = MConst | MVar
type identifier = Variable of Var_name.t

type type_expr =
    | TEInt
    | TEVoid
[@@deriving equal]

type expr =
    | Int of loc * int
    | Identifier of loc * identifier
    | Func of loc * Fn_name.t * expr list

