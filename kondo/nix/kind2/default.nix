{
  src,
  fetchFromGitHub,
  lib,
  czmq,
  ocamlPackages,
  stdenv,
}:
stdenv.mkDerivation {
  inherit src;
  pname = "kind2";
  version = src.version;

  buildInputs = [
    ocamlPackages.ocaml
    ocamlPackages.dune_3
    ocamlPackages.findlib
    ocamlPackages.dune-build-info
    ocamlPackages.menhir
    ocamlPackages.menhirLib
    ocamlPackages.num
    ocamlPackages.odoc
    ocamlPackages.ounit
    ocamlPackages.yojson
    ocamlPackages.zmq
    czmq
  ];

  buildPhase = ''
    dune build src @install
  '';

  installPhase = ''
    mkdir -p $out
    dune install --prefix $out
  '';

  doCheck = true;

  checkPhase = ''
    dune test
  '';
}
