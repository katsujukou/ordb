let start ~host ~port =
  print_endline (Printf.sprintf "Server is running on %s:%i" host port);
  Lwt_result.return ()