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

type bin_op =
    | BinOpPlus
    | BinOpMinus
    | BinOpMult
    | BinOpDiv
    | BinOpEq
    | BinOpGt
    | BinOpGte
    | BinOpLt
    | BinOpLte

type block =
    | Block of loc * stmt list * expr option
and expr =
    | Int of loc * int
    | Float of loc * float
    | String of loc * string
    | Neg of loc * expr
    | Identifier of loc * identifier
    | BinOp of loc * bin_op * expr * expr
    | Array of loc * expr list
    | MemberAccess of loc * expr * string
    | Call of loc * expr * expr list
    | If of loc * expr * block * block option
and stmt =
    | ExprStmt of loc * expr
    | Let of loc * Var_name.t * expr
    | Const of loc * Var_name.t * expr
    | Loop of loc * stmt list
and program =
    | Func of loc * Fn_name.t * Var_name.t list * stmt list
