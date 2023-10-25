{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
    ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, ocaml-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ ocaml-overlay.overlays.default ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        ocamlPackages = pkgs.ocaml-ng.ocamlPackages_5_1;

        # pgx-version = "2.2";
        # pgx-src = pkgs.fetchFromGitHub {
        #   owner = "arenadotio";
        #   repo = "pgx";
        #   rev = "2bdd5182142d79710d53bf7c4da2a1f066f71590";
        #   sha256 = "047d47bpqd94lh4m352f3vw735cs8b9z4nz8hzjdkzis8fn88z74";
        # };

        # pgx = ocamlPackages.buildDunePackage {
        #   pname = "pgx";
        #   version = "v${pgx-version}";

        #   src = pgx-src;

        #   buildInputs = with ocamlPackages; [
        #     ppx_compare
        #     ppx_custom_printf
        #     ppx_sexp_conv
        #     camlp-streams
        #     re
        #     uuidm
        #     hex
        #     ipaddr
        #   ];
        # };

        # pgx_lwt = ocamlPackages.buildDunePackage {
        #   pname = "pgx_lwt";
        #   version = "v${pgx-version}";

        #   src = pgx-src;

        #   buildInputs = with ocamlPackages; [
        #     # ppx_compare
        #     # ppx_custom_printf
        #     # ppx_sexp_conv
        #     # camlp-streams
        #     # re
        #     # uuidm
        #     # hex
        #     # ipaddr
        #     pgx
        #     lwt
        #     logs
        #     re
        #     uuidm
        #     ipaddr
        #     hex
        #     camlp-streams
        #     ppx_compare
        #     ppx_sexp_conv
        #   ];
        # };
        # pgx_lwt_unix = ocamlPackages.buildDunePackage {
        #   pname = "pgx_lwt_unix";
        #   version = "v${pgx-version}";

        #   src = pgx-src;

        #   buildInputs = with ocamlPackages; [
        #     # ppx_compare
        #     # ppx_custom_printf
        #     # ppx_sexp_conv
        #     # camlp-streams
        #     # re
        #     # uuidm
        #     # hex
        #     # ipaddr
        #     camlp-streams
        #     ipaddr
        #     hex
        #     logs
        #     lwt
        #     pgx
        #     pgx_lwt
        #     ppx_compare
        #     ppx_sexp_conv
        #     re
        #     uri
        #     uuidm
        #   ];
        # };

        # omigrate = ocamlPackages.buildDunePackage {
        #   pname = "omigrate";
        #   version = "v0.3.2";

        #   src = pkgs.fetchFromGitHub {
        #     owner = "tmattio";
        #     repo = "omigrate";
        #     rev = "ecaca7c04cb9c9d9ebcbb621c64194506826a8ad";
        #     sha256= "1lhd6l51dx280ws7bzy9k0b8ani5hwgc9rngn8wag6wib8wzm1fy";
        #   };

        #   buildInputs = with ocamlPackages; [
        #     camlp-streams
        #     cmdliner
        #     fmt
        #     ipaddr
        #     hex
        #     logs
        #     lwt
        #     lwt_ppx
        #     ocaml_sqlite3
        #     pgx
        #     pgx_lwt
        #     pgx_lwt_unix
        #     ppx_compare
        #     ppx_sexp_conv
        #     re
        #     uuidm
        #     uri
        #   ];
        # };
        petrol-version = "1.2.3";
        petrol = ocamlPackages.buildDunePackage {
          pname = "petrol";
          version = "v${petrol-version}";
          src = pkgs.fetchFromGitHub {
            owner = "Gopiandcode";
            repo = "petrol";
            rev = "${petrol-version}";
            sha256 = "15wrllfdxhwjp7b4wrizi2ip3xyrs8jds2vzy7rfp52dkzi9gcvc";
          };
          buildInputs = with ocamlPackages; [
            lwt
            caqti
            caqti-lwt
          ];
        };

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = (with pkgs.ocaml-ng.ocamlPackages_5_1; [
            ocaml
            dune
            ocaml-lsp
            ocamlformat
            findlib

            ocaml-protoc-plugin
            ppx_deriving
            yojson
            caqti
            caqti-lwt
            caqti-driver-postgresql
            petrol
            lwt
            cmdliner           
          ]);

        };
      }
    );
}
