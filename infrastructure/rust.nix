with (import <nixpkgs> {});

stdenv.mkDerivation {
  name = "terraform";
  buildInputs = [
    rustc
    rust-analyzer
    rustfmt
    cargo
  ];
}
