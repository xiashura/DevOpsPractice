with (import <nixpkgs> {});

stdenv.mkDerivation {
  name = "terraform";
  buildInputs = [
    terraform_0_15
    terraform-providers.libvirt
  ];
}



