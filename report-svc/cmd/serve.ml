let main () = Lwt_main.run @@
  let open Lwt.Infix in
  let open Ordb in
  let _ = Lwt.async @@ fun () ->
    let open Lwt.Syntax in
    let* res = Server.start ~host:"0.0.0.0" ~port:3000 in
    match res with
    | Ok _ -> Lwt.return ()
    | Error exn -> Lwt.fail exn
  in
  let forever, _ = Lwt.wait () in
  Lwt_main.run forever >>= fun _ -> Lwt.return ()


let cmd =
  let open Cmdliner in
  let doc = "Start listening to in-comming gRPC requests on specified port." in
  Cmd.v (Cmd.info "serve" ~doc)
    Term.(const main $ const ())