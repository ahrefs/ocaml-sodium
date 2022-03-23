module C = Configurator.V1

let () =
  C.main ~name:"icu" (fun c ->
    let default : C.Pkg_config.package_conf =
      { libs = [ "-lsodium" ]; cflags = [] }
    in
    let conf =
      match C.Pkg_config.get c with
      | None -> default
      | Some pc ->
      match C.Pkg_config.query pc ~package:"sodium" with
      | None -> default
      | Some deps -> deps
    in
    C.Flags.write_sexp "c_library_flags.sexp" conf.libs
  )
