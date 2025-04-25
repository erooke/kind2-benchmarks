{
  system ? builtins.currentSystem,
  pins ? import ./nix/npins,
  pkgs ? import pins.nixpkgs { inherit system; },
}:
let
  kind2 = pkgs.callPackage ./nix/kind2 { src = pins.kind2; };
in
pkgs.mkShell {
  nativeBuildInputs = [
    kind2
    pkgs.z3
  ];
}
