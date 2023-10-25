let sync url () = 
  Lwt_main.run @@
    let open Lwt.Syntax in
    let* res =  
      let open Ordb_database in
      let open Lwt_result.Syntax in
      let* conn = Caqti_lwt_unix.connect (Uri.of_string url) in
      let* _ = Petrol.VersionedSchema.initialise Schema.ReportsTbl.s conn in
      Lwt_result.return () 
    in
    match res with
    | Ok _ -> 
        print_endline "\x1b[1;32mYour database is now in sync.\x1b[0m";
        Lwt.return ()
    | Error _ -> Lwt.fail_with "Oops!"

let cmd =
  let open Cmdliner in
  let sync =
    let doc = "Executes the changes making your database schema reflect the state of your Petrol schema." in
    let url = 
      let doc = "The connetion URL string which begins with `postgres://`" in
      Arg.(value & opt string "postgres://localhost:5432" & info ["database-url"] ~docv:"URL" ~doc)
    in
    Cmd.v (Cmd.info "sync" ~doc) Term.(const sync $ url $ const ())
  in
  Cmd.group (Cmd.info "db" ~doc:"Tools used to interact with your database")
    [ sync
    ]
