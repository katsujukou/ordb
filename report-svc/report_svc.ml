
let () =
  let open Cmdliner in
  let cmd = Cmd.group (Cmd.info "report-svc")
        [ Serve.cmd
        ; Db.cmd
        ]
  in
  exit @@ Cmd.eval cmd