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
    | Float of loc * float
    | Neg of loc * expr
    | Identifier of loc * identifier
    | Array of loc * expr list
    | MemberAccess of loc * expr * string

type stmt =
    | ExprStmt of loc * expr
    | Let of loc * Var_name.t * expr
    | Const of loc * Var_name.t * expr

type program =
    | Func of loc * Fn_name.t * Var_name.t list * stmt list

