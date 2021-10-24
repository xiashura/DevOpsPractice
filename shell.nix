with (import <nixpkgs> {});

stdenv.mkDerivation {

	RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}"; 

  name = "terraform";
  buildInputs = [
		rustup
		rust-analyzer
    rustc
    rustfmt
    cargo
    ansible
    terraform_0_15
    nodejs
    pipenv
    nodePackages.npm
    nodePackages.cdktf-cli
    terraform-providers.libvirt
  ];
}

