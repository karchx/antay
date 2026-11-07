open Core
open Core_unix

let ay_file =
    Command.Arg_type.create (fun filename ->
        if not (String.is_suffix filename ~suffix: ".ay") then begin
            eprintf "'%s' is not ay file. Hint use the .ay extension\n%!" filename;
            exit 1
        end;

        match Sys_unix.is_file ~follow_symlinks:true filename with

        | `Yes -> filename
        | `No ->
                eprintf "File '%s' not found\n%!" filename;
                exit 1
        | `Unknown ->
                eprintf "Unknow error file\n%!";
                exit 1
    )

let command = 
    Command.basic ~summary: "base Ground from drone antay"
        ~readme:(fun () -> "Working list optins...")
        Command.Let_syntax.(
            let%map_open filename = anon (maybe_with_default "-" ("filename" %: ay_file)) in
            fun () ->
                In_channel.with_file filename ~f:(fun file_ic ->
                    let lexbuf =
                        Lexing.from_channel file_ic in
                    compiler_program_ir lexbuf))


let () = Command_unix.run ~version:"0.1" ~build_info:"RWO" command
